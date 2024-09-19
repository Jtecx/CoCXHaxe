package classes.scenes.aPI;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.BaseContent;
import classes.CoC;
import classes.EngineCore;
import classes.PerkLib;
import classes.scenes.SceneLib;
import classes.internals.Utils;
import coc.view.ButtonData;
import coc.view.CoCButton;
import coc.view.Color;
import coc.view.MainView;
import coc.view.UIUtils;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.text.TextField;
import flash.utils.Dictionary;

class ExplorationEngine extends BaseContent
{
    private var maxRevealLevel(get, never) : Int;
    public var inEncounter(get, never) : Bool;
    public var isActive(get, never) : Bool;
    public var isAtEnd(get, never) : Bool;

    private static inline var MAXDEPTH : Int = 7;
    private static inline var NROADS : Int = 5;
    private static var N : Int = NROADS * MAXDEPTH;
    private static inline var LINE_WIDTH : Float = 4;
    private static inline var LINE_DISABLED : String = "#888888";
    private static inline var LINE_COLOR : String = "#884444";
    private static inline var LINE_NEXT : String = "#0080ff";
    private var lastAreaLevel : Float = 0;
    private var lastTimesExplored : Float = 0;
    
    private function filterUnique(e : SimpleEncounter) : Bool
    {
        if (e.unique)
        {
            var group : String = Std.string(e.unique);
            for (i in 0...N)
            {
                if (flatList[i] != null && !flatList[i].isCleared && flatList[i].encounter)
                {
                    if (flatList[i].encounter == e || (group != null && flatList[i].encounter.unique == e.unique))
                    {
                        return false;
                    }
                }
            }
        }
        return true;
    }
    /** Encounter filter for first location on the road */
    private function filterForStart(e : SimpleEncounter) : Bool
    {
        return !e.special && filterUnique(e);
    }
    /** Encounter filter for locations on the road except first and last */
    private function filterForMid(e : SimpleEncounter) : Bool
    {
        return filterUnique(e);
    }
    /** Encounter filter for last location on the road */
    private function filterForEnd(e : SimpleEncounter) : Bool
    {
        return (e.special || Lambda.indexOf(["npc", "item", "boss", "treasure", "special", "monster"], e.getKind()) >= 0) && filterUnique(e);
    }
    private function filterForSoulSense(e : SimpleEncounter) : Bool
    {
        return soulSenseCheck(e) && filterUnique(e);
    }
    private var filters(default, never) : Array<Dynamic> = [filterForStart, filterForMid, filterForEnd];
    
    public function new()
    {
        super();
        var SIZE : Float = ExplorationEntry.RADIUS * 2;
        var XGAP : Float = (MainView.TEXTZONE_W) / (MAXDEPTH + 1) - SIZE;
        var YGAP : Float = SIZE * 1.5;
        
        startPos = new ExplorationEntry(-1, -1, XGAP / 2, YGAP + (NROADS - 1) * (SIZE + YGAP) / 2);
        startPos.label = "Start";
        var y : Float = YGAP;
        for (i in 0...NROADS)
        {
            var x : Float = startPos.sprite.x + SIZE + XGAP;
            roads.push([]);
            for (j in 0...MAXDEPTH)
            {
                roads[i][j] = new ExplorationEntry(i, j, x, y);
                flatList.push(roads[i][j]);
                x += SIZE + XGAP;
            }
            y += SIZE + YGAP;
        }
        initialized = true;  // for clear() to work  
        clear();
    }
    
    /**
	 * This properties can be set after prepareArea() and before doExplore()
	 */
    public var prompt : String = "";
    public var leave : ButtonData = null;
    public var onEnd : ButtonData = null;
    /**
	 * true - encounters can be fully revealed, displaying their name.
	 * false - only encounter kind can be revealed
	 */
    public var canRevealFull : Bool = true;
    public var canMasturbate : Bool = true;
    public var canInventory : Bool = true;
    public var canSoulSense : Bool = true;
    /**
	 * function(e:SimpleEncounter):Boolean.
	 * If returns true, that encounter can be revealed with Soul Sense skill.
	 * Default: all NPC-tagged encounters.
	 */
    public var soulSenseCheck : Function = defaultSoulseSenseCheck;
    /**
	 * function(e:ExplorationEntry):Boolean, called BEFORE the encounter.
	 * If it returns true, do not continue with the exploration UI
	 */
    public var onEncounter : Function = null;
    /**
	 * Called after UI is shown - can add custom buttons here
	 */
    public var onMenu : Function = null;
    /**
	 * A simple storage for current area tags.
	 *
	 * Known area tags:
	 * - generic: "plants", "water"
	 * - area group: "forest", "desert", "battlefield", "lake", "mountains"
	 * - specific area: "explore", "lakeBeach", "forestInner", "forestOuter", "deepwoods", "desertInner", "desertOuter",
	 *   "battlefieldBoundary", "battlefieldOuter", "caves", "bog", "swamp", "hills", "mountainsLow", "mountainsMid"
	 *
	 * @example
	 *
	 * explorer.setTags("forest", "forestOutskirts", "plants");
	 *
	 * if (explorer.areaTags.plants) { ... } - if near plants
	 */
    public var areaTags : Dynamic = { };
    public var branchChance : Float = 0;
    public var crossingAllowed : Bool = false;
    
    private var maxDepth : Int = MAXDEPTH;
    private var source : GroupEncounter = new GroupEncounter("UNUSED", []);
    private var playerEntry : ExplorationEntry = null;
    private var currentEntry : ExplorationEntry = null;
    private var flatList : Array<Dynamic> = [];
    private var roads : Array<Dynamic> = [];
    private var road : Array<Dynamic> = null;
    /** Selected road */
    private var roadIndex : Int = -1;
    /** Position on road - the next encounter to explore */
    private var roadPos : Int = -1;
    private var initialized : Bool = false;
    private var finished : Bool = false;
    private var startPos : ExplorationEntry;
    private var nextNodes : Array<Dynamic> = [];
    
    /**
	 * Switch to clear, uninitialized state.
	 */
    public function clear() : Void
    {
        if (!initialized)
        {
            return;
        }
        trace("explorer.clear");
        initialized = false;
        finished = false;
        areaTags = { };
        leave = new ButtonData("Leave", defaultReturn).hint("Return to camp.").icon("Back");
        prompt = "Explore the area.";
        onEnd = new ButtonData("Return", defaultReturn).hint("Return to camp.").icon("Back");
        startPos.unlink();
        for (i in 0...ExplorationEngine.N)
        {
            flatList[i].setEmpty();
            flatList[i].unlink();
        }
        roadPos = 0;
        roadIndex = -1;
        road = null;
        currentEntry = null;
        playerEntry = null;
        nextNodes = [];
        onMenu = null;
        onEncounter = null;
        soulSenseCheck = defaultSoulseSenseCheck;
    }
    public function entryAt(roadNo : Int, roadPos : Int) : ExplorationEntry
    {
        return roads[roadNo][roadPos];
    }
    public function markEncounterDone() : Void
    {
        if (initialized && currentEntry != null)
        {
            trace("markEncounterDone", currentEntry.encounterName);
            currentEntry.markCleared();
            currentEntry = null;
        }
    }
    /**
	 * Switch to "finished" state where data is still kept but exploration cannot proceed.
	 *
	 * This function can be called in encounters that finish exploration early (e.g. combat loss).
	 *
	 * This function does not display any menus!
	 */
    public function stopExploring() : Void
    {
        trace("explorer.stopExploring");
        if (!initialized)
        {
            return;
        }
        finished = true;
        areaTags = { };
        markEncounterDone();
    }
    /**
	 * End current encounter and display exploration UI.
	 * This function can be used as a callback when finishing the encounter.
	 *
	 * If there is no encounter, return to camp using 1 hour.
	 *
	 * @param timePassedMinutes Advance time, -1 for default value
	 */
    public function done(timePassedMinutes : Int = -1) : Void
    {
        trace("explorer.done");
        if (!initialized)
        {
            defaultReturn();
            return;
        }
        if (timePassedMinutes < 0)
        {
            if (currentEntry == null)
            {
                timePassedMinutes = 0;
            }
            else
            {
                timePassedMinutes = ExplorationEntry.EncounterKinds[currentEntry.kind].time;
            }
        }
        if (timePassedMinutes > 0)
        {
            advanceMinutes(timePassedMinutes);
        }
        markEncounterDone();
        if (finished)
        {
            onEnd.callback();
        }
        else
        {
            doExplore();
        }
    }
    /**
	 * Start or continue the exploration.
	 *
	 * It is safe to call when exploration is finished (returns to camp after 1 hour).
	 * It throws an error if exploration is not initialized.
	 */
    public function doExplore() : Void
    {
        if (!initialized)
        {
            throw new Error("ExplorationEngine was not initialized");
        }
        if (finished)
        {
            trace("explorer.doExplore(finished)");
            onEnd.callback();
        }
        /* // Uncomment to auto return-to-camp after finishing last entry
		if (roadIndex >= 0 && numUnexplored() == 0) {
			trace("explorer.doExplore(ended)")
			stopExploring();
			onEnd.callback();
		} else */
        else if (timeQueued)
        {
            trace("explorer.doExplore(timeQueued)");
            goNext(false);
        }
        else
        {
            trace("explorer.doExplore(normal)");
            validate();
            showUI();
        }
    }
    private var _errors : String = "";
    /**
	 * Do a full reset, then prepare the exploration of the area.
	 * @param area Group encounter to pick from
	 */
    public function prepareArea(area : GroupEncounter, branchChance : Float = 0.1, maxDepth : Int = MAXDEPTH) : Void
    {
        trace("explorer.prepareArea");
        this.maxDepth = Math.min(MAXDEPTH, maxDepth);
        _errors = "";
        this.branchChance = branchChance;
        this.crossingAllowed = false;
        clear();
        this.source = area;
        validatePool(area);
        generateAll();
    }
    private function validatePool(pool : GroupEncounter) : Void
    {
        for (e/* AS3HX WARNING could not determine type for var: e exp: EField(EIdent(pool),components) type: null */ in pool.components)
        {
            if (Std.is(e, GroupEncounter))
            {
                validatePool(try cast(e, GroupEncounter) catch(e:Dynamic) null);
            }
            else if (Std.is(e, SimpleEncounter))
            {
                if (!(try cast(e, SimpleEncounter) catch(e:Dynamic) null).getKind())
                {
                    _errors += "ERROR: Encounter '" + e.encounterName() + "' is missing 'kind' property.\n";
                }
            }
        }
    }
    
    private function defaultReturn() : Void
    {
        camp.returnToCampUseOneHour();
    }
    private function get_maxRevealLevel() : Int
    {
        return (canRevealFull) ? ExplorationEntry.REVEAL_FULL : ExplorationEntry.REVEAL_KIND;
    }
    
    /**
	 * Current entry that is being executed - after player starts the encounter and before stopExploring()/markEncounterDone()/done()
	 */
    public function getCurrentEntry() : ExplorationEntry
    {
        return currentEntry;
    }
    private function get_inEncounter() : Bool
    {
        return !!currentEntry;
    }
    
    /**
	 * True if exploration engine is currently active - whether on a map or inside an encounter.
	 */
    private function get_isActive() : Bool
    {
        return initialized && !finished;
    }
    public function numUnrevealed() : Int
    {
        var n : Int = 0;
        var max : Int = maxRevealLevel;
        for (i in 0...N)
        {
            if (!flatList[i].isDisabled && flatList[i].revealLevel < max)
            {
                n++;
            }
        }
        return as3hx.Compat.parseInt(n);
    }
    private function get_isAtEnd() : Bool
    {
        return nextNodes.length == 0;
    }
    public function roadLength(roadIndex : Int) : Int
    {
        var length : Int;
        length = MAXDEPTH;
        while (length > 0)
        {
            if (roads[roadIndex][length - 1].encounter)
            {
                return length;
            }
            length--;
        }
        return 0;
    }
    
    public function findByName(name : String) : ExplorationEntry
    {
        for (i in 0...N)
        {
            if (!flatList[i].isDisabled && flatList[i].encounterName == name)
            {
                return flatList[i];
            }
        }
        return null;
    }
    public function findAllByName(name : String) : Array<Dynamic>
    {
        var result : Array<Dynamic> = [];
        for (i in 0...N)
        {
            if (!flatList[i].isDisabled && flatList[i].encounterName == name)
            {
                result.push(flatList[i]);
            }
        }
        return result;
    }
    public function revealRandom() : ExplorationEntry
    {
        var n : Int = numUnrevealed();
        if (n < 0)
        {
            return null;
        }
        var x : Int = rand(n);
        var max : Int = maxRevealLevel;
        for (i in 0...N)
        {
            if (!flatList[i].isDisabled && flatList[i].revealLevel < max)
            {
                if (x == 0)
                {
                    trace("Revaling entry " + ((i / MAXDEPTH) | 0) + ";" + (i % MAXDEPTH) + " " + flatList[i].encounterName);
                    flatList[i].incReveal();
                    return flatList[i];
                }
                x--;
            }
        }
        trace("No entry to reveal??");
        return null;
    }
    public function revealAllByName(name : String, level : Int = ExplorationEntry.REVEAL_FULL) : Void
    {
        for (i in 0...N)
        {
            if (!flatList[i].isDisabled && flatList[i].encounterName == name)
            {
                flatList[i].setRevealLevel(level);
            }
        }
    }
    public function revealAll(level : Int = ExplorationEntry.REVEAL_FULL) : Void
    {
        for (i in 0...N)
        {
            if (flatList[i].encounter)
            {
                flatList[i].setRevealLevel(level);
            }
        }
    }
    /**
	 * Reveal `n` locations.
	 * If `n` is float: `n = i + f` (`i` is int and `0<f<1`),
	 * then reveal either `i` or `i+1` locations, with `f` chance to reveal `i+1`
	 *
	 * @example
	 * revealMultiple(3.4) = 60% to reveal 3,
	 *                       40% to reveal 4
	 */
    public function revealMultiple(n : Float) : Void
    {
        if (Math.isNaN(n) || n <= 0)
        {
            return;
        }
        if (n == -Infinity)
        {
            revealAll();
            return;
        }
        var i : Int = randomIncrement(n);
        while (i-- > 0)
        {
            if (!revealRandom())
            {
                break;
            }
        }
    }
    public function setTags(tags : Array<Dynamic> = null) : Void
    {
        for (tag in tags)
        {
            this.areaTags[tag] = true;
        }
    }
    private function clearNext() : Void
    {
        for (e in nextNodes)
        {
            e.isNext = false;
        }
        nextNodes = [];
    }
    private function selectRoad(i : Int) : Void
    {
        roadIndex = i;
        road = roads[i];
        clearNext();
        nextNodes.push(road[0]);
        road[0].isNext = true;
        roadPos = 0;
        disableUnreachable();
    }
    private function disableUnreachable() : Void
    {
        if (road == null)
        {
            return;
        }
        var reachable : Dictionary = new Dictionary();
        var queue : Array<Dynamic> = nextNodes.copy();
        while (queue.length > 0)
        {
            var e : ExplorationEntry = queue.pop();
            if (e.isDisabled || !e.encounter || Reflect.field(reachable, Std.string(e)) != null)
            {
                continue;
            }
            queue = queue.concat(e.nextNodes);
            Reflect.setField(reachable, Std.string(e), true);
        }
        for (e in flatList)
        {
            if (!e.isDisabled && e.encounter && Reflect.field(reachable, Std.string(e)) == null)
            {
                trace("Unreachable: " + e);
                e.markDisabled();
            }
        }
    }
    private function selectRoadAndExploreNext(i : Int) : Void
    {
        selectRoad(i);
        execEntry(road[0]);
    }
    @:allow(classes.scenes.aPI)
    private function entryClick(entry : ExplorationEntry) : Void
    {
        if (!entry.isNext)
        {
            return;
        }
        if (roadIndex < 0)
        
        // Select road{
            
            for (i in 0...NROADS)
            {
                if (roads[i][0] == entry)
                {
                    selectRoadAndExploreNext(i);
                    return;
                }
            }
        }
        else if (Lambda.indexOf(nextNodes, entry) >= 0)
        {
            execEntry(entry);
        }
    }
    
    private function execEntry(entry : ExplorationEntry) : Void
    {
        trace("explorer.execEntry", entry.encounterName);
        clearOutput();
        if (currentEntry != null)
        {
            trace("WARNING: ExplorationEntry " + currentEntry.encounter.encounterName() + " was not resolved");
            currentEntry.isPlayerHere = false;
        }
        currentEntry = entry;
        if (playerEntry != null)
        {
            playerEntry.isPlayerHere = false;
        }
        entry.isPlayerHere = true;
        playerEntry = entry;
        roadPos = entry.roadPos;
        roadIndex = entry.roadIndex;
        clearNext();
        for (next/* AS3HX WARNING could not determine type for var: next exp: EField(EIdent(entry),nextNodes) type: null */ in entry.nextNodes)
        {
            if (next.encounter && !next.isDisabled)
            {
                next.isNext = true;
                nextNodes.push(next);
            }
        }
        disableUnreachable();
        if (onEncounter != null)
        {
            if (onEncounter(entry))
            {
                return;
            }
        }
        entry.encounter.execEncounter();
    }
    private function createMap() : Sprite
    {
        var map : Sprite = new Sprite();
        var g : Graphics = map.graphics;
        
        if (roadIndex < 0)
        {
            startPos.isPlayerHere = true;
            playerEntry = startPos;
        }
        startPos.redraw();
        map.addChild(startPos.sprite);
        
        for (i in 0...NROADS)
        {
            for (j in 0...MAXDEPTH)
            {
                var node : ExplorationEntry = roads[i][j];
                if (node.encounter)
                
                // draw the sprite{
                    
                    node.redraw();
                    map.addChild(node.sprite);
                    if (j == 0)
                    
                    // draw the lines from startPos{
                        
                        var lineColor : String;
                        if (node.isDisabled)
                        {
                            lineColor = LINE_DISABLED;
                        }
                        else if (node.isNext)
                        {
                            lineColor = LINE_NEXT;
                        }
                        else
                        {
                            lineColor = LINE_COLOR;
                        }
                        g.lineStyle(LINE_WIDTH, Color.convertColor(lineColor));
                        g.moveTo(startPos.centerX, startPos.centerY);
                        var midx : Float = (startPos.centerX + node.centerX) / 2;
                        g.lineTo(midx, startPos.centerY);
                        g.lineTo(midx, node.centerY);
                        if (roadIndex < 0)
                        {
                            var tf : TextField = UIUtils.newTextField({
                                        text : "" + (i + 1),
                                        x : midx + 2,
                                        y : node.centerY,
                                        defaultTextFormat : {
                                            font : mainView.mainText.defaultTextFormat.font,
                                            size : as3hx.Compat.parseFloat(mainView.mainText.defaultTextFormat.size) - 2,
                                            color : mainView.mainText.defaultTextFormat.color
                                        }
                                    });
                            map.addChild(tf);
                            tf.y -= tf.height;
                        }
                        g.lineTo(node.centerX, node.centerY);
                    }
                    for (next/* AS3HX WARNING could not determine type for var: next exp: EField(EIdent(node),nextNodes) type: null */ in node.nextNodes)
                    {
                        if (!next.encounter)
                        {
                            continue;
                        }
                        if (next.isDisabled)
                        {
                            lineColor = LINE_DISABLED;
                        }
                        else if (next.isNext && node.isPlayerHere)
                        {
                            lineColor = LINE_NEXT;
                        }
                        else
                        {
                            lineColor = LINE_COLOR;
                        }
                        g.lineStyle(LINE_WIDTH, Color.convertColor(lineColor));
                        g.moveTo(node.centerX, node.centerY);
                        g.lineTo(next.centerX, next.centerY);
                    }
                }
            }
        }
        
        return map;
    }
    private function showUI(message : String = "") : Void
    {
        var i : Int;
        var e : ExplorationEntry = null;
        // If there is an encounter with chance ALWAYS, stop the exploration and execute it immediately
        i = 0;
        while (e == null && i < N)
        {
            if (flatList[i].encounter && !flatList[i].isDisabled && flatList[i].encounter.encounterChance() == Encounters.ALWAYS)
            {
                e = flatList[i];
            }
            i++;
        }
        // Check to pool for same
        i = 0;
        while (e == null && i < source.components.length)
        {
            if (source.components[i].encounterChance() >= Encounters.ALWAYS)
            {
                e = new ExplorationEntry(roadIndex, roadPos, 0, 0);
                e.setupForEncounter(try cast(source.components[i], SimpleEncounter) catch(e:Dynamic) null);
                e.revealFull();
            }
            i++;
        }
        if (e != null)
        
        // stopExploring(); // Encounter is responsible for stopping the exploration, if needed{
            
            if (onEncounter != null)
            {
                onEncounter(e);
            }
            e.encounter.execEncounter();
            return;
        }
        
        // Buttons
        // [Forward/Path 1] [Path 2] [Path 3] [Path 4] [Path 5]
        // [   SoulSense  ] [      ] [      ] [      ] [      ]
        // [   Inventory  ] [ Mast ] [Repeat] [ReRoll] [Leave ]
        clearOutput();
        spriteSelect();
        if (_errors != null)
        {
            outputText(_errors);
        }
        outputText(prompt);
        if (message != null)
        {
            outputText("\n" + message);
        }
        var overlust : Int = camp.overLustCheck();
        mainView.setCustomElement(createMap());
        menu();
        if (road != null)
        {
            var n : Int = 0;
            for (node in nextNodes)
            {
                if (node != null && node.isNext && node.encounter)
                {
                    var label : String;
                    if (node.roadIndex > roadIndex)
                    {
                        label = "South";
                    }
                    else if (node.roadIndex < roadIndex)
                    {
                        label = "North";
                    }
                    else
                    {
                        label = "Forward";
                    }
                    button(n).show(label, curry(execEntry, node)).hint(node.tooltipText, node.tooltipHeader);
                    n++;
                }
            }
            if (n == 0)
            
            // End of the road{
                
                onEnd.applyTo(button(0));
                button(0).call(function() : Void
                        {
                            stopExploring();
                            onEnd.callback.call();
                        });
            }
        }
        // Road not picked
        else
        {
            
            for (i in 0...NROADS)
            {
                var b : CoCButton = ((NROADS <= 3)) ? button(i * 5) : button(i);
                if (roads[i][0] != null && roads[i][0].encounter)
                {
                    b.show("Path " + (i + 1), curry(selectRoadAndExploreNext, i));
                }
            }
        }
        if (canSoulSense && player.hasPerk(PerkLib.SoulSense))
        {
            button(5).show("Soul Sense", doSoulSense).hint("Use your soul sense to detect people.\n\nSoulforce cost: " + soulSenseCost()).disableIf(player.soulforce < soulSenseCost());
        }
        button(10).show("Inventory", curry(inventory.showInventoryMenu, doExplore)).hint("Use an item or manage your equipment.").disableIf(!canInventory);
        SceneLib.masturbation.masturButton(11).disableIf(!canMasturbate);
        if (playerEntry != null && playerEntry.encounter && playerEntry.reenter)
        {
            button(12).show("Repeat", curry(execEntry, playerEntry)).hint("Repeat the '" + playerEntry.label + "' encounter.");
        }
        if (overlust == 2 && canMasturbate)
        {
            if (!isAtEnd)
            {
                for (i in 0...NROADS)
                {
                    button(i).disable("You're too aroused to explore!");
                }
                button(12).disable("You're too aroused to explore!");
            }
        }
        button(13).show("Re-roll", normalReroll).hint("Use 30 min to re-roll current area explore nodes.");
        
        if (debug)
        {
            button(14).show("Menu", cheatMenu);
        }
        else if (leave != null && !finished && !isAtEnd)
        {
            leave.applyTo(button(14));
        }
        if (onMenu != null)
        {
            onMenu();
        }
        mainViewManager.updateCharviewIfNeeded();
    }
    private function normalReroll() : Void
    {
        for (i in 0...N)
        {
            flatList[i].isPlayerHere = false;
        }
        generateAll();
        skillBasedReveal(lastAreaLevel, lastTimesExplored);
        advanceMinutes(30);
        showUI();
    }
    public function cheatMenu() : Void
    {
        var cheatReveal : Int->Void = function(level : Int) : Void
        {
            revealAll(level);
            showUI();
        }
        
        var cheatReroll : Void->Void = function() : Void
        {
            for (i in 0...N)
            {
                flatList[i].isPlayerHere = false;
            }
            generateAll();
            showUI();
        }
        
        statScreenRefresh();
        menu();
        button(0).show("Reveal(0)", curry(cheatReveal, 0)).hint("Hide all");
        button(1).show("Reveal(1)", curry(cheatReveal, 1)).hint("Partially reveal all");
        button(2).show("Reveal(2)", curry(cheatReveal, 2)).hint("Fully reveal all");
        if (!finished)
        {
            button(3).show("Re-roll", cheatReroll).hint("Recreate the map");
        }
        button(4).show("Camp", camp.returnToCampUseOneHour).hint("Return to camp");
        
        if (leave != null && !finished && !isAtEnd)
        {
            leave.applyTo(button(13));
        }
        button(14).show("Back", showUI).icon("Back");
    }
    public function generateAt(roadNo : Int, roadPos : Int) : Void
    {
        generate(roads[roadNo][roadPos], 1);
    }
    public function setEncounterObjectAt(roadNo : Int, roadPos : Int, encounter : SimpleEncounter) : Void
    {
        roads[roadNo][roadPos].setupForEncounter(encounter);
    }
    
    /**
	 * Find the encounter with specific name in the source and put in on the map.
	 * Call after prepareArea().
	 * @param roadNo Road number 0..4
	 * @param roadPos Position on road 0..6
	 * @param encounterName
	 */
    public function setEncounterAt(roadNo : Int, roadPos : Int, encounterName : String) : Void
    {
        var e : SimpleEncounter = source.findByName(encounterName);
        if (e != null)
        {
            setEncounterObjectAt(roadNo, roadPos, e);
        }
    }
    /**
	 *
	 * @param entry
	 * @param special 0: first, 1: mid, 2: last
	 */
    private function generate(entry : ExplorationEntry, special : Int) : Void
    {
        var nTries : Int = 10;
        var filter : Function = filters[special];
        while (nTries-- > 0)
        {
            var e : SimpleEncounter = try cast(source.pickEncounter(filter), SimpleEncounter) catch(e:Dynamic) null;
            if (e == null)
            {
                continue;
            }
            entry.setupForEncounter(e);
            return;
        }
        entry.setEmpty();
    }
    private function generateAll() : Void
    {
        clearNext();
        var i : Int;
        var j : Int;
        for (i in 0...N)
        {
            flatList[i].unlink();
        }
        for (i in 0...NROADS)
        {
            var length : Int = (maxDepth <= 2) ? randIntIn(1, maxDepth) : randIntIn(2, maxDepth);
            trace("Road " + i + " length " + length);
            j = as3hx.Compat.parseInt(length - 1);
            while (j >= 0)
            {
                generate(roads[i][j], 
                        (j == length - 1) ? 2 : (j == 0) ? 0 : 1
            );
                if (!roads[i][j].encounter)
                {
                    break;
                }
                if (j > 0)
                {
                    roads[i][j - 1].link(roads[i][j]);
                }
                j--;
            }
            for (j in length...MAXDEPTH)
            {
                roads[i][j].setEmpty();
            }
            if (roads[i][0].encounter)
            {
                roads[i][0].isNext = true;
                nextNodes.push(roads[i][0]);
                startPos.link(roads[i][0]);
            }
        }
        if (branchChance > 0)
        {
            for (i in 0...NROADS)
            {
                for (j in 0...MAXDEPTH - 1)
                {
                    if (!roads[i][j].encounter)
                    {
                        continue;
                    }
                    if (i > 0)
                    
                    // North branch{
                        
                        // Avoid crossing the ~~beams~~ branches:
                        // i-1;j  --- i-1;j+1
                        //   i;j  ---   i;j+1
                        // link SW to NE if no link from NW to SE
                        if ((crossingAllowed || roads[i - 1][j].nextNodes.indexOf(roads[i][j + 1]) == -1)
                            && roads[i - 1][j + 1].encounter
                            && Math.random() < branchChance)
                        {
                            roads[i][j].link(roads[i - 1][j + 1]);
                        }
                    }
                    if (i < NROADS - 1)
                    
                    // South branch{
                        
                        if ((crossingAllowed || roads[i + 1][j].nextNodes.indexOf(roads[i][j + 1]) == -1)
                            && roads[i + 1][j + 1].encounter
                            && Math.random() < branchChance)
                        {
                            roads[i][j].link(roads[i + 1][j + 1]);
                        }
                    }
                }
            }
        }
        for (i in 0...NROADS)
        {
            var s : String = "Road " + i + " is";
            for (j in 0...MAXDEPTH)
            {
                s += " ";
                s += roads[i][j].encounterName;
            }
            trace(s);
        }
        initialized = true;
        road = null;
        roadIndex = -1;
        roadPos = 0;
        currentEntry = null;
    }
    private function validate() : Void
    {
        for (i in 0...NROADS)
        {
            for (j in 0...MAXDEPTH)
            {
                var e : ExplorationEntry = roads[i][j];
                if (!e.isCleared && !e.isDisabled && e.encounter && e.encounter.originalChance() <= 0)
                {
                    trace("Regenerating entry " + i + ";" + j + " " + e.encounterName);
                    e.encounter = null;
                    var special : Int = 1;
                    if (j == 0)
                    {
                        special = 0;
                    }
                    if (j + 1 == MAXDEPTH || roads[i][j + 1].isDisabled)
                    {
                        special = 2;
                    }
                    generate(e, special);
                }
            }
        }
    }
    
    public function skillBasedReveal(areaLevel : Float, timesExplored : Float) : Void
    {
        var n : Float = 0;
        
        // +1 reveal per 100 area explorations
        n += timesExplored / 100;
        
        // Wisdom-based reveal:
        // * first reveal costs 10 wisdom, scaled with NG+ and area level
        // * each following reveal costs 5% more wis
        var wisFactor : Float = 10;
        wisFactor *= 1 + 4 * (areaLevel - 1) / 99;  // x1 on area level 1, x4 on area level 100  
        wisFactor *= (1 + 0.2 * CoC.instance.newGamePlusMod());  // +20% per NG level  
        n += solveSum(player.wis, wisFactor, wisFactor * 0.05);
        
        // +1 reveal per Eyes of the Hunter rank
        if (player.hasPerk(PerkLib.EyesOfTheHunterNovice))
        {
            n += 1;
        }
        if (player.hasPerk(PerkLib.EyesOfTheHunterAdept))
        {
            n += 1;
        }
        if (player.hasPerk(PerkLib.EyesOfTheHunterExpert))
        {
            n += 1;
        }
        if (player.hasPerk(PerkLib.EyesOfTheHunterMaster))
        {
            n += 1;
        }
        if (player.hasPerk(PerkLib.EyesOfTheHunterGrandMaster))
        {
            n += 1;
        }
        if (player.hasPerk(PerkLib.EyesOfTheHunterEx))
        {
            n += 1;
        }
        if (player.hasPerk(PerkLib.EyesOfTheHunterSu))
        {
            n += 1;
        }
        if (player.hasPerk(PerkLib.JobEsper))
        {
            n += 1;
        }
        
        lastAreaLevel = areaLevel;
        lastTimesExplored = timesExplored;
        
        revealMultiple(n);
    }
    public function soulSenseCost() : Float
    {
        return 100;
    }
    public static function defaultSoulseSenseCheck(e : SimpleEncounter) : Bool
    {
        return e.getKind() == "npc";
    }
    public function doSoulSense() : Void
    {
        player.soulforce -= soulSenseCost();
        statScreenRefresh();
        
        var candidates : Array<Dynamic> = [];
        var message : String = "";
        for (i in 0...N)
        {
            var e : ExplorationEntry = flatList[i];
            if (e.isDisabled || e.isFullyRevealed)
            {
                continue;
            }
            if (soulSenseCheck(e.encounter))
            {
                candidates.push(e);
            }
        }
        if (candidates.length == 0)
        {
            var encounter : SimpleEncounter = try cast(source.pickEncounterOrNull(filterForSoulSense), SimpleEncounter) catch(e:Dynamic) null;
            if (encounter != null)
            {
                var entry : ExplorationEntry = addNode(encounter);
                if (entry != null)
                {
                    entry.revealKind();
                    message = "You've found something!";
                }
                else
                {
                    message = "You reach out, but your soul sense detects nothing special.";
                }
            }
            else
            {
                message = "You reach out, but your soul sense detects nothing special.";
            }
        }
        else
        {
            e = Utils.randomChoice(candidates);
            e.incReveal();
            if (e.isFullyRevealed)
            {
                message = "You've found " + e.label + "!";
            }
            else
            {
                message = "You've found something!";
            }
        }
        
        showUI(message);
    }
    
    /**
	 * Add an encounter at the end of the road
	 * @param encounter
	 * @param roadIndex 0..NROADS-1, or -1 for random
	 * @return exploration node, null if impossible to add
	 */
    public function addNode(encounter : SimpleEncounter, roadIndex : Int = -1) : ExplorationEntry
    {
        if (encounter == null)
        {
            return null;
        }
        if (roadIndex == -1)
        {
            var indices : Array<Dynamic> = [];
            for (i in 0...NROADS)
            {
                var n : Int = roadLength(i);
                if (n < MAXDEPTH && (n == 0 || !roads[i][n - 1].isDisabled))
                {
                    indices.push(i);
                }
            }
            if (indices.length == 0)
            {
                return null;
            }
            roadIndex = randomChoice(indices);
        }
        var roadPos : Int;
        var entry : ExplorationEntry;
        for (roadPos in 0...MAXDEPTH)
        {
            entry = roads[roadIndex][roadPos];
            if (!entry.encounter)
            {
                break;
            }
        }
        if (roadPos >= MAXDEPTH)
        {
            return null;
        }
        entry.setupForEncounter(encounter);
        roads[roadIndex][roadPos - 1].link(entry);
        return entry;
    }
    
    /**
	 * Remove last entry from road
	 * @param roadIndex 0..4
	 */
    public function removeLast(roadIndex : Int) : Void
    {
        var rl : Int = roadLength(roadIndex);
        if (rl > 0)
        {
            var entry : ExplorationEntry = roads[roadIndex][rl - 1];
            entry.setEmpty();
            startPos.unlinkOne(entry);
            for (e2 in flatList)
            {
                e2.unlinkOne(entry);
            }
        }
    }
}


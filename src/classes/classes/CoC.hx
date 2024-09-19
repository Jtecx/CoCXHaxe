/*
 CoC Main File - This is what loads when the game begins. If you want
 to start understanding the structure of CoC, this is the place to start.
 First, we import all the classes from many different files across the codebase.
 It would be wise not to alter the
 order of these imports until more is known about what needs to load and when.
*/

package classes;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.globalFlags.KACHIEVEMENTS;
import classes.globalFlags.KFLAGS;
import classes.items.*;
import classes.scenes.aPI.Encounter;
import classes.scenes.aPI.Encounters;
import classes.scenes.aPI.SimpleEncounter;
import classes.scenes.QuestLib;
import classes.transformations.TransformationLib;
import classes.display.DebugInfo;
import classes.display.PerkMenu;
import classes.display.SpriteDb;
import classes.internals.Utils;
import coc.model.GameModel;
import coc.model.TimeModel;
import coc.view.CoCButton;
import coc.view.IconLib;
import coc.view.MainView;
import coc.xxc.Story;
import coc.xxc.StoryCompiler;
import coc.xxc.StoryContext;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.*;
import flash.net.RegisterClassAlias;
import flash.text.TextFormat;
import mx.logging.Log;
import mx.logging.LogEventLevel;
import mx.logging.targets.TraceTarget;

// BREAKING ALL THE RULES.
/****
 classes.CoC: The Document class of Corruption of the Champions.
 ****/
// This class instantiates the game. If you create a new place/location/scene you'll likely have to add it into here.
// Add in descriptions for the include statements. Many of the description text code is inside of these.
// Suggest moving or removing old comments referencing things that aren't needed anymore.
@:meta(SWF(width="1420",height="800",pageTitle="Corruption of Champions",backgroundColor="#000000"))

class CoC extends MovieClip
{
    public static var instance(get, never) : CoC;
    public var inCombat(get, set) : Bool;
    public var gameState(get, never) : Int;

    
    private static var _instance : CoC;
    private static function get_instance() : CoC
    {
        return _instance;
    }
    //Game Version
    public var debugGameVer : String = "v0.9a.264";
    
    //Mod save version.
    public var modSaveVersion : Float = 36.58;
    public var levelCap(default, never) : Float = 205;
    
    //Lock cheats menus from public
    // builds.
    public var lockCheats : Bool = true;
    
    //Used to restrict random drops from overlapping uniques
    public var plotFight : Bool = false;
    public var timeQ : Float = 0;  // Queued hours  
    public var timeQmin : Int = 0;  // Queued minutes  
    
    /*private static var doCamp:Function; //Set by campInitialize, should only be called by playerMenu
    private static function campInitialize(passDoCamp:Function):void { doCamp = passDoCamp; }*/
    
    public var charCreation : CharCreation = new CharCreation();
    public var saves : Saves = new Saves(gameStateDirectGet, gameStateDirectSet);
    public var playerAppearance : PlayerAppearance = new PlayerAppearance();
    // Libraries
    public var mutations : Mutations = new Mutations();
    public var transformations : TransformationLib = new TransformationLib();
    // Items/
    public var itemTemplates : ItemTemplateLib = new ItemTemplateLib();
    public var consumables : ConsumableLib = new ConsumableLib();
    public var useables : UseableLib = new UseableLib();
    public var weapons : WeaponLib = new WeaponLib();
    public var weaponsrange : WeaponRangeLib = new WeaponRangeLib();
    public var weaponsflyingswords : FlyingSwordsLib = new FlyingSwordsLib();
    public var armors : ArmorLib = new ArmorLib();
    public var undergarments : UndergarmentLib = new UndergarmentLib();
    public var miscjewelries : MiscJewelryLib = new MiscJewelryLib();
    public var headjewelries : HeadJewelryLib = new HeadJewelryLib();
    public var necklaces : NecklaceLib = new NecklaceLib();
    public var jewelries : JewelryLib = new JewelryLib();
    public var shields : ShieldLib = new ShieldLib();
    public var vehicles : VehiclesLib = new VehiclesLib();
    
    public var questLib : QuestLib;
    
    
    // Force updates in Pepper Flash ahuehue
    private var _updateHack : Sprite = new Sprite();
    
    public var mainViewManager : MainViewManager = new MainViewManager();
    public var mainMenu : MainMenu = new MainMenu();
    public var perkMenu : PerkMenu = new PerkMenu();
    public var playerInfo : PlayerInfo = new PlayerInfo();
    public var debugInfoMenu : DebugInfo = new DebugInfo();
    public var gameSettings : GameSettings = new GameSettings();
    public var rootStory : Story = new Story("story", null, "root", true);
    public var compiler : StoryCompiler = new StoryCompiler("content/").attach(rootStory);
    public var context : StoryContext;
    
    public var perkTree : PerkTree;
    
    /****
     This is used purely for bodges while we get things cleaned up.
     Hopefully, anything you stick to this object can be removed eventually.
     I only used it because for some reason the Flash compiler wasn't seeing
     certain functions, even though they were in the same scope as the
     function calling them.
     ****/
    //Looks like this dangerous little var is no longer used anywhere, huzzah.		public var semiglobalReferencer :* = {};
    
    public var mainView : MainView;
    
    public var model : GameModel;
    
    // ALL THE VARIABLES:
    // Declare the various global variables as class variables.
    // Note that they're set up in the constructor, not here.
    /**
     * True if currently loading save.
     */
    public var isLoadingSave : Bool;
    public var debug : Bool;
    public var ver : String;
    public var version : String;
    public var versionID : Int = 0;
    public var permObjVersionID : Int = 0;
    public var images : ImageManager;
    public var player : Player;
    public var player2 : Player;
    public var monster : Monster;
    public var flags : DefaultDict;
    public var achievements : DefaultDict;
    private var _gameState : Int;
    public var time : TimeModel;
    public var textHistory : Array<Dynamic>;
    public var currentText : String;
    public var oldStats : Dynamic;  // I *think* this is a generic object  
    public var inputManager : InputManager;
    public var monkey : ChaosMonkey;
    public var testingBlockExiting : Bool;
    
    public var kFLAGS_REF : Dynamic;
    public var kACHIEVEMENTS_REF : Dynamic;
    
    private function get_inCombat() : Bool
    {
        return _gameState == 1;
    }
    
    private function set_inCombat(value : Bool) : Bool
    {
        _gameState = ((value) ? 1 : 0);
        return value;
    }
    
    public function resetGameState() : Void
    {
        _gameState = 3;
    }
    private function gameStateDirectGet() : Int
    {
        return _gameState;
    }
    
    private function gameStateDirectSet(value : Int) : Void
    {
        _gameState = value;
    }
    
    /**
     * Raw NG+ level
     */
    public function newGamePlusLevel() : Int
    {
        return flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
    }
    
    /**
     * NG+ level capped
     */
    public function newGamePlusMod() : Int
    {
        return Utils.boundInt(0, newGamePlusLevel(), 5);
    }
    public function newGamePlusFactor() : Float
    {
        return 1 + newGamePlusMod();
    }
    
    private static function setUpLogging() : Void
    {
        var traceTarget : TraceTarget = new TraceTarget();
        
        traceTarget.level = LogEventLevel.WARN;
        
        /* AS3HX WARNING namespace modifier CONFIG::debug */{
            traceTarget.level = LogEventLevel.DEBUG;
        }
        
        //Add date, time, category, and log level to the output
        traceTarget.includeDate = true;
        traceTarget.includeTime = true;
        traceTarget.includeCategory = true;
        traceTarget.includeLevel = true;
        
        // let the logging begin!
        Log.addTarget(traceTarget);
    }
    
    public function new()
    {
        super();
        _instance = this;
        context = new StoryContext(this);
        
        questLib = new QuestLib();
        
        this.kFLAGS_REF = kFLAGS;
        this.kACHIEVEMENTS_REF = kACHIEVEMENTS;
        // cheat for the parser to be able to find kFLAGS
        // If you're not the parser, DON'T USE THIS
        
        // This is a flag used to prevent the game from exiting when running under the automated tester
        // (the chaos monkey)
        testingBlockExiting = false;
        
        // Used for stopping chaos monkey on syntax errors. Separate flag so we can make stopping optional
        CoC_Settings.haltOnErrors = false;
        
        this.model = new GameModel();
        this.mainView = new MainView();
        this.mainView.name = "mainView";
        this.mainView.addEventListener("addedToStage", _postInit);
        this.stage.addChild(this.mainView);
        //DEBUG-SPECIFIC CONFIG SETTINGS
        if (CoC_Settings.debugBuild)
        {
            lockCheats = false;
        }
    }
    private function _postInit(e : Event) : Void
    // Hooking things to MainView.
    {
        
        this.mainView.onNewGameClick = charCreation.newGameGo;
        this.mainView.onAppearanceClick = playerAppearance.appearance;
        this.mainView.onDataClick = saves.saveLoad;
        this.mainView.onLevelClick = playerInfo.levelUpMenu;
        this.mainView.onPerksClick = perkMenu.displayPerks;
        this.mainView.onStatsClick = playerInfo.displayStats;
        this.mainView.onBottomButtonClick = function(i : Int, button : CoCButton) : Void
                {
                    textHistory.push("<br>[" + button.labelText + "]<br>");
                };
        CoCButton.clickErrorHandler =function(error : Error, button : CoCButton) : Void
                {
                    trace(error.getStackTrace());
                    EngineCore.addButton(0, "Rescue", EventParser.playerMenu);
                    mainView.mainText.htmlText +=
                    "\n----\nError in scene: " + error.message + "\n" + error.getStackTrace() + "\n----\n";
                }  // ******************************************************************************************    // Set up all the messy global stuff:  ;
        
        
        
        
        
        
        
        var mainView : MainView = this.mainView;
        var model : GameModel = this.model;
        
        
        /**
         * Global Variables used across the whole game. I hope to whittle it down slowly.
         */
        
        /**
         * System Variables
         * Debug, Version, etc
         */
        //{ region SystemVariables
        
        //DEBUG, used all over the place
        debug = false;
        
        //Version NUMBER
        ver = "1.0.2_mod_Xianxia_" + debugGameVer;
        ver += " (<b></b>)";
        
        this.images = new ImageManager(stage, mainView);
        this.inputManager = new InputManager(stage, mainView, false);
        new ControlBindings().run(inputManager);
        
        this.monkey = new ChaosMonkey(this);
        
        //} endregion
        
        /**
         * Player specific variables
         * The player object and variables associated with the player
         */
        //{ region PlayerVariables
        
        //The Player object, used everywhere
        //player = new Player();
        model.player = player;
        player2 = new Player();
        new PlayerEvents();
        
        //Used in perk selection, mainly eventParser, input and engineCore
        //tempPerk = null;
        
        //Create monster, used all over the place
        monster = new Monster();
        //} endregion
        
        /**
         * State Variables
         * They hold all the information about item states, menu states, game states, etc
         */
        //{ region StateVariables
        
        
        //The extreme flag state array. This needs to go. Holds information about everything, whether it be certain attacks for NPCs
        //or state information to do with the game.
        flags = new DefaultDict();
        
        achievements = new DefaultDict();
        
        ///Used everywhere to establish what the current game state is
        // Key system variables
        //0 = normal
        //1 = in combat
        //2 = in combat in grapple
        //3 = at start or game over screen
        _gameState = 0;
        
        //} endregion
        
        /**
         * Display Variables
         * Variables that hold display information like number of days and all the current displayed text
         */
        //{ region DisplayVariables
        
        //Holds the date and time display in the bottom left
        time = new TimeModel();
        model.time = time;
        
        //The string holds all the "story" text, mainly used in engineCore
        currentText = "";
        textHistory = [];
        //}endregion
        
        
        // These are toggled between by the [home] key.
        mainView.textBGWhite.visible = false;
        mainView.textBGTan.visible = false;
        
        // *************************************************************************************
        
        //Used for stat tracking to keep up/down arrows correct.
        oldStats = { };
        model.oldStats = oldStats;
        oldStats.oldStr = 0;
        oldStats.oldTou = 0;
        oldStats.oldSpe = 0;
        oldStats.oldInte = 0;
        oldStats.oldSens = 0;
        oldStats.oldLib = 0;
        oldStats.oldCor = 0;
        oldStats.oldHP = 0;
        oldStats.oldLust = 0;
        oldStats.oldFatigue = 0;
        oldStats.oldSoulforce = 0;
        oldStats.oldHunger = 0;
        
        // ******************************************************************************************
        
        //mainView._getButtonToolTipText = getButtonToolTipText;
        
        
        //Register the classes we need to be able to serialize and reconstitute so
        // they'll get reconstituted into the correct class when deserialized
        registerClassAlias("AssClass", AssClass);
        registerClassAlias("Character", Character);
        registerClassAlias("Cock", Cock);
        registerClassAlias("CockTypesEnum", CockTypesEnum);
        registerClassAlias("Enum", Enum);
        registerClassAlias("Creature", Creature);
        registerClassAlias("ItemSlotClass", ItemSlotClass);
        registerClassAlias("KeyItemClass", KeyItemClass);
        registerClassAlias("Monster", Monster);
        registerClassAlias("Player", Player);
        registerClassAlias("StatusEffectClass", StatusEffectClass);
        registerClassAlias("VaginaClass", VaginaClass);
        //registerClassAlias("Enum", Enum);
        
        Encounters.hookAdjustChance = adjustEncounterChance;
        Encounters.hookOnSelect = onEncounterSelect;
        Encounters.hookBeforeSelect = beforeEncounterSelect;
        
        //Hide sprites
        mainView.hideSprite();
        //Hide up/down arrows
        mainView.statsView.hideUpDown();
        new Story("lib", rootStory, "monsters", true);
        execPostInit();
        loadStory();
        IconLib.INSTANCE.loadIcons();
        this.addFrameScript(0, this.run);
    }
    private function beforeEncounterSelect(pool : Array<Dynamic>) : Void
    {  // Disabled - interferes with the new encounter system  
        /*
        while (true) {
        var tw:Number = 0;
        for each (var e:Encounter in pool) {
        var ec:Number = Encounters.chance(pool,e);
        if (ec > 0) tw += ec;
        }
        if (tw > 0 || !isFinite(tw)) break;
        // all encounters are "exhausted", reset their adjustments
        var hasSE:Boolean = false;
        var strace:String = "resetting encounters:";
        for each (e in pool) {
        var s:SimpleEncounter = e as SimpleEncounter;
        if (!s || s.adjustment >= 0) continue;
        var bc:Number = s.originalChance();
        if (bc > 0 && isFinite(bc)) {
        hasSE = true;
        s.adjustment += bc;
        strace += " " + s.encounterName() + "=" + Encounters.ch2str(Encounters.chance(pool, s));
        }
        }
        trace(strace);
        if (!hasSE) break; // somehow total chance is <=0 but there are no SimpleEncounters to work with
        }
        */
        
    }
    private function adjustEncounterChance(pool : Array<Dynamic>, e : Encounter, c : Float) : Float
    {
        if (c == Encounters.ALWAYS)
        {
            return c;
        }
        if (Std.is(e, SimpleEncounter))
        {
            if (Lambda.has(e, "day") && Reflect.field(e, "day") == null && !BaseContent.isNightTime)
            {
                return 0;
            }
            if (Lambda.has(e, "night") && Reflect.field(e, "night") == null && BaseContent.isNightTime)
            {
                return 0;
            }
        }
        return c;
    }
    private function onEncounterSelect(pool : Array<Dynamic>, pick : Encounter) : Void
    {  // How chance adjustment works  
        // When event is picked, we reduce its chance by 0.1 to simulate "picking a card"
        // When all events total to <= 0, we reset their adjustment to +baseChance to simulate "returning cards to deck"
        // 0.1 is selected to work well with typical magnitudes
        // Smaller - more randomness
        // Bigger - more predictability
        // Too big - all events fire one by one during first shuffle
        
        // Disabled - interferes with the new encounter system
        // if (pick is SimpleEncounter) (pick as SimpleEncounter).adjustment -= 0.1;
        
    }
    
    private function loadStory() : Void
    {
        compiler.includeFile("coc.xml", true);
    }
    
    public function run() : Void
    {
        this.inputManager.showHotkeys = false;
        trace("Initializing races");
        Races.load();
        trace("Initializing perks");
        PerkLib.initDependencies();
        perkTree = new PerkTree();
        EnchantmentLib.instance;
        mainMenu.mainMenu();
        this.stop();
        
        if (_updateHack != null)
        {
            _updateHack.name = "wtf";
            _updateHack.graphics.beginFill(0xFF0000, 1);
            _updateHack.graphics.drawRect(0, 0, 2, 2);
            _updateHack.graphics.endFill();
            
            stage.addChild(_updateHack);
            _updateHack.x = 999;
            _updateHack.y = 799;
        }
    }
    
    public function forceUpdate() : Void
    {
        _updateHack.x = 999;
        _updateHack.addEventListener(Event.ENTER_FRAME, moveHackUpdate);
    }
    
    public function moveHackUpdate(e : Event) : Void
    {
        _updateHack.x -= 84;
        
        if (_updateHack.x < 0)
        {
            _updateHack.x = 0;
            _updateHack.removeEventListener(Event.ENTER_FRAME, moveHackUpdate);
        }
    }
    
    public function spriteSelect(choice : Class<Dynamic> = null) : Void
    // Inlined call from lib/src/coc/view/MainView.as
    {
        
        if (choice == null || flags[kFLAGS.SHOW_SPRITES_FLAG] == 1)
        {
            mainViewManager.hideSprite();
        }
        else
        {
            mainViewManager.showSpriteBitmap(SpriteDb.bitmapData(choice));
        }
    }
    
    public function outputHistory() : Void
    {
        mainView.hideTestInputPanel();
        EngineCore.clearOutputTextOnly();
        var txt : String = textHistory.join("<br>");
        textHistory = [];
        EngineCore.rawOutputText(txt);
        // On the next animation frame
        as3hx.Compat.setTimeout(function() : Void
                {
                    mainView.scrollBar.value = mainView.scrollBar.maximum;
                }, 0);
    }
    /*
    public static function main(container:DisplayObjectContainer):void {
//			MainView._layout = layout;

    container.addChild(new CoC(container.stage).mainView);
    /!*var e:DisplayObjectContainer = main.parent;
     while (e && !e.stage) e = e.parent;
     new CoC(e?e.stage:null);*!/
    }
    */
    public static inline var STAT_GAIN_CLASSIC : Int = 0;
    public function flushOutputTextToGUI() : Void
    {
        var fmt : TextFormat = mainView.mainText.defaultTextFormat;
        
        if (flags[kFLAGS.CUSTOM_FONT_SIZE] != 0)
        {
            fmt.size = flags[kFLAGS.CUSTOM_FONT_SIZE];
        }
        fmt.color = (mainViewManager.darkThemeImpl()) ? 0xffffff : 0;
        mainView.mainText.defaultTextFormat = fmt;
        mainView.setOutputText(currentText);
    }
    /**
     * Places combobox after the visible text.
     */
    public function placeComboBoxAfterText() : Void
    {
        flushOutputTextToGUI();
        mainView.placeComboBox(mainView.mainText.x + 10, mainView.mainText.y + mainView.mainText.textHeight + 10);
        EngineCore.outputText("\n\n\n");
    }
    public function showComboBox(items : Array<Dynamic>, prompt : String, onChange : Function) : Void
    {
        mainView.showComboBox(items, prompt, onChange);
        placeComboBoxAfterText();
    }
    private static var initQueue : Array<Dynamic> = [];
    public static function onGameInit(f : Function) : Void
    {
        initQueue.push(f);
    }
    private static function execPostInit() : Void
    {
        var f : Function;
        while ((f = initQueue.shift()))
        {
            f();
        }
    }
    
    private function get_gameState() : Int
    {
        return _gameState;
    }
    private static var CoC_static_initializer = {
        {
            /*
             * This is a static initializer block, used as an ugly hack to setup
             * logging before any of the class variables are initialized.
             * This is done because they could log messages during construction.
             */
            
            CoC.setUpLogging();
        };
        true;
    }

}


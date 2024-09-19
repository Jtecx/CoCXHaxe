package classes.scenes.aPI;

import classes.CoC;
import classes.scenes.SceneLib;
import coc.view.Color;
import coc.view.UIUtils;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class ExplorationEntry
{
    public var centerX(get, never) : Float;
    public var centerY(get, never) : Float;
    public var isFullyRevealed(get, never) : Bool;
    public var encounterName(get, never) : String;

    public static inline var REVEAL_NOT : Int = 0;
    public static inline var REVEAL_KIND : Int = 1;
    public static inline var REVEAL_FULL : Int = 2;
    public static inline var RADIUS : Float = 16;
    //	public static const LABEL_TEXT_FORMAT:Object = {
    //		color: "#000000",
    //		align: "center"
    //	};
    //	public static const LABEL_OUTLINE:String     = "#888800";
    private static inline var BORDER_WIDTH : Float = 3;
    private static inline var BORDER_CLEARED : String = "#222222";
    private static inline var BORDER_UNKNOWN : String = "#222222";
    private static inline var BORDER_NEXT : String = "#0080ff";
    private static inline var BORDER_PLAYER : String = "#ffaa00";
    private static inline var COLOR_DISABLED : String = "#666666";
    private static inline var COLOR_DEFAULT : String = "#aaaaaa";
    public static var EncounterKinds : Dynamic = {
            walk : {
                label : "Walk",
                color : "#eeeeee",
                time : 30
            },
            item : {
                label : "Item",
                color : "#00ff00",
                time : 10
            },
            treasure : {
                label : "Treasure",
                color : "#80ff00",
                time : 15
            },
            npc : {
                label : "NPC",
                color : "#ff80ff",
                time : 30
            },
            place : {
                label : "Place",
                color : "#88aaff",
                time : 30
            },
            special : {
                label : "Special",
                color : "#ff00ff",
                time : 30
            },
            event : {
                label : "Event",
                color : "#eeee00",
                time : 15
            },
            monster : {
                label : "Monster",
                color : "#aa0000",
                time : 15
            },
            boss : {
                label : "Boss",
                color : "#ff0000",
                time : 30
            },
            trap : {
                label : "Trap",
                color : "#ff8000",
                time : 15
            }
        };
    
    public var encounter : SimpleEncounter;
    public var kind : String;
    public var color : String;
    public var label : String;
    public var tooltipHeader : String;
    public var tooltipText : String;
    public var isNext : Bool;
    public var isCleared : Bool;
    public var isDisabled : Bool;  // no encounter, cleared, or off-road  
    public var isPlayerHere : Bool;
    public var revealLevel : Int;  // 0: not revealed, 1: kind, 2: full  
    public var reenter : Bool;
    public var x : Float;
    public var y : Float;
    private function get_centerX() : Float
    {
        return x + RADIUS;
    }
    private function get_centerY() : Float
    {
        return y + RADIUS;
    }
    public var sprite : Sprite;
    public var tfLabel : TextField;
    public var roadIndex : Int;
    public var roadPos : Int;
    public var nextNodes : Array<Dynamic> = [];
    
    private function get_isFullyRevealed() : Bool
    {
        return revealLevel == REVEAL_FULL;
    }
    private function get_encounterName() : String
    {
        return (encounter != null) ? encounter.encounterName() : "(null)";
    }
    public function new(
            roadIndex : Int,
            roadPos : Int,
            x : Float,
            y : Float)
    {
        this.roadIndex = roadIndex;
        this.roadPos = roadPos;
        this.x = x;
        this.y = y;
        createUI();
        setEmpty();
    }
    
    private function createUI() : Void
    {
        sprite = new Sprite();
        tfLabel = UIUtils.newTextField({
                            x : 0,
                            y : 2 * RADIUS,
                            width : 2 * RADIUS,
                            autoSize : TextFieldAutoSize.CENTER
                        });
        //		tfLabel.filters       = [UIUtils.outlineFilter(LABEL_OUTLINE)];
        sprite.addChild(tfLabel);
        
        sprite.mouseChildren = false;
        sprite.addEventListener(MouseEvent.CLICK, onClick);
        sprite.addEventListener(MouseEvent.ROLL_OVER, onHover);
        sprite.addEventListener(MouseEvent.ROLL_OUT, onDim);
        sprite.x = x;
        sprite.y = y;
    }
    public function redraw() : Void
    {
        var g : Graphics = sprite.graphics;
        
        var borderColor : Int = Color.convertColor32(
                (isPlayerHere) ? BORDER_PLAYER : (isDisabled) ? BORDER_CLEARED : (isNext) ? BORDER_NEXT : (isCleared) ? BORDER_CLEARED : BORDER_UNKNOWN
        );
        
        g.clear();
        g.lineStyle(BORDER_WIDTH, borderColor);
        g.beginFill(Color.convertColor32((isPlayerHere) ? COLOR_DISABLED : color));
        g.drawCircle(RADIUS, RADIUS, RADIUS);
        g.endFill();
        
        var mainTextFormat : TextFormat = CoC.instance.mainView.mainText.defaultTextFormat;
        tfLabel.defaultTextFormat = UIUtils.convertTextFormat({
                            font : mainTextFormat.font,
                            size : as3hx.Compat.parseFloat(mainTextFormat.size || 12) - 4,
                            color : mainTextFormat.color,
                            align : "center"
                        });
        tfLabel.text = label;
        
        sprite.buttonMode = isNext;
    }
    
    private function onClick(event : MouseEvent) : Void
    {
        if (encounter != null && !isDisabled)
        {
            SceneLib.explorationEngine.entryClick(this);
        }
    }
    private function onHover(event : MouseEvent) : Void
    {
        if (tooltipText == null && tooltipHeader == null)
        {
            return;
        }
        CoC.instance.mainView.toolTipView.showForElement(try cast(event.target, DisplayObject) catch(e:Dynamic) null, tooltipHeader, tooltipText);
    }
    private function onDim(event : MouseEvent) : Void
    {
        CoC.instance.mainView.toolTipView.hide();
    }
    
    public function setEmpty() : Void
    {
        encounter = null;
        kind = null;
        label = "";
        color = COLOR_DISABLED;
        tooltipHeader = "";
        tooltipText = "";
        isNext = false;
        isDisabled = true;
        isCleared = false;
        isPlayerHere = false;
        revealLevel = REVEAL_NOT;
        reenter = false;
        unlink();
    }
    public function unlink() : Void
    {
        nextNodes = [];
    }
    public function unlinkOne(e : ExplorationEntry) : Void
    {
        var i : Int = Lambda.indexOf(nextNodes, e);
        if (i >= 0)
        {
            nextNodes.splice(i, 1);
        }
    }
    public function link(e : ExplorationEntry) : Void
    {
        nextNodes.push(e);
    }
    
    public function setupForEncounter(e : SimpleEncounter) : Void
    {
        encounter = e;
        kind = e.getKind();
        isCleared = false;
        isDisabled = false;
        reenter = !!e.reenter;
        setRevealLevel(REVEAL_NOT);
    }
    public function incReveal() : Void
    {
        if (revealLevel == REVEAL_NOT)
        {
            revealKind();
        }
        else
        {
            revealFull();
        }
    }
    public function revealKind() : Void
    {
        revealLevel = REVEAL_KIND;
        var kind : String = encounter.getKind();
        if (kind != null)
        {
            if (Lambda.has(EncounterKinds, kind))
            {
                var entry : Dynamic = Reflect.field(EncounterKinds, kind);
                label = entry.label;
                tooltipHeader = label;
                tooltipText = ((Lambda.has(entry, "hint"))) ? entry.hint : "Trigger this encounter";
                color = ((Lambda.has(entry, "color"))) ? entry.color : COLOR_DEFAULT;
            }
            else
            {
                label = kind;
                tooltipHeader = label;
            }
        }
        else
        {
            label = "ERROR";
            tooltipHeader = label;
            tooltipText = "This encounter doesn't kave 'kind' property configured. This is a bug. You can still safely trigger it";
        }
    }
    public function setRevealLevel(level : Int) : Void
    {
        revealLevel = level;
        if (level == REVEAL_NOT)
        {
            label = "???";
            color = COLOR_DEFAULT;
            tooltipHeader = "Unknown Encounter";
            tooltipText = "Trigger this encounter";
            redraw();
        }
        else if (level == REVEAL_KIND)
        {
            revealKind();
        }
        else if (level == REVEAL_FULL)
        {
            revealFull();
        }
    }
    
    public function revealFull() : Void
    {
        revealKind();
        revealLevel = REVEAL_FULL;
        label = encounter.getLabel();
        tooltipHeader = encounter.getTooltipHeader();
        tooltipText = encounter.getTooltipHint();
    }
    
    public function markCleared() : Void
    {
        revealFull();
        color = COLOR_DISABLED;
        isNext = false;
        isCleared = true;
        tooltipHeader = "";
        tooltipText = "";
    }
    public function markDisabled() : Void
    {
        if (encounter == null)
        {
            return;
        }
        color = COLOR_DISABLED;
        isDisabled = true;
        isNext = false;
        tooltipHeader = "";
        tooltipText = "";
    }
    public function toString() : String
    {
        if (roadIndex < 0)
        {
            return "[Start]";
        }
        return "[" + roadIndex + ";" + roadPos + ";" + encounterName + "]";
    }
}


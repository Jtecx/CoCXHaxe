/****
 coc.view.MainView

 I have no real idea yet what eventTestInput is for,
 but its coordinates get tested for in places, and set in others.
 Perhaps some day I'll ask.

 It's for allowing people to test stuff in the parser. It gets moved into view, and you
 can enter stuff in the text window, which then gets fed through the parser.

 That's good to know.  Cheers.
 ****/

package coc.view;

import flash.errors.ArgumentError;
import haxe.Constraints.Function;

typedef ThemesTypedef = {
    var dark : Bool;
    var bgBitmap : Dynamic;
    var glass : Int;
    var glassAlpha : Float;
    var statGlass : Int;
    var statGlassAlpha : Float;
    var statBorderColor : Int;
    var statTextColor : Int;
    var barAlpha : Float;
}
import classes.CoC;
import classes.CoCSettings;
import classes.EngineCore;
import com.bit101.components.ComboBox;
import com.bit101.components.ScrollBar;
import com.bit101.components.TextFieldVScroll;
import com.bit101.components.ScrollPane;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;

class MainView extends Block
{
    public var onNewGameClick(never, set) : Function;
    public var onDataClick(never, set) : Function;
    public var onStatsClick(never, set) : Function;
    public var onLevelClick(never, set) : Function;
    public var onPerksClick(never, set) : Function;
    public var onAppearanceClick(never, set) : Function;
    public var onBottomButtonClick(never, set) : Function;

    @:meta(Embed(source="../../../res/ui/background1.png"))

    public static var Background1 : Class<Dynamic>;
    @:meta(Embed(source="../../../res/ui/background2.png"))

    public static var Background2 : Class<Dynamic>;
    @:meta(Embed(source="../../../res/ui/background3.png"))

    public static var Background3 : Class<Dynamic>;
    @:meta(Embed(source="../../../res/ui/background4.png"))

    public static var Background4 : Class<Dynamic>;
    @:meta(Embed(source="../../../res/ui/backgroundKaizo.png"))

    public static var BackgroundKaizo : Class<Dynamic>;
    public static var Themes : Array<ThemesTypedef> = [
        // Style 1, "Map"
        {
            dark : false,
            bgBitmap : Background1,
            glass : 0xffffff,
            glassAlpha : 0.4,
            statGlass : 0xffffff,
            statGlassAlpha : 0.4,
            statBorderColor : 0x000000,
            statTextColor : 0x000000,
            barAlpha : 0.4
        }, 
        // Style 2, "Parchment"
        {
            dark : false,
            bgBitmap : Background2,
            glass : 0xffffff,
            glassAlpha : 0.4,
            statGlass : 0xffffff,
            statGlassAlpha : 0.4,
            statBorderColor : 0x000000,
            statTextColor : 0x000000,
            barAlpha : 0.4
        }, 
        // Style 3, "Marble"
        {
            dark : false,
            bgBitmap : Background3,
            glass : 0xffffff,
            glassAlpha : 0.4,
            statGlass : 0xffffff,
            statGlassAlpha : 0.4,
            statBorderColor : 0x000000,
            statTextColor : 0x000000,
            barAlpha : 0.4
        }, 
        // Style 4, "Obsidian"
        {
            dark : false,
            bgBitmap : Background4,
            glass : 0xffffff,
            glassAlpha : 0.7,
            statGlass : 0xffffff,
            statGlassAlpha : 0.2,
            statBorderColor : 0xA37C17,
            statTextColor : 0xFFFFFF,
            barAlpha : 0.5
        }, 
        // Style 5, "Black"
        {
            dark : true,
            bgBitmap : null,
            glass : 0xffffff,
            glassAlpha : 0,
            statGlass : 0xffffff,
            statGlassAlpha : 0,
            statBorderColor : 0xA37C17,
            statTextColor : 0xFFFFFF,
            barAlpha : 1
        }, 
        // Style 6, "Kaizo"
        {
            dark : false,
            bgBitmap : BackgroundKaizo,
            glass : 0xffffff,
            glassAlpha : 0.4,
            statGlass : 0xffffff,
            statGlassAlpha : 0.4,
            statBorderColor : 0x000000,
            statTextColor : 0x000000,
            barAlpha : 0.4
        }
    ];
    
    // Menu button names.
    public static inline var MENU_NEW_MAIN : String = "newGame";
    public static inline var MENU_DATA : String = "data";
    public static inline var MENU_STATS : String = "stats";
    public static inline var MENU_LEVEL : String = "level";
    public static inline var MENU_PERKS : String = "perks";
    public static inline var MENU_APPEARANCE : String = "appearance";
    
    
    public static inline var GAP : Float = 4;  // Gap between UI panels  
    public static var HALFGAP : Float = GAP / 2;
    public static inline var BTN_W : Float = 150;  // Button size  
    public static inline var BTN_H : Float = 40;
    
    public static inline var SCREEN_W : Float = 1420;
    public static inline var SCREEN_H : Float = 800;
    
    // TOPROW: [Main Menu]/[New Game], [Data] ... [Appearance]
    
    // Columns:
    //      1               2          3
    //
    //     [ TOPROW                 ]
    //     [STAT1 | STAT2] /TEXTZONE\ [SPRITE ]
    //     [   CHARVIEW  ] \TEXTZONE/ [MONSTER]
    //                     [BUTTONS ]
    // Rows are NOT fixed, so stat1/2 and sprite are NOT of same height
    
    // Misc properties
    @:allow(coc.view)
    private static inline var TOPROW_NUMBTNS : Float = 6;
    public static var VSCROLLBAR_W : Float = ScrollBar.VWIDTH;
    @:allow(coc.view)
    private static inline var BOTTOM_COLS : Float = 5;
    @:allow(coc.view)
    private static inline var BOTTOM_ROWS : Float = 3;
    @:allow(coc.view)
    private static var BOTTOM_BUTTON_COUNT : Int = BOTTOM_COLS * BOTTOM_ROWS;
    
    // Column 1 core
    @:allow(coc.view)
    private static inline var STATBAR_COL_W : Float = 205;
    @:allow(coc.view)
    private static var STATBAR_W : Float = STATBAR_COL_W * 2;
    @:allow(coc.view)
    private static var CHARVIEW_W : Float = 200 * 2;
    @:allow(coc.view)
    private static var COLUMN_1_X : Float = HALFGAP;
    @:allow(coc.view)
    private static var COLUMN_1_W : Float = Math.max(STATBAR_W, CHARVIEW_W);
    @:allow(coc.view)
    private static var COLUMN_1_RIGHT : Float = COLUMN_1_X + COLUMN_1_W;
    // Column 2 core
    public static inline var TEXTZONE_W : Float = 770;
    @:allow(coc.view)
    private static var COLUMN_2_X : Float = COLUMN_1_RIGHT + GAP;
    @:allow(coc.view)
    private static var COLUMN_2_W : Float = TEXTZONE_W;
    @:allow(coc.view)
    private static var COLUMN_2_RIGHT : Float = COLUMN_2_X + COLUMN_2_W;
    // Column 3 core
    @:allow(coc.view)
    private static var COLUMN_3_X : Float = COLUMN_2_RIGHT + GAP;
    @:allow(coc.view)
    private static var COLUMN_3_RIGHT : Float = SCREEN_W - HALFGAP;
    @:allow(coc.view)
    private static var COLUMN_3_W : Float = COLUMN_3_RIGHT - COLUMN_3_X;
    // Top row. Its width depends on textzone size and declared later
    @:allow(coc.view)
    private static var TOPROW_X : Float = COLUMN_1_X;
    @:allow(coc.view)
    private static var TOPROW_Y : Float = HALFGAP;
    @:allow(coc.view)
    private static var TOPROW_H : Float = BTN_H;
    @:allow(coc.view)
    private static var TOPROW_BOTTOM : Float = TOPROW_Y + TOPROW_H + GAP;
    // Stat bar and its columns. Height depends on charview size
    public static var STATBAR_X : Float = COLUMN_1_X;
    @:allow(coc.view)
    private static var STATBAR_Y : Float = TOPROW_BOTTOM + GAP;
    @:allow(coc.view)
    private static var STATBAR_1_X : Float = STATBAR_X;
    @:allow(coc.view)
    private static var STATBAR_1_RIGHT : Float = STATBAR_1_X + STATBAR_COL_W + HALFGAP;
    @:allow(coc.view)
    private static var STATBAR_2_X : Float = STATBAR_1_RIGHT;
    @:allow(coc.view)
    private static var STATBAR_2_RIGHT : Float = STATBAR_2_X + STATBAR_COL_W + HALFGAP;
    @:allow(coc.view)
    private static var STATBAR_RIGHT : Float = STATBAR_2_RIGHT;
    public static var STATBAR_WIDTH : Float = STATBAR_RIGHT - STATBAR_X;
    // Char viewer
    @:allow(coc.view)
    private static inline var CHARVIEW_X : Float = 0;
    @:allow(coc.view)
    private static var CHARVIEW_H : Float = 202 * 2;
    @:allow(coc.view)
    private static var CHARVIEW_BOTTOM : Float = SCREEN_H;
    @:allow(coc.view)
    private static var CHARVIEW_Y : Float = CHARVIEW_BOTTOM - CHARVIEW_H;
    // Text zone
    @:allow(coc.view)
    private static var TEXTZONE_X : Float = STATBAR_RIGHT;
    @:allow(coc.view)
    private static var TEXTZONE_Y : Float = TOPROW_BOTTOM + GAP;
    @:allow(coc.view)
    private static var TEXTZONE_RIGHT : Float = TEXTZONE_X + TEXTZONE_W + GAP;
    // Bottom menu
    @:allow(coc.view)
    private static var BOTTOM_X : Float = STATBAR_RIGHT + HALFGAP;
    @:allow(coc.view)
    private static var BOTTOM_H : Float = (GAP + BTN_H) * BOTTOM_ROWS;  // height = rows x button height  
    @:allow(coc.view)
    private static var BOTTOM_W : Float = TEXTZONE_W;  // width = textzone width  
    @:allow(coc.view)
    private static var BOTTOM_HGAP : Float = (BOTTOM_W - BTN_W * BOTTOM_COLS) / (2 * BOTTOM_COLS);  // between btns  
    @:allow(coc.view)
    private static var BOTTOM_Y : Float = SCREEN_H - BOTTOM_H;  // bottom = screen bottom  
    // Sprite (top right)
    public static var SPRITE_X : Float = COLUMN_3_X;
    public static var SPRITE_Y : Float = TEXTZONE_Y;
    public static var SPRITE_MAX_W : Float = SCREEN_W - SPRITE_X - GAP;
    public static var SPRITE_MAX_H : Float = SPRITE_MAX_W;
    // monster stats (top right below sprite)
    public static var MONSTER_X : Float = COLUMN_3_X;
    public static var MONSTER_W : Float = SPRITE_MAX_W;
    public static inline var MONSTER_H : Float = 270;
    public static var MONSTER_Y : Float = SPRITE_Y + SPRITE_MAX_H + GAP;
    // corner stats (bottom right)
    @:allow(coc.view)
    private static var CORNERSTATS_X : Float = COLUMN_3_X;
    @:allow(coc.view)
    private static var CORNERSTATS_W : Float = COLUMN_3_W;
    @:allow(coc.view)
    private static var CORNERSTATS_BOTTOM : Float = SCREEN_H - HALFGAP;
    // Various dependencies
    @:allow(coc.view)
    private static var TEXTZONE_H : Float = SCREEN_H - TEXTZONE_Y - BOTTOM_H - 2 * GAP;
    @:allow(coc.view)
    private static var TOPROW_W : Float = TEXTZONE_X + TEXTZONE_W;
    @:allow(coc.view)
    private static var STATBAR_BOTTOM : Float = CHARVIEW_BOTTOM - CHARVIEW_H - GAP;
    @:allow(coc.view)
    private static var STATBAR_H : Float = STATBAR_BOTTOM - STATBAR_Y;
    
    private var blackBackground : BitmapDataSprite;
    public var textBGWhite : BitmapDataSprite;
    public var textBGTan : BitmapDataSprite;
    public var background : BitmapDataSprite;
    public var backgroundGlass : BitmapDataSprite;
    public var sprite : BitmapDataSprite;
    
    public var mainText : TextField;
    public var nameBox : TextField;
    public var eventTestInput : TextField;
    public var aCb : ComboBox;
    private var comboboxHandler : Function;
    
    public var toolTipView : ToolTipView;
    public var cornerStatsView : CornerStatsView;
    public var statsView : StatsView;
    public var notificationView : NotificationView;
    public var monsterStatsView : MonsterStatsView;
    public var sideBarDecoration : Sprite;
    
    private var _onBottomButtonClick : Function;  //(index:int, button:CoCButton)=>void  
    public var bottomButtons : Array<Dynamic>;
    private var currentActiveButtons : Array<Dynamic>;
    private var allButtons : Array<Dynamic>;
    private var topRow : Block;
    public var newGameButton : CoCButton;
    public var dataButton : CoCButton;
    public var statsButton : CoCButton;
    public var levelButton : CoCButton;
    public var perksButton : CoCButton;
    public var appearanceButton : CoCButton;
    public var scrollBar : TextFieldVScroll;
    
    private var callbacks : Dynamic = { };
    private var options : Dynamic;
    /**
	 * `function(event:String):void` to handle `<a href="event:data">` links.
	 * Is reset on `clearOutput()`
	 */
    public var linkHandler : Function;
    private var customElement : DisplayObject = null;
    public var hotkeysDisabled : Bool = false;
    
    public var charView : CharView;
    public function new()
    {
        super();
        addElement(blackBackground = new BitmapDataSprite({
                            x : -SCREEN_W / 2,
                            width : SCREEN_W * 2,
                            height : SCREEN_H * 2,
                            y : -SCREEN_H / 2,
                            fillColor : "#000000"
                        }), { });
        addElement(background = new BitmapDataSprite({
                            bitmapClass : Background1,
                            width : SCREEN_W,
                            height : SCREEN_H,
                            fillColor : 0,
                            repeat : true
                        }));
        addElement(backgroundGlass = new BitmapDataSprite({
                            fillColor : "#ffffff",
                            borderColor : "#222222",
                            borderWidth : 1,
                            x : TEXTZONE_X,
                            y : TEXTZONE_Y,
                            width : TEXTZONE_W,
                            height : TEXTZONE_H,
                            alpha : 0.4
                        }));
        addElement(topRow = new Block({
                            x : TOPROW_X,
                            y : TOPROW_Y,
                            width : TOPROW_W,
                            height : TOPROW_H,
                            layoutConfig : {
                                type : "grid",
                                cols : 6,
                                padding : GAP
                            }
                        }));
        topRow.addElement(newGameButton = new CoCButton({
                            labelText : "New Game"
                        }));
        topRow.addElement(dataButton = new CoCButton({
                            labelText : "Data"
                        }));
        topRow.addElement(statsButton = new CoCButton({
                            labelText : "Stats"
                        }));
        topRow.addElement(levelButton = new CoCButton({
                            labelText : "Level Up"
                        }));
        topRow.addElement(perksButton = new CoCButton({
                            labelText : "Perks & Opt."
                        }));
        topRow.addElement(appearanceButton = new CoCButton({
                            labelText : "Appearance"
                        }));
        addElement(textBGWhite = new BitmapDataSprite({
                            fillColor : "#FFFFFF",
                            x : TEXTZONE_X,
                            y : TEXTZONE_Y,
                            width : TEXTZONE_W,
                            height : TEXTZONE_H
                        }));
        addElement(textBGTan = new BitmapDataSprite({
                            fillColor : "#EBD5A6",
                            x : TEXTZONE_X,
                            y : TEXTZONE_Y,
                            width : TEXTZONE_W,
                            height : TEXTZONE_H
                        }));
        mainText = addTextField({
                            multiline : true,
                            wordWrap : true,
                            x : TEXTZONE_X,
                            y : TEXTZONE_Y,
                            width : TEXTZONE_W - VSCROLLBAR_W,
                            height : TEXTZONE_H,
                            mouseEnabled : true,
                            defaultTextFormat : {
                                size : 20
                            }
                        });
        mainText.addEventListener(TextEvent.LINK, function(e : TextEvent) : Void
                {
                    if (linkHandler != null)
                    {
                        linkHandler(decodeURI(e.text));
                    }
                });
        scrollBar = new TextFieldVScroll(mainText);
        UIUtils.setProperties(scrollBar, {
                    name : "scrollBar",
                    direction : "vertical",
                    scrollTarget : mainText,
                    x : mainText.x + mainText.width,
                    y : mainText.y,
                    height : mainText.height,
                    width : VSCROLLBAR_W
                });
        addElement(scrollBar);
        nameBox = addTextField({
                            border : true,
                            background : "#FFFFFF",
                            type : "input",
                            visible : false,
                            width : 160,
                            height : 25,
                            defaultTextFormat : {
                                size : 16,
                                font : "Arial"
                            }
                        });
        eventTestInput = addTextField({
                            type : "input",
                            background : "#FFFFFF",
                            border : "true",
                            visible : false,
                            text : "Paste event text & codes here.",
                            x : TEXTZONE_X,
                            y : TEXTZONE_Y,
                            width : TEXTZONE_W - VSCROLLBAR_W - GAP,
                            height : TEXTZONE_H - GAP,
                            defaultTextFormat : {
                                size : 16,
                                font : "Arial"
                            }
                        });
        StatBar.setDefaultOptions({
                    barColor : "#600000",
                    width : STATBAR_COL_W - 2 * HALFGAP
                });
        this.cornerStatsView = new CornerStatsView();
        this.addElement(this.cornerStatsView);
        // Init subviews.
        this.statsView = new StatsView(this, this.cornerStatsView);
        this.statsView.hide();
        this.addElement(this.statsView);
        this.notificationView = new NotificationView({
                    x : CHARVIEW_X,
                    y : CHARVIEW_Y,
                    width : COLUMN_1_W
                });
        this.addElement(this.notificationView);
        
        this.monsterStatsView = new MonsterStatsView(this);
        this.monsterStatsView.hide();
        this.addElement(this.monsterStatsView);
        
        addElement(sprite = new BitmapDataSprite({
                            x : SPRITE_X,
                            y : SPRITE_Y,
                            stretch : true
                        }));
        
        this.formatMiscItems();
        
        this.allButtons = [];
        
        createBottomButtons();
        var button : CoCButton;
        for (button in [newGameButton, dataButton, statsButton, levelButton, perksButton, appearanceButton])
        {
            this.allButtons.push(button);
        }
        this.toolTipView = new ToolTipView(this  /*, this.model*/  );
        this.toolTipView.hide();
        this.addElement(this.toolTipView);
        
        // hook!
        this.width = SCREEN_W;
        this.height = SCREEN_H;
        this.scaleX = 1;
        this.scaleY = 1;
        charView = new CharView();
        //charView.bgFill  = 0xff808080;
        charView.name = "charview";
        //		this.charView.x       = TEXTZONE_X + TEXTZONE_W + GAP;
        //		this.charView.y       = TEXTZONE_Y;
        charView.visible = false;
    }
    
    /*override public function get width():Number {
	 return 1000;
	 }
	 override public function get height():Number {
	 return 800;
	 }
	 override public function get scaleX():Number {
	 return 1;
	 }*/
    //////// Initialization methods. /////////
    
    private function formatMiscItems() : Void
    {
        this.aCb = new ComboBox();
        this.aCb.width = 200;
        this.aCb.scaleY = 1.1;
        this.aCb.move(-1250, -1550);
        this.aCb.addEventListener(Event.SELECT, function(event : Event) : Void
                {
                    if (comboboxHandler != null)
                    {
                        comboboxHandler(cast((event.target), ComboBox).selectedItem);
                    }
                });
        
        this.hideSprite();
    }
    
    // Removes the need for some code in input.as and InitializeUI.as.
    
    // This creates the bottom buttons,
    // positions them,
    // and also assigns their index to a bottomIndex property on them.
    private function createBottomButtons() : Void
    {
        var b : Sprite;
        var bi : Int;
        var r : Int;
        var c : Int;
        var button : CoCButton;
        
        this.bottomButtons = [];
        
        //var originalTextFormat:TextFormat = this.toolTipView.hd.getTextFormat();
        //		var buttonFont:Font  = new ButtonLabelFont();
        for (bi in 0...BOTTOM_BUTTON_COUNT)
        {
            r = as3hx.Compat.parseInt(bi / BOTTOM_COLS) << 0;
            c = as3hx.Compat.parseInt(bi % BOTTOM_COLS);
            
            //			b.x      = BUTTON_X_OFFSET + c * BUTTON_X_DELTA;
            //			b.y      = BUTTON_Y_OFFSET + r * BUTTON_Y_DELTA;
            //			b.width  = BUTTON_REAL_WIDTH;   //The button symbols are actually 135 wide
            //			b.height = BUTTON_REAL_HEIGHT; //and 38 high. Not sure why the difference here.
            
            button = createActionButton(bi);
            button.visible = false;
            button.x = BOTTOM_X + BOTTOM_HGAP + c * (BOTTOM_HGAP * 2 + BTN_W);
            button.y = BOTTOM_Y + r * (GAP + BTN_H);
            this.bottomButtons.push(button);
            this.addElement(button);
        }
        this.allButtons = this.allButtons.concat(this.bottomButtons);
    }
    
    public function createActionButton(index : Int) : CoCButton
    {
        var button : CoCButton = new CoCButton();
        button.preCallback = function(b : CoCButton) : Void
                {
                    if (_onBottomButtonClick != null)
                    {
                        _onBottomButtonClick(index, button);
                    }
                };
        button.addEventListener(MouseEvent.CLICK, this.executeBottomButtonClick);
        return button;
    }
    
    //////// Internal(?) view update methods ////////
    
    public function showBottomButton(index : Int, label : String, callback : Function = null, toolTipViewText : String = "", toolTipViewHeader : String = "") : CoCButton
    {
        var button : CoCButton = try cast(this.bottomButtons[index], CoCButton) catch(e:Dynamic) null;
        
        if (button == null)
        {
            return null;
        }
        button.labelText = label;
        button.callback = callback;
        button.toolTipHeader = toolTipViewHeader;
        button.toolTipText = toolTipViewText;
        button.visible = true;
        button.enabled = true;
        button.alpha = 1;  // failsafe to avoid possible problems with dirty hack  
        return button;
    }
    
    public function showBottomButtonDisabled(index : Int, label : String, toolTipViewText : String = "", toolTipViewHeader : String = "") : CoCButton
    {
        var button : CoCButton = try cast(this.bottomButtons[index], CoCButton) catch(e:Dynamic) null;
        
        if (button == null)
        {
            return null;
        }
        return button.showDisabled(label, toolTipViewText, toolTipViewHeader);
    }
    
    public function hideBottomButton(index : Int) : CoCButton
    {
        var button : CoCButton = try cast(this.bottomButtons[index], CoCButton) catch(e:Dynamic) null;
        // Should error.
        if (button == null)
        {
            return null;
        }
        return button.reset();
    }
    
    public function hideCurrentBottomButtons() : Void
    {
        this.currentActiveButtons = [];
        
        for (i in 0...BOTTOM_BUTTON_COUNT)
        {
            var button : CoCButton = try cast(this.bottomButtons[i], CoCButton) catch(e:Dynamic) null;
            
            if (button.visible == true)
            {
                this.currentActiveButtons.push(i);
                button.visible = false;
            }
        }
    }
    
    public function showCurrentBottomButtons() : Void
    {
        if (!this.currentActiveButtons)
        {
            return;
        }
        if (currentActiveButtons.length == 0)
        {
            return;
        }
        
        for (i in 0...currentActiveButtons.length)
        {
            var btnIdx : Int = Reflect.field(currentActiveButtons, i);
            var button : CoCButton = try cast(this.bottomButtons[btnIdx], CoCButton) catch(e:Dynamic) null;
            
            button.visible = true;
        }
    }
    
    //////// Internal event handlers ////////
    
    private function executeBottomButtonClick(event : Event) : Void
    {
        this.toolTipView.hide();
    }
    
    private function hoverElement(event : MouseEvent) : Void
    {
        var button : CoCButton;
        
        button = try cast(event.target, CoCButton) catch(e:Dynamic) null;
        
        if (button != null && button.visible && button.toolTipText)
        {
            this.toolTipView.showForElement(button, button.toolTipHeader, button.toolTipText);
        }
        else
        {
            this.toolTipView.hide();
        }
    }
    
    private function dimElement(event : MouseEvent) : Void
    {
        this.toolTipView.hide();
    }
    
    
    //////// Bottom Button Methods ////////
    
    public function setButton(index : Int, label : String = "", callback : Function = null, toolTipViewText : String = "") : Void
    {
        if (index < 0 || index >= BOTTOM_BUTTON_COUNT)
        {
            trace("MainView.setButton called with out of range index:", index);
            // throw new RangeError();
            return;
        }
        
        if (label != null)
        {
            this.showBottomButton(index, label, callback, toolTipViewText);
        }
        else
        {
            this.hideBottomButton(index);
        }
    }
    
    // There was one case where the label needed to be set but I could not determine from context whether the button should be shown or not...
    public function setButtonText(index : Int, label : String) : Void
    {
        this.bottomButtons[index].labelText = label;
    }
    
    public function hasButton(labelText : String) : Bool
    {
        return this.indexOfButtonWithLabel(labelText) != -1;
    }
    
    public function indexOfButtonWithLabel(labelText : String) : Int
    {
        var i : Int;
        
        for (i in 0...this.bottomButtons.length)
        {
            if (this.getButtonText(i) == labelText)
            {
                return i;
            }
        }
        
        return -1;
    }
    
    public function clearBottomButtons() : Void
    {
        var i : Int;
        for (i in 0...BOTTOM_BUTTON_COUNT)
        {
            this.setButton(i);
        }
    }
    
    public function getButtonText(index : Int) : String
    //			var matches:*;
    {
        
        
        if (index < 0 || index > BOTTOM_BUTTON_COUNT)
        {
            return "";
        }
        else
        {
            return this.bottomButtons[index].labelText;
        }
    }
    
    public function clickButton(index : Int) : Void
    {
        this.bottomButtons[index].click();
    }
    
    // This function checks if the button at index has text
    // that matches at least one of the possible texts passed as an argument.
    public function buttonTextIsOneOf(index : Int, possibleLabels : Array<Dynamic>) : Bool
    {
        return (Lambda.indexOf(possibleLabels, this.getButtonText(index)) != -1);
    }
    
    public function buttonIsVisible(index : Int) : Bool
    {
        if (index < 0 || index > BOTTOM_BUTTON_COUNT)
        {
            return null;
        }
        else
        {
            return this.bottomButtons[index].visible;
        }
    }
    
    
    //////// Menu Button Methods ////////
    
    private function getMenuButtonByName(name : String) : CoCButton
    {
        switch (name)
        {
            case MENU_NEW_MAIN:
                return newGameButton;
            case MENU_DATA:
                return dataButton;
            case MENU_STATS:
                return statsButton;
            case MENU_LEVEL:
                return levelButton;
            case MENU_PERKS:
                return perksButton;
            case MENU_APPEARANCE:
                return appearanceButton;
        }
        return null;
    }
    
    ////////
    
    public function setMenuButton(name : String, label : String = "", callback : Function = null) : Void
    {
        var button : CoCButton = this.getMenuButtonByName(name);
        
        if (button == null)
        {
            throw new ArgumentError("MainView.setMenuButton: Invalid menu button name: " + name);
        }
        
        if (label != null)
        {
            button.labelText = label;
            button.toolTipHeader = label;
        }
        
        if (callback != null)
        {
            button.callback = callback;
        }
    }
    
    private function set_onNewGameClick(callback : Function) : Function
    {
        this.newGameButton.callback = callback;
        return callback;
    }
    
    private function set_onDataClick(callback : Function) : Function
    {
        this.dataButton.callback = callback;
        return callback;
    }
    
    private function set_onStatsClick(callback : Function) : Function
    {
        this.statsButton.callback = callback;
        return callback;
    }
    
    private function set_onLevelClick(callback : Function) : Function
    {
        this.levelButton.callback = callback;
        return callback;
    }
    
    private function set_onPerksClick(callback : Function) : Function
    {
        this.perksButton.callback = callback;
        return callback;
    }
    
    private function set_onAppearanceClick(callback : Function) : Function
    {
        this.appearanceButton.callback = callback;
        return callback;
    }
    
    private function set_onBottomButtonClick(value : Function) : Function
    {
        _onBottomButtonClick = value;
        return value;
    }
    public function showMenuButton(name : String) : Void
    {
        var button : CoCButton = this.getMenuButtonByName(name);
        button.visible = true;
    }
    
    public function hideMenuButton(name : String) : Void
    {
        var button : CoCButton = this.getMenuButtonByName(name);
        button.visible = false;
    }
    
    public function showAllMenuButtons() : Void
    {
        this.showMenuButton(MENU_NEW_MAIN);
        this.showMenuButton(MENU_DATA);
        this.showMenuButton(MENU_STATS);
        this.showMenuButton(MENU_LEVEL);
        this.showMenuButton(MENU_PERKS);
        this.showMenuButton(MENU_APPEARANCE);
    }
    
    public function hideAllMenuButtons() : Void
    {
        this.hideMenuButton(MENU_NEW_MAIN);
        this.hideMenuButton(MENU_DATA);
        this.hideMenuButton(MENU_STATS);
        this.hideMenuButton(MENU_LEVEL);
        this.hideMenuButton(MENU_PERKS);
        this.hideMenuButton(MENU_APPEARANCE);
    }
    
    public function menuButtonIsVisible(name : String) : Bool
    {
        return this.getMenuButtonByName(name).visible;
    }
    
    public function menuButtonHasLabel(name : String, label : String) : Bool
    {
        return this.getMenuButtonByName(name).labelText == label;
    }
    
    
    //////// misc... ////////
    
    public function invert() : Void
    {
        this.blackBackground.visible = !this.blackBackground.visible;
    }
    
    public function clearOutputText() : Void
    {
        this.linkHandler = null;
        if (this.customElement)
        {
            this.removeElement(this.customElement);
            this.customElement = null;
            this.scrollBar.activated = true;
        }
        this.hotkeysDisabled = false;
        this.mainText.htmlText = "";
        this.scrollBar.draw();
    }
    
    /**
	 * Display a custom UI element. Only 1 supported at a time (use container if more is needed).
	 * It will be removed on clearOutput() call
	 * @param element
	 * @param afterText Position the element after current text (true, default) or on top of text (false)
	 * @param stretch Stretch the element (default false)
	 */
    public function setCustomElement(element : DisplayObject, afterText : Bool = true, stretch : Bool = false, scroll : Bool = false) : Void
    {
        CoC.instance.flushOutputTextToGUI();
        if (this.customElement)
        {
            this.removeElement(this.customElement);
        }
        var innerElement : DisplayObject = element;
        if (scroll)
        {
            var container : ScrollPane = new ScrollPane();
            container.autoHideScrollBar = true;
            container.PanelAlpha = 0;
            container.color = 0xCCCCC;
            container.border = false;
            //container.setStyle("upSkin", new MovieClip());
            //container.horizontalScrollPolicy = ScrollPolicy.OFF;
            //container.verticalPageScrollSize = mainText.height - 64;
            //container.verticalLineScrollSize = 16;
            container.addChild(innerElement);
            element = container;
            if (Std.is(innerElement, Block))
            {
                innerElement.addEventListener(Block.ON_LAYOUT, function(e : Event) : Void
                        {
                            container.update();
                        });
            }
            scrollBar.visible = false;
            if (CoC_Settings.mobileBuild)
            {
                container.dragContent = true;
                Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
            }
        }
        element.x = mainText.x;
        element.y = (afterText) ? mainText.y + mainText.textHeight : mainText.y;
        if (stretch || scroll)
        {
            element.width = TEXTZONE_W;
            element.height = mainText.y + mainText.height - element.y;
        }
        if (scroll && stretch)
        {
            innerElement.width = container.width - ScrollBar.VWIDTH;
        }
        this.addElement(element);
        this.customElement = element;
    }
    public function getCustomElement() : DisplayObject
    {
        return customElement;
    }
    
    public function appendOutputText(text : String) : Void
    {
        var fmt : TextFormat = this.mainText.defaultTextFormat;
        fmt.bold = false;
        fmt.italic = false;
        fmt.underline = false;
        this.mainText.htmlText += text;
        this.mainText.defaultTextFormat = fmt;
        this.scrollBar.draw();
    }
    
    // I think font ones are 90% false reports (because of some Flash weirdness)
    // (no actual unclosed tag, but the font is off because dark magic)
    // there's a workaround I might try - if the font is messed up, clear text (but save first), reset font, and print text again
    private var fontKostyl : Bool = false;
    
    public function setOutputText(text : String) : Void
    {
        var fmt : TextFormat = this.mainText.defaultTextFormat;
        fmt.bold = false;
        fmt.italic = false;
        fmt.underline = false;
        this.mainText.defaultTextFormat = fmt;
        this.mainText.htmlText = text;  // Altering htmlText can cause changes in defaultTextFormat  
        var fmtnew : TextFormat = this.mainText.defaultTextFormat;
        this.mainText.defaultTextFormat = fmt;
        if (fmtnew.bold != fmt.bold || fmtnew.italic != fmt.italic || fmtnew.underline != fmt.underline)
        {
            if (fontKostyl)
            
            //autofix failed, rerun didn't help{
                
                this.mainText.htmlText += " /!\\ UNCLOSED TAG DETECTED (When reporting this bug, give information on your previous actions. You can check text history by pressing [H] (Mobile version does not support this).) /!\\ ";
            }
            //attempt to autofix
            else
            {
                
                var txt : String = CoC.instance.currentText;
                EngineCore.clearOutputTextOnly(true);
                CoC.instance.currentText = txt;
                fontKostyl = true;
                CoC.instance.flushOutputTextToGUI();
                fontKostyl = false;
            }
        }
        this.scrollBar.draw();
    }
    
    public function hideSprite() : Void
    {
        this.sprite.visible = false;
    }
    
    public function showTestInputPanel() : Void
    {
        this.eventTestInput.x = 207.5;
        this.eventTestInput.y = 55.1;
        
        this.mainText.visible = false;
        
        this.eventTestInput.selectable = true;
        //		this.eventTestInput.type       = TextFieldType.INPUT;
        this.eventTestInput.visible = true;
        
        this.scrollBar.value = this.eventTestInput.y;
    }
    
    public function hideTestInputPanel() : Void
    {
        this.eventTestInput.x = -10207.5;
        this.eventTestInput.y = -1055.1;
        
        this.mainText.visible = true;
        
        
        this.eventTestInput.selectable = false;
        //		this.eventTestInput.type       = TextFieldType.DYNAMIC;
        this.eventTestInput.visible = false;
        
        this.scrollBar.value = this.mainText.y;
    }
    
    public function hideComboBox() : Void
    {
        stage.focus = null;
        if (aCb.parent != null)
        {
            removeElement(aCb);
        }
        comboboxHandler = null;
    }
    
    public function showComboBox(items : Array<Dynamic>, propmt : String, onChange : Function) : Void
    {
        aCb.items = items;
        aCb.numVisibleItems = 15;
        aCb.defaultLabel = propmt;
        comboboxHandler = onChange;
        if (aCb.parent == null)
        {
            addElement(aCb);
        }
        aCb.visible = true;
    }
    public function placeComboBox(x : Float, y : Float) : Void
    {
        aCb.move(x, y);
    }
    public function placeCharviewAtRight() : Void
    {
        charView.x = CHARVIEW_X;
        charView.y = CHARVIEW_BOTTOM - CHARVIEW_H;
    }
    public function showSpriteBitmap(bmp : BitmapData) : Void
    {
        if (bmp == null)
        {
            return;
        }
        sprite.visible = true;
        var scale : Float = SPRITE_MAX_W / bmp.width;
        if (bmp.height * scale > SPRITE_MAX_H)
        {
            scale = SPRITE_MAX_H / bmp.height;
        }
        if (scale > 4)
        {
            scale = 4;
        }
        sprite.scaleX = scale;
        sprite.scaleY = scale;
        sprite.graphics.clear();
        sprite.graphics.beginBitmapFill(bmp, null, false, false);
        sprite.graphics.drawRect(0, 0, bmp.width, bmp.height);
        sprite.graphics.endFill();
    }
    public function setTheme(theme : Int, font : String) : Void
    {
        var style : Dynamic = Themes[theme];
        if (style == null)
        {
            return;
        }
        background.bitmapClass = style.bgBitmap;
        backgroundGlass.fillColor = style.glass;
        backgroundGlass.alpha = style.glassAlpha;
        statsView.setTheme(theme, font);
        monsterStatsView.setTheme(theme, font);
    }
}


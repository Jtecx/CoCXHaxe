//The code that is responsible for managing MainView.
package classes;

import classes.globalFlags.KFLAGS;
import coc.view.BoundClip;
import coc.view.MainView;
import coc.view.SimpleTween;
import coc.view.StatsView;
import coc.view.UIUtils;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.ui.Keyboard;
import flash.utils.Timer;

class MainViewManager extends BaseContent
{
    //Interface flags
    public var registeredShiftKey : Bool = false;
    
    public var textColorArray(default, never) : Array<Dynamic> = [0, 0, 0, 0xFFFFFF, 0xFFFFFF, 0, 0, 0, 0, 0];
    public var darkThemes(default, never) : Array<Dynamic> = [false, false, false, false, true, false, false, false, false, false];
    public var barAlphaArray(default, never) : Array<Dynamic> = [0.4, 0.4, 0.5, 1, 1, 1, 1, 1, 1, 1];
    
    public var statsHidden : Bool = false;
    public var buttonsTweened : Bool = false;
    
    public function new()
    {
        super();
    }
    
    //------------
    // SHOW/HIDE
    //------------
    public function darkThemeImpl() : Bool
    {
        return Reflect.field(darkThemes, Std.string(flags[kFLAGS.BACKGROUND_STYLE]));
    }
    
    public function setTheme() : Void
    {
        var i : Int = 0;  //Will be used for array.  
        
        //Set background
        var style : Int = flags[kFLAGS.BACKGROUND_STYLE];
        var font : String = ((flags[kFLAGS.USE_OLD_FONT] > 0)) ? StatsView.ValueFontOld : StatsView.ValueFont;
        mainView.setTheme(style, font);
    }
    
    public function hideSprite() : Void
    // Inlined from lib/src/coc/view/MainView.as
    {
        
        mainView.sprite.visible = false;
    }
    public function showSpriteBitmap(bmp : BitmapData) : Void
    {
        mainView.showSpriteBitmap(bmp);
    }
    //------------
    // REFRESH
    //------------
    public function refreshStats() : Void
    {
        if (flags[kFLAGS.HUNGER_ENABLED] > 0 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75)
        {
            mainView.statsView.toggleHungerBar(true);
        }
        else
        {
            mainView.statsView.toggleHungerBar(false);
        }
        //Set theme!
        setTheme();
        mainView.statsView.refreshStats(CoC.instance);
    }
    public function updateCharviewIfNeeded() : Void
    {
        if (flags[kFLAGS.CHARVIEW_STYLE] != 0)
        
        // if not display always{
            
            hidePlayerDoll();
        }
        // if display always
        else
        {
            
            showPlayerDoll(false);
        }
    }
    public function showPlayerDoll(reload : Bool = false) : Void
    //tweenOutStats();
    {
        
        if (reload)
        {
            mainView.charView.reload("external");
        }
        mainView.charView.setCharacter(player);
        mainView.charView.redraw();
        mainView.charView.visible = true;
        if (flags[kFLAGS.CHARVIEW_STYLE] == 2)
        
        // display in the text{
            
            mainView.charView.x = 0;
            mainView.charView.y = 0;
            BoundClip.nextContent = mainView.charView;
            outputText("<img src='coc.view::BoundClip' align='left' id='charview'/>");
        }
        // display in the corner
        else
        {
            
            mainView.placeCharviewAtRight();
            mainView.addElementBelow(mainView.charView, mainView.notificationView);
        }
    }
    public function hidePlayerDoll() : Void
    {
        mainView.charView.visible = false;
        tweenInStats();
    }
    public function createFloatingText(x : Float, y : Float, htmlText : String, color : Dynamic = "#000", shadowColor : Dynamic = "#fff") : Void
    {
        var tf : TextField = UIUtils.newTextField({
                    x : x,
                    y : y,
                    defaultTextFormat : extend({ }, mainView.mainText.defaultTextFormat, {
                                size : 18,
                                color : color
                            }),
                    autoSize : TextFieldAutoSize.CENTER,
                    filters : [UIUtils.outlineFilter(shadowColor)],
                    htmlText : htmlText
                });
        mainView.addElement(tf);
        new SimpleTween(tf, "y", y - 50, 1000, {
                    easing : "linear"
                }).then(function() : Void
                {
                    new SimpleTween(tf, "alpha", 0.0, 500, {
                                easing : "easeIn"
                            }).then(function() : Void
                            {
                                mainView.removeElement(tf);
                            });
                });
    }
    public function createFloatingTextAtCursor(htmlText : String, color : Dynamic = "#000", shadowColor : Dynamic = "#fff") : Void
    {
        createFloatingText(mainView.mouseX, mainView.mouseY, htmlText, color, shadowColor);
    }
    public function createFloatingTextAtElement(element : DisplayObject, htmlText : String, color : Dynamic = "#000", shadowColor : Dynamic = "#fff") : Void
    {
        var point : Point = UIUtils.getRelativePos(element, mainView);
        createFloatingText(point.x, point.y, htmlText, color, shadowColor);
    }
    
    //Show/hide stats bars.
    public function tweenInStats() : Void
    {
        if (!statsHidden)
        {
            return;
        }
        statsHidden = false;
        mainView.cornerStatsView.visible = true;
        new SimpleTween(mainView.statsView, "x", MainView.STATBAR_X, 1000, {
            easing : "easeIn"
        });
        new SimpleTween(mainView.statsView, "alpha", 1.0, 1000, {
            easing : "easeIn"
        });
    }
    public function tweenOutStats() : Void
    {
        if (statsHidden)
        {
            return;
        }
        statsHidden = true;
        mainView.cornerStatsView.visible = false;
        new SimpleTween(mainView.statsView, "x", -MainView.STATBAR_WIDTH, 1000, {
            easing : "easeIn"
        });
        new SimpleTween(mainView.statsView, "alpha", 0.0, 1000, {
            easing : "easeIn"
        });
    }
    
    //Animate buttons for startup!
    public function startUpButtons() : Void
    {
        if (buttonsTweened)
        {
            return;
        }
        buttonsTweened = true;
        for (i in 0...15)
        {
            mainView.bottomButtons[i].y += 140;
        }
        var t : Timer = new Timer(1000, 1);
        t.addEventListener(TimerEvent.TIMER, tweenButtonsIn);
        t.start();
    }
    private function tweenButtonsIn(e : TimerEvent = null) : Void
    {
        var t : Timer = new Timer(20, 28);
        t.addEventListener(TimerEvent.TIMER, moveButtonsIn);
        t.start();
    }
    private function moveButtonsIn(e : TimerEvent) : Void
    {
        for (i in 0...15)
        {
            mainView.bottomButtons[i].y -= 5;
        }
    }
    
    //Allows shift key.
    public function registerShiftKeys() : Void
    {
        if (!registeredShiftKey)
        {
            mainView.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
            mainView.stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
            registeredShiftKey = true;
        }
    }
    
    public function keyPressed(event : KeyboardEvent) : Void
    {
        if (event.keyCode == Keyboard.SHIFT)
        {
            shiftKeyDown = true;
        }
    }
    public function keyReleased(event : KeyboardEvent) : Void
    {
        if (event.keyCode == Keyboard.SHIFT)
        {
            shiftKeyDown = false;
        }
    }
    public function traceSelf() : String
    {
        var chdump : DisplayObject->Int->Float->Bool->Float->Float->String = function(obj : DisplayObject, depth : Int, alpha : Float, visible : Bool, scaleX : Float, scaleY : Float) : String
        {
            var s : String = repeatString("  ", depth);
            
            var className : String = Type.getClassName(obj).replace("coc.view::", "<coc>::").replace("spark.components::", "<s>::").replace("spark.skins.spark::", "<spark>::").replace("flash.display::", "<f>::").replace("flash.text::", "<ft>::").replace("flash.text.engine::", "<fte>::");
            s += className + " '" + obj.name + "' ";
            
            s += "xy=(" + (obj.x | 0) + "," + (obj.y | 0) + ") ";
            
            var smar : String = "";
            var spad : String = "";
            /*var uio:UIComponent = obj as UIComponent;
			 if (uio) {
			 spad = uio.getStyle("paddingTop") + "," + uio.getStyle("paddingRight") +
			 "," + uio.getStyle("paddingBottom") + "," + uio.getStyle("paddingLeft");
			 if (spad == "0,0,0,0") spad = ""; else spad = ", pad=[" + spad + "]";
			 /!*smar = uio.getStyle("marginTop")+","+uio.getStyle("marginRight")+
			 ","+uio.getStyle("marginBottom")+","+uio.getStyle("marginLeft");
			 if (smar == "0,0,0,0") smar = ""; else smar=", mar=["+smar+"]";*!/
			 }*/
            s += "sz=" + (obj.width | 0) + "x" + (obj.height | 0) + spad + smar;
            
            alpha = alpha * obj.alpha;
            visible = visible && obj.visible;
            scaleX = scaleX * obj.scaleX;
            scaleY = scaleY * obj.scaleY;
            var salpha : String = "";
            var svis : String = "";
            var ssx : String = "";
            var ssy : String = "";
            if (alpha != 1.0)
            {
                salpha += ", a=" + obj.alpha;
                if (alpha != obj.alpha)
                {
                    salpha += "=" + alpha;
                }
            }
            if (!visible)
            {
                svis += ", v=" + obj.visible;
                if (visible != obj.visible)
                {
                    svis += "=" + visible;
                }
            }
            if (scaleX != 1.0 || obj.scaleX != 1.0)
            {
                ssx += ", sx=" + obj.scaleX;
                if (scaleX != obj.scaleX)
                {
                    ssx += "=" + scaleX;
                }
            }
            if (scaleY != 1.0 || obj.scaleY != 1.0)
            {
                ssy += ", sy=" + obj.scaleY;
                if (scaleY != obj.scaleY)
                {
                    ssy += "=" + scaleY;
                }
            }
            s += salpha + svis + ssx + ssy;
            var txt : TextField = try cast(obj, TextField) catch(e:Dynamic) null;
            if (txt != null)
            {
                var ts : String = txt.text;
                if (ts.length > 0)
                {
                    ts = ts.substr(0, 17) + "...";
                }
                ts = new as3hx.Compat.Regex('[\\r\\n\\t]', "g").replace(ts, " ");
                s += ", txt='" + ts + "'";
            }
            
            /*var txt:IDisplayText = obj as IDisplayText;
			 if (txt) {
			 var ts:String = txt.text;
			 if (ts.length > 20) ts = ts.substr(0, 17) + "...";
			 s += ", txt='" + ts.replace(/[\r\n\t\0]/g, ' ') + "'";
			 }*/
            
            var doc : DisplayObjectContainer = try cast(obj, DisplayObjectContainer) catch(e:Dynamic) null;
            if (doc  /*&& !(obj is Label) && !(obj is ComboBox) && !(obj is TextArea) && !(obj is TextInput)*/  )
            {
                var i : Int;
                var n : Int = doc.numChildren;
                var rslt : String;
                rslt = "\n" + s;
                for (i in 0...n)
                {
                    var child : DisplayObject = doc.getChildAt(i);
                    /*if (!(child is TextLine)) {*/
                    rslt += chdump(child, depth + 1, alpha, visible, scaleX, scaleY);
                }
                return rslt;
            }
            else
            {
                return "\n" + s;
            }
        }
        var obj : Stage = CoC.instance.stage;
        return chdump(obj, 0, obj.alpha, obj.visible, obj.scaleX, obj.scaleY);
    }
}


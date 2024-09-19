package coc.view;

import classes.CoCSettings;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

//import coc.model.GameModel;
class ToolTipView extends Block
{
    public var header(get, set) : String;
    public var text(get, set) : String;

    @:meta(Embed(source="../../../res/ui/tooltip.png"))

    public static var tooltipBg : Class<Dynamic>;
    public var bg : Sprite;public var ln : Sprite;public var hd : TextField;public var tf : TextField;
    
    private var mainView : MainView;
    private static inline var MIN_HEIGHT : Float = 239;
    private static inline var WIDTH : Float = 350;
    
    public function new(mainView : MainView)
    {
        super();
        this.mainView = mainView;
        
        this.bg = addBitmapDataSprite({
                            x : 0,
                            y : 0,
                            width : WIDTH,
                            height : 239,
                            stretch : true,
                            bitmapClass : tooltipBg
                        });
        this.hd = addTextField({
                            x : 15,
                            y : 15,
                            width : WIDTH - 34,
                            multiline : true,
                            autosize : TextFieldAutoSize.LEFT,
                            wordWrap : true,
                            embedFonts : true,
                            defaultTextFormat : {
                                size : 18,
                                font : CoCButton.ButtonLabelFontName
                            }
                        });
        this.ln = addBitmapDataSprite({
                            x : 15,
                            y : 40,
                            width : WIDTH - 30,
                            height : 1,
                            fillColor : "#000000"
                        });
        this.tf = addTextField({
                            x : 15,
                            y : 40,
                            width : WIDTH - 34,
                            multiline : true,
                            wordWrap : true,
                            defaultTextFormat : {
                                size : 15
                            }
                        });
        this.tf.autoSize = TextFieldAutoSize.LEFT;
    }
    
    /**
		 * Display tooltip near rectangle with specified coordinates
		 */
    public function show(bx : Float, by : Float, bw : Float, bh : Float) : Void
    {
        if (CoC_Settings.mobileBuild)
        {
            bx -= 64;
            by -= 64;
            bw += 128;
            bh += 128;
        }
        this.x = bx;
        if (this.x < 0)
        {
            this.x = 0;
        }
        else if (this.x + this.width > mainView.width)
        {
            this.x = mainView.width - this.width;
        }
        autosize();
        if (by + bh < mainView.height / 2)
        
        // put to the bottom{
            
            this.y = by + bh;
        }
        // put on top
        else
        {
            
            this.y = by - this.height;
        }
        this.visible = true;
        this.parent.addChild(this);
    }
    public function showForElement(e : DisplayObject, header : String, text : String) : Void
    {
        this.header = header;
        this.text = text;
        var lpt : Point = e.getRect(this.parent).topLeft;
        show(lpt.x, lpt.y, e.width, e.height);
    }
    
    public function hide() : Void
    {
        this.visible = false;
    }
    
    private function set_header(newText : String) : String
    {
        this.hd.htmlText = newText || "";
        autosize();
        return newText;
    }
    
    private function get_header() : String
    {
        return this.hd.htmlText;
    }
    
    private function set_text(newText : String) : String
    {
        this.tf.htmlText = newText || "";
        autosize();
        return newText;
    }
    
    private function get_text() : String
    {
        return this.tf.htmlText;
    }
    
    private function autosize() : Void
    {
        this.ln.y = Math.max(40, this.hd.x + this.hd.textHeight);
        this.tf.y = this.ln.y;
        bg.height = Math.max(tf.textHeight + tf.y + 23, MIN_HEIGHT);
    }
}


/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view;

import haxe.Constraints.Function;
import classes.internals.Utils;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.filters.DropShadowFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class UIUtils
{
    public function new()
    {
    }
    public static function convertColor(input : Dynamic) : Int
    {
        return Color.convertColor(input);
    }
    public static function convertTextFormat(input : Dynamic) : TextFormat
    {
        if (Std.is(input, TextFormat))
        {
            return try cast(input, TextFormat) catch(e:Dynamic) null;
        }
        var tf : TextFormat = new TextFormat();
        setProperties(tf, input, {
                    color : Color.convertColor
                });
        return tf;
    }
    public static function convertSize(value : Dynamic, ref100pc : Float) : Float
    {
        if (Std.is(value, Float))
        {
            return as3hx.Compat.parseFloat(value);
        }
        value = "" + value;
        if (value.indexOf("%") == value.length - 1)
        {
            return as3hx.Compat.parseFloat(value.substr(0, value.length - 1)) * ref100pc / 100;
        }
        return as3hx.Compat.parseFloat(value);
    }
    public static function setProperties(e : Dynamic, options : Dynamic, special : Dynamic = null) : Dynamic
    {
        if (options != null)
        {
            for (key in Reflect.fields(options))
            {
                if (key.indexOf("on") == 0)
                {
                    e.addEventListener(key.substr(2), Utils.bindThis(try cast(Reflect.field(options, key), Function) catch(e:Dynamic) null, e));
                }
                else if (options.exists(key) && Lambda.has(e, key))
                {
                    var spcobj : Dynamic = (special != null) ? Reflect.field(special, key) : null;
                    if (spcobj == null)
                    {
                        continue;
                    }
                    var spc : Function = try cast(spcobj, Function) catch(e:Dynamic) null;
                    var value : Dynamic = Reflect.field(options, key);
                    Reflect.setField(e, key, (spc != null) ? spc(value) : value);
                }
            }
        }
        return e;
    }
    
    public static function newTextField(options : Dynamic = null) : TextField
    {
        if (Std.is(options, String))
        {
            options = {
                        text : options
                    };
        }
        var e : TextField = new TextField();
        e.antiAliasType = AntiAliasType.ADVANCED;
        if (Lambda.has(options, "defaultTextFormat"))
        {
            e.defaultTextFormat = UIUtils.convertTextFormat(Reflect.field(options, "defaultTextFormat"));
        }
        UIUtils.setProperties(e, options, {
                    defaultTextFormat : UIUtils.convertTextFormat,
                    background : UIUtils.convertColor,
                    textColor : UIUtils.convertColor,
                    autoSize : null,
                    text : null,
                    htmlText : null
                });
        if (!(Lambda.has(options, "mouseEnabled")) && Reflect.field(options, "type") != "input")
        {
            e.mouseEnabled = false;
        }
        if (!(Lambda.has(options, "width") || Lambda.has(options, "height") || Lambda.has(options, "autoSize")))
        {
            e.autoSize = TextFieldAutoSize.LEFT;
        }
        else if (Lambda.has(options, "autoSize"))
        
        // set it after sizes{
            
            e.autoSize = Reflect.field(options, "autoSize");
        }
        if (Lambda.has(options, "htmlText"))
        {
            e.htmlText = options.htmlText;
        }
        else if (Lambda.has(options, "text"))
        {
            e.text = options.text;
        }
        return e;
    }
    public static function outlineFilter(color : Dynamic) : DropShadowFilter
    {
        return new DropShadowFilter(
        0.0, 
        0, 
        Color.convertColor32(color), 
        1.0, 
        4.0, 
        4.0, 
        10.0);
    }
    public static function subsprite(src : BitmapData, x : Int, y : Int, width : Int, height : Int) : BitmapData
    {
        var dst : BitmapData = new BitmapData(width, height, true, 0);
        if (width > 0 && height > 0)
        {
            dst.copyPixels(src, new Rectangle(x, y, width, height), new Point(0, 0));
        }
        return dst;
    }
    public static function drawBitmap(g : Graphics, bmp : BitmapData, x : Int, y : Int, width : Int = -1, height : Int = -1) : Void
    {
        if (width == -1)
        {
            width = bmp.width;
        }
        if (height == -1)
        {
            height = bmp.height;
        }
        // We can't just draw a bitmap onto Graphics, we have to use beginBitmapFill
        // It fills the shape with repeated bitmap pattern
        // with origin at graphics' 0,0 corner.
        // To compensate and avoid weird tiling artifact, we transorm the bitmap fill.
        var m : Matrix = new Matrix();
        m.translate(x, y);
        g.beginBitmapFill(bmp, m);
        g.drawRect(x, y, width, height);
        g.endFill();
    }
    public static function getRelativePos(element : DisplayObject, container : DisplayObject) : Point
    {
        var x : Float = 0;
        var y : Float = 0;
        while (element && element != container)
        {
            x += element.x;
            y += element.y;
            element = element.parent;
        }
        return new Point(x, y);
    }
}


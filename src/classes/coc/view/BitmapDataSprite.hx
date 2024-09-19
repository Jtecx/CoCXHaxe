/**
 * Coded by aimozg on 04.06.2017.
 */
package coc.view;

import classes.internals.Utils;
import flash.display.Bitmap;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Matrix;

@:meta(Style(name="fillColor",type="uint",format="Color",inherit="no"))

class BitmapDataSprite extends Sprite
{
    public var smooth(get, set) : Bool;
    public var bitmapClass(get, set) : Class<Dynamic>;
    public var bitmap(get, set) : Bitmap;
    public var fillColor(get, set) : Int;
    public var fillAlpha(get, set) : Float;
    public var borderColor(get, set) : Int;
    public var borderWidth(get, set) : Int;
    public var borderRadius(get, set) : Int;
    public var borderImage(get, set) : BorderImage;
    public var stretch(get, set) : Bool;
    public var repeat(get, set) : Bool;
    public var crop(get, set) : Bool;

    public function new(options : Dynamic = null)
    {
        super();
        options = Utils.extend({ }, options);
        if (options != null)
        {
            _fillColor = UIUtils.convertColor(Utils.moveValue(options, "fillColor", _fillColor));
            _borderColor = UIUtils.convertColor(Utils.moveValue(options, "borderColor", _borderColor));
            _width = Utils.moveValue(options, "width", _width);
            _height = Utils.moveValue(options, "height", _height);
            if (_width || _height)
            {
                setSize(_width, _height);
            }
            _stretch = Utils.moveValue(options, "stretch", _stretch);
            _repeat = Utils.moveValue(options, "repeat", _repeat);
            _crop = Utils.moveValue(options, "crop", _crop);
            _borderImage = Utils.moveValue(options, "borderImage", _borderImage);
            _bitmapX = Utils.moveValue(options, "bitmapX", _bitmapX);
            _bitmapY = Utils.moveValue(options, "bitmapY", _bitmapY);
            bitmapClass = Utils.moveValue(options, "bitmapClass", null);
            bitmap = Utils.moveValue(options, "bitmap", _bitmap);
            for (key in Reflect.fields(options))
            {
                if (options.exists(key))
                {
                    var value : Dynamic = Reflect.field(options, key);
                    if (Lambda.has(this, key))
                    {
                        Reflect.setField(this, key, value);
                    }
                    else
                    {
                        trace("Unknown BitmapDataSprite property", key);
                    }
                }
            }
        }
    }
    private var _bitmap : Bitmap = null;
    private var _bitmapX : Float = 0;
    private var _bitmapY : Float = 0;
    private var _borderImage : BorderImage = null;
    private var _fillColor : Int = 0;
    private var _fillAlpha : Float = 1.0;
    private var _borderColor : Int = 0;
    private var _borderWidth : Int = 0;
    private var _borderRadius : Int = 0;
    private var _width : Float = 0;
    private var _height : Float = 0;
    private var _stretch : Bool = false;
    private var _repeat : Bool = false;
    private var _crop : Bool = false;
    private var _smooth : Bool = true;
    
    private function get_smooth() : Bool
    {
        return _smooth;
    }
    private function set_smooth(value : Bool) : Bool
    {
        _smooth = value;
        redraw();
        return value;
    }
    
    private function set_bitmapClass(value : Class<Dynamic>) : Class<Dynamic>
    {
        if (Type.getClass(value))
        {
            bitmap = try cast((Type.createInstance(value, [])), Bitmap) catch(e:Dynamic) null;
        }
        else
        {
            bitmap = null;
        }
        return value;
    }
    private function get_bitmapClass() : Class<Dynamic>
    {
        return null;
    }
    private function get_bitmap() : Bitmap
    {
        return _bitmap;
    }
    private function set_bitmap(value : Bitmap) : Bitmap
    {
        if (_bitmap == value)
        {
            return value;
        }
        _bitmap = value;
        if (value != null)
        {
            if (_width == 0 || !crop && !stretch && !repeat)
            {
                _width = value.width;
            }
            if (_height == 0 || !crop && !stretch && !repeat)
            {
                _height = value.height;
            }
        }
        redraw();
        return value;
    }
    private function get_fillColor() : Int
    {
        return _fillColor;
    }
    private function set_fillColor(value : Dynamic) : Dynamic
    {
        if (!(Std.is(value, Float)))
        {
            value = Color.convertColor(value);
        }
        if (_fillColor == value)
        {
            return value;
        }
        _fillColor = value;
        redraw();
        return value;
    }
    private function get_fillAlpha() : Float
    {
        return _fillAlpha;
    }
    private function set_fillAlpha(value : Float) : Float
    {
        if (_fillAlpha == value)
        {
            return value;
        }
        _fillAlpha = value;
        redraw();
        return value;
    }
    private function get_borderColor() : Int
    {
        return _borderColor;
    }
    private function set_borderColor(value : Dynamic) : Dynamic
    {
        if (!(Std.is(value, Float)))
        {
            value = Color.convertColor(value);
        }
        if (_borderColor == value)
        {
            return value;
        }
        _borderColor = value;
        if (_borderWidth != 0)
        {
            redraw();
        }
        return value;
    }
    private function get_borderWidth() : Int
    {
        return _borderWidth;
    }
    private function set_borderWidth(value : Int) : Int
    {
        if (_borderWidth == value)
        {
            return value;
        }
        _borderWidth = value;
        redraw();
        return value;
    }
    private function get_borderRadius() : Int
    {
        return _borderRadius;
    }
    private function set_borderRadius(value : Int) : Int
    {
        if (_borderRadius == value)
        {
            return value;
        }
        _borderRadius = value;
        if (borderWidth != 0)
        {
            redraw();
        }
        return value;
    }
    private function get_borderImage() : BorderImage
    {
        return _borderImage;
    }
    private function set_borderImage(value : BorderImage) : BorderImage
    {
        if (_borderImage == value)
        {
            return value;
        }
        _borderImage = value;
        redraw();
        return value;
    }
    override private function set_width(value : Float) : Float
    {
        setSize(value, _height);
        return value;
    }
    override private function set_height(value : Float) : Float
    {
        setSize(_width, value);
        return value;
    }
    public function setSize(width : Float, height : Float) : Void
    {
        _width = width;
        _height = height;
        redraw();
        super.width = width;
        super.height = height;
    }
    private function get_stretch() : Bool
    {
        return _stretch;
    }
    private function set_stretch(value : Bool) : Bool
    {
        if (_stretch == value)
        {
            return value;
        }
        _stretch = value;
        redraw();
        return value;
    }
    private function get_repeat() : Bool
    {
        return _repeat;
    }
    private function set_repeat(value : Bool) : Bool
    {
        if (_repeat == value)
        {
            return value;
        }
        _repeat = value;
        redraw();
        return value;
    }
    private function get_crop() : Bool
    {
        return _crop;
    }
    private function set_crop(value : Bool) : Bool
    {
        if (_crop == value)
        {
            return value;
        }
        _crop = value;
        redraw();
        return value;
    }
    private function redraw() : Void
    {
        var graphics : Graphics = this.graphics;
        graphics.clear();
        if (_borderImage != null)
        {
            graphics.lineStyle();
        }
        else
        {
            this.graphics.lineStyle(borderWidth, _borderColor, (borderWidth > 0) ? 1.0 : 0);
        }
        if (bitmap != null)
        {
            var m : Matrix = new Matrix();
            if (stretch)
            {
                m.scale(_width / bitmap.width, _height / bitmap.height);
                graphics.beginBitmapFill(bitmap.bitmapData, m, false, smooth);
            }
            else
            {
                m.translate(_bitmapX, _bitmapY);
                graphics.beginBitmapFill(bitmap.bitmapData, m, repeat);
            }
        }
        else
        {
            graphics.beginFill(_fillColor, _fillAlpha);
        }
        if (_borderRadius != 0)
        {
            graphics.drawRoundRect(0, 0, _width, _height, _borderRadius, _borderRadius);
        }
        else
        {
            graphics.drawRect(0, 0, _width, _height);
        }
        graphics.endFill();
        if (_borderImage != null)
        {
            _borderImage.drawOver(graphics, _width, _height, true);
        }
    }
}


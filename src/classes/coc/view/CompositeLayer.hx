/**
 * Coded by aimozg on 11.07.2017.
 */
package coc.view;

import flash.display.BitmapData;

class CompositeLayer
{
    public var width(get, never) : Int;
    public var height(get, never) : Int;
    public var dx(get, never) : Int;
    public var dy(get, never) : Int;
    public var name(get, never) : String;

    private var _name : String;
    private var src : BitmapData;
    private var dst : BitmapData;
    private var keyColors : Dynamic;  // uint color24 -> uint color24  
    private var dirty : Bool = true;
    private var _dx : Int;
    private var _dy : Int;
    private var animation : LayerAnimation;
    
    private function get_width() : Int
    {
        return src.width;
    }
    private function get_height() : Int
    {
        return src.height;
    }
    
    private function get_dx() : Int
    {
        return as3hx.Compat.parseInt(_dx + ((animation != null) ? animation.dx() : 0));
    }
    
    private function get_dy() : Int
    {
        return as3hx.Compat.parseInt(_dy + ((animation != null) ? animation.dy() : 0));
    }
    
    public function advanceTime(dt : Int, t2 : Int) : Bool
    {
        if (animation != null)
        {
            return animation.advanceTime(dt, t2);
        }
        return false;
    }
    public function resetAnimation() : Void
    {
        if (animation != null)
        {
            animation.reset();
        }
    }
    
    @:allow(coc.view)
    private function new(name : String, src : BitmapData, dx : Int, dy : Int)
    {
        this._name = name;
        this.src = src;
        this._dx = dx;
        this._dy = dy;
        this.dst = new BitmapData(src.width, src.height, true, 0);
        this.keyColors = { };
        this.dst.draw(src);
    }
    
    
    private function get_name() : String
    {
        return _name;
    }
    public function setKeyColors(newKeyColors : Dynamic) : Void
    {
        for (kc in Reflect.fields(keyColors))
        {
            if (!(Lambda.has(newKeyColors, kc)))
            {
                dirty = true;
                Reflect.deleteField(keyColors, kc);
            }
        }
        for (kc in Reflect.fields(newKeyColors))
        {
            if (!(Lambda.has(keyColors, kc)) || Reflect.field(keyColors, Std.string(kc)) != Reflect.field(newKeyColors, Std.string(kc)))
            {
                dirty = true;
                Reflect.setField(keyColors, Std.string(kc), Reflect.field(newKeyColors, Std.string(kc)));
            }
        }
    }
    public function setAnimation(animation : AnimationDef, composite : CompositeImage) : Void
    {
        if (!this.animation && animation == null)
        {
            return;
        }
        this.animation = (animation != null) ? new LayerAnimation(animation, this, composite) : null;
        //		if (animation) {
        //			animation.setKeyColors(keyColors);
        //		}
        dirty = true;
    }
    
    public function draw() : BitmapData
    {
        if (dirty)
        {
            doUpdate();
        }
        var image : CompositeLayer = (animation != null) ? animation.image() : null;
        if (image != null && !image.animation)
        {
            image.setKeyColors(keyColors);
            return image.draw();
        }
        return dst;
    }
    
    private function doUpdate() : Void
    {
        recolor(keyColors, src, dst);
    }
    public static function recolor(keyColors : Dynamic, src : BitmapData, dst : BitmapData) : Void
    {
        var y : Int = 0;
        var height : Int = src.height;
        while (y < height)
        {
            var x : Int = 0;
            var width : Int = src.width;
            while (x < width)
            {
                var pix : Int = src.getPixel32(x, y);
                var alpha : Int = pix & 0xff000000;
                var rgb : Int = pix & 0x00ffffff;
                if (Lambda.has(keyColors, rgb))
                {
                    rgb = Reflect.field(keyColors, Std.string(rgb)) & 0x00ffffff;
                }
                dst.setPixel32(x, y, alpha | rgb);
                x++;
            }
            y++;
        }
    }
}


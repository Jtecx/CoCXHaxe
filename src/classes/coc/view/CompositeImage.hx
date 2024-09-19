/**
 * Coded by aimozg on 10.07.2017.
 */
package coc.view;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

class CompositeImage
{
    public var width(get, never) : Int;
    public var height(get, never) : Int;

    private var list : Array<Dynamic>;
    private var layers : Dynamic;
    private var animations : Dynamic;
    private var visibility : Dynamic;
    private var bmp : BitmapData;
    private function get_width() : Int
    {
        return bmp.width;
    }
    private function get_height() : Int
    {
        return bmp.height;
    }
    
    public function new(width : Int, height : Int)
    {
        list = [];
        layers = { };
        animations = { };
        visibility = { };
        bmp = new BitmapData(width, height, true, 0);
    }
    public function addLayer(name : String, src : BitmapData, dx : Int, dy : Int, visible : Bool = true) : Void
    {
        if (Lambda.has(visibility, name))
        {
            removeLayer(name);
        }
        var layer : CompositeLayer = new CompositeLayer(name, src, dx, dy);
        Reflect.setField(layers, name, layer);
        list.unshift(layer);
        Reflect.setField(visibility, name, visible);
    }
    public function getLayer(name : String) : CompositeLayer
    {
        return Reflect.field(layers, name);
    }
    public function addAnimation(animation : AnimationDef) : Void
    {
        this.animations[animation.name] = animation;
    }
    public function advanceTime(dt : Int, t2 : Int) : Bool
    {
        var dirty : Bool = false;
        for (layer in list)
        {
            if (Reflect.field(visibility, Std.string(layer.name)) != null)
            {
                if (layer.advanceTime(dt, t2))
                {
                    dirty = true;
                }
            }
        }
        return dirty;
    }
    public function removeLayer(name : String) : Void
    {
        for (i in 0...list.length)
        {
            if (Reflect.field(list, i).name == name)
            {
                list.splice(i, 1);
                Reflect.deleteField(visibility, name);
                break;
            }
        }
        Reflect.deleteField(layers, name);
    }
    public function replaceLayer(name : String, src : BitmapData, dx : Int, dy : Int) : Void
    {
        for (i in 0...list.length)
        {
            if (Reflect.field(list, i).name == name)
            {
                Reflect.setField(list, i, new CompositeLayer(name, src, dx, dy));
            }
        }
    }
    public function setMultiVisibility(prefix : String, visible : Bool) : Void
    {
        for (key in Reflect.fields(visibility))
        {
            if (key.indexOf(prefix) == 0)
            {
                Reflect.setField(visibility, key, visible);
            }
        }
    }
    public function setVisibility(name : String, visible : Bool) : Void
    {
        if (Lambda.has(visibility, name))
        {
            Reflect.setField(visibility, name, visible);
        }
        else
        {
            trace("[WARN] <" + ((visible) ? "show" : "hide") + "> called for non-existing layer " + name);
        }
    }
    public function isVisible(name : String) : Bool
    {
        return !!Reflect.field(visibility, name);
    }
    public function setAnimation(layerName : String, animationName : String) : Void
    {
        var layer : CompositeLayer = Reflect.field(layers, layerName);
        if (layer == null)
        {
            trace("[WARN] <animate> called for non-existing layer " + layerName);
            return;
        }
        if (Reflect.field(visibility, layerName) == null)
        {
            return;
        }
        var animation : AnimationDef = Reflect.field(animations, animationName);
        if (animationName != null && animation == null)
        {
            trace("[WARN] <animate> called for non-existing animation " + animationName);
            return;
        }
        layer.setAnimation(animation, this);
    }
    public function setMultiAnimation(prefix : String, animationName : String) : Void
    {
        var animation : AnimationDef = Reflect.field(animations, animationName);
        if (animationName != null && animation == null)
        {
            trace("[WARN] <animate> called for non-existing animation " + animationName);
            return;
        }
        for (key in Reflect.fields(visibility))
        {
            if (key.indexOf(prefix) == 0 && Reflect.field(visibility, key) != null)
            {
                (try cast(Reflect.field(layers, key), CompositeLayer) catch(e:Dynamic) null).setAnimation(animation, this);
            }
        }
    }
    public function resetAnimations() : Void
    {
        for (layer in list)
        {
            layer.resetAnimation();
        }
    }
    public function hideAll() : Void
    {
        for (layer in list)
        {
            Reflect.setField(visibility, Std.string(layer.name), false);
            layer.setAnimation(null, null);
        }
    }
    public function draw(keyColors : Dynamic) : BitmapData
    {
        bmp.fillRect(bmp.rect, 0);
        for (layer in list)
        {
            if (Reflect.field(visibility, Std.string(layer.name)) != null)
            {
                layer.setKeyColors(keyColors);
                var sx : Int = 0;
                var sy : Int = 0;
                var sw : Int = layer.width;
                var sh : Int = layer.height;
                var dx : Int = layer.dx;
                var dy : Int = layer.dy;
                if (dx < 0)
                {
                    sx = -dx;
                    dx = 0;
                }
                if (dy < 0)
                {
                    sy = -dy;
                    dy = 0;
                }
                if (dx + sw > width)
                {
                    sw = as3hx.Compat.parseInt(width - dx);
                }
                if (dy + sh > height)
                {
                    sh = as3hx.Compat.parseInt(height - dy);
                }
                bmp.copyPixels(layer.draw(), 
                        new Rectangle(sx, sy, sw, sh), 
                        new Point(dx, dy), null, null, true
            );
            }
        }
        return bmp;
    }
}






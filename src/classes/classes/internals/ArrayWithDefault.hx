/**
 * Created by aimozg on 02.04.2017.
 */
package classes.internals;

import haxe.Constraints.Function;
import flash.utils.Proxy;


class ArrayWithDefault extends Proxy
{
    public var length(get, never) : Int;

    private var array(default, never) : Array<Dynamic> = [];
    private var _debug(default, never) : Bool = false;
    public function new(array : Array<Dynamic> = null)
    {
        super();
        if (array != null)
        {
            this.array.push.apply(this.array, array);
        }
    }
    override private function hasProperty(name : Dynamic) : Bool
    {
        if (_debug)
        {
            trace("hasProperty", name);
        }
        return Math.isFinite(+name);
    }
    override private function getProperty(name : Dynamic) : Dynamic
    {
        var s : Float = +name;
        var i : Int = new Int(s);
        if (_debug)
        {
            trace("getProperty ", as3hx.Compat.typeof((name)), name);
        }
        if (s >= 0)
        {
            stretch(i + 1);
            if (_debug)
            {
                trace("Counter " + i + " being accessed. Value = " + array[i]);
            }
            return array[i];
        }
        else
        {
            return Reflect.field(array, Std.string(name));
        }
    }
    private function get_length() : Int
    {
        return array.length;
    }
    override private function setProperty(name : Dynamic, value : Dynamic) : Void
    {
        if (name == "length")
        {
            if (_debug)
            {
                trace("setProperty ", name, value);
            }
            stretch(value);
        }
        else
        {
            var s : Float = +name;
            var i : Int = new Int(s);
            value = __DOLLAR__cast(value);
            if (_debug)
            {
                trace("setProperty ", name, value);
            }
            if (Math.isFinite(s))
            {
                stretch(i);
                array[i] = value;
            }
        }
    }
    private function __DOLLAR__cast(o : Dynamic) : Dynamic
    {
        return o;
    }
    private function stretch(length : Int) : Void
    {
        if (length > array.length)
        {
            if (_debug)
            {
                trace("stretch(" + length + ").");
            }
            for (j in array.length...length)
            {
                array[j] = defaultValue();
            }
        }
    }
    private function defaultValue() : Dynamic
    {
        return null;
    }
    override private function deleteProperty(name : Dynamic) : Bool
    {
        if (_debug)
        {
            trace("deleteProperty", name);
        }
        var s : Float = +name;
        var i : Int = new Int(s);
        if (Math.isFinite(s) && i < array.length)
        {
            if (i == array.length - 1)
            {
                as3hx.Compat.setArrayLength(array, i);
                return true;
            }
            else
            {
                array[i] = defaultValue();
            }
        }
        return false;
    }
    
    
    override private function nextName(index : Int) : String
    {
        if (_debug)
        {
            trace("nextName", index);
        }
        return Std.string(index);
    }
    
    override private function nextValue(index : Int) : Dynamic
    {
        if (_debug)
        {
            trace("nextValue", index);
        }
        return array[index];
    }
    
    override private function nextNameIndex(index : Int) : Int
    {
        if (_debug)
        {
            trace("nextNameIndex ", index);
        }
        if (index < array.length)
        {
            return as3hx.Compat.parseInt(index + 1);
        }
        return 0;
    }
    
    override private function callProperty(name : Dynamic, rest : Array<Dynamic> = null) : Dynamic
    {
        if (name == "valueOf")
        {
            return toString();
        }
        var v : Function = Reflect.field(this, Std.string(name));
        return Reflect.callMethod(null, v, rest);
    }
    
    public function toString() : String
    {
        return "[" + Std.string(array) + "]";
    }
}


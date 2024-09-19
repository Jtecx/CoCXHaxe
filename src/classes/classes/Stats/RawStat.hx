/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.stats;

import classes.Creature;
import classes.internals.Jsonable;
import classes.internals.Utils;

class RawStat implements IStat implements Jsonable
{
    public var host(get, never) : Creature;
    public var statName(get, never) : String;
    public var min(get, set) : Float;
    public var max(get, set) : Float;
    public var value(get, set) : Float;

    
    private var _min : Float = -Infinity;
    private var _max : Float = +Infinity;
    private var _value : Float = 0;
    private var _name : String;
    private var _host : Creature;
    
    /**
	 * @param options Options object:
	 * value: default 0;
	 * min: default -Infinity
	 * max: default +Infinity
	 */
    public function new(owner : Creature, name : String, options : Dynamic = null)
    {
        options = Utils.extend({
                            value : 0.0,
                            min : -Infinity,
                            max : +Infinity
                        }, options);
        this._name = name;
        this._value = Reflect.field(options, "value");
        this._min = Reflect.field(options, "min");
        this._max = Reflect.field(options, "max");
        this._host = owner;
    }
    
    
    private function get_host() : Creature
    {
        return _host;
    }
    
    private function get_statName() : String
    {
        return _name;
    }
    
    private function get_min() : Float
    {
        return _min;
    }
    private function set_min(value : Float) : Float
    {
        _min = value;
        return value;
    }
    private function get_max() : Float
    {
        return _max;
    }
    private function set_max(value : Float) : Float
    {
        _max = value;
        return value;
    }
    private function get_value() : Float
    {
        return Utils.boundFloat(min, _value, max);
    }
    private function set_value(value : Float) : Float
    {
        _value = value;
        return value;
    }
    public function saveToObject() : Dynamic
    {
        return {
            value : _value
        };
    }
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        var x : Dynamic = Reflect.field(o, "value");
        if (as3hx.Compat.typeof(x) != "number")
        {
            var errmsg : String = "Expected number, got " + (as3hx.Compat.typeof(x)) + " " + x;
            if (!ignoreErrors)
            {
                throw errmsg;
            }
            else
            {
                trace(errmsg);
            }
            x = 0.0;
        }
        _value = x;
    }
}


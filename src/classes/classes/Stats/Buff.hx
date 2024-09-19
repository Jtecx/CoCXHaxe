/**
 * Coded by aimozg on 30.05.2018.
 */
package classes.stats;

import classes.internals.Jsonable;
import classes.internals.Utils;

class Buff implements Jsonable
{
    public var stat(get, never) : BuffableStat;
    public var options(get, set) : Dynamic;
    public var tag(get, never) : String;
    public var value(get, set) : Float;

    private var _tag : String;
    public var rawValue : Float;
    public var save : Bool;
    public var text : String;
    public var show : Bool;
    public var rate : Int;
    public var tick : Int;
    private var _stat : BuffableStat;
    
    public static inline var RATE_PERMANENT : Int = 0;
    public static inline var RATE_ROUNDS : Int = 1;
    public static inline var RATE_HOURS : Int = 2;
    public static inline var RATE_DAYS : Int = 3;
    
    private function get_stat() : BuffableStat
    {
        return _stat;
    }
    public function new(stat : BuffableStat, value : Float, tag : String, save : Bool = true, show : Bool = true, text : String = null)
    {
        this._stat = stat;
        this.rawValue = value;
        this._tag = tag;
        this.save = save;
        this.show = show;
        this.text = ((text == null)) ? Utils.capitalizeFirstLetter(tag) : text;
        this.rate = RATE_PERMANENT;
        this.tick = 0;
    }
    public function withOptions(options : Dynamic) : Buff
    {
        this.options = options;
        return this;
    }
    private function get_options() : Dynamic
    {
        return {
            save : save,
            show : show,
            text : text,
            rate : rate,
            tick : tick
        };
    }
    private function set_options(value : Dynamic) : Dynamic
    {
        if (value == null)
        {
            return value;
        }
        if (Lambda.has(value, "save"))
        {
            this.save = value.save;
        }
        if (Lambda.has(value, "text"))
        {
            this.text = value.text;
        }
        if (Lambda.has(value, "show"))
        {
            this.show = value.show;
        }
        if (Lambda.has(value, "rate"))
        {
            this.rate = value.rate;
        }
        if (Lambda.has(value, "tick"))
        {
            this.tick = value.tick;
        }
        return value;
    }
    public function saveToObject() : Dynamic
    {
        return [rawValue, _tag, options];
    }
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (Std.is(o, Array))
        {
            rawValue = +Reflect.field(o, Std.string(0));
            _tag = Reflect.field(o, Std.string(1));
            options = Reflect.field(o, Std.string(2));
            return;
        }
        if (ignoreErrors)
        {
            return;
        }
        throw "Not a valid Buff: " + o;
    }
    
    private function get_tag() : String
    {
        return _tag;
    }
    private function get_value() : Float
    {
        return rawValue;
    }
    private function set_value(value : Float) : Float
    {
        rawValue = value;
        _stat.recalculate();
        return value;
    }
}


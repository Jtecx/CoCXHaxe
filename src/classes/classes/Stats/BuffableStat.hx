package classes.stats;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.Creature;
import classes.internals.EnumValue;
import classes.internals.Jsonable;
import classes.internals.Utils;

/**
 * BuffableStat is aggregation (sum/min/max/product) of buffs.
 * Buff contains (see Buff.as for details) unique tag:String, value:Number, and other options
 * Total value is maintained as a cache
 *
 * Options object structure:
 * save: boolean = true, <-- save and load the effect. False for effects created by other creature properties (race, perks)
 * show: boolean = true, <-- can be viewed by player. Note that player might figure that there is a hidden effect
 * text: String = null, (default is same as tag) <-- displayable name in the list of effects
 */
class BuffableStat implements IStat implements Jsonable
{
    public var base(get, never) : Float;
    public var aggregate(get, never) : Int;
    public var min(get, never) : Float;
    public var max(get, never) : Float;
    public var value(get, never) : Float;
    public var host(get, never) : Creature;
    public var statName(get, never) : String;

    private static var AggregateTypes : Array<Dynamic> = [];
    
    public static var AGGREGATE_SUM : Int = EnumValue.add(AggregateTypes, 0, "AGGREGATE_SUM", {
                    short : "sum"
                });
    public static var AGGREGATE_MAX : Int = EnumValue.add(AggregateTypes, 1, "AGGREGATE_MAX", {
                    short : "max"
                });
    public static var AGGREGATE_MIN : Int = EnumValue.add(AggregateTypes, 2, "AGGREGATE_MIN", {
                    short : "min"
                });
    public static var AGGREGATE_PROD : Int = EnumValue.add(AggregateTypes, 3, "AGGREGATE_PROD", {
                    short : "prod"
                });
    
    private var _base : Float = 0.0;
    private var _baseFn : Function = null;
    private var _aggregate : Int = AGGREGATE_SUM;
    private var _min : Float = -Infinity;
    private var _max : Float = +Infinity;
    private var _value : Float = 0.0;  // Aggregate of buffs ONLY  
    private var _buffs : Array<Dynamic> = [];
    private var _name : String;
    private var _host : Creature;
    
    /**
	 * Set of buff tags (key is tag and value is true) that were removed since last
	 * `advanceTime`, `removeCombatRoundTrackingBuffs`, or `addTicksToBuff` call.
	 */
    public var recentlyRemovedTags : Dynamic = { };
    
    private function get_base() : Float
    {
        return ((_baseFn != null)) ? _baseFn() : _base;
    }
    private function get_aggregate() : Int
    {
        return _aggregate;
    }
    private function get_min() : Float
    {
        return _min;
    }
    private function get_max() : Float
    {
        return _max;
    }
    public function redefine(options : Dynamic) : Void
    {
        options = Utils.extend({
                            aggregate : this.aggregate,
                            base : this._baseFn || this.base,
                            min : this.min,
                            max : this.max
                        }, options);
        if (Std.is(options.aggregate, String))
        {
            options.aggregate = EnumValue.findByProperty(AggregateTypes, "short", options.aggregate).value;
        }
        if (options.aggregate == AGGREGATE_PROD && options.base == 0.0)
        {
            options.base = 1.0;
        }
        this._aggregate = options.aggregate;
        var base : Dynamic = Reflect.field(options, "base");
        if (Std.is(base, Function))
        {
            this._baseFn = base;
            this._base = aggregateBase();
        }
        else
        {
            this._base = base;
            this._baseFn = null;
        }
        this._min = Reflect.field(options, "min");
        this._max = Reflect.field(options, "max");
        recalculate();
    }
    private function get_value() : Float
    {
        var x : Float = aggregateStep(this.base, _value);
        if (x < min)
        {
            return min;
        }
        if (x > max)
        {
            return max;
        }
        return x;
    }
    
    /**
	 * @param options Options object: {
	 *     aggregate: how to aggregate multiple effects, AGGREGATE_constant or 'sum'/'min'/'max';
	 *     base: default 0; can be Function ()=>Number
	 *     min: default -Infinity;
	 *     max: default +Infinity;
	 * }
	 */
    public function new(host : Creature, name : String, options : Dynamic = null)
    {
        this._host = host;
        this._name = name;
        redefine(options);
        
        if (!(Lambda.has(AggregateTypes, this._aggregate)))
        {
            throw new Error("Invalid aggregate type");
        }
    }
    
    private function get_host() : Creature
    {
        return _host;
    }
    
    private function get_statName() : String
    {
        return _name;
    }
    
    /**
	 * Add `amount` ticks to buff tagged `tag`.
	 * Does nothing if no such buff or it is permanent.
	 *
	 * Will reset & populate`recentlyRemovedTags`
	 */
    public function addTicksToBuff(tag : String, amount : Float) : Void
    {
        recentlyRemovedTags = { };
        var buff : Buff = findBuff(tag);
        if (buff == null || buff.rate == Buff.RATE_PERMANENT)
        {
            return;
        }
        buff.tick += amount;
        if (buff.tick <= 0)
        {
            Reflect.setField(recentlyRemovedTags, tag, true);
            removeBuff(tag);
        }
    }
    
    private function aggregateBase() : Float
    {
        return (_aggregate == AGGREGATE_PROD) ? 1 : 0;
    }
    private function aggregateStep(accumulator : Float, value : Float) : Float
    {
        switch (_aggregate)
        {
            case AGGREGATE_SUM:
                accumulator += value;
            case AGGREGATE_MAX:
                accumulator = ((accumulator > value)) ? accumulator : value;
            case AGGREGATE_MIN:
                accumulator = ((accumulator < value)) ? accumulator : value;
            case AGGREGATE_PROD:
                accumulator *= value;
        }
        return accumulator;
    }
    public function calculate() : Float
    {
        var value : Float = aggregateBase();
        for (buff in _buffs)
        {
            value = aggregateStep(value, buff.value);
        }
        return value;
    }
    public function recalculate() : Void
    {
        _value = calculate();
    }
    private function indexOfBuff(tag : String) : Int
    {
        for (i in 0..._buffs.length)
        {
            if (_buffs[i].tag == tag)
            {
                return i;
            }
        }
        return -1;
    }
    public function hasBuff(tag : String) : Bool
    {
        return indexOfBuff(tag) != -1;
    }
    /**
	 * @return Buff or null
	 */
    public function findBuff(tag : String) : Buff
    {
        var i : Int = indexOfBuff(tag);
        if (i == -1)
        {
            return null;
        }
        return _buffs[i];
    }
    public function valueOfBuff(tag : String, defaultValue : Float = 0.0) : Float
    {
        var i : Int = indexOfBuff(tag);
        if (i == -1)
        {
            return defaultValue;
        }
        return _buffs[i].value;
    }
    public function ticksOfBuff(tag : String) : Int
    {
        var i : Int = indexOfBuff(tag);
        if (i == -1)
        {
            return 0;
        }
        return _buffs[i].tick;
    }
    public function addOrIncreaseBuff(tag : String, buffValue : Float, newOptions : Dynamic = null) : Void
    {
        var i : Int = indexOfBuff(tag);
        if (i == -1)
        {
            _buffs.push(new Buff(this, buffValue, tag).withOptions(newOptions));
        }
        else
        {
            _buffs[i].rawValue += buffValue;
            if (newOptions != null)
            {
                _buffs[i].options = newOptions;
            }
        }
        if (_aggregate == AGGREGATE_SUM)
        {
            _value += buffValue;
        }
        else if (_aggregate == AGGREGATE_PROD)
        {
            _value *= buffValue;
        }
        else
        {
            _value = calculate();
        }
    }
    public function addOrReplaceBuff(tag : String, buffValue : Float, newOptions : Dynamic = null) : Void
    {
        var i : Int = indexOfBuff(tag);
        if (i == -1)
        {
            _buffs.push(new Buff(this, buffValue, tag).withOptions(newOptions));
        }
        else
        {
            _buffs[i].rawValue = buffValue;
            if (newOptions != null)
            {
                _buffs[i].options = newOptions;
            }
        }
        _value = calculate();
    }
    public function removeBuff(tag : String) : Void
    {
        var i : Int = indexOfBuff(tag);
        if (i == -1)
        {
            return;
        }
        var buffValue : Float = _buffs[i].value;
        _buffs.splice(i, 1);
        if (_aggregate == AGGREGATE_SUM)
        {
            _value -= buffValue;
        }
        else if (_aggregate == AGGREGATE_PROD && buffValue != 0)
        {
            _value /= buffValue;
        }
        else
        {
            _value = calculate();
        }
    }
    public function listBuffs() : Array<Dynamic>
    {
        return _buffs.copy();
    }
    public function removeAllBuffs() : Void
    {
        this._buffs = [];
        this._value = aggregateBase();
    }
    /**
	 * Advance time-tracking buffs by `ticks` units, unit type is defined by `rate`
	 * Buffs with their countdown expired are removed.
	 *
	 * Will reset & populate `recentlyRemovedTags`
	 */
    public function advanceTime(rate : Int, tick : Int) : Void
    {
        if (rate == Buff.RATE_PERMANENT)
        {
            throw "Invalid time unit " + rate;
        }
        if (tick < 0)
        {
            throw "Invalid ticks count " + tick;
        }
        if (tick == 0)
        {
            return;
        }
        var changed : Bool = false;
        recentlyRemovedTags = { };
        var i : Int = as3hx.Compat.parseInt(_buffs.length - 1);
        while (i >= 0)
        {
            var buff : Buff = _buffs[i];
            if (buff.rate == Buff.RATE_ROUNDS && buff.tick == 9999)
            {
                {i--;continue;
                }
            }
            if (buff.rate == rate)
            {
                buff.tick -= tick;
                if (buff.tick <= 0)
                {
                    Reflect.setField(recentlyRemovedTags, Std.string(buff.tag), true);
                    _buffs.splice(i, 1);
                    changed = true;
                }
            }
            i--;
        }
        if (changed)
        {
            recalculate();
        }
    }
    
    /**
	 * Remove all buffs with `rate == RATE_ROUNDS`.
	 *
	 * Will reset & populate `recentlyRemovedTags`
	 */
    public function removeCombatRoundTrackingBuffs() : Void
    {
        var changed : Bool = false;
        recentlyRemovedTags = { };
        var i : Int = as3hx.Compat.parseInt(_buffs.length - 1);
        while (i >= 0)
        {
            if (_buffs[i].rate == Buff.RATE_ROUNDS)
            {
                Reflect.setField(recentlyRemovedTags, Std.string(_buffs[i].tag), true);
                _buffs.splice(i, 1);
                changed = true;
            }
            i--;
        }
        if (changed)
        {
            recalculate();
        }
    }
    
    public function saveToObject() : Dynamic
    {
        var jbuffs : Array<Dynamic> = [];
        for (b in _buffs)
        {
            if (!b.save)
            {
                continue;
            }
            jbuffs.push(b.saveToObject());
        }
        return {
            effects : jbuffs
        };
    }
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        removeAllBuffs();
        var value : Float = aggregateBase();
        for (savedBuff/* AS3HX WARNING could not determine type for var: savedBuff exp: EField(EIdent(o),effects) type: null */ in o.effects)
        {
            var buff : Buff = new Buff(this, 0, "", false);
            buff.loadFromObject(savedBuff, ignoreErrors);
            var buffValue : Float = buff.value;
            value = aggregateStep(value, buffValue);
            _buffs.push(buff);
        }
        this._value = value;
    }
}


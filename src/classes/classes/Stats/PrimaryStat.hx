/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.stats;

import classes.Creature;
import classes.internals.Jsonable;
import classes.internals.Utils;

class PrimaryStat implements IStat implements IStatHolder implements Jsonable
{
    public var core(get, never) : RawStat;
    public var train(get, never) : RawStat;
    public var mult(get, never) : BuffableStat;
    public var bonus(get, never) : BuffableStat;
    public var mult100(get, never) : Int;
    public var host(get, never) : Creature;
    public var statName(get, never) : String;
    public var trainMultValue(get, never) : Float;
    public var value(get, never) : Float;
    public var totalCore(get, never) : Float;
    public var min(get, never) : Float;
    public var max(get, never) : Float;

    private var _core : RawStat;
    private var _train : RawStat;
    private var _mult : BuffableStat;
    private var _bonus : BuffableStat;
    private var _name : String;
    private var _host : Creature;
    private var _substats : Dynamic;
    
    public function reset(core : Float) : Void
    {
        _core.value = core;
        _train.value = 0;
        _mult.removeAllBuffs();
        _bonus.removeAllBuffs();
    }
    public function removeAllEffects() : Void
    {
        _mult.removeAllBuffs();
        _bonus.removeAllBuffs();
    }
    public function removeEffect(tag : String) : Void
    {
        _mult.removeBuff(tag);
        _bonus.removeBuff(tag);
    }
    
    private function get_core() : RawStat
    {
        return _core;
    }
    private function get_train() : RawStat
    {
        return _train;
    }
    private function get_mult() : BuffableStat
    {
        return _mult;
    }
    private function get_bonus() : BuffableStat
    {
        return _bonus;
    }
    private function get_mult100() : Int
    {
        return Math.floor(_mult.value * 100);
    }
    public function new(host : Creature, name : String)
    {
        _name = name;
        _host = host;
        _core = new CoreStat(host, name + ".core");
        _train = new TrainingStat(host, name + ".train");
        _mult = new BuffableStat(host, name + ".mult", {
                    base : 1.0,
                    min : 0
                });
        _bonus = new BuffableStat(host, name + ".bonus", { });
        _substats = {
                    core : _core,
                    train : _train,
                    mult : _mult,
                    bonus : _bonus
                };
    }
    
    
    private function get_host() : Creature
    {
        return _host;
    }
    
    private function get_statName() : String
    {
        return _name;
    }
    public function findStat(fullname : String) : IStat
    {
        if (fullname.indexOf(".") == -1)
        {
            return Reflect.field(_substats, fullname);
        }
        return StatUtils.findStatByPath(this, fullname);
    }
    public function allStats() : Array<Dynamic>
    {
        return Utils.values(_substats);
    }
    public function allStatNames() : Array<Dynamic>
    {
        return Utils.keys(_substats);
    }
    private function get_trainMultValue() : Float
    {
        return (mult.value + 1) / 2;
    }
    private function get_value() : Float
    {
        return Math.max(min, core.value * mult.value + train.value * trainMultValue + bonus.value);
    }
    private function get_totalCore() : Float
    {
        return Math.max(min, core.value + train.value);
    }
    private function get_min() : Float
    {
        return 1;
    }
    private function get_max() : Float
    {
        return core.max * mult.value + train.max * trainMultValue + Math.max(0, bonus.value);
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            core : core.saveToObject(),
            train : train.saveToObject(),
            mult : mult.saveToObject(),
            bonus : bonus.saveToObject()
        };
    }
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (as3hx.Compat.typeof(o.core) == "number")
        {
            core.value = o.core;
        }
        else
        {
            core.loadFromObject(o.core, ignoreErrors);
        }
        if (o.train)
        {
            train.loadFromObject(o.train, ignoreErrors);
        }
        mult.loadFromObject(o.mult, ignoreErrors);
        bonus.loadFromObject(o.bonus, ignoreErrors);
    }
}


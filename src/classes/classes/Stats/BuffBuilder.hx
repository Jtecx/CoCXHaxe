package classes.stats;

import classes.stats.BuffableStat;
import classes.internals.Utils;

class BuffBuilder
{
    
    private var store : StatStore;
    private var tag : String;
    private var options : Dynamic = { };
    
    public function new(store : StatStore, tag : String)
    {
        this.store = store;
        this.tag = tag;
    }
    
    // Utility functions
    
    public function isPresent() : Bool
    {
        return store.hasBuff(tag);
    }
    public function findAllBuffObjects() : Array<Dynamic>
    {
        return store.buffObjects(tag);
    }
    public function findBuffObjectOfStat(statName : String) : Buff
    {
        var stat : BuffableStat = store.findBuffableStat(statName);
        return stat.findBuff(tag);
    }
    public function getRemainingTicks() : Int
    {
        var buff : Buff = store.buffObjects(tag)[0];
        if (buff != null)
        {
            return buff.tick;
        }
        return 0;
    }
    public function getValueOfStatBuff(statName : String) : Float
    {
        var stat : BuffableStat = store.findBuffableStat(statName);
        return stat.valueOfBuff(tag);
    }
    
    // Builder functions
    
    public function remove() : BuffBuilder
    {
        store.removeBuffs(tag);
        return this;
    }
    public function removeFromStat(statName : String) : BuffBuilder
    {
        store.findBuffableStat(statName).removeBuff(tag);
        return this;
    }
    public function addStat(statName : String, value : Float,
            min : Float = Math.NEGATIVE_INFINITY,
            max : Float = Math.POSITIVE_INFINITY) : BuffBuilder
    {
        var stat : BuffableStat = store.findBuffableStat(statName);
        var oldValue : Float = stat.valueOfBuff(tag);
        var newValue : Float = Utils.boundFloat(min, oldValue + value, max);
        if (newValue == 0)
        {
            stat.removeBuff(tag);
        }
        else
        {
            stat.addOrReplaceBuff(tag, newValue, options);
        }
        return this;
    }
    public function subtractStat(statName : String, value : Float,
            min : Float = Math.NEGATIVE_INFINITY,
            max : Float = Math.POSITIVE_INFINITY) : BuffBuilder
    {
        addStat(statName, -value, min, max);
        return this;
    }
    public function setStat(statName : String, value : Float) : BuffBuilder
    {
        store.findBuffableStat(statName).addOrReplaceBuff(tag, value, options);
        return this;
    }
    public function addStats(buffObject : Dynamic) : BuffBuilder
    {
        store.addBuffObject(buffObject, tag, options);
        return this;
    }
    public function subtractStats(buffObject : Dynamic) : BuffBuilder
    {
        store.addBuffObject(StatUtils.inverseBuffObject(buffObject), tag, options);
        return this;
    }
    public function setStats(buffObject : Dynamic) : BuffBuilder
    {
        store.replaceBuffObject(buffObject, tag, options);
        return this;
    }
    public function withOptions(options : Dynamic) : BuffBuilder
    {
        Utils.extend(this.options, options);
        store.setBuffOptions(tag, options);
        return this;
    }
    public function withText(text : String) : BuffBuilder
    {
        return withOptions({
                    text : text
                });
    }
    public function permanent() : BuffBuilder
    {
        return withOptions({
                    rate : Buff.RATE_PERMANENT,
                    tick : 0
                });
    }
    public function forHours(hours : Int) : BuffBuilder
    {
        return withOptions({
                    rate : Buff.RATE_HOURS,
                    tick : hours
                });
    }
    public function forDays(days : Int) : BuffBuilder
    {
        return withOptions({
                    rate : Buff.RATE_DAYS,
                    tick : days
                });
    }
    public function combatTemporary(rounds : Int) : BuffBuilder
    {
        return withOptions({
                    rate : Buff.RATE_ROUNDS,
                    tick : rounds
                });
    }
    public function combatPermanent() : BuffBuilder
    {
        return withOptions({
                    rate : Buff.RATE_ROUNDS,
                    tick : 9999
                });
    }
    public function addDuration(tick : Int) : BuffBuilder
    {
        store.addTicksToBuffs(tag, tick);
        return this;
    }
    
    // Utility functions for particular stats go here
    
    public function addStr(value : Float) : BuffBuilder
    {
        return addStat("str", value);
    }
    public function addStrMult(value : Float) : BuffBuilder
    {
        return addStat("str.mult", value);
    }
    public function addTou(value : Float) : BuffBuilder
    {
        return addStat("tou", value);
    }
    public function addTouMult(value : Float) : BuffBuilder
    {
        return addStat("tou.mult", value);
    }
    public function addSpe(value : Float) : BuffBuilder
    {
        return addStat("spe", value);
    }
    public function addSpeMult(value : Float) : BuffBuilder
    {
        return addStat("spe.mult", value);
    }
    public function addInt(value : Float) : BuffBuilder
    {
        return addStat("int", value);
    }
    public function addIntMult(value : Float) : BuffBuilder
    {
        return addStat("int.mult", value);
    }
    public function addWis(value : Float) : BuffBuilder
    {
        return addStat("wis", value);
    }
    public function addWisMult(value : Float) : BuffBuilder
    {
        return addStat("wis.mult", value);
    }
    public function addLib(value : Float) : BuffBuilder
    {
        return addStat("lib", value);
    }
    public function addLibMult(value : Float) : BuffBuilder
    {
        return addStat("lib.mult", value);
    }
    public function addSens(value : Float) : BuffBuilder
    {
        return addStat("sens", value);
    }
}


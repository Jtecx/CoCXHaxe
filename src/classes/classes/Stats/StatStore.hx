/**
 * Coded by aimozg on 01.08.2018.
 */
package classes.stats;

import haxe.Constraints.Function;
import classes.CoC;
import classes.internals.Utils;
import coc.script.Eval;

class StatStore implements IStatHolder
{
    private var _stats : Dynamic = { };
    /**
	 * Set of buff tags (key is tag and value is true) that were removed since last
	 * `advanceTime`, `removeCombatRoundTrackingBuffs`, or `addTicksToBuffs` call.
	 */
    public var recentlyRemovedTags : Dynamic = { };
    
    public function new(setup : Array<Dynamic> = null)
    {
        if (setup != null)
        {
            for (stat in setup)
            {
                this._stats[stat.statName] = stat;
            }
        }
    }
    public function findStat(fullname : String) : IStat
    {
        if (fullname.indexOf(".") == -1)
        {
            return Reflect.field(_stats, fullname);
        }
        return StatUtils.findStatByPath(this, fullname);
    }
    public function addStat(stat : IStat) : StatStore
    {
        this._stats[stat.statName] = stat;
        return this;
    }
    public function addStatList(setup : Array<Dynamic>) : StatStore
    {
        for (stat in setup)
        {
            addStat(stat);
        }
        return this;
    }
    public function addStatObject(setup : Dynamic) : StatStore
    {
        Utils.extend(_stats, setup);
        return this;
    }
    public function allStats() : Array<Dynamic>
    {
        return Utils.values(_stats);
    }
    public function allStatNames() : Array<Dynamic>
    {
        return Utils.keys(_stats);
    }
    public function findBuffableStat(fullname : String) : BuffableStat
    {
        var istat : IStat = findStat(fullname);
        if (Std.is(istat, BuffableStat))
        {
            return try cast(istat, BuffableStat) catch(e:Dynamic) null;
        }
        else if (Std.is(istat, PrimaryStat))
        {
            return (try cast(istat, PrimaryStat) catch(e:Dynamic) null).bonus;
        }
        else
        {
            return null;
        }
    }
    /**
	 * Advance time-tracking buffs by `ticks` units, unit type is defined by `rate`
	 * Buffs with their countdown expired are removed.
	 *
	 * Will reset & populate `recentlyRemovedTags`
	 */
    public function advanceTime(rate : Int, tick : Int) : Void
    {
        recentlyRemovedTags = { };
        forEachStat(function(stat : BuffableStat) : Void
                {
                    stat.advanceTime(rate, tick);
                    Utils.extend(recentlyRemovedTags, stat.recentlyRemovedTags);
                }, BuffableStat);
    }
    /**
	 * Remove all buffs with `rate == RATE_ROUNDS`.
	 *
	 * Will reset & populate `recentlyRemovedTags`
	 */
    public function removeCombatRoundTrackingBuffs() : Void
    {
        recentlyRemovedTags = { };
        forEachStat(function(stat : BuffableStat) : Void
                {
                    stat.removeCombatRoundTrackingBuffs();
                    Utils.extend(recentlyRemovedTags, stat.recentlyRemovedTags);
                }, BuffableStat);
    }
    
    /**
	 * @param iter (IStat)=>any
	 */
    public function forEachStat(iter : Function, filter : Class<Dynamic> = null) : Void
    {
        var queue : Array<Dynamic> = [this];
        while (queue.length > 0)
        {
            var e : IStatHolder = try cast(queue.pop(), IStatHolder) catch(e:Dynamic) null;
            if (e == null)
            {
                continue;
            }
            var stats : Array<Dynamic> = e.allStats();
            for (stat in stats)
            {
                if (filter == null || Std.is(stat, filter))
                {
                    iter(stat);
                }
            }
            queue = queue.concat(stats);
        }
    }
    public function allStatsAndSubstats() : Array<Dynamic>
    {
        var result : Array<Dynamic> = [];
        forEachStat(function(stat : IStat) : Void
                {
                    result.push(stat);
                });
        return result;
    }
    
    /**
	 * Options are
	 * text, displayed text in buff description
	 * show, default true. If false, then the buff will be hidden in detalization. You'll still see total value but not the reason.
	 * save, default true. If false, then the buff will not be saved. It is useable for buffs from races, perks, and items - they should be auto-added
	 * rate, default Buff.RATE_PERMANENT. Other options are: RATE_ROUNDS, RATE_HOURS, RATE_DAYS. Used with ticks, see below.
	 * ticks, default 0. How many units of time (see rate) the buff will last until it will be auto-removed
	 */
    public function addBuff(stat : String, amount : Float, tag : String, options : Dynamic) : Void
    {
        var s : BuffableStat = findBuffableStat(stat);
        if (s == null)
        {
            trace("/!\\ addBuff(" + stat + ", " + amount + ") in " + tag);
        }
        else
        {
            s.addOrIncreaseBuff(tag, amount, options);
        }
    }
    
    public function removeBuffs(tag : String) : Void
    {
        forEachStat(function(stat : BuffableStat) : Void
                {
                    stat.removeBuff(tag);
                }, BuffableStat);
    }
    
    public function hasBuff(tag : String) : Bool
    {
        var result : Bool = false;
        forEachStat(function(stat : BuffableStat) : Void
                {
                    if (stat.hasBuff(tag))
                    {
                        result = true;
                    }
                }, BuffableStat);
        return result;
    }
    public function buffObjects(tag : String) : Array<Dynamic>
    {
        var result : Array<Dynamic> = [];
        forEachStat(function(stat : BuffableStat) : Void
                {
                    var buff : Buff = stat.findBuff(tag);
                    if (buff != null)
                    {
                        result.push(buff);
                    }
                }, BuffableStat);
        return result;
    }
    
    /**
	 * Add `amount` ticks to all buffs tagged `tag`.
	 * Does nothing if no such buffs or they are permanent
	 */
    public function addTicksToBuffs(tag : String, amount : Float) : Void
    {
        recentlyRemovedTags = { };
        forEachStat(function(stat : BuffableStat) : Void
                {
                    stat.addTicksToBuff(tag, amount);
                    Utils.extend(recentlyRemovedTags, stat.recentlyRemovedTags);
                }, BuffableStat);
    }
    
    public function replaceBuffObject(buffs : Dynamic, tag : String, options : Dynamic = null, evalContext : Dynamic = null) : Void
    {
        applyBuffObject(buffs, tag, options, evalContext, true);
    }
    public function addBuffObject(buffs : Dynamic, tag : String, options : Dynamic = null, evalContext : Dynamic = null) : Void
    {
        applyBuffObject(buffs, tag, options, evalContext, false);
    }
    public function setBuffOptions(tag : String, options : Dynamic) : Void
    {
        if (options == null)
        {
            return;
        }
        forEachStat(function(stat : BuffableStat) : Void
                {
                    var buff : Buff = stat.findBuff(tag);
                    if (buff != null)
                    {
                        buff.options = options;
                    }
                }, BuffableStat);
    }
    private function applyBuffObject(buffs : Dynamic, tag : String, options : Dynamic, evalContext : Dynamic, replaceMode : Bool = false) : Void
    {
        for (statname in Reflect.fields(buffs))
        {
            var buff : Dynamic = Reflect.field(buffs, statname);
            var value : Float;
            if (Std.is(buff, Float))
            {
                value = buff;
            }
            else if (Std.is(buff, String))
            {
                value = Eval.eval(evalContext, buff);
            }
            else
            {
                trace("/!\\ applyBuffObject: " + tag + "/" + statname);
                value = +buff;
            }
            var s : BuffableStat = findBuffableStat(statname);
            if (s == null)
            {
                trace("/!\\ addBuff(" + statname + ", " + value + ") in " + tag);
            }
            else if (replaceMode)
            {
                s.addOrReplaceBuff(tag, value, options);
            }
            else
            {
                s.addOrIncreaseBuff(tag, value, options);
            }
        }
    }
}


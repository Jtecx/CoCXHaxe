package classes;

import haxe.Constraints.Function;
import classes.stats.StatUtils;
import classes.internals.Utils;
import classes.internals.race.RaceTierRequirement;

class RaceTier
{
    
    public var tierNumber : Int;
    public var requirements : Array<Dynamic>;
    public var name : String;
    private var nameFn : Function;
    public var minScore : Int;
    private var _buffs : Dynamic;
    public var extraBonuses : Array<Dynamic>;
    public var requiresPreviousTier : Bool = false;
    
    public function new(
            tierNumber : Int,
            name : String,
            nameFn : Function,
            minScore : Int,
            buffs : Dynamic,
            requirements : Array<Dynamic>,
            extraBonuses : Array<Dynamic>)
    {
        var thiz : RaceTier = this;
        this.tierNumber = tierNumber;
        this.name = name;
        this.nameFn = nameFn || function(body : BodyData) : String
                {
                    return thiz.name;
                };
        this.minScore = minScore;
        this._buffs = buffs;
        this.requirements = requirements.copy();
        this.extraBonuses = extraBonuses.copy();
    }
    
    public function nameFor(body : BodyData) : String
    {
        return nameFn(body);
    }
    
    public function check(body : BodyData, score : Int) : Bool
    {
        if (score < minScore)
        {
            return false;
        }
        for (r in requirements)
        {
            if (!r.check(body))
            {
                return false;
            }
        }
        return true;
    }
    
    /**
	 * @param body null if player doesn't have this tier, otherwise player body data
	 * @return buffs, NG+ scaled
	 */
    public function buffs(body : BodyData) : Dynamic
    {
        var buffs : Dynamic = unscaledBuffs(body);
        var factor : Float = CoC.instance.newGamePlusFactor();
        if (factor == 1)
        {
            return buffs;
        }
        for (buffName/* AS3HX WARNING could not determine type for var: buffName exp: EField(EIdent(StatUtils),NgScaledRacialBuffs) type: null */ in StatUtils.NgScaledRacialBuffs)
        {
            if (Lambda.has(buffs, buffName))
            {
                Reflect.field(buffs, Std.string(buffName)) *= factor;
            }
        }
        return buffs;
    }
    /**
	 * @param body null if player doesn't have this tier, otherwise player body data
	 * @return buffs, not NG+ scaled. The object could be modified, so a copy should be returned.
	 */
    public function unscaledBuffs(body : BodyData) : Dynamic
    {
        return Utils.extend({ }, _buffs);
    }
    public function hasBuffs() : Bool
    {
        if (extraBonuses.length > 0)
        {
            return true;
        }
        //noinspection LoopStatementThatDoesntLoopJS
        for (key in Reflect.fields(_buffs))
        {
            return true;
        }
        return false;
    }
    public function describeBuffs(body : BodyData, separator : String = ", ", withExtraBonuses : Bool = true) : String
    {
        var s : Array<Dynamic> = [];
        var buffs : Dynamic = this.buffs(body);
        for (key in Reflect.fields(buffs))
        {
            s.push(StatUtils.explainBuff(key, Reflect.field(buffs, key)));
        }
        if (withExtraBonuses)
        {
            Utils.pushAll(s, extraBonuses);
        }
        if (s.length > 0)
        {
            return s.join(separator);
        }
        return "";
    }
}


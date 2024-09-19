package classes.internals.race;

import haxe.Constraints.Function;
import classes.BodyData;
import classes.RaceTier;
import classes.stats.StatUtils;

class DynamicBuffRaceTier extends RaceTier
{
    /**
	 * `(body:BodyData)=>buff object`
	 */
    private var dynamicBuffsFn : Function;
    private var dynamicBuffDescription : String;
    
    /**
	 * @param nameFn `(body:BodyData)=>String`
	 * @param staticBuffs buff object
	 * @param dynamicBuffsFn `(body:BodyData)=>buff object`
	 * @param dynamicBuffDescription string to display when tier is not present
	 */
    public function new(
            tierNumber : Int,
            name : String,
            nameFn : Function,
            minScore : Int,
            staticBuffs : Dynamic,
            dynamicBuffsFn : Function,
            dynamicBuffDescription : String,
            requirements : Array<Dynamic>,
            extraBonuses : Array<Dynamic>)
    {
        super(
                tierNumber, 
                name, 
                nameFn, 
                minScore, 
                staticBuffs, 
                requirements, 
                extraBonuses
        );
        this.dynamicBuffsFn = dynamicBuffsFn;
        this.dynamicBuffDescription = dynamicBuffDescription;
    }
    
    override public function hasBuffs() : Bool
    {
        return true;
    }
    
    override public function unscaledBuffs(body : BodyData) : Dynamic
    {
        if (body == null)
        {
            return _buffs;
        }
        return StatUtils.mergeBuffObjects(
                dynamicBuffsFn(body), 
                _buffs
        );
    }
    
    override public function describeBuffs(body : BodyData, separator : String = ", ", withExtraBonuses : Bool = true) : String
    {
        var s : String = super.describeBuffs(body, separator, withExtraBonuses);
        if (body == null && dynamicBuffDescription != null && withExtraBonuses)
        {
            if (s != null)
            {
                s += ", " + dynamicBuffDescription;
            }
            else
            {
                s = dynamicBuffDescription;
            }
        }
        return s;
    }
}


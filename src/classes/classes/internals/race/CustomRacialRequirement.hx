package classes.internals.race;

import haxe.Constraints.Function;
import classes.BodyData;

class CustomRacialRequirement extends RacialRequirement
{
    private var scoreFn : Function;
    
    /**
	 *
	 * @param group
	 * @param name
	 * @param checkFn (body)=>Boolean
	 * @param scoreFn (body)=>int
	 * @param minScore
	 */
    public function new(
            group : String,
            name : String,
            checkFn : Function,
            scoreFn : Function,
            failScore : Int,
            minScore : Int)
    {
        super(
                group, 
                name, 
                checkFn, 
                0, 
                failScore, 
                minScore
        );
        this.scoreFn = scoreFn;
    }
    
    override public function passScore(body : BodyData) : Int
    {
        return scoreFn(body);
    }
    
    override public function varyingScore() : Bool
    {
        return true;
    }
}


package classes.internals.race;

import haxe.Constraints.Function;
import classes.BodyData;

class RaceTierRequirement
{
    public var name : String;
    /**
	 * `(body:BodyData)=>Boolean`
	 */
    private var checkFn : Function;
    
    /**
	 * @param name
	 * @param checkFn `(body)=>Boolean`
	 */
    public function new(
            name : String,
            checkFn : Function)
    {
        this.name = name;
        this.checkFn = checkFn;
    }
    
    public function check(bodyData : BodyData) : Bool
    {
        return checkFn(bodyData);
    }
}


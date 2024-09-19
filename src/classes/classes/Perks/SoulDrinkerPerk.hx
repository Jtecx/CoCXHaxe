/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class SoulDrinkerPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Those creatures you defeat and drink from have parts of their soul stolen with their blood increasing your overall stats by " + params.value1 + "% (1% for each victim drained).";
    }
    
    public function new()
    {
        super("Soul Drinker", "Soul Drinker", 
                "NOT RELEVANT TEXT"
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


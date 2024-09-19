/**
 * ...
 * @author Liadri
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class PerformancePowerPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Increase perfomance power by " + (params.value1 * 100) + "%.";
    }
    
    public function new()
    {
        super("Performance Power", "Performance Power", 
                "Your equipment boost your perfomance power."
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



/**
 * ...
 * @author Zavos
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class ObsessionPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Increase spell power by " + (params.value1 * 100) + "% and increase power/lower cost of black magic by " + (params.value2 * 100) + "%.";
    }
    
    public function new()
    {
        super("Obsession", "Obsession", 
                "Your equipment boost your spells power and augment your black magic at the same time lowering it costs!"
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



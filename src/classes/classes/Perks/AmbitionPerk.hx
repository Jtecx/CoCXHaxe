/**
 * ...
 * @author Zavos
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class AmbitionPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Increase spell power by " + (params.value1 * 100) + "% and increase power/lower cost of white magic by " + (params.value2 * 100) + "%.";
    }
    
    public function new()
    {
        super("Ambition", "Ambition", 
                "Your equipment boost your spells power and argument your white magic at the same time lowering it costs!"
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionTranshumanismIntPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_INT_LEVEL + ") Increases maximum base/core Int by " + params.value1 * 16 + ".";
    }
    
    public function new()
    {
        super("Ascension: Transhumanism (Int)", "Ascension: Transhumanism (Int)", "", "Increases maximum base/core Int by 16.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



/**
 * ...
 * @author Liadri
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class DarkAscensionBottomlessHungerPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_BOTTOMLESS_HUNGER_LEVEL + ") Decrease the cost of upgrading yourself through demonic energy by " + params.value1 * 5 + "%.";
    }
    
    public function new()
    {
        super("Dark Ascension: Bottomless hunger", "Dark Ascension: Bottomless hunger", "", "Decrease the cost of upgrading yourself through demonic energy by 5%.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



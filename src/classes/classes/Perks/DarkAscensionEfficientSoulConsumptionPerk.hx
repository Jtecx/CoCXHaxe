/**
 * ...
 * @author Liadri
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class DarkAscensionEfficientSoulConsumptionPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_EFFICIENT_SOUL_CONSUMPTION_LEVEL + ") Raise max demonic energy capacity by " + params.value1 * 5 + "%.";
    }
    
    public function new()
    {
        super("Dark Ascension: Efficient Soul Consumption", "Dark Ascension: Efficient Soul Consumption", "", "Raise max demonic energy capacity by 5% per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



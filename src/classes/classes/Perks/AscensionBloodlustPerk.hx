/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionBloodlustPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_BLOODLUST_LEVEL + ") Increases range physical attacks multiplier by " + params.value1 * 10 + "% multiplicatively.";
    }
    
    public function new()
    {
        super("Ascension: Bloodlust", "Ascension: Bloodlust", "", "Increases range physical attacks multiplier by 10% per level, multiplicatively.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



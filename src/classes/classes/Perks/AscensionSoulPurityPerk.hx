/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionSoulPurityPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_SOULPURITY_LEVEL + ") Increases maximum Soulforce by " + params.value1 * 50 + ".";
    }
    
    public function new()
    {
        super("Ascension: Soul Purity", "Ascension: Soul Purity", "", "Increases maximum Soulforce by 50 per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


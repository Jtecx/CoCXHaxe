/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionFuryPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_INNERPOWER_LEVEL + ") Increases maximum Wrath by " + params.value1 * 100 + ".";
    }
    
    public function new()
    {
        super("Ascension: FURY", "Ascension: FURY", "", "Increases maximum Wrath by 100 per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


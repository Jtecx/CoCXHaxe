/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionInnerPowerPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_INNERPOWER_LEVEL + ") Increases maximum Mana by " + params.value1 * 120 + ".";
    }
    
    public function new()
    {
        super("Ascension: Inner Power", "Ascension: Inner Power", "", "Increases maximum Mana by 120 per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


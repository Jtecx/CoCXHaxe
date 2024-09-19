/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionTranshumanismTouPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_TOU_LEVEL + ") Increases maximum base/core Tou by " + params.value1 * 16 + ".";
    }
    
    public function new()
    {
        super("Ascension: Transhumanism (Tou)", "Ascension: Transhumanism (Tou)", "", "Increases maximum base/core Tou by 16.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionTranshumanismPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_LEVEL + ") Increases maximum base/core Str/Tou/Spe/Int/Wis/Lib by " + params.value1 * 2 + ".";
    }
    
    public function new()
    {
        super("Ascension: Transhumanism", "Ascension: Transhumanism", "", "Increases maximum base/core Str/Tou/Spe/Int/Wis/Lib/Sen by 2.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



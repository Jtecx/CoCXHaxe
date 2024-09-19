/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionTranshumanismStrPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TRANSHUMANISM_STR_LEVEL + ") Increases maximum base/core Str by " + params.value1 * 16 + ".";
    }
    
    public function new()
    {
        super("Ascension: Transhumanism (Str)", "Ascension: Transhumanism (Str)", "", "Increases maximum base/core Str by 16.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



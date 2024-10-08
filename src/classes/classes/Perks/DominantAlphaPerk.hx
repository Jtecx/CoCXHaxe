/**
 * Created by Ormael on 25.07.18.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class DominantAlphaPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Increase your might by " + params.value1 * 2 + "% based on the number of slaves and submissive followers and lovers you lord upon. " +
        "Raping opponents gives you a temporary surge of strength (" + params.value2 + ")lasting (" + params.value3 + ") hours.";
    }
    
    public function new()
    {
        super("Dominant Alpha", "Dominant Alpha", "Increase your might based on the number of slaves and submissive followers and lovers you lord upon. Raping opponents gives you a temporary surge of strength lasting a few hours.");
    }
}


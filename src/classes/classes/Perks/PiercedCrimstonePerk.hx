/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class PiercedCrimstonePerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Increases minimum lust by " + Math.round(params.value1) + "%.";
    }
    
    public function new()
    {
        super("Pierced: Crimstone", "Pierced: Crimstone", 
                "You've been pierced with Crimstone and your lust seems to stay a bit higher than before."
        );
    }
}


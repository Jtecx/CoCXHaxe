/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class PiercedIcestonePerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Reduces minimum lust by " + Math.round(params.value1) + "%.";
    }
    
    public function new()
    {
        super("Pierced: Icestone", "Pierced: Icestone", 
                "You've been pierced with Icestone and your lust seems to stay a bit lower than before."
        );
    }
}


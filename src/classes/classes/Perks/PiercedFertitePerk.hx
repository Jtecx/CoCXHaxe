/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class PiercedFertitePerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Increases cum production by " + Math.round(2 * params.value1) + "% and fertility by " + Math.round(params.value1) + ".";
    }
    
    public function new()
    {
        super("Pierced: Fertite", "Pierced: Fertite", 
                "You've been pierced with Fertite and any male or female organs have become more fertile."
        );
    }
}


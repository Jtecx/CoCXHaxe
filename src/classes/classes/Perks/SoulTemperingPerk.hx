/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class SoulTemperingPerk extends PerkType
{
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Tempered by tribulations your soul transcended it limitations. Increases maximum base/core Int/Wis/Lib by " + params.value1 + " and Sens by " + params.value1 * 5 + ".";
    }
    
    public function new()
    {
        super("Soul Tempering", "Soul Tempering", 
                "Tempered by tribulations your soul transcended it limitations."
        );
    }
}


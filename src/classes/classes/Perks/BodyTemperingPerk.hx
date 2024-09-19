/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class BodyTemperingPerk extends PerkType
{
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Tempered by tribulations your physical body transcended it limitations. Increases maximum base/core Str/Tou/Spe by " + params.value1 + ".";
    }
    
    public function new()
    {
        super("Body Tempering", "Body Tempering", 
                "Tempered by tribulations your physical body transcended it limitations."
        );
    }
}


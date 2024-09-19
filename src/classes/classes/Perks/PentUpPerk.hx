/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class PentUpPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Increases minimum lust by " + Math.round(params.value1) + "% and makes you more vulnerable to seduction.";
    }
    
    public function new()
    {
        super("Pent Up", "Pent Up", "Increases minimum lust and makes you more vulnerable to seduction");
    }
}


/**
 * Created by Ormael on 18.01.16.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class BowShootingPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Reduces arrow shooting costs by " + params.value1 + "%.";
    }
    
    public function new()
    {
        super("Bow Shooting", "Bow Shooting", "Reduces cost of shotting arrows.");
    }
}


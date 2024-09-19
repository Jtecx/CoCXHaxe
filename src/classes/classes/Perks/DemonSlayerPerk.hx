/**
 * Created by Ormael on 25.07.18.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class DemonSlayerPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Deal " + params.value1 * 100 + "% more physical melee damage to True Demons type enemies. (Rank: " + params.value1 * 10 + ")";
    }
    
    public function new()
    {
        super("Demon Slayer", "Demon Slayer", "Deal more physical melee damage to True Demons type enemies.");
    }
}


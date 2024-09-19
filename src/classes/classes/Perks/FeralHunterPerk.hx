/**
 * Created by Ormael on 25.07.18.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class FeralHunterPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Deal " + params.value1 * 100 + "% more physical melee damage to Feral type enemies. (Rank: " + params.value1 * 10 + ")";
    }
    
    public function new()
    {
        super("Feral Hunter", "Feral Hunter", "Deal more physical melee damage to Feral type enemies.");
    }
}


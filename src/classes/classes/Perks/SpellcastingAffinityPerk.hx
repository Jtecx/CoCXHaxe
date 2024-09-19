/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class SpellcastingAffinityPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Reduces spell costs by " + params.value1 + "%.";
    }
    
    public function new()
    {
        super("Spellcasting Affinity", "Spellcasting Affinity", "Reduces spell costs.");
    }
}


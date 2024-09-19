package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class MagicalFertilityPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "" + (10 + (params.value1 * 5)) + "% higher chance of pregnancy and increased pregnancy speed.";
    }
    
    public function new()
    {
        super("Magical Fertility", "Magical Fertility", "10% higher chance of pregnancy and increased pregnancy speed.");
    }
}


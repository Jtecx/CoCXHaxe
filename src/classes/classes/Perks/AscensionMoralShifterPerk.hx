package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionMoralShifterPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_MORALSHIFTER_LEVEL + ") Increases corruption gains and losses by " + params.value1 * 20 + "%.";
    }
    
    public function new()
    {
        super("Ascension: Moral Shifter", "Ascension: Moral Shifter", "", "All corruption gains and losses are increased by 20% per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}




package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionWisdomPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_WISDOM_LEVEL + ") Increases experience gained in battles by " + params.value1 * 20 + "%.";
    }
    
    public function new()
    {
        super("Ascension: Wisdom", "Ascension: Wisdom", "", "Increases experience gains by 20% per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



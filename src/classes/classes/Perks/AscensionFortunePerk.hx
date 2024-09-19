package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionFortunePerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + ") Increases gems gained in battles by " + params.value1 * 20 + "%.";
    }
    
    public function new()
    {
        super("Ascension: Fortune", "Ascension: Fortune", "", "Increases gems gains by 20% per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



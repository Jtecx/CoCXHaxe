package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionEndurancePerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_ENDURANCE_LEVEL + ") Increases maximum fatigue by " + params.value1 * 30 + ".";
    }
    
    public function new()
    {
        super("Ascension: Endurance", "Ascension: Endurance", "", "Increases maximum fatigue by 30 per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



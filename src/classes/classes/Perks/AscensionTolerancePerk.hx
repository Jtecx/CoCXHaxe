package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionTolerancePerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        var mult : Int = (CoC.instance.gameSettings.sceneHunter_inst.other) ? 10 : 5;
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_TOLERANCE_LEVEL + ") Increases corruption tolerance by " + params.value1 * mult + " and reduces corruption requirement by " + params.value1 * mult + ".";
    }
    
    public function new()
    {
        super("Ascension: Corruption Tolerance", "Ascension: Corruption Tolerance", "", "Increases corruption tolerance by 5 per level and reduces corruption requirement by 5 per level. With SH:Other - 10 per level for both.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



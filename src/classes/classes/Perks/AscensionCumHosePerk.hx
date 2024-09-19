package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionCumHosePerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_CUM_HOSE_LEVEL + ") Increases cum per orgasm by " + params.value1 * 200 + " mLs.";
    }
    
    public function new()
    {
        super("Ascension: Cum Hose", "Ascension: Cum Hose", "", "Increases cum per orgasm by 200 mLs per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



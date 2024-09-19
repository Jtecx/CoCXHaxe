package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionMilkFaucetPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_MILK_FAUCET_LEVEL + ") Increases milk production by " + params.value1 * 200 + " mL.";
    }
    
    public function new()
    {
        super("Ascension: Milk Faucet", "Ascension: Milk Faucet", "", "Increases milk production by 200 mL per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionMysticalityPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_MYSTICALITY_LEVEL + ") Increases spell effect multiplier by " + params.value1 * 10 + "% multiplicatively and decrease spells costs by " + params.value1 * 2 + "%.";
    }
    
    public function new()
    {
        super("Ascension: Mysticality", "Ascension: Mysticality", "", "Increases spell effect multiplier by 10% per level, multiplicatively and decrease spells costs by 2%.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



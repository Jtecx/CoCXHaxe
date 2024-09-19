/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionSpiritualEnlightenmentPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_SPIRITUALENLIGHTENMENT_LEVEL + ") Increases soulskill effect multiplier by " + params.value1 * 10 + "% multiplicatively and decrease soulskill costs by " + params.value1 * 2 + "%.";
    }
    
    public function new()
    {
        super("Ascension: Spiritual Enlightenment", "Ascension: Spiritual Enlightenment", "", "Increases soulskill effect multiplier by 10% per level, multiplicatively and decrease soulskill costs by 2% per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



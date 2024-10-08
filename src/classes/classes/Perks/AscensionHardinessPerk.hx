/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class AscensionHardinessPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_HARDINESS_LEVEL + ") Increases maximum HP by " + params.value1 * 400 + ".";
    }
    
    public function new()
    {
        super("Ascension: Hardiness", "Ascension: Hardiness", "", "Increases maximum HP by 400 per level.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



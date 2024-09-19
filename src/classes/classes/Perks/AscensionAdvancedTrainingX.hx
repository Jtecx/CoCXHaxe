/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class AscensionAdvancedTrainingX extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        var pVal : Float = (player.perkv1(PerkLib.AscensionAdvTrainingX) * 4);
        return "Your gain " + Std.string(pVal) + " more stat points at each level up.";
    }
    
    override public function name(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _name;
        }
        var sufval : String = Std.string(player.perkv1(PerkLib.AscensionAdvTrainingX));
        return "Ascension: Advanced Training " + sufval;
    }
    
    public function new()
    {
        super("Ascension Advanced Training", "Ascension: Advanced Training", 
                "."
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


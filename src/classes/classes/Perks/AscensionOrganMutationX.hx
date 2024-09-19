/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class AscensionOrganMutationX extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        var pVal : Float = player.perkv1(PerkLib.AscensionAdditionalOrganMutationX);
        return "Your body has adapted to having unnatural organs to the point of being able to sustain " + Std.string(pVal) + " extra mutation" + ((pVal > 1) ? "s" : "") + " in each organ. Double increase to Adaptations category.";
    }
    
    override public function name(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _name;
        }
        var sufval : String = Std.string(player.perkv1(PerkLib.AscensionAdditionalOrganMutationX));
        return "Ascension: Additional Organ Mutation " + sufval;
    }
    
    public function new()
    {
        super("Ascension Additional Organ Mutation", "Ascension: Additional Organ Mutation", 
                "."
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class AscensionBuildPrestigeX extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        var pVal : Float = player.perkv1(PerkLib.AscensionBuildingPrestigeX) + 1;
        return "Your understanding of prestige jobs from your previous life allows you to pick another " + Std.string(pVal) + " job" + ((pVal > 1) ? "s" : "") + " at lvl 54+.";
    }
    
    override public function name(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _name;
        }
        var sufval : String = Std.string(player.perkv1(PerkLib.AscensionBuildingPrestigeX));
        return "Ascension: Building Prestige Stage " + sufval;
    }
    
    public function new()
    {
        super("Ascension Building Prestige Stage", "Ascension: Building Prestige Stage", 
                "."
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


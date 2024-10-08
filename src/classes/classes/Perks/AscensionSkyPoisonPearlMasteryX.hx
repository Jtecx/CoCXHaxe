package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class AscensionSkyPoisonPearlMasteryX extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        var pVal : Float = player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX);
        return "You gain +" + (pVal * 3) + " venom recharge speed, +" + (pVal * 10) + "% to max venom cap, +" + (pVal * 10) + "% to poison resistance, " + (pVal * 100) + "% more spirit stones carried over and lower req. level to open next sections of pearl by " + (pVal * 6) + " levels. (Rank: " + pVal + ")";
    }
    
    override public function name(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _name;
        }
        var sufval : String = Std.string(player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX));
        return "Ascension: Sky Poison Pearl Mastery " + sufval;
    }
    
    public function new()
    {
        super("Ascension Sky Poison Pearl Mastery", "Ascension: Sky Poison Pearl Mastery", 
                "."
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


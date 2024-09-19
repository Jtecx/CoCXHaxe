package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class SurvivalTrainingXPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "You have trained to better survive this realm hostile environment. (+1% to MaxOver HP, MaxOver Lust and Diehard each 3 lvl's up to +" + params.value1 * 10 + "%)";
    }
    
    override public function name(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _name;
        }
        var sufval : String = Std.string(player.perkv1(PerkLib.SPSurvivalTrainingX));
        return "Survival Training (Rank: " + sufval + ")";
    }
    
    public function new()
    {
        super("Survival Training", "Survival Training", ".");
    }
}


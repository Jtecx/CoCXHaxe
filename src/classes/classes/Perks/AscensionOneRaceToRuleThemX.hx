/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class AscensionOneRaceToRuleThemX extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player)
        {
            return _desc;
        }
        var pVal : Float = player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX);
        return "Your racial paragon boost is increased. +" + Std.string(2 * pVal) + " to each stat per level and increases racial skill power by " + Std.string(25 * pVal) + "%.";
    }
    
    override public function name(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _name;
        }
        var sufval : String = Std.string(player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX));
        return "Ascension: One Race To Rule Them All " + sufval;
    }
    
    public function new()
    {
        super("Ascension One Race To Rule Them All", "Ascension: One Race To Rule Them All", 
                "."
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


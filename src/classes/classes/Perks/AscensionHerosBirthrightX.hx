/**
 * Created by Demojay on 24.12.23.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class AscensionHerosBirthrightX extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player)
        {
            return _desc;
        }
        var pVal : Float = player.perkv1(PerkLib.AscensionHerosBirthrightRankX);
        if (pVal < 6)
        {
            return "The level needed to use legendary items has been reduced by " + Std.string(9 * pVal) + ", making the minimum level " + Std.string(54 - (9 * pVal)) + ".";
        }
        else
        {
            return "There is no longer a minimum level needed to use legendary items.";
        }
    }
    
    override public function name(params : PerkClass = null) : String
    {
        if (!player)
        {
            return _name;
        }
        var sufval : String = Std.string(player.perkv1(PerkLib.AscensionHerosBirthrightRankX));
        return "Ascension: Hero's Birthright " + sufval;
    }
    
    public function new()
    {
        super("Ascension Hero's Birthright", "Ascension: Hero's Birthright", 
                "."
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


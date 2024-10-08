/**
 * ...
 * @author Liadri
 */
package classes.perks;

import classes.iMutations.IMutationsLib;
import classes.PerkClass;
import classes.PerkType;

class StarSphereMasteryPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        var fr : Float = 1;
        var sr : String = "";
        var mr : String = "";
        if (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 3)
        {
            mr = ", " + (params.value1 * 4) + " soulforce, " + (params.value1 * 3) + " mana";
        }
        return "Regenerate " + (params.value1 * fr) + " fatigue" + sr + mr + " every round. Increase Fox Fire damage by " + (params.value1 * 5) + "%. (Rank: " + params.value1 + ")";
    }
    
    public function new()
    {
        super("Star Sphere Mastery", "Star Sphere Mastery", 
                "You have mastered your control over the flow of energy in your star sphere. You are now able to recover fatigue, soulforce and mana over time."
        );
    }
}



package classes.items.weaponsRange;

import classes.items.WeaponRange;
import classes.Player;

/**
	 * ...
	 * @author Oxdeception
	 */
class WildHunt extends WeaponRange
{
    
    public function new()
    {
        super("WildHunt", "Wild Hunt", "wild hunt longbow", "wild hunt longbow", "shot", 130, 6500, 
                "The ebony wood of this corrupt bow seems to ignore light. Arrows fired with this weapon seem to have a malignant mind of their own, striking down the weak with brutal efficiency.", 
                "Bow"
        );
        withTag(I_LEGENDARY);
    }
    override private function get_attack() : Float
    {
        var boost : Int = 0;
        var scal : Float = 5;
        if (game.player.spe >= 100)
        {
            boost += 40;
            scal -= 1;
        }
        if (game.player.spe >= 50)
        {
            boost += 30;
            scal -= 1;
        }
        boost += Math.round(game.player.cor / scal);
        return (27 + boost);
    }
}



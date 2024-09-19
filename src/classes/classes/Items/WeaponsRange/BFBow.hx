/**
 * ...
 * @author Ormael
 */
package classes.items.weaponsRange;

import classes.items.WeaponRange;
import classes.PerkLib;
import classes.Player;

class BFBow extends WeaponRange
{
    
    public function new()
    {
        super("B F Bow", "B.F.Bow", "big fucking bow", "a big fucking bow", "shot", 50, 2500, "Big Fucking Bow - the best solution for a tiny e-pen complex at this side of the Mareth!  This 2H 3,5 meters long bow requires 150 speed to fully unleash it power.", "Bow");
        withBuffs({
                    rangedaccuracy : -30
                });
    }
    
    override private function get_attack() : Float
    {
        var boost : Int = 0;
        if (game.player.spe >= 150)
        {
            boost += 20;
        }
        if (game.player.spe >= 100)
        {
            boost += 15;
        }
        if (game.player.spe >= 50)
        {
            boost += 10;
        }
        return (5 + boost);
    }
}


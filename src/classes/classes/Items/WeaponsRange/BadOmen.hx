/**
 * ...
 * @author Lady Aeducan
 */
package classes.items.weaponsRange;

import classes.items.WeaponRange;
import classes.globalFlags.KFLAGS;

class BadOmen extends WeaponRange
{
    
    public function new()
    {
        super("BadOmen", "BadOmen", "Bad Omen", "a Bad Omen", "shot", 150, 7500, "A single 22mm, four-round revolver, the Bad Omen has even largest bullets than desert eagle. Its shots are deadly and precise through the gun has one hell of a recoil. Requires 200 strength to fully unleash it power.", "Pistol");
        withTag(I_LEGENDARY);
    }
    
    override private function get_attack() : Float
    {
        var boost : Int = 0;
        var scal : Float = 10;
        if (game.player.str >= 200)
        {
            boost += 40;
            scal -= 3;
        }
        if (game.player.str >= 100)
        {
            boost += 40;
            scal -= 3;
        }
        if (game.player.str >= 50)
        {
            boost += 10;
            scal -= 2;
        }
        boost += Math.round(game.player.cor / scal);
        return (10 + boost);
    }
}



/**
 * ...
 * @author Ormael
 */
package classes.items.weaponsRange;

import classes.items.WeaponRange;
import classes.PerkLib;
import classes.Player;
import classes.scenes.aPI.FnHelpers;

class MinoBomber extends WeaponRange
{
    
    public function new()
    {
        super("MinoBomber", "MinoBomber", "MinoBomber", "a MinoBomber", "shot", 1, 1000, "Both a sex toy and a weapon, the MinoBomber uses one rather unconventional ammunition: cum. Invented to take advantage of minotaur near endless supply of cum, this setup consists of a machine gun linked to a massive tank to be strapped on the users back and a harness with cockpump. The gun is only as strong as the user's cum production, and, since the weapon seldom constantly milks the minotaur, it will never need to satisfy its sexual needs. As expected, this setup is quite heavy and only a very strong individual or a minotaur could use it.", WT_2H_FIREARM);
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.str >= 100 && game.player.hasBalls() && game.player.ballSize >= 4)
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            if (game.player.str < 100)
            {
                outputText("This setup is to heavy for you to wield! ");
            }
            if (!game.player.hasBalls() || game.player.ballSize < 4)
            {
                outputText("You lack the 'assets' to use this weapon. ");
            }
        }
        return false;
    }
    
    override private function get_attack() : Float
    {
        var cumatk : Float = (1 + (game.player.cumQ() / 100));
        cumatk = FnHelpers.FN.logScale(cumatk, MinoBomberABC, 10);
        return cumatk;
    }
    
    private static var MinoBomberABC : Dynamic = FnHelpers.FN.buildLogScaleABC(10, 100, 1000, 10, 100);
}

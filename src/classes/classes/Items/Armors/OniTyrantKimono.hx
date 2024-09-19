/**
 * @author Liadri
 */
package classes.items.armors;

import classes.CoC;
import classes.items.Armor;
import classes.PerkLib;
import classes.Player;

class OniTyrantKimono extends Armor
{
    
    public function new()
    {
        super("OT Kimo", "OniTyrantKimono", "Oni Tyrant kimono", "a oni tyrant kimono", 30, 50, 27000, "This deceptively sturdy kimono belonged to a tyrant amonst oni nobility. In their homeland oni rules over lesser race with an iron fist. Might makes right or so they say.", "Light");
        withTag(A_AGILE);
        withTag(I_LEGENDARY);
        withPerk(PerkLib.OniTyrantKimono, 0, 0, 0, 0);
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.tallness >= 80)
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            outputText("You aren't tall enough to wear this kimono!");
        }
        return false;
    }
    override private function get_def() : Float
    {
        var mod : Int = as3hx.Compat.parseInt(game.player.cor / 10);
        return 20 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = as3hx.Compat.parseInt(game.player.cor / 5);
        return 30 + mod;
    }
}


/**
 * ...
 * @author Liadri
 */
package classes.items.armors;

import classes.items.Armor;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;

class TamamoNoMaeCursedKimono extends Armor
{
    
    public function new()
    {
        super("T.C.Kimono", "T.C.Kimono", "Tamamo no Mae Cursed Kimono", "a Tamamo no Mae Cursed Kimono", 10, 60, 12000, "It is said that this beautiful Kimono decorated with flower motifs was worn by lady Tamamoe, last leader of the kitsunes, before she fell from grace into a Kumiho. Increase the potency of spells and soulskill by up to 50% based on corruption and empower all Kitsunes ability. Like most kitsune outfit this Kimono is made to improve ones charms and thus leaves you as agile as if naked.", "Light");
        withBuffs({
                    spellcost : -0.60,
                    teasedmg : +15
                });
        withPerk(PerkLib.TamamoNoMaeCursedKimono, 0, 0, 0, 0);
        withTag(A_REVEALING);
        withTag(I_LEGENDARY);
    }
    
    override private function get_def() : Float
    {
        var mod : Int = as3hx.Compat.parseInt(game.player.cor / 20);
        return 5 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = as3hx.Compat.parseInt(game.player.cor / 5);
        return 40 + mod;
    }
}


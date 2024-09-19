/**
 * ...
 * @author Liadri
 */
package classes.items.armors;

import classes.items.Armor;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;

class CowGunslingerOutfit extends Armor
{
    
    public function new()
    {
        super("C.G.Outfit", "C.G.Outfit", "Cow Gunslinger Outfit", "a Cow Gunslinger Outfit", 20, 40, 12800, "A leather coat with a belt for holstering guns all made for a sturdy holstein. This outfit was retrieved from an offworld gunslinger who became a cow.", "Medium");
        withBuffs({
                    teasedmg : +15
                });
        withTag(A_AGILE);
        withPerk(PerkLib.CowGunslingerOutfit, 0, 0, 0, 0);
        withTag(A_REVEALING);
        withTag(I_LEGENDARY);
    }
    
    override private function get_def() : Float
    {
        var mod : Int = 0;
        mod += as3hx.Compat.parseInt(game.player.cor / 5);
        return 20 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = 0;
        mod += as3hx.Compat.parseInt(game.player.cor / 10);
        return 10 + mod;
    }
}


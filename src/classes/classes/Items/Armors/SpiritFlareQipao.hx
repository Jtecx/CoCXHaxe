/**
 * ...
 * @author Liadri
 */
package classes.items.armors;

import classes.items.Armor;
import classes.PerkLib;
import classes.Player;

class SpiritFlareQipao extends Armor
{
    
    public function new()
    {
        super("SFlareQ", "S.FlareQipao", "Spirit Flare Qipao", "a Spirit Flare Qipao", 10, 60, 12000, "A traditionnal quipao from the land of rice. Many folks of this land have strong elemental affinities and It has been heavily enchanted with elemental magic to enhance the potency of elemental attack and martial arts. When worn by a compatible species the gathering element assist in a fast recovery.", "Light");
        withTag(I_LEGENDARY);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        {
            game.player.createPerk(PerkLib.Misdirection, 0, 0, 1, 0);
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        if (game.player.perkv4(PerkLib.Misdirection) == 0 && game.player.perkv3(PerkLib.Misdirection) > 0)
        {
            game.player.removePerk(PerkLib.Misdirection);
        }
        super.afterUnequip(doOutput, slot);
    }
    
    override private function get_def() : Float
    {
        var mod : Int = as3hx.Compat.parseInt((100 - game.player.cor) / 20);
        return 5 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = as3hx.Compat.parseInt((100 - game.player.cor) / 5);
        return 40 + mod;
    }
}


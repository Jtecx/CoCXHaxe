/**
 * @author Liadri
 */
package classes.items.armors;

import classes.items.Armor;
import classes.StatusEffects;

class DeathPrinceGoldenArmor extends Armor
{
    
    public function new()
    {
        super("DeathPGA", "DeathPrinceGoldenArmor", "Death Prince Golden Armor", "a Death Prince Golden Armor", 20, 40, 19200, "A set of golden armor worn by Anubi lords, both a symbol of status and power. These armors are generally granted to an anubis who has acquired a sizable amount of slaves. (empowers Anubi ability by 50%, +200% Magic Soulskill power, grants 5% regeneration when soulforce is above half)", "Medium");
        withTag(I_LEGENDARY);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        {
            while (game.player.hasStatusEffect(StatusEffects.DeathPrinceGA))
            {
                game.player.removeStatusEffect(StatusEffects.DeathPrinceGA);
            }
            game.player.createStatusEffect(StatusEffects.DeathPrinceGA, 0, 0, 0, 0);
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        while (game.player.hasStatusEffect(StatusEffects.DeathPrinceGA))
        {
            game.player.removeStatusEffect(StatusEffects.DeathPrinceGA);
        }
        super.afterUnequip(doOutput, slot);
    }
    
    override private function get_def() : Float
    {
        var mod : Int = 0;
        mod += as3hx.Compat.parseInt(game.player.cor / 10);
        return 10 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = 0;
        mod += as3hx.Compat.parseInt(game.player.cor / 5);
        return 20 + mod;
    }
}



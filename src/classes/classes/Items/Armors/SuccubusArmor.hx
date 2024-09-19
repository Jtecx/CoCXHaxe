/**
 * ...
 * @author Liadri
 */
package classes.items.armors;

import classes.globalFlags.KFLAGS;
import classes.items.Armor;
import classes.PerkLib;

class SuccubusArmor extends Armor
{
    
    public function new()
    {
        super("S.Armor", "S.Armor", "Succubus armor", "a Succubus armor", 50, 25, 3000, "The fully corrupted maiden armor became an armor fit for a succubus. It incite its owner to sex and rewards it for debauching herself. It's already suggestive design became downright obscene as the metal and clothes color turned black as night.", "Light", false, false);
        withBuffs({
                    teasedmg : 10,
                    minlustx : 0.3
                });
        withTag(A_REVEALING);
        withTag(I_LEGENDARY);
    }
    
    override private function get_def() : Float
    {
        var mod : Int = 0;
        mod += as3hx.Compat.parseInt(game.player.cor / 10);
        mod += as3hx.Compat.parseInt(game.flags[kFLAGS.BIKINI_ARMOR_BONUS] * 2);
        return 20 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = 0;
        mod += as3hx.Compat.parseInt(game.player.cor / 20);
        mod += game.flags[kFLAGS.BIKINI_ARMOR_BONUS];
        return 10 + mod;
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (!super.canEquip(doOutput, slot))
        {
            return false;
        }
        return LustyMaidensArmor.canUseStatic(doOutput);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        Reflect.setField(_buffs, "teasedmg", (10 + game.flags[kFLAGS.BIKINI_ARMOR_BONUS]) * 5);
        super.afterEquip(doOutput, slot);
    }
}


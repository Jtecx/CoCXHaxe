/**
 * Created by aimozg on 11.01.14.
 */
package classes.items.consumables;

import classes.items.Consumable;
import classes.items.ConsumableLib;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;
import classes.internals.Utils;

@:final class LustStick extends Consumable
{
    
    public function new()
    {
        super("LustStk", "LustStk", "a tube of golden lipstick", ConsumableLib.DEFAULT_VALUE, "This tube of golden lipstick is used by harpies to keep males aroused.  It has aphrodisiac properties on anyone with male genitalia and is most effective when applied to the lips or groin.");
    }
    
    override public function canUse() : Bool
    {
        if (game.player.hasCock() && !game.player.hasPerk(PerkLib.LuststickAdapted))
        {
            outputText("You look at the tube of lipstick, but get the idea it would be a pretty bad idea to smear a thick coating of cock-hardening aphrodisiacs over your own lips.  ");
            return false;
        }
        return true;
    }
    
    override public function useItem() : Bool
    {
        if (game.player.hasStatusEffect(StatusEffects.LustStickApplied))
        {
            game.player.addStatusValue(StatusEffects.LustStickApplied, 1, Utils.rand(12) + 12);
            outputText("You carefully open the sweet-smelling tube and smear the lipstick over the coat you already have on your lips.  <b>No doubt another layer will make it last even longer!</b>  ");
            outputText("You finish and pucker your lips, feeling fairly sexy with your new, thicker makeup on.\n\n");
        }
        else
        {
            game.player.createStatusEffect(StatusEffects.LustStickApplied, 24, 0, 0, 0);
            outputText("You carefully open the sweet-smelling tube and smear the lipstick over your lips.  ");
            if (game.player.hasCock())
            {
                outputText("It tingles a little, but the drugs have little to no effect on you now.");
            }
            else
            {
                outputText("Honestly, it amazes you that something as little as a kiss can make a man putty in your hands.");
            }
            outputText("  You finish and pucker your lips, feeling fairly sexy with your new makeup on.\n\n");
        }
        game.player.dynStats("lus", 1, "scale", false);
        return (false);
    }
}

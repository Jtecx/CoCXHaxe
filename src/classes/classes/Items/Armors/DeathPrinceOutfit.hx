/**
 * @author Liadri
 */
package classes.items.armors;

import classes.items.Armor;
import classes.StatusEffects;

class DeathPrinceOutfit extends Armor
{
    
    public function new()
    {
        super("DeathPO", "DeathPrinceOutfit", "Death Prince Outfit", "a Death Prince Outfit", 0, 5, 500, "The formal outfit worn by anubi slavers from the inner desert region. (+50% Magic Soulskill power, grants 2% regeneration when soulforce is above half)", "Light");
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        {
            while (game.player.hasStatusEffect(StatusEffects.DeathPrinceO))
            {
                game.player.removeStatusEffect(StatusEffects.DeathPrinceO);
            }
            game.player.createStatusEffect(StatusEffects.DeathPrinceO, 0, 0, 0, 0);
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        while (game.player.hasStatusEffect(StatusEffects.DeathPrinceO))
        {
            game.player.removeStatusEffect(StatusEffects.DeathPrinceO);
        }
        super.afterUnequip(doOutput, slot);
    }
}



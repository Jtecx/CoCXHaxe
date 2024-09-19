package classes.items.jewelries;

import classes.items.Jewelry;
import classes.scenes.nPCs.KihaFollower;
import classes.StatusEffects;

class StarfireBand extends Jewelry
{
    public function new()
    {
        super("StarfireBand", "Starfire Band", "Starfire Band", "Starfire Band", 0, 0, 1200, "The engagement ring given to you by Kiha");
        withBuffs({
                    res_fire : 40,
                    res_physical : 10,
                    res_magic : 10
                }, true);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        {
            outputText("This Ring is clearly the work of a master jeweller and enchanter. Just wearing this band fills your body with comfortable warmth. ");
            if (KihaFollower.ProposalStatus == 3)
            {
                outputText("When you focus on the ring, you can feel a vague tinge of curiosity...and a surge of affection, with a little exasperation in there. Kiha notices you thinking of her, and you pull back from the ring, mentally. The connection fades, but you can still feel the barest hint of a mental pull, homing back towards your fiery wife. \n");
            }
            else
            {
                outputText("The ring fills you with a very faint feeling of loneliness. You feel like…You’ve left something behind…or someone. \n");
            }
            while (game.player.hasStatusEffect(StatusEffects.FieryBand))
            {
                game.player.removeStatusEffect(StatusEffects.FieryBand);
            }
            game.player.createStatusEffect(StatusEffects.FieryBand, 0, 0, 0, 0);
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        while (game.player.hasStatusEffect(StatusEffects.FieryBand))
        {
            game.player.removeStatusEffect(StatusEffects.FieryBand);
        }
        super.afterUnequip(doOutput, slot);
    }
}


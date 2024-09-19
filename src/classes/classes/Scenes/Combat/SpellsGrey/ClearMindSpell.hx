package classes.scenes.combat.spellsGrey;

import classes.scenes.combat.AbstractGreySpell;
import classes.scenes.combat.CombatAbilities;
import classes.StatusEffects;

class ClearMindSpell extends AbstractGreySpell
{
    public function new()
    {
        super(
                "Clear Mind", 
                "Recover from a stun or fear.", 
                TARGET_SELF, 
                TIMING_INSTANT, 
                [TAG_RECOVERY]
        );
        baseManaCost = 100;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsClearMind);
    }
    
    override private function usabilityCheck() : String
    {
        if (!(isPlayerStunned() || isPlayerPowerStunned() || isPlayerFeared()))
        {
            return "You're neither stunned nor in fear.";
        }
        if (isPlayerPowerStunned())
        {
            return "Cannot recover from a power stun.";
        }
        return super.usabilityCheck();
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (!backfired(display))
        {
            if (display)
            {
                outputText("As you incant the spell, you draw a small knife and cut your hand as the incantation ends, the jolt of pain clearing your mind and snapping you out of some of your lust.");
            }
            HPChange(-(player.maxHP() * 0.01), false);
            if (player.hasStatusEffect(StatusEffects.IsabellaStunned))
            {
                player.removeStatusEffect(StatusEffects.IsabellaStunned);
            }
            if (player.hasStatusEffect(StatusEffects.Stunned))
            {
                player.removeStatusEffect(StatusEffects.Stunned);
            }
            if (player.hasStatusEffect(StatusEffects.Whispered))
            {
                player.removeStatusEffect(StatusEffects.Whispered);
            }
            if (player.hasStatusEffect(StatusEffects.Confusion))
            {
                player.removeStatusEffect(StatusEffects.Confusion);
            }
            if (player.hasStatusEffect(StatusEffects.Fear))
            {
                player.removeStatusEffect(StatusEffects.Fear);
            }
        }
    }
}


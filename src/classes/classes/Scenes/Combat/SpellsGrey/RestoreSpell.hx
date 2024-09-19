package classes.scenes.combat.spellsGrey;

import classes.scenes.combat.AbstractGreySpell;
import classes.scenes.combat.CombatAbilities;
import classes.StatusEffects;

class RestoreSpell extends AbstractGreySpell
{
    public function new()
    {
        super(
                "Restore", 
                "Heal for a decent amount of health and regenerate a little over time.  ", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_HEALING]
        );
        baseManaCost = 80;
        isLastResortApplicable = false;
        isBloodMagicApplicable = false;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsRestore);
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.PlayerRegenerate);
    }
    
    override public function isStackable() : Bool
    {
        return true;
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 5;
        calcC += spellGenericCooldown();
        if (player.weapon == weapons.U_STAFF)
        {
            calcC -= 2;
        }
        return calcC;
    }
    
    override public function calcDuration() : Int
    {
        return 7;
    }
    
    override public function advance(display : Bool) : Void
    {  /* handled in Regenerate spell */  
        
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (!backfired(display))
        {
            if (display)
            {
                outputText("As you incant the spell, your wounds begin to close on their own. Your pain fades away, and as your bleeding stops, you're filled with a sense of relief...and energy. You're not out of this fight yet!");
            }
            CombatAbilities.Heal.doEffect(false);
            if (player.hasStatusEffect(StatusEffects.PlayerRegenerate))
            {
                player.addStatusValue(StatusEffects.PlayerRegenerate, 1, calcDuration());
            }
            else
            {
                player.createStatusEffect(StatusEffects.PlayerRegenerate, calcDuration(), 0, 0, 0);
            }
        }
    }
}


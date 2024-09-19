package classes.scenes.combat.spellsDivine;

import classes.Monster;
import classes.scenes.combat.AbstractDivineSpell;
import classes.StatusEffects;

class TearsOfDenialSpell extends AbstractDivineSpell
{
    public function new()
    {
        super(
                "Tears of Denial", 
                "When hit by an ability that would put you to min hit points or be filled with lust instead heal you to full health and wash your desire away.  ", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF]
        );
        baseManaCost = 3000;
    }
    
    override private function get_buttonName() : String
    {
        return "TearsOfDenial";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsTearsOfDenial);
    }
    
    override public function isActive() : Bool
    {
        return player.statusEffectv1(StatusEffects.TearsOfDenial) > 0;
    }
    
    override private function usabilityCheck() : String
    {
        if (player.hasStatusEffect(StatusEffects.TearsOfDenial))
        {
            return "Can be casted only once per combat.";
        }
        return super.usabilityCheck();
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You call on the power of mercy in order to deny defeat. A small aura of magic shields your heart as your spell takes effect, ready to safeguard your victory.\n\n");
        }
        player.createStatusEffect(StatusEffects.TearsOfDenial, 1, 0, 0, 0);
    }
}


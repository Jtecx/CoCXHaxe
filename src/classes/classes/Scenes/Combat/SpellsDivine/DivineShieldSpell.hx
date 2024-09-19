package classes.scenes.combat.spellsDivine;

import classes.Monster;
import classes.scenes.combat.AbstractDivineSpell;
import classes.StatusEffects;

class DivineShieldSpell extends AbstractDivineSpell
{
    public function new()
    {
        super(
                "Divine Shield", 
                "Increase magic resistance by 40%.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF]
        );
        baseManaCost = 600;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsDivineShield);
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "+" + calcMagnitude() + "% magic resistance for " + numberOfThings(calcDuration(), "round");
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.DivineShield);
    }
    
    override public function calcDuration() : Int
    {
        var duration : Float = 6;
        duration += combat.magic.perkRelatedDurationBoosting();
        return duration;
    }
    
    public function calcMagnitude() : Float
    {
        return 40;
    }
    
    override public function advance(display : Bool) : Void
    {
        if (player.statusEffectv2(StatusEffects.DivineShield) <= 0)
        {
            player.removeStatusEffect(StatusEffects.DivineShield);
        }
        else
        {
            player.addStatusValue(StatusEffects.DivineShield, 2, -1);
        }
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You usher a prayer for protection from the dark spells cast by the heretics and a powerful bubble of raw energy encases you, deflecting most of the magical assaults away.\n\n");
        }
        player.createStatusEffect(StatusEffects.DivineShield, calcMagnitude(), calcDuration(), 0, 0);
    }
}


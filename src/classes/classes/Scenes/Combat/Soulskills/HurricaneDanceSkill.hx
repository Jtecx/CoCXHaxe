package classes.scenes.combat.soulskills;

import classes.scenes.combat.AbstractSoulSkill;
import classes.scenes.combat.CombatAbility;
import classes.StatusEffects;
import classes.Monster;

class HurricaneDanceSkill extends AbstractSoulSkill
{
    public function new()
    {
        super(
                "Hurricane Dance", 
                "Take on the aspect of the wind, dodging attacks like a leaf in the wind.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF], 
                StatusEffects.KnowsHurricaneDance
        );
        baseSFCost = 30;
    }
    
    override private function get_buttonName() : String
    {
        return "Hurricane Dance";
    }
    
    override public function calcCooldown() : Int
    {
        return soulskillTier3Cooldown(10);
    }
    
    override public function calcDuration() : Int
    {
        return 5;
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Increases speed and evasion for " + calcDuration() + " rounds";
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("Your movement becomes more fluid and precise, increasing your speed and evasion.\n\n");
        }
        setDuration();
    }
    
    override public function durationEnd(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("<b>Hurricane Dance effect wore off!</b>\n\n");
        }
    }
}

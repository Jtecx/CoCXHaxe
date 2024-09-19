package classes.scenes.combat.soulskills;

import classes.scenes.combat.AbstractSoulSkill;
import classes.scenes.combat.CombatAbility;
import classes.StatusEffects;
import classes.Monster;

class EarthStanceSkill extends AbstractSoulSkill
{
    public function new()
    {
        super(
                "Earth Stance", 
                "Take on the stability and strength of the earth, gaining temporary damage reduction", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF], 
                StatusEffects.KnowsEarthStance
        );
        baseSFCost = 30;
    }
    
    override private function get_buttonName() : String
    {
        return "Earth Stance";
    }
    
    override public function calcCooldown() : Int
    {
        return soulskillTier3Cooldown(10);
    }
    
    override public function calcDuration() : Int
    {
        return 3;
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Gains 30% damage reduction for the next " + calcDuration() + " rounds";
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("Your body suddenly hardens like rock. You will be way harder to damage for a while.\n\n");
        }
        setDuration();
    }
    
    override public function durationEnd(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("<b>Earth Stance effect wore off!</b>\n\n");
        }
    }
}

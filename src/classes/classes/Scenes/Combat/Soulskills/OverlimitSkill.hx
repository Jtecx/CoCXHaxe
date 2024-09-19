package classes.scenes.combat.soulskills;

import classes.scenes.combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;

class OverlimitSkill extends AbstractSoulSkill
{
    public function new()
    {
        super(
                "Overlimit", 
                "Double your melee damage for a time, by ignoring your body's limits, pushing past them.", 
                TARGET_SELF, 
                TIMING_TOGGLE, 
                [TAG_BUFF], 
                StatusEffects.KnowsOverlimit
        );
        baseSFCost = 0;
    }
    
    override private function get_buttonName() : String
    {
        if (isActive())
        {
            return "Overlimit(Off)";
        }
        else
        {
            return "Overlimit(On)";
        }
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Increases melee damage by 100%, and lust resistance by 10%. Reduces Health by 10% per turn";
    }
    
    override public function toggleOff(display : Bool = true) : Void
    {
        super.toggleOff(display);
        if (display)
        {
            outputText("You let your rage fade, your red aura and manic strength vanishing along with it. You wince, feeling the strain you put your body through.\n\n");
        }
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You let out a primal roar of pain and fury, as you push your body beyond its normal capacity, a blood red aura cloaking your form.\n\n");
        }
        setDuration();
    }
}

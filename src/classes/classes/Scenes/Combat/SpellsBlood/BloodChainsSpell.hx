package classes.scenes.combat.spellsBlood;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBloodSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class BloodChainsSpell extends AbstractBloodSpell
{
    public function new()
    {
        super(
                "Blood Chains", 
                "Blood Chains will immobilize foe briefly.", 
                TARGET_ENEMY, 
                TIMING_LASTING, 
                [TAG_DEBUFF]
        );
        baseHpCost = 100;
        inflictBleed = false;
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Stun for " + numberOfThings(calcDuration(), "round");
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBloodChains);
    }
    
    override public function isActive() : Bool
    {
        return monster.hasStatusEffect(StatusEffects.Stunned);
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 3;
        calcC += spellGenericCooldown();
        return calcC;
    }
    
    override public function calcDuration() : Int
    {
        var calcD : Int = 2;
        if (player.hasPerk(PerkLib.BloodDemonIntelligence))
        {
            calcD *= 2;
        }
        return calcD;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + ((player.HP < player.maxOverHP()) ? "wounds" : "skin pores") + ". Blood starts to gather before your chest, coalescing into a crimson sphere. ");
            outputText("The blood covering your chest splits into dozens of stems. The mass pushes off from your chest, launching at [themonster]. The threads of blood cover [monster him], tacky-wet strands binding them tight enough to prevent them from moving.");
        }
        if (!monster.hasPerk(PerkLib.Resolute))
        {
            monster.createStatusEffect(StatusEffects.Stunned, calcDuration() - 1, 0, 0, 0);
        }
        else if (display)
        {
            outputText(" However, [Themonster] was able to break free below you could take action!");
        }
    }
}


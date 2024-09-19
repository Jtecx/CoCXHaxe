package classes.scenes.combat.spellsBlood;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBloodSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class BloodShieldSpell extends AbstractBloodSpell
{
    public function new()
    {
        super(
                "Blood Shield", 
                "Blood Shield will form blood shield to block enemy attacks.", 
                TARGET_SELF, 
                TIMING_TOGGLE, 
                [TAG_BUFF]
        );
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Absorb " + calcPower() + " damage";
    }
    
    override private function get_buttonName() : String
    {
        return (isActive()) ? "Deactiv BS" : "Blood Shield";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBloodShield);
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.BloodShield);
    }
    
    override public function hpCost() : Float
    {
        return spellCostBlood(calcBasePower());
    }
    public function calcPower() : Float
    {
        var cP : Float = calcBasePower() * spellModBlood();
        if (player.hasPerk(PerkLib.BloodDemonIntelligence))
        {
            cP *= 2;
        }
        return Math.round(cP);
    }
    public function calcBasePower() : Float
    {
        var shieldcost : Float = 0;
        shieldcost += (player.maxOverHP() * 0.2);
        return shieldcost;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + ((player.HP < player.maxOverHP()) ? "wounds" : "skin pores") + ". Blood starts to gather around you, coalescing into a semi transparent crimson " + ((player.hasStatusEffect(StatusEffects.Flying)) ? "" : "hemi") + "sphere.");
        }
        player.createStatusEffect(StatusEffects.BloodShield, calcPower(), 0, 0, 0);
    }
    
    override public function toggleOff(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("Deciding you no longer need to maintain your blood shield, you stop maintaining it.");
        }
        player.removeStatusEffect(StatusEffects.BloodShield);
    }
}


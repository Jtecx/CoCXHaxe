package classes.scenes.combat.spellsGrey;

import classes.Monster;
import classes.scenes.combat.AbstractGreySpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class HydroAcidSpell extends AbstractGreySpell
{
    public function new()
    {
        super(
                "Hydro Acid", 
                "Condense part of the ambient moisture into acid spray to attack your enemy.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_ACID, TAG_TIER2]
        );
        baseManaCost = 100;
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " acid damage";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsHydroAcid);
    }
    
    override public function calcCooldown() : Int
    {
        return spellGreyTier2Cooldown();
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var baseDamage : Float = 6 * scalingBonusIntelligence(randomize);
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        return adjustSpellDamage(baseDamage, DamageType.ACID, CAT_SPELL_GREY, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You bring your hands together, your [eyes] glowing sickly green. You point both hands at your foe, a deluge of clear fluid hissing as it sprays from your palms. Your stream of acid strikes true, burning at your foe!\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.ACID);
        if (monster.hasStatusEffect(StatusEffects.AcidDoT))
        {
            monster.addStatusValue(StatusEffects.AcidDoT, 1, 1);
            monster.addStatusValue(StatusEffects.AcidDoT, 3, 1);
        }
        else
        {
            monster.createStatusEffect(StatusEffects.AcidDoT, 2, 0.02, 1, 0);
        }
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}

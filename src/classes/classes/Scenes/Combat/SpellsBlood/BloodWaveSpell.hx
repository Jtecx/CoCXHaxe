package classes.scenes.combat.spellsBlood;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBloodSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class BloodWaveSpell extends AbstractBloodSpell
{
    public function new()
    {
        super(
                "Blood Wave", 
                "Blood Wave will attack all surrounding foes with a wave of blood.  It deals more damage when used against larger than average sized group of enemies.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_AOE]
        );
        baseHpCost = 400;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBloodWave);
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " magical damage";
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 2;
        calcC += spellGenericCooldown();
        return calcC;
    }
    
    public function calcDamage(target : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var damage : Float = adjustSpellDamage(
                scalingBonusIntelligence(randomize) * 4 * bloodAffinityBoost(), 
                DamageType.MAGICAL, 
                CAT_SPELL_BLOOD, 
                target, 
                false, 
                casting
        );
        if (damage < 10)
        {
            damage = 10;
        }
        if (target != null && target.hasPerk(PerkLib.EnemyLargeGroupType))
        {
            damage *= 5;
        }
        return Math.round(damage);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + ((player.HP < player.maxOverHP()) ? "wounds" : "skin pores") + ". Blood starts to gather around you, coalescing into a crimson ring. ");
            outputText("It roils, sphere sloshing with increasing intensity. You release it, and the sphere bursts, covering the area in a thin layer of roiling, seething blood tendrils. [themonster] reels back, only for the blood to home in, crashing into [themonster] like an iron-scented tidal wave.");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.MAGICAL, false, false);
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}


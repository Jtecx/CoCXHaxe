package classes.scenes.combat.spellsBlood;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBloodSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class BloodExplosionSpell extends AbstractBloodSpell
{
    public function new()
    {
        super(
                "Blood Explosion", 
                "Blood Explosion will attack foe with blood orb.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_AOE]
        );
        baseHpCost = 200;
    }
    
    override private function get_buttonName() : String
    {
        return "BloodExplosion";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBloodExplosion);
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " magical damage";
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 0;
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
        return Math.round(damage);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + ((player.HP < player.maxOverHP()) ? "wounds" : "skin pores") + ". Blood starts to gather above your hand, coalescing into a crimson sphere. ");
            outputText("It roils as you concentrate on it before aim the orb at [themonster], it bursts and seeps into [monster him] on impact as [monster he]'" + ((monster.plural) ? "re" : "s") + " afflicted by the magic.\n\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.MAGICAL, false, false);
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}


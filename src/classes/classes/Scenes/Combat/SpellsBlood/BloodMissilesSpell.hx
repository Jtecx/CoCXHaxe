package classes.scenes.combat.spellsBlood;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBloodSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class BloodMissilesSpell extends AbstractBloodSpell
{
    public function new()
    {
        super(
                "Blood Missiles", 
                "Blood Missiles will attack foe with five blood spheres.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING]
        );
        baseHpCost = 50;
        magicAddonProcs = 5;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBloodMissiles);
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + "(x5) magical damage";
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = -1;
        calcC += spellGenericCooldown();
        if (calcC < 0)
        {
            calcC = 0;
        }
        return calcC;
    }
    
    public function calcDamage(target : Monster, randomize : Bool = true, casting : Bool = true) : Float
    {
        var damage : Float = adjustSpellDamage(
                scalingBonusIntelligence(randomize) * bloodAffinityBoost(), 
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
            outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + ((player.HP < player.maxOverHP()) ? "wounds" : "skin pores") + ". Around you form a few crimson spheres you aim at [themonster]!\n\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        //Determine if critical hit!
        var crit : Bool = false;
        var critChance : Int = 5;
        critChance += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals))
        {
            critChance = 0;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            damage *= 1.75;
        }
        if (display)
        {
            outputText("[Themonster] takes ");
        }
        var n : Int = 5;
        while (n-- > 0)
        {
            doMagicDamage(damage, true, true);
            if (display && crit)
            {
                outputText(" <b>*Critical Hit!*</b>");
            }
        }
        if (display)
        {
            outputText(" damage.");
        }
        damage *= 5;
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}


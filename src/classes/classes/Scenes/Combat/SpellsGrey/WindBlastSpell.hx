package classes.scenes.combat.spellsGrey;

import classes.globalFlags.KACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractGreySpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class WindBlastSpell extends AbstractGreySpell
{
    public var ex : Bool;
    
    public function new(ex : Bool = false)
    {
        super(
                (ex) ? "Wind Blast (Ex)" : "Wind Blast", 
                (ex) ? 
                "Devastate the enemy ranks with a barrage of wrath-empowered wind vortexes." : "Devastate the enemy ranks with a barrage of wind vortexes.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_WIND, TAG_AOE, TAG_TIER1]
        );
        baseManaCost = 200;
        if (ex)
        {
            baseWrathCost = 100;
        }
        this.ex = ex;
    }
    
    override private function get_buttonName() : String
    {
        return (ex) ? "WindBlast(Ex)" : "Wind Blast";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " wind damage";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsWindBlast) &&
        (!ex || player.hasPerk(PerkLib.MagesWrathEx));
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 0;
        calcC += spellGreyCooldown();
        if (player.weaponRange == weaponsrange.RG_TOME && player.level < 18)
        {
            if (player.level < 6)
            {
                calcC -= 1;
            }
            if (player.level < 12)
            {
                calcC -= 1;
            }
            calcC -= 1;
            if (calcC < 0)
            {
                calcC = 0;
            }
        }
        return calcC;
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var baseDamage : Float = 2 * scalingBonusIntelligence(randomize);
        if (player.hasPerk(PerkLib.Convergence) && monster != null && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType) || monster.hasPerk(PerkLib.Enemy300Type)))
        {
            if (player.hasPerk(PerkLib.SuperConvergence))
            {
                if (monster.hasPerk(PerkLib.EnemyGroupType))
                {
                    baseDamage *= 3.5;
                }
                else if (monster.hasPerk(PerkLib.EnemyLargeGroupType))
                {
                    baseDamage *= 2;
                }
                else
                {
                    baseDamage *= 1.5;
                }
            }
            else if (monster.hasPerk(PerkLib.EnemyGroupType))
            {
                baseDamage *= 2;
            }
            else
            {
                baseDamage *= 1.5;
            }
        }
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        if (ex)
        {
            baseDamage *= 2;
        }
        return adjustSpellDamage(baseDamage, DamageType.WIND, CAT_SPELL_GREY, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You focus your intents at your opponent as the air swirls around them. A vortex forms as the violent air moves to your command.\n");
            outputText("You call down the squall as the slicing wind cuts into them.\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.WIND, false, true, true);
        if (ex)
        {
            awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
        }
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}

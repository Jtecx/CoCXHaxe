package classes.scenes.combat.soulskills;

import classes.PerkLib;
import classes.scenes.combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.iMutations.IMutationsLib;
import classes.Monster;
import classes.globalFlags.KFLAGS;
import classes.scenes.combat.Combat;
import classes.scenes.dungeons.d3.LivingStatue;

class KillingIntentSkill extends AbstractSoulSkill
{
    public function new()
    {
        super(
                "Killing Intent", 
                "Project your bloodlust through your soul sense, damaging the enemies' mind. Damage increases with the number of monsters killed and cultivation rank.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER1], 
                PerkLib.KillingIntent
        );
        baseSFCost = 200;
        lastAttackType = Combat.LAST_ATTACK_SPELL;
    }
    /*
    override protected function usabilityCheck():String {
    var uc:String =  super.usabilityCheck();
    if (uc) return uc;

		if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
			return "You are too angry to think straight. Smash your puny opponents first and think later.";
		}

    return "";
    }
*/
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(target)) + " true damage. Can cause fear";
    }
    
    private function calcDeathMod() : Float
    {
        var mod : Float = 1;
        var monstersKilled : Int = as3hx.Compat.parseInt(flags[kFLAGS.THIEFS_KILLED] +
                flags[kFLAGS.GOBLINS_KILLED] +
                flags[kFLAGS.HELLHOUNDS_KILLED] +
                flags[kFLAGS.IMPS_KILLED] +
                flags[kFLAGS.MINOTAURS_KILLED] +
                flags[kFLAGS.TRUE_DEMONS_KILLED]);
        mod += 0.1 * flags[kFLAGS.SOUL_CULTIVATION] * monstersKilled;
        return mod;
    }
    
    override public function calcCooldown() : Int
    {
        return soulskillCooldown(3, false);
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var damage : Float = scalingBonusWisdom();
        if (damage < 10)
        {
            damage = 10;
        }
        //soulskill mod effect
        damage *= combat.soulskillMagicalMod();
        damage *= calcDeathMod();
        //other bonuses
        if (player.hasPerk(PerkLib.Heroism) && (monster != null && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))))
        {
            damage *= 2;
        }
        if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5))
        {
            damage *= 1.5;
        }
        return Math.round(damage);
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        clearOutput();
        if (monster.hasPerk(PerkLib.Insanity) || monster.inte == 0)
        {
            if (display)
            {
                outputText("You try to strike the enemy's resolve with your bloodlust, but the monster is unaffected. It doesn't seem as though bloodlust registers to them!\n\n");
            }
            return;
        }
        else if (Std.is(monster, LivingStatue))
        {
            if (display)
            {
                outputText("Bloodlust does not matter to a statue!\n\n");
            }
            return;
        }
        if (silly())
        {
            if (display)
            {
                outputText("You narrow your eyes at this foolish upstart. \"<i>Junior, you dare!</i>\" Your power of your soul flares from your body, seeking to strike them down. ");
            }
            else if (display)
            {
                outputText("You set your focus on [themonster], sending your desire to kill them through your soulforce. ");
            }
        }
        var damage : Float = calcDamage(monster);
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
            outputText("Your intent slams into [themonster], sending them reeling from your bloodlust! ");
        }
        doTrueDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        if (rand(5) == 0 && monster.level <= player.level)
        {
            monster.createStatusEffect(StatusEffects.Fear, 1, 0, 0, 0);
            if (display)
            {
                outputText(" [Themonster] is left cowed from your mental attack!");
            }
        }
        checkAchievementDamage(damage);
        if (display)
        {
            outputText("\n\n");
        }
        if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0)
        {
            anubiHeartLeeching(damage);
        }
        combat.heroBaneProc(damage);
    }
}

package classes.scenes.combat.soulskills;

import classes.PerkLib;
import classes.scenes.combat.AbstractSoulSkill;
import classes.scenes.nPCs.Jojo;
import classes.scenes.nPCs.JojoScene;
import classes.scenes.dungeons.d3.LivingStatue;
import classes.Races;
import classes.StatusEffects;
import classes.iMutations.IMutationsLib;
import classes.Monster;
import classes.globalFlags.KFLAGS;
import classes.scenes.combat.Combat;

class CleansingPalmSkill extends AbstractSoulSkill
{
    public function new()
    {
        super(
                "Cleansing Palm", 
                "Unleash the power of your cleansing aura! More effective against corrupted opponents. Doesn't work on the pure. Damage based on physical attack.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_MAGICAL], 
                PerkLib.CleansingPalm
        );
        baseSFCost = 30;
        lastAttackType = Combat.LAST_ATTACK_SPELL;
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (player.cor >= (10 + player.corruptionTolerance))
        {
            return "You are too corrupt to use this ability!";
        }
        
        return "";
    }
    
    override private function get_buttonName() : String
    {
        return "C.Palm";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(target)) + " magical damage";
    }
    
    private function calcCorruptionMulti(monster : Monster) : Float
    {
        var corruptionMulti : Float = (monster.cor - 20) / 25;
        if (corruptionMulti > 1.5)
        {
            corruptionMulti = 1.5;
            corruptionMulti += ((monster.cor - 57.5) / 100);
        }
        return corruptionMulti;
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var damage : Float = scalingBonusWisdom() * 2;
        damage += combat.meleeUnarmedDamageNoLagSingle();
        if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit))
        {
            if (player.isRaceCached(Races.MOUSE, 2) && player.countRings(jewelries.INMORNG))
            {
                damage *= 2.2;
            }
            else
            {
                damage *= 2;
            }
            damage = combat.fireTypeDamageBonusLarge(damage);
        }
        if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat))
        {
            damage = combat.fireTypeDamageBonus(damage);
            damage *= 1.1;
        }
        damage *= soulskillMod();
        if (monster != null)
        {
            damage *= calcCorruptionMulti(monster);
            if (player.hasPerk(PerkLib.PerfectStrike) && monster.monsterIsStunned())
            {
                damage *= 1.5;
            }
        }
        if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5))
        {
            damage *= 1.5;
        }
        return Math.round(damage);
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (Std.is(monster, Jojo))
        
        // Not a completely corrupted monkmouse{
            
            if (JojoScene.monk < 2)
            {
                if (display)
                {
                    outputText("You thrust your palm forward, sending a blast of pure energy towards Jojo. At the last second he sends a blast of his own against yours canceling it out\n\n");
                }
                return;
            }
        }
        if (Std.is(monster, LivingStatue))
        {
            if (display)
            {
                outputText("You thrust your palm forward, causing a blast of pure energy to slam against the giant stone statue - to no effect!");
            }
            return;
        }
        
        var damage : Float = calcDamage(monster);
        if (damage > 0)
        {
            if (display)
            {
                outputText("You thrust your palm forward, creating a blast of pure energy that erupts from your palm, slamming into [themonster], tossing");
                if ((try cast(monster, Monster) catch(e:Dynamic) null).plural)
                {
                    outputText(" them");
                }
                else
                {
                    outputText((try cast(monster, Monster) catch(e:Dynamic) null).mfn(" him", " her", " it"));
                }
                outputText(" back a few feet.\n\n");
                if (silly() && calcCorruptionMulti(monster) >= 1.75)
                {
                    outputText("It's super effective!  ");
                }
            }
            //Determine if critical hit!
            var crit : Bool = false;
            var critChance : Int = 5;
            critChance += combat.combatPhysicalCritical();
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
            combat.checkForElementalEnchantmentAndDoDamage(damage, true, true, crit, false, 2);
            if (display)
            {
                if (crit)
                {
                    outputText(" <b>*Critical Hit!*</b>");
                }
                outputText("damage \n\n");
            }
        }
        else if (display)
        {
            outputText("You thrust your palm forward, causing a blast of pure energy to slam against [themonster], which they ignore. It is probably best you don’t use this technique against the pure.\n\n");
        }
        combat.WrathGenerationPerHit2(5);
        if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0)
        {
            this.anubiHeartLeeching(damage);
        }
        combat.heroBaneProc(damage);
        combat.EruptingRiposte();
    }
}

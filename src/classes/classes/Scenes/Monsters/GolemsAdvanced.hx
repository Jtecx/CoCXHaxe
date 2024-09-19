/**
 * ...
 * @author Ormael
 */
package classes.scenes.monsters;

import classes.*;
import classes.scenes.SceneLib;

class GolemsAdvanced extends AbstractGolem
{
    public function backhand() : Void
    {
        outputText("The golems visage twists into a grimace of irritation, and few of them swings their hands at you in a vicious backhand.");
        var damage : Float = as3hx.Compat.parseInt(((str + weaponAttack) * 6) - rand(player.tou) - player.armorDef);
        //Dodge
        if (damage <= 0 || (player.getEvasionRoll()))
        {
            outputText(" You slide underneath the surprise swings!");
        }
        else
        {
            if (hasStatusEffect(StatusEffects.Provoke))
            {
                damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
            }
            outputText(" They hits you square in the chest from a few different angles. ");
            damage = player.takePhysDamage(damage, true);
        }
    }
    
    public function overhandSmash() : Void
    {
        outputText("Raising their fists high overhead, the golems swiftly brings them down in a punishing strike!");
        
        var damage : Float = 150 + as3hx.Compat.parseInt(((str + weaponAttack) * 6) - rand(player.tou) - player.armorDef);
        if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll())
        {
            outputText(" You're able to sidestep it just in time.");
        }
        else
        {
            if (hasStatusEffect(StatusEffects.Provoke))
            {
                damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
            }
            outputText(" The concussive strikes impacts you with a bonecrushing force. ");
            damage = player.takePhysDamage(damage, true);
        }
    }
    
    override private function performCombatAction() : Void
    {
        if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85)
        {
            if (hasStatusEffect(StatusEffects.Provoke))
            {
                var choiceP : Float = rand(3);
                if (choiceP == 0)
                {
                    eAttack();
                }
                if (choiceP == 1)
                {
                    backhand();
                }
                if (choiceP == 2)
                {
                    overhandSmash();
                }
            }
            else if (this.HPRatio() < 0.6)
            {
                var choice2 : Float = rand(5);
                if (choice2 < 3)
                {
                    eAttack();
                }
                if (choice2 == 3)
                {
                    backhand();
                }
                if (choice2 == 4)
                {
                    overhandSmash();
                }
            }
            else if (this.HPRatio() < 0.8)
            {
                var choice1 : Float = rand(4);
                if (choice1 < 3)
                {
                    eAttack();
                }
                if (choice1 == 3)
                {
                    backhand();
                }
            }
            else
            {
                eAttack();
            }
        }
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        if (player.hasStatusEffect(StatusEffects.SoulArena))
        {
            SceneLib.combat.finishCombat();
        }
        else
        {
            SceneLib.campMakeWinions.postFightGolemOptions3();
        }
    }
    
    public function new()
    {
        super(true);
        this.a = "the ";
        this.short = "advanced golems";
        this.imageName = "advanced golems";
        this.long = "You're currently fighting advanced golems. They're all around eight feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
        initStrTouSpeInte(320, 250, 180, 10);
        initWisLibSensCor(10, 10, 10, 0);
        this.tallness = 96;
        this.drop = NO_DROP;
        this.level = 51;
        this.bonusHP = 900;
        this.additionalXP = 900;
        this.weaponName = "stone fists";
        this.weaponVerb = "smash";
        this.weaponAttack = 100;
        this.armorName = "stone";
        this.armorDef = 100;
        this.armorMDef = 20;
        this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
        checkMonster();
    }
}


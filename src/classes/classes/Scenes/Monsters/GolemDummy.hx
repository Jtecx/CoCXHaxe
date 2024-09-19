/**
 * ...
 * @author Ormael
 */
package classes.scenes.monsters;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;

class GolemDummy extends AbstractGolem
{
    public function backhand() : Void
    {
        outputText("The golem's visage twists into a grimace of irritation, and it swings its hand at you in a vicious backhand.");
        var damage : Float = as3hx.Compat.parseInt((str + weaponAttack) - rand(player.tou) - player.armorDef);
        //Dodge
        if (damage <= 0 || (player.getEvasionRoll()))
        {
            outputText(" You slide underneath the surprise swing!");
        }
        else
        {
            if (hasStatusEffect(StatusEffects.Provoke))
            {
                damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
            }
            outputText(" It hits you square in the chest. ");
            damage = player.takePhysDamage(damage, true);
        }
    }
    
    override private function performCombatAction() : Void
    {
        if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85)
        {
            if (hasStatusEffect(StatusEffects.Provoke))
            {
                var choiceP : Float = rand(4);
                if (choiceP < 2)
                {
                    eAttack();
                }
                if (choiceP > 1)
                {
                    backhand();
                }
            }
            else if (this.HPRatio() < 0.75)
            {
                var choice : Float = rand(4);
                if (choice < 3)
                {
                    eAttack();
                }
                if (choice == 3)
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
            SceneLib.campMakeWinions.postFightGolemOptions1();
        }
    }
    
    public function new()
    {
        super(false);
        if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 0)
        {
            this.a = "the ";
            this.short = "dummy golem";
            this.imageName = "dummy golem";
            this.long = "You're currently fighting the dummy golem. It's six feet tall, without any sexual characteristics. It has a stone body covered in cracks. It has no weapons, using its grey stone fists to smash enemies.";
            initStrTouSpeInte(20, 20, 10, 10);
            initWisLibSensCor(10, 10, 10, 0);
            this.level = 6;
            this.bonusHP = 50;
            this.additionalXP = 50;
            this.weaponAttack = 10;
            this.armorDef = 10;
            this.armorMDef = 2;
        }
        if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 2)
        {
        }
        if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 4)
        {
        }
        if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 6)
        {
        }
        this.tallness = 72;
        this.drop = NO_DROP;
        this.weaponName = "stone fists";
        this.weaponVerb = "smash";
        this.armorName = "cracked stone";
        this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        checkMonster();
    }
}



/**
 * ...
 * @author Ormael
 */
package classes.scenes.monsters;

import classes.*;
import classes.scenes.SceneLib;

class GolemDummyAdvanced extends AbstractGolem
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
        this.a = "the ";
        this.short = "advanced dummy golem";
        this.imageName = "advanced dummy golem";
        this.long = "You're currently fighting advanced dummy golem. It's seven feet tall without any sexual characteristics, it stone body covered in cracks and using it bare stone fists to smash enemies.";
        initStrTouSpeInte(60, 60, 30, 10);
        initWisLibSensCor(10, 10, 10, 0);
        this.tallness = 84;
        this.drop = NO_DROP;
        this.level = 18;
        this.bonusHP = 150;
        this.additionalXP = 150;
        this.weaponName = "stone fists";
        this.weaponVerb = "smash";
        this.weaponAttack = 20;
        this.armorName = "cracked stone";
        this.armorDef = 20;
        this.armorMDef = 4;
        this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        checkMonster();
    }
}


/**
 * ...
 * @author Ormael
 */
package classes.scenes.monsters;

import classes.*;
import classes.scenes.SceneLib;

class GolemTrueAdvanced extends AbstractGolem
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
    
    public function overhandSmash() : Void
    {
        outputText("Raising its fist high overhead, the golem swiftly brings it down in a punishing strike!");
        
        var damage : Float = 100 + as3hx.Compat.parseInt((str + weaponAttack) - rand(player.tou) - player.armorDef);
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
            outputText(" The concussive strike impacts you with bonecrushing force. ");
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
        super(false);
        this.a = "the ";
        this.short = "advanced true golem";
        this.imageName = "advanced true golem";
        this.long = "You're currently fighting advanced true golem. It's eight feet tall without any sexual characteristics, it stone body lacking any cracks dummy ones possesed and using it bare stone fists to smash enemies.";
        initStrTouSpeInte(250, 200, 150, 10);
        initWisLibSensCor(10, 10, 10, 0);
        this.tallness = 96;
        this.drop = NO_DROP;
        this.level = 51;
        this.bonusHP = 650;
        this.additionalXP = 650;
        this.weaponName = "stone fists";
        this.weaponVerb = "smash";
        this.weaponAttack = 70;
        this.armorName = "stone";
        this.armorDef = 70;
        this.armorMDef = 14;
        this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        checkMonster();
    }
}


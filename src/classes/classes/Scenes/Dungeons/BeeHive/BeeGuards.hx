/**
 * ...
 * @author Liadri
 */
package classes.scenes.dungeons.beeHive;

import classes.*;
import classes.bodyParts.Antennae;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.LowerBody;
import classes.bodyParts.Tail;
import classes.bodyParts.Wings;
import classes.globalFlags.*;
import classes.scenes.SceneLib;
import classes.internals.ChainedDrop;

class BeeGuards extends Monster
{
    
    public function beeGuardsStinger() : Void
    {
        outputText("One of the guards strikes through your defenses, trying to burrow her stinger in. ");
        //Miss:
        if (rand(20) + 1 + player.spe / 20 > 17)
        {
            outputText("Luckly it missed you.");
        }
        //Hit:
        else
        {
            outputText("The arousal and pleasure spike from the aphrodisiac in the sting leaves you stunned.");
            if (!player.hasPerk(PerkLib.Resolute))
            {
                player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
            }
            createStatusEffect(StatusEffects.AbilityCooldown1, 5, 0, 0, 0);
            player.takeLustDamage(90 + rand(45), true);
        }
    }
    
    public function beeGuardsSpearStrike() : Void
    {
        outputText("One of the guards attempts to impale you with her spear! ");
        //Miss:
        if (rand(20) + 1 + player.spe / 20 > 17)
        {
            outputText("The weapon missed you.");
        }
        //Hit:
        else
        {
            outputText("The weapon goes right through you! ");
            var damage : Float = weaponAttack + str * 2 + rand(str);
            damage = player.takePhysDamage(damage, true);
        }
    }
    
    override private function performCombatAction() : Void
    {
        if (rand(2) == 0 && !hasStatusEffect(StatusEffects.AbilityCooldown1))
        {
            beeGuardsStinger();
        }
        else
        {
            beeGuardsSpearStrike();
        }
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        clearOutput();
        outputText("The two guards fall to the ground, " + ((hpVictory) ? "their wounds too great" : "too busy masturbating") + " to keep up on fighting. You get past them and enter the Hive.");
        if (hpVictory)
        {
            flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] = 2;
        }
        else
        {
            flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] = 2.5;
        }
        cleanupAfterCombat();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.dungeons.beehive.room1LostToGuards();
    }
    
    public function new()
    {
        super();
        this.a = "";
        this.short = "Bee guards";
        this.long = "These two bee guards are trying to prevent you from entering the Hive. While most bees are covered in chitin-like plating, these girls look even tougher than their less combative counterparts.";
        this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
        createBreastRow(Appearance.breastCupInverse("D"));
        this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = rand(14) + 59;
        this.hips.type = Hips.RATING_CURVY + 3;
        this.butt.type = Butt.RATING_EXPANSIVE;
        this.lowerBody = LowerBody.BEE;
        this.bodyColor = "yellow";
        this.hairColor = randomChoice("black", "black and yellow");
        this.hairLength = 6;
        initStrTouSpeInte(70, 220, 90, 35);
        initWisLibSensCor(35, 170, 125, 50);
        this.weaponName = "chitin-plated fist";
        this.weaponVerb = "armored punch";
        this.weaponAttack = 15;
        this.armorName = "chitin";
        this.armorDef = 50;
        this.armorMDef = 20;
        this.bonusHP = 1000;
        this.bonusLust = 325;
        this.level = 30;
        this.gems = rand(30) + 30;
        this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4).add(consumables.W__BOOK, 1 / 3).add(consumables.BEEHONY, 1 / 2).elseDrop(useables.B_CHITN);
        this.antennae.type = Antennae.BEE;
        this.wings.type = Wings.BEE_SMALL;
        this.tailType = Tail.BEE_ABDOMEN;
        this.tailVenom = 100;
        checkMonster();
    }
}


  /**
 * ...
 * @author Ormael & Redcake
 */  
package classes.scenes.explore;

import classes.*;
import classes.bodyParts.Arms;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.LowerBody;
import classes.bodyParts.RearBody;
import classes.bodyParts.Wings;
import classes.scenes.SceneLib;
import classes.internals.*;

//import classes.BodyParts.Tail;
class Pierce extends Monster
{
    public function moveClawCombo() : Void
    {
        createStatusEffect(StatusEffects.Attacks, 6, 0, 0, 0);
        eAttack();
    }
    
    public function moveCleanse() : Void
    {
        outputText("The malikore stabs himself with his tail, cleansing himself from poison!");
        if (hasStatusEffect(StatusEffects.PoisonDoT))
        {
            removeStatusEffect(StatusEffects.PoisonDoT);
        }
        if (hasStatusEffect(StatusEffects.PoisonDoTH))
        {
            removeStatusEffect(StatusEffects.PoisonDoTH);
        }
        if (hasStatusEffect(StatusEffects.LustDoT))
        {
            removeStatusEffect(StatusEffects.LustDoT);
        }
        if (hasStatusEffect(StatusEffects.LustDoTH))
        {
            removeStatusEffect(StatusEffects.LustDoTH);
        }
    }
    
    override private function performCombatAction() : Void
    {
        if (!monsterIsStunned() && (hasStatusEffect(StatusEffects.PoisonDoT) || hasStatusEffect(StatusEffects.PoisonDoTH) || hasStatusEffect(StatusEffects.LustDoT) || hasStatusEffect(StatusEffects.LustDoTH)))
        {
            moveCleanse();
        }
        else
        {
            moveClawCombo();
        }
    }
    
    override private function get_long() : String
    {
        var str : String = "";
        if (hasStatusEffect(StatusEffects.Flying))
        {
            str += "The malikore is circling you in the air readying a salvo of spike to throw at you.";
        }
        else
        {
            str += "The malikore is currently circling you looking for an opening to strike. He’s actually good on the eye and you would give him more attention if not for the fact he’s trying to beat you down and rape you.";
        }
        return str;
    }
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "alpha malikore";
        this.long = "";
        this.createCock(36, 7);
        this.createCock(36, 7);
        this.balls = 2;
        this.ballSize = 5;
        this.cumMultiplier = 1;
        this.hoursSinceCum = 1000;
        createBreastRow(0);
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.tallness = 120;
        this.hips.type = Hips.RATING_AVERAGE;
        this.butt.type = Butt.RATING_TIGHT;
        this.bodyColor = "light";
        this.hairColor = "red";
        this.hairLength = 13;
        initStrTouSpeInte(130, 195, 330, 200);
        initWisLibSensCor(200, 230, 110, 60);
        this.weaponAttack = 54;
        this.weaponName = "claw";
        this.weaponVerb = "claw-slash";
        this.armorName = "black shorts";
        this.armorDef = 16;
        this.armorMDef = 3;
        this.bonusHP = 200;
        this.bonusLust = 379;
        this.lust = 30;
        this.lustVuln = .8;
        this.level = 39;
        this.gems = 45 + rand(40);
        this.drop = new ChainedDrop().add(armors.S_SWMWR, 1 / 12).add(consumables.L_DRAFT, 1 / 4).add(consumables.MANTICV, 0.7);
        this.wings.type = Wings.MANTICORE_LARGE;
        this.rearBody.type = RearBody.LION_MANE;
        this.arms.type = Arms.LION;
        this.lowerBody = LowerBody.LION;
        //this.tailType = Tail.MANTICORE_PUSSYTAIL;
        //this.tailRecharge = 0;
        this.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
        this.createPerk(PerkLib.JobCourtesan, 0, 0, 0, 0);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
        this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
        checkMonster();
    }
}



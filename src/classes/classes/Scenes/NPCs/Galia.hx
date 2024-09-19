/**
 * ...
 * @author Ormael
 */
package classes.scenes.nPCs;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.LowerBody;
import classes.bodyParts.Wings;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;
import classes.internals.*;

class Galia extends Monster
{
    public function clawAttack() : Void
    {
        outputText("" + this.capitalA + this.short + " charges at you with h" + ((flags[kFLAGS.GALIA_LVL_UP] >= 1) ? "er" : "is") + " claws ready! ");
        if (player.getEvasionRoll())
        {
            outputText("You manage to avoid h" + ((flags[kFLAGS.GALIA_LVL_UP] >= 1) ? "er" : "is") + " claws thanks to your reaction!");
            return;
        }
        else
        {
            outputText("" + this.capitalA + this.short + " manages to swipe you!  You let out a cry in pain. ");
            var damage : Int = as3hx.Compat.parseInt(eBaseStrengthDamage() + rand(50) + str + weaponAttack);
            if (damage < 50)
            {
                damage = 50;
            }
            player.takePhysDamage(damage, true);
        }
    }
    
    public function doubleAttack() : Void
    {
        outputText("" + this.capitalA + this.short + " charges at you with h" + ((flags[kFLAGS.GALIA_LVL_UP] >= 1) ? "er" : "is") + " deadly claws ready! ");
        if (player.getEvasionRoll())
        {
            outputText("You manage to dodge h" + ((flags[kFLAGS.GALIA_LVL_UP] >= 1) ? "er" : "is") + " deadly attack!");
            return;
        }
        else
        {
            outputText("" + this.capitalA + this.short + " manages to slash you with h" + ((flags[kFLAGS.GALIA_LVL_UP] >= 1) ? "er" : "is") + " deadly claws!");
            var damage : Int = as3hx.Compat.parseInt(eBaseStrengthDamage() + rand(50) + str + weaponAttack);
            if (damage < 50)
            {
                damage = 50;
            }  //Min-cap damage.  
            if (damage >= 250 && !player.immuneToBleed())
            {
                outputText("You let out a cry in pain and you swear you could see your wounds bleeding. ");
                player.createStatusEffect(StatusEffects.IzmaBleed, 2, 0, 0, 0);
            }
            else
            {
                outputText("Thankfully the wounds aren't that serious. ");
            }
            player.takePhysDamage(damage, true);
            player.takePhysDamage(damage, true);
        }
    }
    
    override private function performCombatAction() : Void
    {
        this.wrath += 100;
        var choice1 : Float = rand(4);
        if (choice1 < 2)
        {
            eAttack();
        }
        if (choice1 == 2)
        {
            clawAttack();
        }
        if (choice1 == 3)
        {
            doubleAttack();
        }
    }
    
    override public function defeated(hpVictory : Bool) : Void
    //if (flags[kFLAGS.GALIA_LVL_UP] >= 1) {
    {
        
        //if (player.hasStatusEffect(StatusEffects.CampSparingDinah)) {
        //player.removeStatusEffect(StatusEffects.CampSparingDinah);
        SceneLib.galiaFollower.GaliaLostSparring();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    //if (flags[kFLAGS.GALIA_LVL_UP] >= 1) {
    {
        
        //if (player.hasStatusEffect(StatusEffects.CampSparingDinah)) {
        //player.removeStatusEffect(StatusEffects.CampSparingDinah);
        SceneLib.galiaFollower.GaliaWonSparring();
    }
    
    public function new()
    {
        super();
        var add : Float = 0;
        if (flags[kFLAGS.GALIA_LVL_UP] < 2)
        {
            initStrTouSpeInte(35, 5, 5, 5);
            initWisLibSensCor(5, 5, 5, 100);
            this.weaponAttack = 2;
            this.armorDef = 1;
            this.armorMDef = 0;
            this.bonusWrath = 50;
            this.bonusLust = 11;
            this.lust = 40;
            this.level = 1;
            this.gems = rand(5) + 5;
            this.createPerk(PerkLib.OverMaxHP, 1, 0, 0, 0);
        }
        if (flags[kFLAGS.GALIA_LVL_UP] >= 2 && flags[kFLAGS.GALIA_LVL_UP] < 5)
        {
            add += flags[kFLAGS.GALIA_LVL_UP] - 1;
            initStrTouSpeInte(35 + (25 * add), 5 + (5 * add), 5 + (15 * add), 5 + (10 * add));
            initWisLibSensCor(5 + (10 * add), 5 + (2 * add), 5 + (21 * add), 100);
            this.weaponAttack = 2 + (5 * add);
            this.armorDef = 1 + (2 * add);
            this.armorMDef = 0 + (1 * add);
            this.bonusHP = 50 + (50 * add);
            this.bonusWrath = 50 + (100 * add);
            this.bonusLust = 11 + (29 * add);  //lib+sens+lvl  
            this.lust = 40;
            this.level = (1 + (6 * add));
            this.gems = rand(5) + 5;
            this.createPerk(PerkLib.OverMaxHP, 1 + (6 * add), 0, 0, 0);
        }
        if (flags[kFLAGS.GALIA_LVL_UP] >= 5 && flags[kFLAGS.GALIA_LVL_UP] < 8)
        
        //pierwsza normalna mutacja{
            
            add += flags[kFLAGS.GALIA_LVL_UP] - 5;
            initStrTouSpeInte(110 + (25 * add), 20 + (5 * add), 50 + (15 * add), 35 + (10 * add));
            initWisLibSensCor(35 + (10 * add), 11 + (2 * add), 68 + (21 * add), 100);
            this.weaponAttack = 17;
            this.armorDef = 7;
            this.armorMDef = 3;
            this.bonusHP = 200;
            this.bonusWrath = 350;
            this.bonusLust = 98;
            this.lust = 40;
            this.level = 14;
            this.gems = rand(5) + 5;
            this.createPerk(PerkLib.OverMaxHP, 14 + (6 * add), 0, 0, 0);
            this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.GALIA_LVL_UP] == 8)
        
        //pierwsza specialna ewolucja/mutacja{
            
            initStrTouSpeInte(135, 25, 65, 45);
            initWisLibSensCor(45, 13, 89, 100);
            this.weaponAttack = 22;
            this.armorDef = 9;
            this.armorMDef = 4;
            this.bonusHP = 250;
            this.bonusWrath = 450;
            this.bonusLust = 127;
            this.lust = 40;
            this.level = 25;
            this.gems = rand(6) + 15;
            this.createPerk(PerkLib.OverMaxHP, 25, 0, 0, 0);
            this.createPerk(PerkLib.EnemyChampionType, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.GALIA_LVL_UP] < 5)
        {
            this.long = "Galia is short, only 2 feet 3 inches tall. An unkempt mane of shaggy platinum blond hair hangs from her head, parted by two short curved horns. Her eyes are solid black, save for tiny red irises. Her skin is bright red unencumbered by clothing or armor, save for a small loincloth at her belt and wrap fighting to keep her massive for her height breasts. Her extremely well-muscled body is nowhere to be seen replaced by much soft one, her feet are covered by tiny wooden sandals, and her hands tipped with sharp claws. A pair of tiny but functional wings occasionally flap from her back.";
            createBreastRow(Appearance.breastCupInverse("DD"));
            this.hairLength = 36;
            this.tallness = 26;
        }
        if (flags[kFLAGS.GALIA_LVL_UP] >= 5 && flags[kFLAGS.GALIA_LVL_UP] < 8)
        {
            this.long = "Galia is now taller reaching 4 feet 4 inches. An unkempt mane of shaggy platinum blond hair hangs from her head, parted by two short curved horns. Her eyes are solid black, save for tiny red irises. Her skin is bright red unencumbered by clothing or armor, save for bandage-like loincloths wrapped around her foreamrs, forelegs and hips. The one wrapped around her more them ample chest seems to be from some elastic metalic material that barely doing it job. Her extremely well-muscled body is nowhere to be seen replaced by much soft one, her feet are covered by wooden sandals, and her hands tipped with sharp claws. A pair of small but functional wings occasionally flap from her back.";
            createBreastRow(Appearance.breastCupInverse("DD"));
            this.hairLength = 62;
            this.tallness = 52;
        }
        if (flags[kFLAGS.GALIA_LVL_UP] < 8)
        {
            this.createVagina(true, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_TIGHT);
            this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
            this.ass.analWetness = AssClass.WETNESS_NORMAL;
            this.hips.type = Hips.RATING_CURVY + 2;
            this.butt.type = Butt.RATING_JIGGLY + 2;
            this.weaponName = "claws";
            this.weaponVerb = "claw-slash";
            this.armorName = "leathery skin";
        }
        this.a = "";
        this.short = "Galia";
        this.imageName = "imp";
        this.bodyColor = "red";
        this.hairColor = "black";
        this.plural = false;
        this.drop = NO_DROP;
        if (flags[kFLAGS.GALIA_LVL_UP] < 8)
        {
            this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.GALIA_AFFECTION] >= 2)
        {
            this.createPerk(PerkLib.Sentience, 0, 0, 0, 0);
        }
        this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
        if (flags[kFLAGS.GALIA_LVL_UP] >= 8)
        {
            this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
        }
        checkMonster();
    }
}



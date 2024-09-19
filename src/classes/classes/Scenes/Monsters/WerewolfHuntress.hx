/**
 * ...
 * @author Liadri
 */
package classes.scenes.monsters;

import classes.scenes.nPCs.*;
import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.scenes.SceneLib;
import classes.globalFlags.KFLAGS;
import classes.internals.*;

class WerewolfHuntress extends Monster
{
    public function usingClawCombo() : Void
    {
        outputText("The werewolf attempts to rend you with her claws.\n");
        eAttack();
        eAttack();
        eAttack();
        eAttack();
        eAttack();
        eAttack();
        eAttack();
        eAttack();
    }
    
    public function usingPounce() : Void
    {
        outputText("The werewolf pounces on you, pinning you to the ground as she gets in position, claws at the ready.");
        player.createStatusEffect(StatusEffects.WolfHold, 0, 0, 0, 0);
        if (player.hasPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy")
        {
            var takeD : Float;
            takeD = 8 + rand(10);
            player.takePhysDamage(takeD, true);
        }
    }
    
    public function usingRavage() : Void
    {
        outputText("The werewolf rends you with her claws.");
        var RavageDmg : Float = eBaseStrengthDamage();
        RavageDmg = Math.round(RavageDmg);
        player.takePhysDamage(RavageDmg, true);
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.werewolfFemaleScene.wonWithWerewolf();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.werewolfFemaleScene.lostToWerewolf();
    }
    
    public function new()
    {
        super();
        initStrTouSpeInte(200, 165, 200, 50);
        initWisLibSensCor(50, 100, 50, 50);
        this.weaponAttack = 36 + 2;
        this.armorDef = 200 + 10;
        this.armorMDef = 5;
        this.bonusHP = 800 + 50;
        this.bonusLust = 129 + 26;
        this.level = 50;
        this.a = "the ";
        this.short = "werewolf huntress";
        this.imageName = "luna";
        this.long = "Your opponent is a werewolf lycanthrope. While halfway human in appearance its glowing green eyes, canine ears, sharp fangs, bushy tails and claw armed paws reminds you of its bestial nature." +
                " It circles you, sniffing the air as it looks for an opportunity to maul or snap at you, supernaturally fast in its movement. As a veteran huntress she actualy is far more experienced then the regular lycanthrope.";
        // this.plural = false;
        this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("DD"));
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = 6 * 12 + 6;
        this.hips.type = Hips.RATING_CURVY;
        this.butt.type = Butt.RATING_NOTICEABLE;
        this.skin.growFur({
                    color : "ashen"
                });
        this.hairColor = "ashen";
        this.hairLength = 8;
        this.weaponName = "paws";
        this.weaponVerb = "paw-slash";
        this.armorName = "fur";
        this.lust = 10;
        this.lustVuln = 0.01;
        this.gems = 5 + rand(5);
        this.drop = new WeightedDrop().add(null, 1).add(consumables.WOLF_PP, 5);
        this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
        this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
        this.abilities = [
                {
                    call : usingRavage,
                    type : ABILITY_PHYSICAL,
                    range : RANGE_MELEE,
                    tags : [TAG_BODY],
                    weight : 2
                }, 
                {
                    call : usingClawCombo,
                    type : ABILITY_PHYSICAL,
                    range : RANGE_MELEE,
                    tags : [TAG_BODY]
                }, 
                {
                    call : usingPounce,
                    type : ABILITY_PHYSICAL,
                    range : RANGE_MELEE,
                    tags : [TAG_BODY],
                    condition : function() : Bool
                    {
                        return !player.hasStatusEffect(StatusEffects.WolfHold);
                    }
                }, 
                {
                    call : usingRavage,
                    type : ABILITY_PHYSICAL,
                    range : RANGE_MELEE,
                    tags : [TAG_BODY],
                    condition : function() : Bool
                    {
                        return player.hasStatusEffect(StatusEffects.WolfHold);
                    },
                    weight : Infinity
                }
        ];
        checkMonster();
    }
}


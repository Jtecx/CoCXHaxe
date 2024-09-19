/**
 * ...
 * @author Ormael
 */
package classes.scenes.areas.battlefield;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.scenes.SceneLib;
import classes.scenes.areas.battlefield.BattlefieldEnemiesScenes;
import classes.internals.*;

class VengefulApparitions extends Monster
{
    public var Ghosts : BattlefieldEnemiesScenes = new BattlefieldEnemiesScenes();
    
    private function VengefulApparitionsMagicMissles() : Void
    {
        outputText("You hear a hissing, as several of the ghastly figures float forward. From their glowing palms, pulsating orbs are formed, and launched, one after the other. The projectiles aren't all fired directly at you, but they seem to arc, violet orbs darkening the area as they all home in on you. You dodge, but they track your movements effortlessly. The first few don't hurt much, but the sheer number of the projectiles quickly add up. ");
        var damage : Float = eBaseIntelligenceDamage() * 0.25;
        player.takeMagicDamage(damage, true);
        player.takeMagicDamage(damage, true);
        player.takeMagicDamage(damage, true);
        player.takeMagicDamage(damage, true);
        if (this.level == 30)
        {
            player.takeMagicDamage(damage, true);
            player.takeMagicDamage(damage, true);
        }
        if (player.hasStatusEffect(StatusEffects.ChargeWeapon) || player.hasStatusEffect(StatusEffects.ChargeArmor) || player.statStore.hasBuff("Might") || player.statStore.hasBuff("Blink"))
        {
            if (player.hasStatusEffect(StatusEffects.ChargeWeapon))
            {
                player.removeStatusEffect(StatusEffects.ChargeWeapon);
            }
            else if (player.hasStatusEffect(StatusEffects.ChargeArmor))
            {
                player.removeStatusEffect(StatusEffects.ChargeArmor);
            }
            else if (player.statStore.hasBuff("Might"))
            {
                player.statStore.removeBuffs("Might");
            }
            else
            {
                player.statStore.removeBuffs("Blink");
            }
        }
        outputText("\n");
    }
    
    override private function performCombatAction() : Void
    {
        var choice : Float = rand(4);
        switch (choice)
        {
            case 0, 1, 2:
                eAttack();
            case 3:
                VengefulApparitionsMagicMissles();
            default:
                eAttack();
        }
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        Ghosts.defeatVengefulApparitions();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        Ghosts.loseToAVengefulApparitions();
    }
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "vengeful apparitions";
        this.imageName = "vengefulapparitions";
        this.long = "You are currently battling the vengeful apparitions. While they're humanoid, they seem to have once been a variety of races, from goblins to minotaurs...Even a human or two. While their \"bodies\" appear almost normal, draped in a variety of armors or fancy clothing, their legs end in misty vapor, inches off the ground. Their jaws all hang open, and their eyes are blank, staring at you unblinking. They flicker in and out of sight, heads and limbs shaking unnaturally. The only sound they make is the occasional moan, or single, hissing word.";
        this.plural = true;
        this.pronoun1 = "they";
        this.pronoun2 = "them";
        this.pronoun3 = "their";
        this.createCock(15, 2);
        this.createCock(15, 2, CockTypesEnum.HUMAN);
        this.balls = 2;
        this.ballSize = 1;
        this.cumMultiplier = 3;
        this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_LOOSE);
        createBreastRow(0);
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = 78;
        this.hips.type = Hips.RATING_SLENDER;
        this.butt.type = Butt.RATING_TIGHT;
        this.bodyColor = "white";
        this.hairColor = "white";
        this.hairLength = 3;
        this.weaponName = "fists";
        this.weaponVerb = "punches";
        this.armorName = "translucent clothes";
        this.armorDef = 100;
        this.lust = 10;
        if (rand(2) == 0)
        {
            initStrTouSpeInte(132, 165, 198, 420);
            initWisLibSensCor(420, 1, 420, 0);
            this.weaponAttack = 86;
            this.armorMDef = 86;
            this.bonusHP = 750;
            this.bonusLust = 464;
            this.level = 43;
        }
        else
        {
            initStrTouSpeInte(126, 159, 189, 300);
            initWisLibSensCor(300, 1, 300, 0);
            this.weaponAttack = 72;
            this.armorMDef = 72;
            this.bonusHP = 500;
            this.bonusLust = 337;
            this.level = 36;
        }
        this.gems = 10 + rand(5);
        this.drop = NO_DROP;
        if (rand(2) == 0)
        {
            this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
        }
        else
        {
            this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
        }
        this.createPerk(PerkLib.EnemyGhostType, 0, 0, 0, 0);
        checkMonster();
    }
}



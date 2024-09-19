/**
 * ...
 * @author Ormael
 */
package classes.scenes.dungeons.hiddenCave;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.scenes.SceneLib;
import classes.internals.*;

class LoliBatGolem extends Monster
{
    public function clawstrike() : Void
    {
        outputText("The golem's visage twists into a grimace of irritation, and she thrust her hand at you in a vicious strike.");
        var damage : Float = as3hx.Compat.parseInt((str + spe + weaponAttack) - rand(player.tou) - player.armorDef);
        //Dodge
        if (damage <= 0 || (player.getEvasionRoll()))
        {
            outputText(" You slide underneath the surprise thrust!");
        }
        else
        {
            if (hasStatusEffect(StatusEffects.Provoke))
            {
                damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
            }
            outputText(" It strikes you in the chest. ");
            damage = player.takePhysDamage(damage, true);
        }
    }
    
    override private function performCombatAction() : Void
    {
        if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85)
        {
            var choice : Float = rand(2);
            if (choice == 0)
            {
                eAttack();
            }
            if (choice == 1)
            {
                clawstrike();
            }
        }
    }
    
    //	override public function defeated(hpVictory:Boolean):void
    //	{
    //		game.dungeons.hiddencave.cumWitchDefeated();
    //	}
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.dungeons.hiddencave.defeatedByLoliBatGolem();
    }
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "loli bat golem";
        this.imageName = "loli bat golem";
        this.long = "You're currently fighting loli bat golem. It's four feet tall bat that looks like twelves years old girl, her stone body is smooth and polished and she's using bare stone claws to fight. In the middle of her forehead there is a big tattoo consisting of letter A and number 2.";
        this.plural = false;
        this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        this.createStatusEffect(StatusEffects.BonusVCapacity, 100, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("A"));
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.createStatusEffect(StatusEffects.BonusACapacity, 100, 0, 0, 0);
        initStrTouSpeInte(30, 30, 50, 10);
        initWisLibSensCor(10, 10, 10, 0);
        this.hips.type = Hips.RATING_SLENDER + 1;
        this.butt.type = Butt.RATING_AVERAGE;
        this.bodyColor = "light grey";
        this.lustVuln = 0.01;
        this.tallness = 48;
        this.drop = new ChainedDrop().add(useables.GOLCORE, 1);
        this.level = 8;
        this.bonusHP = 100;
        this.weaponName = "stone claws";
        this.weaponVerb = "claw";
        this.weaponAttack = 20;
        this.armorName = "polished stone";
        this.armorDef = 26;
        this.armorMDef = 26;
        this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
        checkMonster();
    }
}



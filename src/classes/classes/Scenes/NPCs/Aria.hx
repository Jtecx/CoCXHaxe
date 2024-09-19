/**
 * ...
 * @author Liadri
 */
package classes.scenes.nPCs;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;
import classes.internals.*;

class Aria extends Monster
{
    
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.ariaScene.MelkieEncounterWon();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.ariaScene.MelkieEncounterLost();
    }
    override private function get_long() : String
    {
        var str : String = "";  /*
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) {
				if (hasStatusEffect(StatusEffects.Flying)) str += "Etna is circling you in the air readying a salvo of spike to throw at you.";
				else str += "You are fighting Aria. She could be compared to a mermaid if not for the fact she's closer to a deadly leopard seal than a fish both in appearance and temper.";
			}
			else {
				if (hasStatusEffect(StatusEffects.Flying)) str += "The manticore is circling you in the air readying a salvo of spike to throw at you.";
				else */  str += "You are fighting a Melkie. She could be compared to a mermaid if not for the fact she's closer to a deadly leopard seal than a fish both in appearance and temper.";
        //}
        return str;
    }
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "Melkie huntress";
        this.long = "";
        //if (flags[kFLAGS.CEANI_LVL_UP] == 5) {
        //this.level = 74;
        //initStrTouSpeInte(340, 360, 260, 210);
        //initWisLibSensCor(210, 210, 80, 0);
        this.level = 37;
        initStrTouSpeInte(170, 180, 130, 105);
        initWisLibSensCor(105, 105, 40, 0);
        this.weaponAttack = 56;
        this.armorDef = 15;
        this.armorMDef = 15;
        //}
        createVagina(true, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_TIGHT);
        this.createStatusEffect(StatusEffects.BonusVCapacity, 60, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("C"));
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.createStatusEffect(StatusEffects.BonusACapacity, 20, 0, 0, 0);
        this.tallness = 132;
        this.hips.type = Hips.RATING_CURVY + 2;
        this.butt.type = Butt.RATING_LARGE + 1;
        this.bodyColor = "black with a white underside";
        this.hairColor = "blond";
        this.hairLength = 13;
        this.weaponName = "harpoon";
        this.weaponVerb = "piercing stab";
        this.armorName = "blue bikini";
        this.bonusHP = 200;
        this.bonusLust = 182;
        this.lust = 30;
        this.lustVuln = .8;
        this.gems = 50;
        this.drop = new ChainedDrop().add(consumables.SKELP__, 0.7);
        //this.rearBody.type = RearBody.ORCA_BLOWHOLE;
        //this.arms.type = Arms.ORCA;
        //this.lowerBody = LowerBody.ORCA;
        //this.tailType = Tail.ORCA;
        //this.tailRecharge = 0;
        this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
        checkMonster();
    }
}


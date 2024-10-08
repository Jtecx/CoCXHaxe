package classes.scenes.places.trollVillage;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.scenes.SceneLib;

class YenzaEnemy extends Monster
{
    public var YenzaCombat : Yenza = SceneLib.trollVillage.yenza;
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.combat.cleanupAfterCombatImpl(SceneLib.zenjiScene.ZenjiMarriageSceneCinco);
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {  //Regen player health and drop lust here  
        
    }
    
    public function new()
    {
        super();  //Yes, she's supposed to be as squishy as old fruit.  
        this.a = "";
        this.short = "Yenza";
        this.long = "";
        createVagina(true, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        createBreastRow(Appearance.breastCupInverse("D"));
        this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = 84;
        this.hips.type = Hips.RATING_FERTILE;
        this.butt.type = Butt.RATING_NOTICEABLE;
        this.bodyColor = "light";
        this.hairColor = "green";
        this.hairLength = 13;
        this.weaponName = "fists";
        this.weaponVerb = "punch";
        this.armorName = "clothes";
        this.armorDef = 1;
        this.armorMDef = 1;
        initStrTouSpeInte(1, 1, 1, 1);
        initWisLibSensCor(1, 1, 1, 1);
        this.HP = 1;
        this.level = 1;
        this.lust = 0;
        this.gems = 100;
    }
}


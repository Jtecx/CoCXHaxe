/**
 * ...
 * @author Liadri
 */
package classes.scenes.monsters;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Face;
import classes.bodyParts.Hips;
import classes.bodyParts.LowerBody;
import classes.scenes.areas.desert.AnubisScene;
import classes.scenes.SceneLib;
import classes.stats.Buff;
import classes.internals.*;

//import classes.BodyParts.Skin;
class Wereshark extends Monster
{
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.weresharkScene.wonWithWereshark();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.weresharkScene.lostToWereshark();
    }
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "wereshark";
        this.imageName = "sharkgirl";
        this.long = "You are fighting a male wereshark. (because there is no male sprite just pretend that this sharkgirl is sharkboy okay?)";
        // this.plural = false;
        this.createCock(20, 2.5);
        this.balls = 2;
        this.ballSize = 4;
        this.cumMultiplier = 6;
        this.hoursSinceCum = 400;
        createBreastRow();
        this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = 6 * 12 + 2;
        this.hips.type = Hips.RATING_SLENDER;
        this.butt.type = Butt.RATING_TIGHT;
        this.lowerBody = LowerBody.WERESHARK;
        this.bodyColor = "gray";
        this.hairColor = "silver";
        this.hairLength = 10;
        initStrTouSpeInte(295, 210, 210, 111);
        initWisLibSensCor(111, 104, 35, 70);
        this.weaponName = "shark teeth";
        this.weaponVerb = "bite";
        this.weaponAttack = 37;
        this.armorName = "tough skin";
        this.armorDef = 31;
        this.armorMDef = 10;
        this.bonusHP = 500;
        this.bonusLust = 206;
        this.lust = 30;
        this.level = 67;
        this.gems = rand(26) + 130;
        this.drop = new WeightedDrop().add(consumables.L_DRAFT, 3).add(consumables.SHARK_T, 5).add(null, 1);
        this.faceType = Face.SHARK_TEETH;
        checkMonster();
    }
}


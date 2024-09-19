package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.lists.Gender;

class JabberwockyRace extends Race
{
    public static var JabberwockyScaleColors : Array<Dynamic> = ["magenta", "pink"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Human", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Human", 
        /*Eyes*/"Human", 
        /*Face*/"Human", 
        /*Gills*/"Human", 
        /*Hair*/"Human", 
        /*Horns*/"Human", 
        /*LowerBody*/"Human", 
        /*RearBody*/"Human", 
        /*Skin*/"Human", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Human", 
        /*Wings*/"Human", 
        /*Penis*/"Human", 
        /*Vagina*/"Human", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Jabberwocky", id, []);  //RaceBody);  
        mutationThreshold = 6;
    }
    
    override public function setup() : Void
    {
        addScores().faceType(ANY(Face.JABBERWOCKY, Face.BUCKTOOTH), +1, -1000).faceType(NONE(Face.DRAGON, Face.DRAGON_FANGS, Face.CAT, Face.CAT_CANINES), 0, -10).eyeType(Eyes.DRACONIC, +1).eyeType(cast((Eyes.CAT), NOT), 0, -10).eyeColor("red", +1).hairColor1("purplish-pink", +1).scaleColor1(cast((JabberwockyScaleColors), ANY), +1).skinCoatType(Skin.DRAGON_SCALES, +1).skinColor1("caramel", +1).hornType(Horns.JABBERWOCKY, +2).earType(Ears.BUNNY, +1).tailType(Tail.DRACONIC, +1).tongueType(Tongue.DRACONIC, +1).antennaeType(Antennae.JABBERWOCKY, +1).wingType(Wings.JABBERWOCKY, +4, -1000).legType(LowerBody.JABBERWOCKY, +1).legType(NONE(LowerBody.FROSTWYRM, LowerBody.FEY_DRAGON, LowerBody.LION), 0, -1000).armType(Arms.JABBERWOCKY, +1).armType(NONE(Arms.DRACONIC, Arms.FEY_DRACONIC, Arms.LION), 0, -10).hasCockOfType(CockTypesEnum.DRAGON, +1).gender(Gender.GENDER_FEMALE, +1);
        addScoresAfter(5).hasPerk(PerkLib.DragonLustPoisonBreath, +1).hasPerk(PerkLib.Insanity, +1);
        addScoresAfter(10).height(cast((120), GREATER_THAN), +1).hasPerk(PerkLib.Dracoforce, +1);
        
        addBloodline(PerkLib.DragonsDescendant, PerkLib.BloodlineDragon);
        addMutation(IMutationsLib.DrakeBloodIM);
        addMutation(IMutationsLib.DrakeBonesIM);
        addMutation(IMutationsLib.DrakeHeartIM);
        addMutation(IMutationsLib.DrakeLungsIM);
        addMutation(IMutationsLib.MightyLegsIM);
        
        buildTier(10, "lesser jabberwocky").namesTauric("lesser jabberwocky", "lesser jabberwocky-taur").buffs({
                            str.mult : +0.50,
                            tou.mult : +0.40,
                            spe.mult : +0.50,
                            int.mult : +0.20,
                            wis.mult : -0.20,
                            lib.mult : +0.10
                        }).end();
        
        buildTier(20, "jabberwocky").namesTauric("jabberwocky", "jabberwocky-taur").buffs({
                            str.mult : +0.90,
                            tou.mult : +0.70,
                            spe.mult : +0.80,
                            int.mult : +0.30,
                            wis.mult : -0.30,
                            lib.mult : +0.60
                        }).end();
        
        buildTier(25, "greater jabberwocky").namesTauric("greater jabberwocky", "greater jabberwocky-taur").buffs({
                            str.mult : +1.05,
                            tou.mult : +0.80,
                            spe.mult : +0.90,
                            int.mult : +0.40,
                            wis.mult : -0.40,
                            lib.mult : +1.00
                        }).end();
        
        buildTier(30, "primal jabberwocky").namesTauric("primal jabberwocky", "primal jabberwocky-taur").buffs({
                            str.mult : +1.25,
                            tou.mult : +0.95,
                            spe.mult : +1.00,
                            int.mult : +0.40,
                            wis.mult : -0.50,
                            lib.mult : +1.40
                        }).end();
    }
}


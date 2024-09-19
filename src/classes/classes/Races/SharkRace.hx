package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.lists.Gender;

class SharkRace extends Race
{
    public static var SharkScaleColors : Array<Dynamic> = ["rough gray", "orange", "dark gray", "iridescent gray", "ashen grayish-blue", "gray"];
    public static var SharkHairColors : Array<Dynamic> = ["silver"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Shark", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Shark", 
        /*Eyes*/"Human", 
        /*Face*/"Shark", 
        /*Gills*/"Fish", 
        /*Hair*/"Shark", 
        /*Horns*/"Human", 
        /*LowerBody*/"Shark", 
        /*RearBody*/"Shark", 
        /*Skin*/"Shark", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Shark", 
        /*Tongue*/"Human", 
        /*Wings*/"Human", 
        /*Penis*/"Human", 
        /*Vagina*/"Shark", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Shark", id, RaceBody);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.SHARK_TEETH, 1).gillType(Gills.FISH, +1).earType(Ears.SHARK, +1).rearType(RearBody.SHARK_FIN, +1).rearType(cast((RearBody.ABYSSAL_SHARK_FIN), NOT), 0, -1).armType(Arms.SHARK, +1).legType(LowerBody.SHARK, +1).legType(cast((LowerBody.ABYSSAL_SHARK), NOT), 0, -1).tailType(Tail.SHARK, +1).hairTypeAndColor1(Hair.NORMAL, cast((SharkHairColors), ANY), +1).skinCoatType(ANY(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES), +1).scaleColor1(cast((SharkScaleColors), ANY), +1).skinCoatPattern(Skin.PATTERN_TIGER_STRIPES, +1).eyeType(Eyes.HUMAN, +1).eyeType(cast((Eyes.DEVIL), NOT), 0, -1).eyeType(cast((Eyes.FERAL), NOT), 0, -11).tongueType(Tongue.HUMAN, +1).gender(Gender.GENDER_HERM, +1).vaginaType(VaginaClass.SHARK, +1).wingType(cast((Wings.FEATHERED_LARGE), NOT), 0, -1000);
        
        addMutation(IMutationsLib.SharkOlfactorySystemIM);
        
        buildTier(10, "shark-morph").namesTauric("shark-morph", "shark-taur").buffs({
                            str.mult : +0.50,
                            spe.mult : +0.90,
                            lib.mult : +0.10
                        }).end();
        
        buildTier(12, "tigershark-morph").namesTauric("tigershark-morph", "tigershark-taur").require("hermaprhodite", function(body : BodyData) : Bool
                                        {
                                            return body.gender == Gender.GENDER_HERM;
                                        }).require("tiger stripes", function(body : BodyData) : Bool
                                {
                                    return body.skinCoatPattern == Skin.PATTERN_TIGER_STRIPES;
                                }).buffs({
                            str.mult : +0.70,
                            spe.mult : +1.00,
                            lib.mult : +0.30,
                            maxlust_base : +50
                        }).end();
        
        buildTier(18, "elder tigershark-morph").namesTauric("elder tigershark-morph", "elder tigershark-taur").require("hermaprhodite", function(body : BodyData) : Bool
                                        {
                                            return body.gender == Gender.GENDER_HERM;
                                        }).require("tiger stripes", function(body : BodyData) : Bool
                                {
                                    return body.skinCoatPattern == Skin.PATTERN_TIGER_STRIPES;
                                }).buffs({
                            str.mult : +0.90,
                            spe.mult : +1.30,
                            lib.mult : +0.50,
                            maxlust_base : +200
                        }).end();
    }
}

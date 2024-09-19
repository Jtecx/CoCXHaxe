package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.CoC;
import classes.geneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

//import classes.VaginaClass;
class AnubisRace extends Race
{
    public static var AnubisEyeColors : Array<Dynamic> = ["red", "green"];
    public static var AnubisHairColors : Array<Dynamic> = ["brown", "black", "bluish black"];
    public static var AnubisFurColors : Array<Dynamic> = ["brown", "black", "bluish black"];
    public static var AnubisSkinColors : Array<Dynamic> = ["dark", "tan", "olive"];
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
        super("Anubis", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.JACKAL, +1).skinPlainOnly(+1).eyeType(Eyes.HUMAN, +1).eyeColor(cast((AnubisEyeColors), ANY), +1).faceType(ANY(Face.DOG, Face.ANIMAL_TOOTHS), +1).tongueType(Tongue.DOG, +1).armType(Arms.CANINE, +1).legType(LowerBody.DOG, +1).tailType(Tail.DOG, +1).wingType(Wings.NONE, +4).skinBasePattern(Skin.PATTERN_GLYPH_TATTOO, +1).furColor01(cast((AnubisFurColors), ANY), +1).hairColor1(cast((AnubisHairColors), ANY), +1).cockOrVaginaOfType(CockTypesEnum.DOG, VaginaClass.HUMAN, +1).skinColor1(cast((AnubisSkinColors), ANY), +1).corruption(cast((50), AT_LEAST), +1).hasPerk(PerkLib.MummyLord, +1);
        
        addMutation(IMutationsLib.AnubiHeartIM);
        addMutation(IMutationsLib.AlphaHowlIM);
        
        buildTier(20, "anubi").buffs({
                            tou.mult : +1.00,
                            wis.mult : +1.50,
                            lib.mult : +0.50
                        }).end();
        buildTier(28, "anubi high priest/ess").namesMaleFemale("anubi high priest", "anubi high priestess").buffs({
                            tou.mult : +1.00,
                            wis.mult : +2.00,
                            lib.mult : +1.20
                        }).end();
    }
}


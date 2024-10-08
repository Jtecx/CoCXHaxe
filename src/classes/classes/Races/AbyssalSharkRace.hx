package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class AbyssalSharkRace extends Race
{
    public static var AbyssalSharkScaleColors : Array<Dynamic> = ["rough gray", "dark gray", "iridescent gray", "ashen", "gray", "black"];
    public static var AbyssalSharkHairColors : Array<Dynamic> = ["silver", "purplish black", "dark purple", "iridescent"];
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
        super("Abyssal Shark", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().gillType(Gills.FISH, +1).earType(Ears.SHARK, +1).eyeType(Eyes.HUMAN, +1).eyeType(Eyes.DEVIL, +2).faceType(Face.SHARK_TEETH, +1).faceType(Face.ABYSSAL_SHARK, +2).hairType(Hair.NORMAL, +1).tongueType(Tongue.HUMAN, +1).tailType(Tail.SHARK, +1).tailType(Tail.ABYSSAL_SHARK, +2).armType(Arms.SHARK, +1).armType(Arms.ABYSSAL_SHARK, +2).legType(LowerBody.SHARK, +1).legType(LowerBody.ABYSSAL_SHARK, +2).rearType(RearBody.SHARK_FIN, +1).rearType(RearBody.ABYSSAL_SHARK_FIN, +2).skinBasePattern(Skin.PATTERN_BIOLUMINESCENCE, +1).hairColor1(cast((AbyssalSharkHairColors), ANY), +1).skinCoatType(ANY(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES), +1).skinColor1(cast((AbyssalSharkScaleColors), ANY), +1).cockOrVaginaOfType(CockTypesEnum.HUMAN, VaginaClass.SHARK, +1).height(cast((108), AT_LEAST), +1).customRequirement("", "H-cup tits (or bigger) or 18\"+ long cock", 
                        function(body : BodyData) : Bool
                        {
                            return body.biggestTitSize > 18 || body.biggestCockSize > 17;
                        }, +1
            ).hasPerk(PerkLib.DantianPhylactery, +1, -10);  //23+1  
        
        addMutation(IMutationsLib.SharkOlfactorySystemIM);
        
        buildTier(10, "abyssal shark-morph").requirePerk(PerkLib.DantianPhylactery).buffs({
                                    str.mult : +0.90,
                                    spe.mult : +0.90,
                                    wis.mult : +0.40,
                                    lib.mult : -0.20,
                                    sens : +50
                                }).withExtraBonuses("+150 Max Hunger").end();
        
        buildTier(18, "elder abyssal shark-morph").requirePreviousTier().buffs({
                                    str.mult : +1.90,
                                    spe.mult : +1.20,
                                    wis.mult : +0.80,
                                    lib.mult : -0.20,
                                    sens : +100
                                }).withExtraBonuses("+300 Max Hunger").end();
        
        buildTier(26, "ancient abyssal shark-morph").requirePreviousTier().buffs({
                                    str.mult : +2.90,
                                    spe.mult : +1.50,
                                    wis.mult : +1.20,
                                    lib.mult : -0.20,
                                    sens : +150
                                }).withExtraBonuses("+450 Max Hunger").end();
    }
}


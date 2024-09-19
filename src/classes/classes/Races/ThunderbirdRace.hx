package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class ThunderbirdRace extends Race
{
    public static var ThunderbirdHairColors : Array<Dynamic> = ["purple", "light blue", "yellow", "white", "emerald", "turquoise"];
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
        super("Thunderbird", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.ELFIN, +1).eyeType(Eyes.RAIJU, +1).faceType(ANY(Face.HUMAN, Face.WEASEL), +1).armType(Arms.HARPY, +1).wingType(Wings.FEATHERED_LARGE, +4).legType(LowerBody.HARPY, +1).tailType(Tail.THUNDERBIRD, +1, -1000).tailType(cast((Tail.KIRIN), NOT), 0, -1000).tailType(cast((Tail.RAIJU), NOT), 0, -1000).rearType(RearBody.RAIJU_MANE, +1).skinBasePattern(Skin.PATTERN_LIGHTNING_SHAPED_TATTOO, +1).hairType(Hair.STORM, +1, -1000).hairColor1(cast((ThunderbirdHairColors), ANY), +1).hasPerk(PerkLib.HarpyWomb, +2);
        
        addMutation(IMutationsLib.HeartOfTheStormIM);
        addMutation(IMutationsLib.HarpyHollowBonesIM);
        
        buildTier(16, "thunderbird").requireWingType(Wings.FEATHERED_LARGE).buffs({
                            tou.mult : -0.20,
                            spe.mult : +1.20,
                            lib.mult : +1.40
                        }).end();
        
        buildTier(21, "greater thunderbird").requirePreviousTier().buffs({
                            tou.mult : -0.25,
                            spe.mult : +1.55,
                            lib.mult : +1.85
                        }).end();
    }
}


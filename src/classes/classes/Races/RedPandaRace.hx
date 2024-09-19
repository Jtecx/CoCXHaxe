package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.PerkLib;
import classes.Race;

class RedPandaRace extends Race
{
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
    
    public static var RedPandaHairColors : Array<Dynamic> = ["white", "auburn", "red", "russet"];
    
    public function new(id : Int)
    {
        super("Red Panda", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.RED_PANDA, +2).earType(Ears.RED_PANDA, +1).tailType(Tail.RED_PANDA, +1).armType(Arms.RED_PANDA, +1).legType(LowerBody.RED_PANDA, +1).hairColor1(cast((RedPandaHairColors), ANY), +1).skinCoatPattern(Skin.PATTERN_RED_PANDA_UNDERBODY, +1).customRequirement("", "russet & black fur", 
                                function(body : BodyData) : Bool
                                {
                                    return body.player.furColor1 == "russet" && body.player.furColor2 == "black";
                                }, +1
                ).skinCoatType(Skin.FUR, +1).height(cast((72), GREATER_THAN), +2);
        
        buildTier(10, "red panda").namesMaleFemaleMorphTaur("red-panda-boy", "red-panda-girl", 
                                "red-panda-morph", "red-panda-taur"
                ).buffs({
                            str.mult : +0.20,
                            spe.mult : +0.80,
                            wis.mult : +0.50
                        }).end();
    }
}


package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.Race;

class BearRace extends Race
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
    
    public static var BearFurColors : Array<Dynamic> = ["black", "brown", "white"];
    
    public function new(id : Int)
    {
        super("Bear", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(ANY(Face.BEAR, Face.PANDA), +2).earType(ANY(Ears.BEAR, Ears.PANDA), +1).tailType(Tail.BEAR, +1).armType(Arms.BEAR, +1).legType(LowerBody.BEAR, +1).eyeType(Eyes.BEAR, +1).skinCoatType(Skin.FUR, +1).furColor1(cast((BearFurColors), ANY), +1).furColors("white and black", +1).height(cast((72), GREATER_THAN), +2);
        
        buildTier(10, "bear").customNamingFunction(function(body : BodyData) : String
                                {
                                    return ((body.faceType == Face.PANDA || body.earType == Ears.PANDA)) ? "panda-morph" : "bear-morph";
                                }).buffs({
                            str.mult : +1.00,
                            tou.mult : +0.80,
                            int.mult : -0.20
                        }).end();
    }
}


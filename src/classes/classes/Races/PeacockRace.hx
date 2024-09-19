package classes.races;

import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.CockTypesEnum;
import classes.Race;

class PeacockRace extends Race
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
    
    public function new(id : Int)
    {
        super("Peafowl", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    //longer very colorful looking tail using feather color 1 & 2
    {
        addScores().hairType(Hair.PEAFOWL, +1).hairType(cast((Hair.FEATHER), NOT), 0, -5).faceType(Face.AVIAN, +1).earType(Ears.AVIAN, +1).eyeType(Eyes.GRYPHON, +1).tailType(Tail.AVIAN, +1).armType(Arms.AVIAN, +1).legType(LowerBody.AVIAN, +1).wingType(Wings.FEATHERED_AVIAN, +2).skinCoatType(Skin.FEATHER, +1).hasCockOfType(CockTypesEnum.AVIAN, +1)  //.tailType(NOT(Tail.FEATHERED_AVIAN), 0, -6)    //bit smaller wings but still capabgle of flight with more colorfull look - using feather color 1 & 2 probably    //.tailType(NOT(Tail.AVIAN), 0, -5)  ;
        
        addMutation(IMutationsLib.HarpyHollowBonesIM);
        
        buildTier(9, "peafowl-morph").buffs({
                            str.mult : -0.10,
                            spe.mult : +0.60,
                            wis.mult : +0.50,
                            lib.mult : +0.35
                        }).end();
    }
}


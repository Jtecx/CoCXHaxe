package classes.races;

import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

class EchidnaRace extends Race
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
        super("Echidna", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
        disabled = true;
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.ECHIDNA, +1).tailType(Tail.ECHIDNA, +1).faceType(Face.ECHIDNA, +1).tongueType(Tongue.ECHIDNA, +1).legType(LowerBody.ECHIDNA, +1).skinCoatType(Skin.FUR, +1).hasCockOfType(CockTypesEnum.ECHIDNA, +1);
        
        buildTier(4, "echidna").namesMaleFemaleMorphTaur("echidna-boy", 
                        "echidna-girl", "echidna", "echidna"
            ).end();
    }
}


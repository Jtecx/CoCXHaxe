package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class FerretRace extends Race
{
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Elf", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Elven", 
        /*Eyes*/"Elf", 
        /*Face*/"Elf", 
        /*Gills*/"None", 
        /*Hair*/"Elf", 
        /*Horns*/"Human", 
        /*LowerBody*/"Elf", 
        /*RearBody*/"Human", 
        /*Skin*/"Elf", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Elf", 
        /*Wings*/"Human", 
        /*Penis*/"Human", 
        /*Vagina*/"Human", 
        /*Perks*/"Elf"
    ];
    
    public function new(id : Int)
    {
        super("Ferret", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.FERRET_MASK, +1).faceType(Face.FERRET, +2).earType(Ears.FERRET, +1).eyeType(Eyes.WEASEL, +2).eyeColor("golden", +1).tailType(Tail.FERRET, +1).legType(LowerBody.FERRET, +1).skinCoatType(Skin.FUR, +2);
        
        buildTier(6, "ferret-morph").namesMaleFemaleMorph("ferret-boy", "ferret-girl", "ferret-morph").buffs({
                            str.mult : -0.10,
                            spe.mult : +0.50,
                            int.mult : +0.30,
                            wis.mult : +0.50,
                            sens : +20
                        }).end();
    }
}


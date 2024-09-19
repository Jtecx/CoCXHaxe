package classes.races;

import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.Race;
import classes.VaginaClass;

class DeerRace extends Race
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
        super("Deer", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.DEER, +1).tailType(Tail.DEER, +1).faceType(Face.DEER, +1).armType(Arms.DEER, +1).armType(Arms.REINDEER, +2).armType(cast((Arms.WENDIGO), NOT), 0, -5).legType(LowerBody.CLOVEN_HOOFED, +1).legType(LowerBody.CLOVEN_HOOFED_2, +2).legType(cast((LowerBody.WENDIGO), NOT), 0, -5).hornTypeAndCount(Horns.ANTLERS, cast((4), AT_LEAST), +1).hornTypeAndCount(Horns.ANTLERS, cast((14), AT_LEAST), +1).hornTypeAndCount(Horns.ANTLERS, cast((24), AT_LEAST), +1).hornTypeAndCount(Horns.ANTLERS, cast((34), AT_LEAST), +1).skinCoatType(Skin.FUR, +1).cockOrVaginaOfType(CockTypesEnum.HORSE, VaginaClass.EQUINE, +1);
        
        buildTier(8, "deer").namesMaleFemaleMorphTaur("deer-morph", "deer-girl", "deer-morph", "deer-taur").buffs({
                            str.mult : +0.25,
                            tou.mult : +0.25,
                            spe.mult : +0.50,
                            int.mult : -0.20,
                            wis.mult : +0.40
                        }).end();
    }
}


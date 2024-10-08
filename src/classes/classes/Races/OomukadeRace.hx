package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class OomukadeRace extends Race
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
        super("Oomukade", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.ANIMAL_TOOTHS, +1).eyeType(Eyes.CENTIPEDE, +1).legType(LowerBody.CENTIPEDE, +4).skinPlainOnly(+1).armType(Arms.CENTIPEDE, +1).antennaeType(Antennae.CENTIPEDE, +1).rearType(RearBody.CENTIPEDE, +2).earType(Ears.ELFIN, +1).skinBasePattern(Skin.PATTERN_VENOMOUS_MARKINGS, +2).cockOrVaginaOfType(CockTypesEnum.OOMUKADE, VaginaClass.VENOM_DRIPPING, +2);
        
        addMutation(IMutationsLib.TrachealSystemIM);
        
        buildTier(8, "centipede").namesMaleFemale("centipede-man", "centipede-girl").buffs({
                            str.mult : +0.70,
                            tou.mult : +0.20,
                            spe.mult : +0.30
                        }).end();
        
        buildTier(13, "elder centipede").namesMaleFemale("elder centipede-man", "elder centipede-girl").buffs({
                            str.mult : +0.95,
                            tou.mult : +0.40,
                            spe.mult : +0.60
                        }).end();
        
        buildTier(18, "oomukade").buffs({
                            str.mult : +1.10,
                            tou.mult : +0.50,
                            spe.mult : +0.70,
                            wis.mult : -0.20,
                            lib.mult : +0.60
                        }).end();
    }
}


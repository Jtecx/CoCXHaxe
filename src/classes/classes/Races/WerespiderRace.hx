package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CoC;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class WerespiderRace extends Race
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
        super("Werespider", id, []);  //RaceBody);  
        disabled = true;
    }
    
    override public function setup() : Void
    //smth like taur but not so long lower body but more like two pairs of legs starting next to each other
    {
        addScores().eyeType(Eyes.WERESPIDER, +2).earType(Ears.INSECT, +1).faceType(Face.SPIDER_FANGS, +1).armType(Arms.ANT, +2).legType(LowerBody.CHITINOUS_SPIDER_LEGS, +1).tailType(Tail.SPIDER_ADBOMEN, +1).noWings(+4).hasPerk(PerkLib.AraneathropyDormant, +1).hasPerk(PerkLib.Araneathropy, +2, -11);
        
        //addMutation(IMutationsLib.AnanasaBirthrightIM);
        addMutation(IMutationsLib.HollowFangsIM);
        addMutation(IMutationsLib.VampiricBloodstreamIM);
        
        buildTier(12, "werespider").buffs({
                            str.mult : +0.70,
                            tou.mult : +0.70,
                            spe.mult : +0.70,
                            lib.mult : -0.30,
                            maxlust_mult : -0.2,
                            maxwrath_mult : -0.8
                        }).end();
    }
}


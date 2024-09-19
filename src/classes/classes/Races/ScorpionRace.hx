package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class ScorpionRace extends Race
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
        super("Scorpion", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
        disabled = true;
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.INSECT, +1).tailType(Tail.SCORPION, +1).skinCoatType(Skin.CHITIN, +1);
        
        addMutation(IMutationsLib.TrachealSystemIM);
        
        buildTier(4, "scorpion").namesTauric("scorpion-morph", "scorpion-taur").buffs({
                            str.mult : +0.00,
                            tou.mult : +0.00,
                            spe.mult : +0.00,
                            int.mult : +0.00,
                            wis.mult : +0.00,
                            lib.mult : +0.00,
                            sens : +0
                        }).end();
    }
}


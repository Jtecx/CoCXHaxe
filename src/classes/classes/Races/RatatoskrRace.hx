package classes.races;

import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class RatatoskrRace extends Race
{
    public static var RatatoskrHairColors : Array<Dynamic> = ["brown", "light brown", "caramel", "chocolate", "russet"];
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
        super("Ratatoskr", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.SQUIRREL, +1).eyeType(Eyes.RATATOSKR, +1).eyeColor(ANY("green", "light green", "emerald"), +1).faceType(ANY(Face.SMUG, Face.SQUIRREL), +1).armType(Arms.SQUIRREL, +1).tongueType(Tongue.RATATOSKR, +1).legType(LowerBody.SQUIRREL, +1).tailType(Tail.SQUIRREL, +1).noWings(+1).noRearBody(+1).hairType(Hair.RATATOSKR, +1).hairColor1(cast((RatatoskrHairColors), ANY), +1).skinCoatType(Skin.FUR, +1).furColor1(cast((RatatoskrHairColors), ANY), +1).height(cast((48), LESS_THAN), +1);
        
        addBloodline(PerkLib.RatatoskrsDescendant, PerkLib.BloodlineRatatoskr);
        addMutation(IMutationsLib.RatatoskrSmartsIM);
        
        buildTier(12, "squirrel").namesTauric("squirrel-morph", "squirrel-taur").buffs({
                            str.mult : -0.20,
                            spe.mult : +0.95,
                            int.mult : +1.05
                        }).end();
        
        buildTier(18, "ratatoskr").namesTauric("ratatoskr", "ratatoskr-taur").buffs({
                            str.mult : -0.25,
                            spe.mult : +1.40,
                            int.mult : +1.55
                        }).end();
    }
}


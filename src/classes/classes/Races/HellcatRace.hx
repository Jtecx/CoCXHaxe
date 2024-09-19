package classes.races;

import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class HellcatRace extends Race
{
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Human", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Snake", 
        /*Eyes*/"Gorgon", 
        /*Face*/"Snake", 
        /*Gills*/"None", 
        /*Hair*/"Gorgon", 
        /*Horns*/"Human", 
        /*LowerBody*/"Snake", 
        /*RearBody*/"Human", 
        /*Skin*/"Snake", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Snake", 
        /*Wings*/"Human", 
        /*Penis*/"Lizard", 
        /*Vagina*/"Lizard", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Hellcat", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(ANY(Face.CAT, Face.CAT_CANINES), +1).eyeType(Eyes.INFERNAL, +1, -1000).earType(Ears.CAT, +1).tongueType(Tongue.CAT, +1).hairType(Hair.BURNING, +1, -1000).tailType(ANY(Tail.BURNING, Tail.TWINKASHA), +1, -1000).tailTypeAndCount(Tail.TWINKASHA, 2, +2).armType(Arms.CAT, +1).legType(LowerBody.CAT, +1).skinCoatType(Skin.FUR, +1).furColor1("midnight black", +1).skinColor1("ashen", +1).hasPerk(PerkLib.Flexibility, +1).customRequirement("", "more hellcat features than other magical feline", 
                CatRace.isHellcatSubrace, 0, -1000
        );
        
        addMutation(IMutationsLib.CatLikeNimblenessIM);
        addMutation(IMutationsLib.EyeOfTheTigerIM);
        addMutation(IMutationsLib.BlazingHeartIM);
        
        buildTier(10, "hellcat").buffs({
                            spe.mult : +0.40,
                            int.mult : +0.85,
                            lib.mult : +0.50,
                            sens : +25
                        }).end();
        
        buildTier(17, "Kasha").buffs({
                            spe.mult : +0.70,
                            int.mult : +1.35,
                            lib.mult : +1.00,
                            sens : +50
                        }).end();
    }
}


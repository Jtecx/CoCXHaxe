package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class MelkieRace extends Race
{
    public static var MelkieSkinColors : Array<Dynamic> = ["light", "fair", "pale"];
    public static var MelkieFurColors : Array<Dynamic> = ["grey", "silver", "white", "glacial white", "light gray"];
    public static var MelkieHairColors : Array<Dynamic> = ["blonde", "platinum blonde"];
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
        super("Melkie", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().skinColor1(cast((MelkieSkinColors), ANY), +1).skinCoatType(Skin.FUR, +1).furColor1(cast((MelkieFurColors), ANY), +1).hairType(Hair.NORMAL, +1).hairColor1(cast((MelkieHairColors), ANY), +1).eyeType(Eyes.HUMAN, +1).eyeColor("blue", +1).faceType(Face.ANIMAL_TOOTHS, +1).earType(Ears.MELKIE, +1).tongueType(Tongue.MELKIE, +1).legType(LowerBody.MELKIE, +3, -1000).armType(Arms.MELKIE, +1).femininity(cast((80), GREATER_THAN), +1).hasVagina(+1).biggestTitSize(cast((3), GREATER_THAN), +1).height(cast((73), AT_LEAST), +1);
        
        addMutation(IMutationsLib.MelkieLungIM);
        addBloodline(PerkLib.MelkiesDescendant, PerkLib.BloodlineMelkie);
        
        buildTier(18, "melkie").buffs({
                            spe.mult : +1.20,
                            int.mult : +1.20,
                            lib.mult : +0.80,
                            sens : +50
                        }).end();
        
        buildTier(21, "elder melkie").buffs({
                            spe.mult : +1.40,
                            int.mult : +1.40,
                            lib.mult : +1.00,
                            sens : +65
                        }).end();
    }
}


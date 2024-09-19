package classes.races;

import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.Race;

class YukiOnnaRace extends Race
{
    public static var YukiOnnaSkinColors : Array<Dynamic> = ["snow white", "light blue", "glacial white"];
    public static var YukiOnnaHairColors : Array<Dynamic> = ["snow white", "silver white", "platinum blonde", "quartz white"];
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
        super("Yuki Onna", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().skinColor1(cast((YukiOnnaSkinColors), ANY), +1).skinBaseAdj("cold", +1).eyeColor("light purple", +1).hairColor1(cast((YukiOnnaHairColors), ANY), +1).hairType(Hair.SNOWY, +1).legType(LowerBody.YUKI_ONNA, +1).armType(Arms.YUKI_ONNA, +1).faceType(Face.YUKI_ONNA, +1).rearType(RearBody.GLACIAL_AURA, +1).wingType(Wings.LEVITATION, +3).femininity(100, +1).noCock(+1).hasVagina(+1);
        
        addMutation(IMutationsLib.FrozenHeartIM);
        
        buildTier(14, "Yuki Onna").buffs({
                            spe.mult : +0.70,
                            int.mult : +1.40,
                            wis.mult : +0.70,
                            lib.mult : +0.50
                        }).end();
    }
}


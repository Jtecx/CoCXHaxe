package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.internals.race.RaceUtils;

class FemaleMindbreakerRace extends Race
{
    public static var MindbreakerEyeColors : Array<Dynamic> = ["yellow", "orange", "light green"];
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
        super("Female Mind Breaker", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.HUMAN, +1).eyeType(Eyes.MINDBREAKER, +1).eyeColor(cast((MindbreakerEyeColors), ANY), +1).earType(Ears.HUMAN, +1).noTail(+1).rearType(RearBody.MINDBREAKER, +4).armType(Arms.MINDBREAKER, +1).legType(LowerBody.MINDBREAKER, +1).tongueType(Tongue.MINDBREAKER, +1).noWings(+3).vaginaType(VaginaClass.MINDBREAKER, +1).noCock(0, -1000).hairTypeAndColor1(Hair.MINDBREAKER, "purple", +1).skinPlainOnly(0, -1).skinColor1("light purple", +1).skinBaseAdj("slippery", +1).hasPerk(PerkLib.Insanity, +1).givePerkV1(PerkLib.MindbreakerBrain1toX);
        
        addMutation(IMutationsLib.MightyLowerHalfIM, +3);
        
        buildTier(20, "mindbreaker").buffs({
                            str.mult : -0.60,
                            spe.mult : -0.10,
                            tou.mult : +1.00,
                            int.mult : +5.50,
                            lib.mult : +4.00,
                            wis.mult : -0.30,
                            sens : +50
                        }).end();
    }
}


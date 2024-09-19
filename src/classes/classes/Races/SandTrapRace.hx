package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

class SandTrapRace extends Race
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
        super("Sand Trap", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().eyeType(Eyes.BLACK_EYES_SAND_TRAP, +1).wingType(Wings.GIANT_DRAGONFLY, +1).vaginaType(VaginaClass.BLACK_SAND_TRAP, +1).hasStatusEffect(StatusEffects.BlackNipples, "Black nipples", +1).hasStatusEffect(StatusEffects.Uniball, "Uniball", +2);
        
        buildTier(5, "sand trap").end();
    }
}


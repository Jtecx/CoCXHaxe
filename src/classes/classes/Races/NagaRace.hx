package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

class NagaRace extends Race
{
    public static var SnakeScaleColors : Array<Dynamic> = ["black", "midnight", "midnight black"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Human", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Snake", 
        /*Eyes*/"Snake", 
        /*Face*/"Snake", 
        /*Gills*/"None", 
        /*Hair*/"Human", 
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
        super("Naga", id, RaceBody);
    }
    
    override public function setup() : Void
    {
        addScores().isNaga(+3, -1000).tongueType(Tongue.SNAKE, +1).faceType(Face.SNAKE_FANGS, +1).armType(Arms.HUMAN, +1).skinCoatType(Skin.SCALES, +1).earType(Ears.SNAKE, +1).eyeType(Eyes.SNAKE, +1).cockOrVaginaOfType(CockTypesEnum.LIZARD, VaginaClass.NAGA, +1).customRequirement("", "not another snake-like race", 
                function(body : BodyData) : Bool
                {
                    return !(GorgonRace.isGorgonLike(body)
                    || CouatlRace.isCouatlLike(body)
                    || VouivreRace.isVouivreLike(body)
                    || HydraRace.isHydraLike(body));
                }, 0, -1000
        );
        
        addMutation(IMutationsLib.VenomGlandsIM);
        addMutation(IMutationsLib.MightyLowerHalfIM);
        
        buildTier(8, "naga").buffs({
                            str.mult : +0.40,
                            tou.mult : +0.20,
                            spe.mult : +0.60
                        }).end();
    }
}


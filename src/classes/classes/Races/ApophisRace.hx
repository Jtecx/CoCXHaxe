package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class ApophisRace extends Race
{
    public static var ApophisScaleColors : Array<Dynamic> = ["black", "midnight", "midnight black"];
    public static var ApophisHairColors : Array<Dynamic> = ["black", "midnight", "midnight black"];
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
        super("Apophis", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().isNaga(+3, -1000).armType(Arms.HUMAN, +1).hairColor1(cast((ApophisHairColors), ANY), +1).skinColor1("light purple", +1).skinCoatType(Skin.SCALES, +1).scaleColor1(cast((ApophisScaleColors), ANY), +1).tongueType(Tongue.SNAKE, +1).faceType(Face.SNAKE_FANGS, +1).eyeTypeAndColor(Eyes.SNAKEFIENDISH, "yellow", +2).earType(Ears.SNAKE, +1).rearType(RearBody.COBRA_HOOD, +2).noWings(+4).cockOrVaginaOfType(CockTypesEnum.LIZARD, VaginaClass.NAGA, +1).corruption(cast((40), AT_LEAST), +1).corruption(cast((60), AT_LEAST), +1).corruption(cast((80), AT_LEAST), +1).corruption(cast((100), AT_LEAST), +2).customRequirement("", "not another snake-like race", 
                        function(body : BodyData) : Bool
                        {
                            return !(GorgonRace.isGorgonLike(body)
                            || CouatlRace.isCouatlLike(body)
                            || HydraRace.isHydraLike(body)
                            || VouivreRace.isVouivreLike(body));
                        }, 0, -1000
            ).hasPerk(PerkLib.Venomancy, +1);
        
        addMutation(IMutationsLib.VenomGlandsIM);
        addMutation(IMutationsLib.MightyLowerHalfIM);
        
        buildTier(20, "apophis").buffs({
                            str.mult : +0.60,
                            tou.mult : +0.60,
                            spe.mult : +0.80,
                            lib.mult : +1.00
                        }).end();
        
        buildTier(26, "unhallowed apophis").buffs({
                            str.mult : +0.80,
                            tou.mult : +0.80,
                            spe.mult : +1.00,
                            lib.mult : +1.30
                        }).end();
    }
    
    public static function isApophisLike(body : BodyData) : Bool
    {
        return body.rearType == RearBody.COBRA_HOOD || body.eyeType == Eyes.SNAKEFIENDISH;
    }
}


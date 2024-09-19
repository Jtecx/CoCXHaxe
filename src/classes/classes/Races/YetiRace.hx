package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.Race;

class YetiRace extends Race
{
    public static var YetiSkinColors : Array<Dynamic> = ["dark", "tan"];
    public static var YetiEyeColors : Array<Dynamic> = ["siilver", "grey", "gray"];
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
        super("Yeti", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().skinColor1(cast((YetiSkinColors), ANY), +1).eyeColor(cast((YetiEyeColors), ANY), +1).legType(LowerBody.YETI, +1).armType(Arms.YETI, +1).rearType(RearBody.YETI_FUR, +1).eyeType(Eyes.HUMAN, +1).earType(Ears.YETI, +1).faceType(Face.YETI_FANGS, +1).hairType(Hair.FLUFFY, +1).hairColor1("white", +1).skinCoatType(Skin.FUR, +1).skinCoatTypeAndColor1(Skin.FUR, "white", +1).height(cast((78), AT_LEAST), +1).customRequirement("butt", "thicc butt", 
                function(body : BodyData) : Bool
                {
                    return body.player.butt.type >= 10;
                }, +1
        );
        
        addMutation(IMutationsLib.YetiFatIM);
        
        buildTier(14, "yeti").namesTauric("yeti", "yeti-taur").buffs({
                            str.mult : +1.00,
                            tou.mult : +0.80,
                            spe.mult : +0.50,
                            int.mult : -0.70,
                            lib.mult : +0.50
                        }).end();
        
        buildTier(17, "true yeti").namesTauric("true yeti", "true yeti-taur").buffs({
                            str.mult : +1.30,
                            tou.mult : +1.00,
                            spe.mult : +0.65,
                            int.mult : -0.90,
                            lib.mult : +0.50
                        }).end();
    }
}


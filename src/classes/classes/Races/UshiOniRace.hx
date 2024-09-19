package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.Race;
import classes.StatusEffects;

class UshiOniRace extends Race
{
    public static var UshiOniSkinColors : Array<Dynamic> = ["green", "red", "grey", "sandy-tan", "pale", "purple"];
    public static var UshiOniHairColors : Array<Dynamic> = ["dark green", "dark red", "blue", "brown", "white", "black"];
    public static var UshiOniEyeColors : Array<Dynamic> = ["black", "red", "gray", "brown", "light blue", "yellow"];
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
        super("Ushi-Onna", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.COW, +1).tailType(Tail.USHI_ONI, +1).faceType(Face.USHI_ONI, +1).hornType(Horns.USHI_ONI, +1).armType(Arms.USHI_ONI, +1).legType(LowerBody.USHI_ONI, +2).skinBasePattern(Skin.PATTERN_RED_PANDA_UNDERBODY, +2).hairTypeAndColor1(Hair.NORMAL, cast((UshiOniHairColors), ANY), +1);
        addConditionedScores(
                        function(body : BodyData) : Bool
                        {
                            return body.player.hasPlainSkinOnly();
                        }, 
                        "plain skin;"
            ).skinColor1(cast((UshiOniSkinColors), ANY), +1);
        
        buildTier(11, "ushi-oni").customNamingFunction(function(body : BodyData) : String
                                {
                                    var prefix : String = "";
                                    switch (body.player.statusEffectv1(StatusEffects.UshiOnnaVariant))
                                    {
                                        case 1:prefix = "fiery ";
                                        case 2:prefix = "frozen ";
                                        case 3:prefix = "sandy ";
                                        case 4:prefix = "pure ";
                                        case 5:prefix = "wicked ";
                                    }
                                    return prefix + body.mf("ushi-oni", "ushi-onna");
                                }).buffs({
                            str.mult : +0.80,
                            tou.mult : +0.70,
                            int.mult : -0.40,
                            wis.mult : -0.40,
                            lib.mult : +0.95
                        }).end();
    }
}


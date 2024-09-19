package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: Mouse
 * Tier 2: Hinezumi
 * Tier 3: Hinezumi
 */
class MouseRace extends Race
{
    public static var MouseHairColors : Array<Dynamic> = ["red", "orange", "pinkish orange", "platinum crimson"];
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
        super("Mouse", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.MOUSE, +1).tailType(ANY(Tail.MOUSE, Tail.HINEZUMI), +1).faceType(ANY(Face.BUCKTEETH, Face.MOUSE), +2).legType(ANY(LowerBody.MOUSE, LowerBody.HINEZUMI), +1).armType(Arms.HINEZUMI, +1).eyeTypeAndColor(Eyes.HINEZUMI, "blazing red", +1).hairType(Hair.BURNING, +1).hairColor1(cast((MouseHairColors), ANY), +1).skinCoatType(Skin.FUR, +1);
        addConditionedScores(function(body : BodyData) : Bool
                                {
                                    return body.skinCoatType == Skin.FUR;
                                }, "fur;").height(cast((60), LESS_THAN), +1).height(cast((52), LESS_THAN), +1);
        
        addMutation(IMutationsLib.HinezumiBurningBloodIM);
        addMutation(IMutationsLib.BlazingHeartIM);
        
        buildTier(8, "mouse-morph").namesMaleFemaleMorphTaur("mouse-boy", "mouse-girl", "mouse-morph", "mouse-taur").buffs({
                            tou.mult : -0.10,
                            spe.mult : +0.80,
                            wis.mult : +0.50
                        }).end();
        
        buildTier(12, "fire mouse").namesTauric("fire mouse", "fire mouse-taur").requireArmType(Arms.HINEZUMI).requireLegType(LowerBody.HINEZUMI).requireTailType(Tail.HINEZUMI).buffs({
                            str.mult : +0.60,
                            tou.mult : -0.10,
                            spe.mult : +0.80,
                            wis.mult : +0.50
                        }).end();
        
        buildTier(15, "hinezumi").namesTauric("hinezumi", "hinezumi-taur").requirePreviousTier().buffs({
                            str.mult : +0.75,
                            tou.mult : -0.10,
                            spe.mult : +0.80,
                            wis.mult : +0.80
                        }).end();
    }
}


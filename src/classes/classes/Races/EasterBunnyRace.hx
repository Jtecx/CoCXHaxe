package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class EasterBunnyRace extends Race
{
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Human", 
        /*Balls*/"Bunny", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Bunny", 
        /*Eyes*/"Human", 
        /*Face*/"Bunny", 
        /*Gills*/"Human", 
        /*Hair*/"Human", 
        /*Horns*/"Human", 
        /*LowerBody*/"Bunny", 
        /*RearBody*/"Human", 
        /*Skin*/"Fur", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Bunny", 
        /*Tongue*/"Human", 
        /*Wings*/"Human", 
        /*Penis*/"EasterBunny", 
        /*Vagina*/"Human", 
        /*Perks*/"EasterBunny"
    ];
    
    public function new(id : Int)
    {
        super("Easter Bunny", id, RaceBody);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(ANY(Face.BUNNY, Face.BUCKTEETH), +1).earType(Ears.BUNNY, +1, -10).legType(LowerBody.BUNNY, +1).skinCoatType(Skin.FUR, +1).tailType(Tail.RABBIT, +1).eyeType(Eyes.HUMAN, +1).armType(Arms.HUMAN, +1).noAntennae(+1).noWings(+1).height(cast((72), LESS_THAN), +1).hasCockOfType(CockTypesEnum.HUMAN, +1).customRequirement("", "No horse cock", 
                                function(body : BodyData) : Bool
                                {
                                    return body.player.horseCocks() < 1;
                                }, 0, -10
                ).customRequirement("", "No equine vagina", 
                        function(body : BodyData) : Bool
                        {
                            return !body.player.vaginaType() != VaginaClass.EQUINE;
                        }, 0, -10
            ).hasPerk(PerkLib.EasterBunnyBalls, +1);
        
        addMutation(IMutationsLib.EasterBunnyEggBagIM);
        addMutation(IMutationsLib.MightyLegsIM);
        
        buildTier(12, "easter bunny").namesMaleFemale("easter bunny-boy", "easter bunny-girl").requirePerk(PerkLib.EasterBunnyBalls).buffs({
                            str.mult : -0.20,
                            tou.mult : -0.10,
                            spe.mult : +0.90,
                            lib.mult : +1.20
                        }).end();
        
        buildTier(15, "true easter bunny").namesMaleFemale("true easter bunny-boy", "true easter bunny-girl").requirePreviousTier().buffs({
                            str.mult : -0.20,
                            tou.mult : -0.10,
                            spe.mult : +1.05,
                            lib.mult : +1.50
                        }).end();
        
        buildTier(20, "greater easter bunny").namesMaleFemale("greater easter bunny-boy", "greater easter bunny-girl").requirePreviousTier().buffs({
                            str.mult : -0.20,
                            tou.mult : -0.10,
                            spe.mult : +1.30,
                            lib.mult : +2.00
                        }).end();
    }
}


package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

class SpiderRace extends Race
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
        super("Spider", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().eyeType(Eyes.SPIDER, +1).earType(Ears.INSECT, +1).faceType(Face.SPIDER_FANGS, +1).armType(Arms.SPIDER, +1).legType(LowerBody.CHITINOUS_SPIDER_LEGS, +1).legType(LowerBody.DRIDER, +2).tailType(Tail.SPIDER_ADBOMEN, +1);
        addScoresAfter(4).earType(Ears.ELFIN, 1).skinCoatType(Skin.CHITIN, +1).hasStatusEffect(StatusEffects.BlackNipples, "black nipples", +1).hasPerk(PerkLib.SpiderOvipositor, +1);
        
        addMutation(IMutationsLib.VenomGlandsIM);
        addMutation(IMutationsLib.ArachnidBookLungIM);
        
        buildTier(10, "spider-morph").customNamingFunction(function(body : BodyData) : String
                                {
                                    if (body.isDrider)
                                    {
                                        return "drider";
                                    }
                                    return body.mf("spider-morph", "spider-girl");
                                }).buffs({
                            str.mult : +0.30,
                            tou.mult : +0.40,
                            spe.mult : +0.20,
                            int.mult : +0.60
                        }).end();
        
        buildTier(16, "elder spider-morph").customNamingFunction(function(body : BodyData) : String
                                {
                                    if (body.isDrider)
                                    {
                                        return "elder drider";
                                    }
                                    return body.mf("elder spider-morph", "elder spider-girl");
                                }).buffs({
                            str.mult : +0.60,
                            tou.mult : +0.70,
                            spe.mult : +0.50,
                            int.mult : +0.60
                        }).end();
    }
}


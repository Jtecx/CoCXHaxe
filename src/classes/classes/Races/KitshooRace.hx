package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class KitshooRace extends Race
{
    public static var KitshooHairColors : Array<Dynamic> = ["white", "black", "red", "orange"];
    public static var KitshooScaleColors : Array<Dynamic> = ["red", "blazing red", "orange", "reddish-orange"];
    public static var KitshooFurColors : Array<Dynamic> = ["red", "blazing red", "orange", "reddish-orange"];
    public static var KitshooSkinColors : Array<Dynamic> = ["tan", "olive", "light", "dark", "ebony", "ashen", "sable", "milky white"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Salamander", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Fox", 
        /*Eyes*/"Fox", 
        /*Face*/"Salamander", 
        /*Gills*/"Human", 
        /*Hair*/"Kitsumori", 
        /*Horns*/"Human", 
        /*LowerBody*/"Salamander", 
        /*RearBody*/"Human", 
        /*Skin*/"Kitsune", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Kitsumori", 
        /*Tongue*/"Human", 
        /*Wings*/"Human", 
        /*Penis*/"Human", 
        /*Vagina*/"Human", 
        /*Perks*/"Kitsune"
    ];
    
    public function new(id : Int)
    {
        super("Kitsumori", id, RaceBody);
        mutationThreshold = 6;
    }
    
    override public function setup() : Void
    {
        addScores().eyeType(Eyes.FOX, +1).earType(Ears.FOX, +1).customScoreRequirement("tail", "multiple cinder fox tails, +1 per tail", 
                                                                function(body : BodyData) : Bool
                                                                {
                                                                    return body.tailType == Tail.KITSHOO && body.tailCount >= 2;
                                                                }, 
                                                                function(body : BodyData) : Int
                                                                {
                                                                    return body.tailCount;
                                                                }, 
                                                                -7
                                ).faceType(Face.SALAMANDER_FANGS, +1).armType(Arms.SALAMANDER, +1).legType(LowerBody.SALAMANDER, +1).skinCoatType(cast((Skin.CHITIN), NOT), 0, -2).skinBaseType(cast((Skin.GOO), NOT), 0, -3).hasPerk(PerkLib.Lustzerker, +1);
        addScoresAfter(5).skinBaseType(Skin.PLAIN, +1, -1).skinBasePattern(Skin.PATTERN_MAGICAL_TATTOO, +1, -1).hairColor1(cast((KitshooHairColors), ANY), +1).hasPerk(PerkLib.StarSphereMastery, +1);
        
        addBloodline(PerkLib.SalamandersDescendant, PerkLib.BloodlineSalamander);
        addMutation(IMutationsLib.KitsuneParathyroidGlandsIM);
        addMutation(IMutationsLib.SalamanderAdrenalGlandsIM);
        
        buildTier(8, "kitsumori").namesTauric("kitsumori", "kitsumori-taur").buffs({
                                    tou.mult : +0.15,
                                    spe.mult : +0.15,
                                    int.mult : +0.40,
                                    wis.mult : +0.50,
                                    lib.mult : +0.50,
                                    sens : +50,
                                    maxlust_base : +20,
                                    maxsf_mult : +0.15
                                }).withExtraBonuses(
                        "+30% SF Regeneration"
            ).end();
        buildTier(16, "elder kitsumori").namesTauric("elder kitsumori", "elder kitsumori-taur").requirePreviousTier().requireTailType(Tail.KITSHOO).requireTailCount(cast((6), AT_LEAST)).buffs({
                                    str.mult : +0.10,
                                    tou.mult : +0.50,
                                    spe.mult : +0.40,
                                    int.mult : +0.70,
                                    wis.mult : +0.80,
                                    lib.mult : +0.90,
                                    sens : +100,
                                    maxlust_base : +40,
                                    maxsf_mult : +0.25
                                }).withExtraBonuses(
                        "+40% SF Regeneration"
            ).end();
        buildTier(24, "nine-tailed elder kitsumori").namesTauric("nine-tailed elder kitsumori", "nine-tailed elder kitsumori-taur").requirePreviousTier().requireTailCount(9).buffs({
                                    str.mult : +0.20,
                                    tou.mult : +0.80,
                                    spe.mult : +0.70,
                                    int.mult : +1.00,
                                    wis.mult : +1.10,
                                    lib.mult : +1.30,
                                    sens : +150,
                                    maxlust_base : +60,
                                    maxsf_mult : +0.35
                                }).withExtraBonuses(
                        "+50% SF Regeneration"
            ).end();
    }
}


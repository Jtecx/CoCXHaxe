package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.Race;
import classes.VaginaClass;

//import classes.PerkLib;
class ArigeanRace extends Race
{
    public static var ArigeanSkinColors : Array<Dynamic> = ["albino"];
    public static var ArigeanHairColors : Array<Dynamic> = ["snowy white", "white", "silver"];
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
        super("Arigean", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.ELVEN, +1).eyeType(Eyes.ARIGEAN, +1).eyeType(Eyes.ARIGEANPRINCESS, +2).faceType(Face.ARIGEAN, +1).tongueType(Tongue.ARIGEAN, +1).tailType(Tail.ARIGEAN_GREEN, +5).tailType(Tail.ARIGEAN_RED, +6).tailType(Tail.ARIGEAN_YELLOW, +7).tailType(Tail.ARIGEAN_PRINCESS, +9).armType(Arms.ARMORED_FOREARMS, +1).legType(LowerBody.ARMORED_LEGS, +1).rearType(RearBody.ARIGEAN_RED_AURA, +1).rearType(RearBody.ARIGEAN_YELLOW_AURA, +2).rearType(RearBody.ARIGEAN_PINCER_LIMBS, +3).hairColor1(cast((ArigeanHairColors), ANY), +1).skinBaseType(Skin.PLAIN, +1).plainSkinOfColor1(cast((ArigeanSkinColors), ANY), +1).cockOrVaginaOfType(CockTypesEnum.ARIGEAN, VaginaClass.ARIGEAN, +1).customRequirement("", "60+ feminity", 
                        function(body : BodyData) : Bool
                        {
                            return body.player.femininity >= 60;
                        }, +1
            ).corruption(cast((10), AT_LEAST), +1);
        
        addMutation(IMutationsLib.ArigeanAssociationCortexIM);
        
        buildTier(9, "half arigean").buffs({
                            str.mult : +0.55,
                            tou.mult : +0.40,
                            spe.mult : +0.55,
                            int.mult : -0.05,
                            wis.mult : -0.10,
                            def : +1
                        }).end();
        
        buildTier(16, "arigean").requireTailType(Tail.ARIGEAN_GREEN).buffs({
                            str.mult : +1.00,
                            tou.mult : +0.70,
                            spe.mult : +1.00,
                            int.mult : -0.10,
                            wis.mult : -0.20,
                            def : +3
                        }).end();
        
        buildTier(18, "arigean elite").requireTailType(Tail.ARIGEAN_RED).buffs({
                            str.mult : +1.30,
                            tou.mult : +0.80,
                            spe.mult : +1.30,
                            int.mult : -0.30,
                            wis.mult : -0.40,
                            def : +4
                        }).end();
        
        buildTier(20, "arigean countess").requireTailType(Tail.ARIGEAN_YELLOW).buffs({
                            str.mult : +1.50,
                            tou.mult : +1.00,
                            spe.mult : +1.50,
                            int.mult : -0.45,
                            wis.mult : -0.55,
                            def : +6
                        }).end();
        
        buildTier(23, "arigean princess").requireTailType(Tail.ARIGEAN_PRINCESS).buffs({
                            str.mult : +4.30,
                            tou.mult : +3.10,
                            spe.mult : +4.30,
                            int.mult : -0.75,
                            wis.mult : -0.60,
                            def : +10
                        }).end();
    }
}


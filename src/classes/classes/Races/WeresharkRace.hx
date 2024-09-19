package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.internals.race.RaceUtils;

class WeresharkRace extends Race
{
    public static var WeresharkScaleColors : Array<Dynamic> = ["rough gray", "dark gray", "iridescent gray", "ashen grayish-blue", "gray"];
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
        super("Wereshark", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.SHARK_TEETH, 1).eyeType(Eyes.FERAL, +2).gillType(Gills.FISH, +1).earType(Ears.SHARK, +1).tongueType(Tongue.HUMAN, +1).rearType(RearBody.SHARK_FIN, +1).armType(Arms.SHARK, +1).legType(LowerBody.WERESHARK, +3, -1000).hairTypeAndColor1(Hair.NORMAL, "silver", +2).skinCoatType(ANY(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES), +1).scaleColor1(cast((WeresharkScaleColors), ANY), +1).cockOrVaginaOfType(CockTypesEnum.HUMAN, VaginaClass.SHARK, +1).noWings(+4).corruption(cast((20), AT_LEAST), +1).corruption(cast((50), AT_LEAST), +1).corruption(cast((80), AT_LEAST), +1).hasPerk(PerkLib.SelachimorphanthropyDormant, +1).hasPerk(PerkLib.Selachimorphanthropy, +2, -11);
        
        addBloodline(PerkLib.WeresharksDescendant, PerkLib.BloodlineWereshark);
        addMutation(IMutationsLib.FerasBirthrightIM);
        addMutation(IMutationsLib.SharkOlfactorySystemIM);
        
        buildTier(12, "wereshark").require("Selachimorphanthropy or Dormant Selachimorphanthropy perk", 
                                RaceUtils.hasAnyPerkFn([PerkLib.Selachimorphanthropy, PerkLib.SelachimorphanthropyDormant])
                ).buffs({
                            str.mult : +0.90,
                            tou.mult : +0.50,
                            spe.mult : +0.50,
                            int.mult : -0.10
                        }).end();
        buildTier(18, "elder wereshark").requirePreviousTier().buffs({
                            str.mult : +1.40,
                            tou.mult : +0.70,
                            spe.mult : +0.70,
                            int.mult : -0.10
                        }).end();
        buildTier(24, "ancient wereshark").requirePreviousTier().buffs({
                            str.mult : +1.90,
                            tou.mult : +0.90,
                            spe.mult : +0.90,
                            int.mult : -0.10
                        }).end();
    }
}


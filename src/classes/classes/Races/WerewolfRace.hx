package classes.races;

import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.internals.race.RaceUtils;

class WerewolfRace extends Race
{
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Wolf", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Wolf", 
        /*Eyes*/"Feral", 
        /*Face*/"WolfFangs", 
        /*Gills*/"Human", 
        /*Hair*/"Wolf", 
        /*Horns*/"Human", 
        /*LowerBody*/"Wolf", 
        /*RearBody*/"Wolf", 
        /*Skin*/"Wolf", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Wolf", 
        /*Tongue*/"Dog", 
        /*Wings*/"Human", 
        /*Penis*/"Wolf", 
        /*Vagina*/"Human", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Werewolf", id, RaceBody);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.WOLF_FANGS, +2).eyeType(Eyes.FERAL, +2).eyeType(cast((Eyes.FENRIR), NOT), 0, -7).earType(Ears.WOLF, +1).tongueType(Tongue.DOG, +1).armType(Arms.WOLF, +1).legType(LowerBody.WOLF, +1).tailType(Tail.WOLF, +1).skinCoatType(Skin.FUR, +1).rearType(RearBody.WOLF_COLLAR, +1).rearType(cast((RearBody.FENRIR_ICE_SPIKES), NOT), 0, -7).cockOrVaginaOfType(CockTypesEnum.WOLF, VaginaClass.HUMAN, +1).noWings(+4).corruption(cast((20), AT_LEAST), +1).corruption(cast((50), AT_LEAST), +1).corruption(cast((80), AT_LEAST), +1).hasPerk(PerkLib.LycanthropyDormant, +1).hasPerk(PerkLib.Lycanthropy, +2, -11);
        
        addBloodline(PerkLib.WerewolfsDescendant, PerkLib.BloodlineWerewolf);
        addMutation(IMutationsLib.FerasBirthrightIM);
        addMutation(IMutationsLib.AlphaHowlIM);
        
        buildTier(12, "werewolf").require("Lycanthropy or Dormant Lycanthropy perk", 
                                RaceUtils.hasAnyPerkFn([PerkLib.Lycanthropy, PerkLib.LycanthropyDormant])
                ).buffs({
                            str.mult : +1.00,
                            tou.mult : +0.60,
                            spe.mult : +0.40,
                            int.mult : -0.20
                        }).end();
        buildTier(18, "elder werewolf").requirePreviousTier().buffs({
                            str.mult : +1.45,
                            tou.mult : +0.90,
                            spe.mult : +0.55,
                            int.mult : -0.20
                        }).end();
        buildTier(24, "ancient werewolf").requirePreviousTier().buffs({
                            str.mult : +1.90,
                            tou.mult : +1.20,
                            spe.mult : +0.70,
                            int.mult : -0.20
                        }).end();
    }
}


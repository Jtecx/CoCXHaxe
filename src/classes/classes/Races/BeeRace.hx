package classes.races;

import haxe.Constraints.Function;
import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.transformations.GradualTransformation;
import classes.transformations.TransformationLib;
import classes.VaginaClass;

class BeeRace extends Race
{
    public var TfList(get, never) : Array<Dynamic>;

    public static var BeeHairColors : Array<Dynamic> = ["shiny black", "brown", "yellow"];
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
    
    
    private function get_TfList() : Array<Dynamic>
    {
        var t : TransformationLib = game.transformations;
        return [
        t.HairChangeColor(BeeHairColors), 
        t.BreastRowsRemoveToOne, 
        t.AntennaeBee, 
        t.EyesSandTrap, 
        t.HornsNone, 
        t.SkinPatternBeeStripes, 
        t.LowerBodyBee, 
        t.ArmsBee, 
        t.NipplesPerBreastOne, 
        t.OvipositorBee, 
        t.TailBee, 
        new GradualTransformation("BeeWings", [
        t.WingsNone, 
        t.WingsBeeSmall, 
        t.WingsBeeLarge
    ]), 
        t.GillsNone, 
        t.CockChangeType(CockTypesEnum.BEE, false), 
        t.RearBodyNone
    ];
    }
    
    public function new(id : Int)
    {
        super("Bee", id, []);
    }
    
    override public function finalizeScore(body : BodyData, score : Int, checkRP : Bool = true, outputText : Function = null) : Int
    {
        if (body.player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden))
        {
            mutations[0][1] = +3;
        }
        else
        {
            mutations[0][1] = +1;
        }
        return super.finalizeScore(body, score, checkRP, outputText);
    }
    
    override public function setup() : Void
    //potem zamienić na specificzny dla pszczół wariant twarzy
    {
        addScores().chitinColors(ANY("yellow and black", "yellow and ebony"), +1).eyeType(Eyes.BLACK_EYES_SAND_TRAP, +1).antennaeType(Antennae.BEE, +1).faceType(Face.HUMAN, +1).earType(Ears.INSECT, +1).noHorns(+1).armType(Arms.BEE, +1).legType(LowerBody.BEE, +1).tailType(Tail.BEE_ABDOMEN, +1).wingType(Wings.BEE_SMALL, +1).wingType(Wings.BEE_LARGE, +4).noRearBody(+1).skinCoatPattern(Skin.PATTERN_BEE_STRIPES, +1).hasPerk(PerkLib.BeeOvipositor, +1).cockOrVaginaOfType(CockTypesEnum.BEE, VaginaClass.BEE, 1).hasPerk(PerkLib.TransformationImmunityBeeHandmaiden, +2);
        addConditionedScores(
                                function(body : BodyData) : Bool
                                {
                                    return body.player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden);
                                }, "Bee tf immunity;"
                ).rearType(RearBody.BEE_HANDMAIDEN, +1).customRequirement("", "black nipples", 
                function(body : BodyData) : Bool
                {
                    return body.player.hasStatusEffect(StatusEffects.BlackNipples);
                }, +1
        );
        
        addMutation(IMutationsLib.TrachealSystemIM);
        addMutation(IMutationsLib.PoisonGlandIM);
        
        buildTier(8, "Bee-Morph").buffs({
                                    tou.mult : +0.40,
                                    spe.mult : +0.40,
                                    int.mult : +0.20,
                                    lib.mult : +0.20
                                }).withExtraBonuses("Min Lib +5").end();
        
        buildTier(16, "Elder Bee-Morph").buffs({
                                    tou.mult : +0.70,
                                    spe.mult : +0.70,
                                    int.mult : +0.50,
                                    lib.mult : +0.50
                                }).withExtraBonuses("Min Lib +10").end();
        
        buildTier(20, "Bee Handmaiden").requirePerk(PerkLib.TransformationImmunityBeeHandmaiden).buffs({
                                    tou.mult : +2.70,
                                    spe.mult : +2.70,
                                    int.mult : +1.80,
                                    lib.mult : +1.80
                                }).withExtraBonuses("Min Lib +30").end();
    }
}


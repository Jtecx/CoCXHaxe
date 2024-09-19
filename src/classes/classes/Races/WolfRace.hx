package classes.races;

import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.geneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;
import classes.transformations.GradualTransformation;
import classes.transformations.TransformationLib;

/**
 * Tier 1: wolf
 * Tier 2: winter wolf
 * Tier 3: Fenrir
 */
class WolfRace extends Race
{
    public var TfList(get, never) : Array<Dynamic>;

    public static var BasicWolfFurColors : Array<Dynamic> = ["glacial white"];
    public static var BasicWolfHairColors : Array<Dynamic> = ["glacial white"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Wolf", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Wolf", 
        /*Eyes*/"Fenrir", 
        /*Face*/"Wolf", 
        /*Gills*/"Human", 
        /*Hair*/"Wolf", 
        /*Horns*/"Human", 
        /*LowerBody*/"Wolf", 
        /*RearBody*/"Fenrir", 
        /*Skin*/"Fenrir", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Wolf", 
        /*Tongue*/"Human", 
        /*Wings*/"Human", 
        /*Penis*/"Wolf", 
        /*Vagina*/"Human", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Wolf", id, RaceBody);
    }
    
    private function get_TfList() : Array<Dynamic>
    {
        var t : TransformationLib = game.transformations;
        return [
        // Wolfize
        new GradualTransformation("WolfFace", [
        t.FaceAnimalTeeth, 
        t.FaceWolf
    ]), 
        t.EarsWolf, 
        t.TailWolf, 
        t.ArmsWolf, 
        t.LowerBodyWolf(), 
        t.SkinFurGradualToFull, 
        t.CockChangeType(CockTypesEnum.WOLF, false), 
        // Humanize
        t.AntennaeNone, 
        t.SkinPatternNone, 
        t.NipplesPerBreastOne, 
        t.GillsNone, 
        t.HornsNone, 
        t.WingsNone
    ];
    }
    
    override public function setup() : Void
    {
        addScores().faceType(ANY(Face.WOLF, Face.ANIMAL_TOOTHS), +1).eyeType(Eyes.FENRIR, +3).eyeType(cast((Eyes.FERAL), NOT), 0, -11).eyeColor("glacial blue", +2).earType(Ears.WOLF, +1).armType(Arms.WOLF, +1).legType(LowerBody.WOLF, +1).tailType(Tail.WOLF, +1).skinCoatType(Skin.FUR, +2).furColor1("glacial white", +1).hairColor1("glacial white", +1).wingType(Wings.NONE, +1).rearType(RearBody.FENRIR_ICE_SPIKES, +6).hasPerk(PerkLib.FreezingBreath, +3).hasCockOfType(CockTypesEnum.WOLF, +1);
        
        addMutation(IMutationsLib.AlphaHowlIM);
        
        buildTier(8, "wolf").namesMaleFemaleTaur("wolf-boy", "wolf-girl", "wolf-taur").buffs({
                            str.mult : +0.50,
                            tou.mult : +0.30,
                            spe.mult : +0.50,
                            int.mult : -0.10
                        }).end();
        buildTier(10, "winter wolf").namesMaleFemaleTaur("winter wolf", "winter wolf", "winter wolf-taur").requireSkinCoatType(Skin.FUR).requireFurColor("glacial white").buffs({
                            str.mult : +0.65,
                            tou.mult : +0.40,
                            spe.mult : +0.55,
                            int.mult : -0.10
                        }).end();
        buildTier(22, "Fenrir").buffs({
                            str.mult : +3.00,
                            tou.mult : +1.60,
                            spe.mult : +2.20,
                            int.mult : -0.20
                        }).end();
    }
}


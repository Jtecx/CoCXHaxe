package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.transformations.TransformationGroupAny;

/**
 * Tier 1: goblin
 */
class GoblinRace extends Race
{
    public var TfList(get, never) : Array<Dynamic>;

    public static var GoblinSkinColors : Array<Dynamic> = ["pale yellow", "grayish-blue", "green", "dark green", "emerald"];
    public static var GoblinRareSkinColors : Array<Dynamic> = ["red", "orange", "pale purple", "royal purple", "light purple"];
    public static var GoblinEyeColors : Array<Dynamic> = ["red", "yellow", "purple"];
    public static var GoblinHairColors : Array<Dynamic> = ["red", "purple", "green", "blue", "pink", "orange"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Human", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Elfin", 
        /*Eyes*/"Goblin", 
        /*Face*/"Human", 
        /*Gills*/"None", 
        /*Hair*/"Goblin", 
        /*Horns*/"Human", 
        /*LowerBody*/"Human", 
        /*RearBody*/"Human", 
        /*Skin*/"Goblin", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Human", 
        /*Wings*/"Human", 
        /*Penis*/"Human", 
        /*Vagina*/"Human", 
        /*Perks*/"Goblin"
    ];
    
    private function get_TfList() : Array<Dynamic>
    {
        return [
        new TransformationGroupAny("FaceHumanOrAnimal", [
        game.transformations.FaceHuman, 
        game.transformations.FaceAnimalTeeth
    ]), 
        new TransformationGroupAny("EarsElfinOrBig", [
        game.transformations.EarsElfin, 
        game.transformations.EarsBig
    ]), 
        game.transformations.SkinPlain, 
        game.transformations.SkinColor(GoblinSkinColors), 
        game.transformations.EyesHuman, 
        game.transformations.EyesChangeColor(GoblinEyeColors), 
        game.transformations.HairChangeColor(GoblinHairColors), 
        game.transformations.ArmsHuman, 
        game.transformations.LowerBodyHuman, 
        game.transformations.AntennaeNone
    ];
    }
    
    public function new(id : Int)
    {
        super("Goblin", id, RaceBody);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(ANY(Face.HUMAN, Face.ANIMAL_TOOTHS), +1).earType(ANY(Ears.ELFIN, Ears.BIG), +1, -1000).hornType(cast((Horns.DEMON), NOT), 0, -10).height(cast((48), LESS_THAN), +1).hasPerk(PerkLib.GoblinoidBlood, +1).hasPerk(PerkLib.BouncyBody, +1).skinPlainOnly(+1).skinColor1(ANY(GoblinSkinColors, GoblinRareSkinColors), +1, -1000).hasVagina(+1);
        addConditionedScores(
                                                                        function(body : BodyData) : Bool
                                                                        {
                                                                            return body.player.hasPlainSkinOnly();
                                                                        }, "plain skin; "
                                    ).eyeTypeAndColor(Eyes.HUMAN, cast((GoblinEyeColors), ANY), +1).hairColor1(cast((GoblinHairColors), ANY), +1).armType(Arms.HUMAN, +1).armType(cast((Arms.TINY), NOT), 0, -10).legType(LowerBody.HUMAN, +1).legType(cast((LowerBody.TINY), NOT), 0, -10).noAntennae(+1);
        
        addBloodline(PerkLib.GoblinsDescendant, PerkLib.BloodlineGoblin);
        addMutation(IMutationsLib.NaturalPunchingBagIM);
        addMutation(IMutationsLib.GoblinOvariesIM);
        
        buildTier(10, "goblin").buffs({
                            str.mult : -0.50,
                            spe.mult : +0.60,
                            int.mult : +1.00,
                            lib.mult : +0.40
                        }).end();
        
        buildTier(20, "broodmother goblin").buffs({
                            str.mult : -0.60,
                            spe.mult : +1.20,
                            int.mult : +2.00,
                            lib.mult : +0.80,
                            sens : +40
                        }).end();
    }
}


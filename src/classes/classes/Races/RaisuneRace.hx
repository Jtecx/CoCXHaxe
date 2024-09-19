package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.CoC;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class RaisuneRace extends Race
{
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Raiju", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Fox", 
        /*Eyes*/"Fox", 
        /*Face*/"Fox", 
        /*Gills*/"Human", 
        /*Hair*/"Raiju", 
        /*Horns*/"Human", 
        /*LowerBody*/"Raiju", 
        /*RearBody*/"Raiju", 
        /*Skin*/"Human", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Raisune", 
        /*Tongue*/"Human", 
        /*Wings*/"Thunder", 
        /*Penis*/"Raiju", 
        /*Vagina*/"Raiju", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Raisune", id, []);  //RaceBody);  
        mutationThreshold = 6;
    }
    
    override public function setup() : Void
    {
        addScores().eyeType(Eyes.FOX, +1).earType(Ears.FOX, +1, -1).faceType(ANY(Face.ANIMAL_TOOTHS, Face.HUMAN, Face.FOX), +1, -1).armType(ANY(Arms.RAIJU, Arms.RAIJU_PAWS), +1).legType(LowerBody.RAIJU, +1).wingType(Wings.THUNDEROUS_AURA, +4).rearType(RearBody.RAIJU_MANE, +1).hairType(Hair.STORM, +1).skinCoatType(cast((Skin.CHITIN), NOT), 0, -2).skinBaseType(cast((Skin.GOO), NOT), 0, -3).cockOrVaginaOfType(CockTypesEnum.RAIJU, VaginaClass.RAIJU, +1);
        addScoresAfter(5).customRequirement("skin", "fur or magical tatoo", 
                        function(body : BodyData) : Bool
                        {
                            return body.skinCoatType == Skin.FUR || body.skinBasePattern == Skin.PATTERN_MAGICAL_TATTOO;
                        }, +1
            ).hasPerk(PerkLib.StarSphereMastery, +1);
        
        addBloodline(PerkLib.RaijusDescendant, PerkLib.BloodlineRaiju);
        addMutation(IMutationsLib.KitsuneParathyroidGlandsIM);
        
        buildTier(11, "raisune").buffs({
                            str.mult : +0.30,
                            tou.mult : +0.35,
                            wis.mult : +1.00,
                            maxlust_mult : -0.15,
                            maxsf_mult : +1,
                            maxwrath_mult : +0.6,
                            maxmana_mult : -0.8
                        }).end();
    }
}


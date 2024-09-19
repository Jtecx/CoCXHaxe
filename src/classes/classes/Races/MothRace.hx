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

class MothRace extends Race
{
    public static var MothChitinColors : Array<Dynamic> = ["brown", "black", "white"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Moth", 
        /*Arms*/"Moth", 
        /*Balls*/"Human", 
        /*Breasts*/"Normal", 
        /*Nips*/"Human", 
        /*Ears*/"Insect", 
        /*Eyes*/"Moth", 
        /*Face*/"Moth", 
        /*Gills*/"None", 
        /*Hair*/"Human", 
        /*Horns*/"Human", 
        /*LowerBody*/"Moth", 
        /*RearBody*/"Human", 
        /*Skin*/"Moth", 
        /*Ovipositor*/"Ant", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Moth", 
        /*Tongue*/"Human", 
        /*Wings*/"Moth", 
        /*Penis*/"Insect", 
        /*Vagina*/"Vagina", 
        /*Perks*/"Human"
    ];
    public function new(id : Int)
    {
        super("Moth", id, []);
    }
    override public function setup() : Void
    {
        addScores().faceType(Face.HUMAN, +1, -1).antennaeType(Antennae.MOTH, +1).earType(Ears.INSECT, +1, -1).eyeType(Eyes.MOTH, +1).armType(Arms.MOTH, +1).legType(LowerBody.MOTH, +1).tailType(Tail.MOTH_ABDOMEN, +1).rearType(RearBody.MOTH_COLLAR, +1).wingType(Wings.MOTH_SMALL, +1).wingType(Wings.MOTH_LARGE, +2).noHorns(+1).skinCoatType(Skin.CHITIN, +1).chitinColor1(cast((MothChitinColors), ANY), +1).hasCockOfType(CockTypesEnum.INSECT, +1);
        //.hasPerk(PerkLib.AntyDexterity, +1)
        
        addMutation(IMutationsLib.TrachealSystemIM);
        
        buildTier(10, "moth-morph").buffs({
                            tou.mult : -0.30,
                            spe.mult : +1.50,
                            wis.mult : +0.70,
                            lib.mult : +0.30,
                            sens : +70
                        }).end();
    }
}


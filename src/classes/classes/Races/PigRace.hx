package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.Race;

class PigRace extends Race
{
    public static var PigSkinColors : Array<Dynamic> = ["pink", "tan", "sable"];
    public static var BoarSkinColors : Array<Dynamic> = ["pink", "dark blue"];
    public static var BoarFurColors : Array<Dynamic> = ["dark brown", "brown", "black", "red", "grey"];
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
        super("Pig", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.PIG, +1).tailType(Tail.PIG, +1).faceType(Face.PIG, +1).faceType(Face.BOAR, +2).armType(ANY(Arms.PIG, Arms.BOAR), +2).legType(LowerBody.CLOVEN_HOOFED, +1).skinPlainOnly(+1).skinColor1(cast((PigSkinColors), ANY), +1).thickness(cast((75), AT_LEAST), +1).hasCockOfType(CockTypesEnum.PIG, +1);
        addConditionedScores(
                                function(body : BodyData) : Bool
                                {
                                    return body.faceType == Face.BOAR || body.armType == Arms.BOAR;
                                }, "boar arms or face;"
                ).skinColor1(cast((BoarSkinColors), ANY), +2).skinCoatTypeAndColor1(Skin.FUR, cast((BoarFurColors), ANY), +2);
        addScoresAfter(4).skinCoatType(Arms.HUMAN, +1).noWings(+1).thickness(cast((150), AT_LEAST), +1);
        
        addMutation(IMutationsLib.PigBoarFatIM);
        
        buildTier(10, "pig-morph").buffs({
                                    str.mult : +0.60,
                                    tou.mult : +1.20,
                                    spe.mult : -0.15,
                                    int.mult : -0.10,
                                    wis.mult : -0.05
                                }).withExtraBonuses("+25 Max Hunger").end();
        
        buildTier(15, "boar-morph").buffs({
                                    str.mult : +1.25,
                                    tou.mult : +1.25,
                                    spe.mult : -0.15,
                                    int.mult : -0.10
                                }).withExtraBonuses("+45 Max Hunger").end();
    }
}


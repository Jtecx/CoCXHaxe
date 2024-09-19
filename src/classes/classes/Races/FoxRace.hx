package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

class FoxRace extends Race
{
    public var TfList(get, never) : Array<Dynamic>;

    public static var FoxHairColors : Array<Dynamic> = ["golden blonde", "reddish-orange", "silver", "white", "red", "black"];
    public static var FoxFurColors : Array<Dynamic> = ["orange and white", "orange and white", "orange and white", "red and white", "black and white", "white", "tan", "brown"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Elf", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Elven", 
        /*Eyes*/"Elf", 
        /*Face*/"Elf", 
        /*Gills*/"None", 
        /*Hair*/"Elf", 
        /*Horns*/"Human", 
        /*LowerBody*/"Elf", 
        /*RearBody*/"Human", 
        /*Skin*/"Elf", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Elf", 
        /*Wings*/"Human", 
        /*Penis*/"Human", 
        /*Vagina*/"Human", 
        /*Perks*/"Elf"
    ];
    
    private function get_TfList() : Array<Dynamic>
    {
        return [
        game.transformations.FaceFox, 
        game.transformations.EyesFox, 
        game.transformations.EarsFox, 
        game.transformations.TailFox(1, 1, true), 
        game.transformations.SkinFurGradual(Skin.COVERAGE_HIGH, {
                    colors : FoxHairColors
                }), 
        game.transformations.ArmsFox, 
        game.transformations.LowerBodyFox(), 
        game.transformations.HairChangeColor(FoxHairColors), 
        game.transformations.CockChangeType(CockTypesEnum.FOX, false)
    ];
    }
    
    
    public function new(id : Int)
    {
        super("Fox", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.FOX, +1).eyeType(Eyes.FOX, +1).eyeType(cast((Eyes.FERAL), NOT), 0, -11).earType(Ears.FOX, +1).tailType(Tail.FOX, +1).customRequirement("", "no more than 1 fox tail", 
                                                                        function(body : BodyData) : Bool
                                                                        {
                                                                            return !(body.tailType == Tail.FOX && body.tailCount > 1);
                                                                        }, 0, -7
                                    ).armType(Arms.FOX, +1).legType(LowerBody.FOX, +1).hasCockOfType(CockTypesEnum.FOX, +1).breastRowCount(cast((1), GREATER_THAN), +1).breastRowCount(3, +1).breastRowCount(4, +2).skinCoatType(Skin.FUR, +1);
        
        buildTier(9, "fox-morph").namesTauric("fox-morph", "fox-taur").buffs({
                            str.mult : -0.30,
                            spe.mult : +1.00,
                            int.mult : +0.65,
                            maxfatigue_base : +20
                        }).end();
    }
}


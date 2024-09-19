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
import classes.internals.Utils;

class AlrauneRace extends Race
{
    public static var AlrauneEyeColor : Array<Dynamic> = ["light purple", "green", "light green", "pale blue", "fiery red", "red"];
    public static var AlrauneHairColor : Array<Dynamic> = ["green", "light purple", "pink", "white", "bluish white", "orange", "red", "bright pink"];
    public static var AlrauneSkinColor : Array<Dynamic> = ["leaf green", "lime green", "turquoise", "light green", "pale blue", "burnt brown", "lavender"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Plant", 
        /*Balls*/"Human", 
        /*Breasts*/"Normal", 
        /*Nips*/"Human", 
        /*Ears*/"Elfin", 
        /*Eyes*/"Alraune", 
        /*Face*/"Human", 
        /*Gills*/"None", 
        /*Hair*/"Plant", 
        /*Horns*/"Human", 
        /*LowerBody*/"Alraune", 
        /*RearBody*/"Human", 
        /*Skin*/"Alraune", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Human", 
        /*Wings*/"Human", 
        /*Penis*/"Alraune", 
        /*Vagina*/"Alraune", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Alraune", id, RaceBody);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.HUMAN, +1).eyeType(Eyes.HUMAN, +1).eyeColor(cast((AlrauneEyeColor), ANY), +1).earType(Ears.ELFIN, +1).hairTypeAndColor1(ANY(Hair.LEAF, Hair.GRASS), cast((AlrauneHairColor), ANY), +1).plainSkinOfColor1(cast((AlrauneSkinColor), ANY), +1).armType(Arms.PLANT, +1).noWings(+1).customRequirement("legs", "alraune-like lower body", 
                                function(body : BodyData) : Bool
                                {
                                    return body.player.isAlraune();
                                }, +5
                ).hasCockOfType(CockTypesEnum.STAMEN, +1).vaginaType(VaginaClass.ALRAUNE, 1);
        
        addMutation(IMutationsLib.FloralOvariesIM);
        
        buildTier(13, "alraune").customNamingFunction(Utils.curry(nameFn, 1)).buffs({
                            tou.mult : +1.00,
                            spe.mult : -0.50,
                            lib.mult : +1.45,
                            def : +10
                        }).end();
        
        buildTier(17, "greater alraune").customNamingFunction(Utils.curry(nameFn, 2)).buffs({
                            tou.mult : +1.15,
                            spe.mult : -0.60,
                            lib.mult : +2.00,
                            def : +10
                        }).end();
    }
    private function nameFn(tier : Int, body : BodyData) : String
    {
        var s : String = "";
        
        if (tier == 2)
        {
            s ="greater "  //else if (tier == 3) s = "true ";  ;
        }
        
        
        if (body.player.hasPerk(PerkLib.SnowLily))
        {
            s += "snow lily ";
        }
        else if (body.player.hasPerk(PerkLib.Cinderbloom))
        {
            s += "cinderbloom ";
        }
        else if (body.player.hasPerk(PerkLib.Nightshade))
        {
            s += "nightshade ";
        }
        
        if (body.legType == LowerBody.FLOWER_LILIRAUNE)
        {
            s += "liliraune";
        }
        else
        {
            s += "alraune";
        }
        
        return s;
    }
}


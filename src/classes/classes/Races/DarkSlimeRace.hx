package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

class DarkSlimeRace extends Race
{
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
    
    public static var DarkSlimeSkinColors : Array<Dynamic> = ["indigo", "light purple", "purple", "purplish black", "dark purple"];
    
    public function new(id : Int)
    {
        super("Dark slime", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().skinColor1(cast((DarkSlimeSkinColors), ANY), +1, -1000).hairType(Hair.GOO, +1).armType(Arms.GOO, +1).legType(LowerBody.GOO, +3).rearType(RearBody.METAMORPHIC_GOO, +2).customRequirement("skin", "slimy goo skin", function(body : BodyData) : Bool
                                {
                                    return body.player.isGooSkin() && body.skinBaseAdj == "slimy";
                                }, +1).hasStatusEffect(StatusEffects.SlimeCraving, "Slime Craving", +1).hasPerk(PerkLib.DarkSlimeCore, +1);
        
        addConditionedScores(function(body : BodyData) : Bool
                                                                                {
                                                                                    return body.player.isGooSkin() && body.skinBaseAdj == "slimy";
                                                                                }, "slimy goo skin;").faceType(Face.HUMAN, +1).eyeType(ANY(Eyes.HUMAN, Eyes.FIENDISH), +1).earType(ANY(Ears.HUMAN, Ears.ELFIN), +1).height(cast((107), GREATER_THAN), +1).hasVagina(+1).noAntennae(+1).noWings(+1).noGills(+1);
        
        addMutation(IMutationsLib.SlimeMetabolismIM);
        addMutation(IMutationsLib.SlimeFluidIM);
        
        buildTier(12, "dark slime").namesMaleFemale("dark slime boi", "dark slime girl").buffs({
                            tou.mult : +0.90,
                            spe.mult : -0.40,
                            int.mult : +0.45,
                            lib.mult : +1.00
                        }).end();
        
        buildTier(16, "dark slime queen").buffs({
                            tou.mult : +1.15,
                            spe.mult : -0.50,
                            int.mult : +0.45,
                            lib.mult : +1.45
                        }).end();
    }
}


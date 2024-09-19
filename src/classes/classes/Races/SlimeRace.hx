package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

class SlimeRace extends Race
{
    public static var SlimeSkinColors : Array<Dynamic> = ["green", "magenta", "blue", "cerulean", "emerald", "pink", "milky white"];
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
        super("Slime", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().skinColor1(cast((SlimeSkinColors), ANY), +1, -1000).hairType(Hair.GOO, +1).armType(Arms.GOO, +1).legType(LowerBody.GOO, +3).rearType(RearBody.METAMORPHIC_GOO, +2).customRequirement("skin", "slimy goo skin", function(body : BodyData) : Bool
                                {
                                    return body.player.isGooSkin() && body.skinBaseAdj == "slimy";
                                }, +1).hasStatusEffect(StatusEffects.SlimeCraving, "Slime Craving", +1).hasPerk(PerkLib.SlimeCore, +1);
        
        addConditionedScores(function(body : BodyData) : Bool
                                                                                {
                                                                                    return body.player.isGooSkin() && body.skinBaseAdj == "slimy";
                                                                                }, "slimy goo skin;").faceType(Face.HUMAN, +1).eyeType(Eyes.HUMAN, +1).earType(ANY(Ears.HUMAN, Ears.ELFIN), +1).height(cast((107), GREATER_THAN), +1).hasVagina(+1).noAntennae(+1).noWings(+1).noGills(+1);
        
        addMutation(IMutationsLib.SlimeMetabolismIM);
        addMutation(IMutationsLib.SlimeFluidIM);
        
        buildTier(10, "slime").namesMaleFemale("slime boi", "slime girl").buffs({
                            tou.mult : +1.00,
                            spe.mult : -0.40,
                            lib.mult : +1.05
                        }).end();
        
        buildTier(14, "slime queen").buffs({
                            tou.mult : +1.15,
                            spe.mult : -0.50,
                            lib.mult : +1.60
                        }).end();
    }
}


package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class MinotaurRace extends Race
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
    
    public function new(id : Int)
    {
        super("Minotaur", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.COW, +1).tailType(Tail.COW, +1).legType(LowerBody.CLOVEN_HOOFED, +1).hornType(Horns.COW_MINOTAUR, +1).customRequirement("", "cum volume > 500", 
                function(body : BodyData) : Bool
                {
                    return body.player.cumQ() > 500;
                }, +1
        );
        addScoresAfter(3).customRequirement("", "cum volume > 1000", 
                                                                                                function(body : BodyData) : Bool
                                                                                                {
                                                                                                    return body.player.cumQ() > 1000;
                                                                                                }, +1
                                                ).skinCoatType(Skin.FUR, +1).faceType(ANY(Face.HUMAN, Face.COW_MINOTAUR), +1).armType(Arms.HUMAN, +1).customRequirement("", "horns size > 5", 
                                                                function(body : BodyData) : Bool
                                                                {
                                                                    return body.player.horns.count > 5;
                                                                }, +1
                                ).hasBalls(+1).ballSize(cast((4), GREATER_THAN), +1).height(cast((81), AT_LEAST), +1).corruption(cast((20), AT_LEAST), +1).noVagina(0, -8).hasCockOfType(CockTypesEnum.HORSE, +1);
        
        addBloodline(PerkLib.MinotaursDescendant, PerkLib.BloodlineMinotaur);
        addMutation(IMutationsLib.MinotaurTesticlesIM);
        addMutation(IMutationsLib.MightyLegsIM);
        
        buildTier(10, "bull-morph").namesMaleFemale("bull-boy", "bull-morph").buffs({
                            str.mult : +1.20,
                            tou.mult : +0.40,
                            spe.mult : -0.40,
                            int.mult : -0.20,
                            lib.mult : +0.50
                        }).end();
        
        buildTier(16, "Minotaur").buffs({
                            str.mult : +2.00,
                            tou.mult : +0.50,
                            spe.mult : -0.50,
                            int.mult : -0.30,
                            lib.mult : +0.70
                        }).end();
    }
}


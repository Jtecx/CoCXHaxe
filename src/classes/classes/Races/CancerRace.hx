package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

class CancerRace extends Race
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
        super("Cancer", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.HUMAN, +1).hairType(Hair.NORMAL, +1).eyeType(Eyes.CANCER, +1).faceType(Face.KUDERE, +1).hasStatusEffect(StatusEffects.CancerCrabStance, "Crab stance", +1).legType(ANY(LowerBody.CRAB, LowerBody.CANCER), +1, -1000).legType(LowerBody.CANCER, +3).noWings(+1).eyeColor("orange", +1).customRequirement("", "cancer genitals", 
                        function(body : BodyData) : Bool
                        {
                            return body.player.foamingCocks() > 0 || body.vaginaType == VaginaClass.CANCER;
                        }, +1
            ).biggestTitSize(cast((3), AT_MOST), +1);
        addMutation(IMutationsLib.TwinHeartIM, +2);
        
        buildTier(13, "lesser cancer").buffs({
                            str.mult : +1.05,
                            tou.mult : +0.80,
                            spe.mult : +0.55,
                            int.mult : -0.30,
                            wis.mult : -0.15
                        }).end();
        
        buildTier(20, "cancer").buffs({
                            str.mult : +1.25,
                            tou.mult : +1.15,
                            spe.mult : +1.05,
                            int.mult : -0.30,
                            wis.mult : -0.15
                        }).end();
    }
}


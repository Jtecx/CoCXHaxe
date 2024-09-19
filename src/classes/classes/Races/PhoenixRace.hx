package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class PhoenixRace extends Race
{
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Phoenix", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Human", 
        /*Eyes*/"Lizard", 
        /*Face*/"Human", 
        /*Gills*/"None", 
        /*Hair*/"Feather", 
        /*Horns*/"Human", 
        /*LowerBody*/"Harpy", 
        /*RearBody*/"Human", 
        /*Skin*/"Salamander", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Salamander", 
        /*Tongue*/"Human", 
        /*Wings*/"Phoenix", 
        /*Penis*/"Lizard", 
        /*Vagina*/"Human", 
        /*Perks*/"Phoenix"
    ];
    
    public function new(id : Int)
    {
        super("Phoenix", id, RaceBody);
    }
    
    override public function setup() : Void
    {
        addScores().wingType(Wings.FEATHERED_PHOENIX, +4, -1000).armType(Arms.PHOENIX, +1).hairType(Hair.FEATHER, +1).eyeType(Eyes.LIZARD, +1).legType(ANY(LowerBody.SALAMANDER, LowerBody.HARPY), +1).tailType(Tail.SALAMANDER, +1).tailType(cast((Tail.KITSHOO), NOT), 0, -1000).skinCoatType(Skin.SCALES, +1).hasCockOfType(CockTypesEnum.LIZARD, +1).hasPerk(PerkLib.PhoenixFireBreath, +1).hasPerk(PerkLib.HarpyWomb, +2);
        addConditionedScores(function(body : BodyData) : Bool
                                {
                                    return body.hairType == Hair.FEATHER;
                                }, "feather hair;", 3).faceType(ANY(Face.HUMAN, Face.SALAMANDER_FANGS), 2).earType(ANY(Ears.HUMAN, Ears.ELFIN, Ears.LIZARD), +1);
        
        addBloodline(PerkLib.SalamandersDescendant, PerkLib.BloodlineSalamander);
        addMutation(IMutationsLib.HarpyHollowBonesIM);
        addMutation(IMutationsLib.SalamanderAdrenalGlandsIM);
        addMutation(IMutationsLib.BlazingHeartIM);
        
        buildTier(10, "phoenix").namesTauric("phoenix", "phoenix-taur").buffs({
                            str.mult : +0.20,
                            tou.mult : +0.20,
                            spe.mult : +0.70,
                            lib.mult : +0.40,
                            maxlust_base : +25
                        }).end();
        
        buildTier(21, "greater phoenix").namesTauric("Greater phoenix", "Greater phoenix-taur").buffs({
                            str.mult : +0.40,
                            tou.mult : +0.20,
                            spe.mult : +1.50,
                            lib.mult : +1.05,
                            maxlust_base : +25
                        }).end();
    }
    
    public static function isPhoenixLike(body : BodyData) : Bool
    {
        return body.wingType == Wings.FEATHERED_PHOENIX;
    }
}


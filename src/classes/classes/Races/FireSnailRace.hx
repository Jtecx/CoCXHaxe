package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class FireSnailRace extends Race
{
    public static var FireSnailEyeColors : Array<Dynamic> = ["red", "orange", "yellow"];
    public static var FireSnailSkinColors : Array<Dynamic> = ["red", "orange"];
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
    
    public function new(id : Int)
    {
        super("Fire Snail", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().antennaeType(Antennae.FIRE_SNAIL, +1).hairType(Hair.BURNING, +1).eyeColor(cast((FireSnailEyeColors), ANY), +1).skinColor1(cast((FireSnailSkinColors), ANY), +1).plainSkinOfAdj("sticky glistering", +1).customRequirement("", "snail shell and no wings", 
                                        function(body : BodyData) : Bool
                                        {
                                            return body.rearType == RearBody.SNAIL_SHELL && body.wingType == Wings.NONE;
                                        }, +5
                    ).customRequirement("", "fire snail lower body and no tail", 
                                function(body : BodyData) : Bool
                                {
                                    return body.legType == LowerBody.FIRE_SNAIL && body.tailType == Tail.NONE;
                                }, +3
                ).eyeType(Eyes.FIRE_SNAIL, +1).faceType(Face.FIRE_SNAIL, +1);
        
        addMutation(IMutationsLib.BlazingHeartIM);
        
        buildTier(15, "fire snail").buffs({
                            str.mult : +0.70,
                            tou.mult : +1.75,
                            spe.mult : -0.80,
                            lib.mult : +1.10,
                            sens : +50
                        }).end();
    }
}


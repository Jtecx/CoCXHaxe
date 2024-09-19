package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.Race;
import classes.StatusEffects;

class GazerRace extends Race
{
    public static var GazerHairColors : Array<Dynamic> = ["black", "midnight", "midnight black"];
    public static var GazerSkinColors : Array<Dynamic> = ["snow white", "red", "pale white"];
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
        super("Gazer", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().hairColor1(cast((GazerHairColors), ANY), +1).skinPlainOnly(+1).skinColor1(cast((GazerSkinColors), ANY), +1).skinBasePattern(Skin.PATTERN_OIL, +1).eyeType(Eyes.MONOEYE, +1).eyeColor("red", +1).faceType(Face.ANIMAL_TOOTHS, +1).armType(Arms.GAZER, +1).legType(LowerBody.GAZER, +1).noTail(+1).wingType(Wings.LEVITATION, +1).customScoreRequirement("rear", 
                "tentacle eyestalks", 
                function(body : BodyData) : Bool
                {
                    return body.rearType == RearBody.TENTACLE_EYESTALKS && body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 2;
                }, 
                function(body : BodyData) : Int
                {
                    var x : Float = body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer);
                    if (x >= 10)
                    {
                        return 10;
                    }
                    if (x >= 8)
                    {
                        return 8;
                    }
                    if (x >= 6)
                    {
                        return 6;
                    }
                    if (x >= 4)
                    {
                        return 4;
                    }
                    if (x >= 2)
                    {
                        return 2;
                    }
                    return 0;
                }
        );
        
        addMutation(IMutationsLib.GazerEyesIM);
        
        buildTier(14, "gazer").require("6+ eye stalks", 
                                function(body : BodyData) : Bool
                                {
                                    return body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 6;
                                }
                ).buffs({
                            tou.mult : +0.80,
                            spe.mult : -0.65,
                            int.mult : +1.30,
                            lib.mult : +0.90
                        }).end();
        
        buildTier(21, "Eye Tyrant").require("10+ eye stalks", 
                                function(body : BodyData) : Bool
                                {
                                    return body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10;
                                }
                ).buffs({
                            tou.mult : +0.55,
                            spe.mult : -0.65,
                            int.mult : +1.80,
                            lib.mult : +1.30
                        }).end();
    }
}


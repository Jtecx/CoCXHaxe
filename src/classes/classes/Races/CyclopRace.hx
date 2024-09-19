package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.Race;
import classes.StatusEffects;
import classes.internals.race.RaceUtils;

class CyclopRace extends Race
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
        super("Cyclop", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().skinPlainOnly(+1).eyeType(Eyes.MONOEYE, +3).faceType(Face.ANIMAL_TOOTHS, +1).noWings(+1).noTail(+1).tone(cast((90), AT_LEAST), +1).customRequirement("", "not a gazer", 
                function(body : BodyData) : Bool
                {
                    return !(body.rearType == RearBody.TENTACLE_EYESTALKS && body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 2);
                }, 0, -10
        );
        addConditionedScores(
                                RaceUtils.checkSlotFn(BodyData.SLOT_EYE_TYPE, Eyes.MONOEYE), 
                                "monoeye;"
                ).armType(Arms.HUMAN, +1).legType(LowerBody.HUMAN, +1);
        addScoresAfter(4).tone(cast((120), AT_LEAST), +1).height(cast((72), GREATER_THAN), +1);
        addScoresAfter(6).height(cast((96), GREATER_THAN), +1);
        addScoresAfter(8).height(cast((120), GREATER_THAN), +1);
        
        buildTier(12, "cyclop").buffs({
                            str.mult : +0.90,
                            tou.mult : +0.90
                        }).end();
    }
}


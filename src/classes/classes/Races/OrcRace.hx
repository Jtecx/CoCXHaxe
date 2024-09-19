package classes.races;

import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class OrcRace extends Race
{
    public static var OrcSkinColors : Array<Dynamic> = ["green", "gray", "brown", "red", "sandy tan"];
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
        super("Orc", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.ELFIN, +1).eyeType(Eyes.ORC, +1).faceType(Face.ORC_FANGS, +1).armType(Arms.ORC, +1).legType(LowerBody.ORC, +1).skinBasePattern(Skin.PATTERN_SCAR_SHAPED_TATTOO, +1).skinColor1(cast((OrcSkinColors), ANY), +1).skinPlainOnly(+1).noTail(+1).height(cast((48), AT_LEAST), 0, -1000).tone(cast((80), AT_LEAST), +1).tone(cast((100), AT_LEAST), +1).tone(cast((120), AT_LEAST), +1).thickness(cast((60), AT_MOST), +1).thickness(cast((20), AT_MOST), +1).hasPerk(PerkLib.Ferocity, +1);
        
        addBloodline(PerkLib.OrcsDescendant, PerkLib.BloodlineOrc);
        addMutation(IMutationsLib.OrcAdrenalGlandsIM);
        
        buildTier(11, "orc").namesTauric("orc", "orc-taur").buffs({
                            str.mult : +1.30,
                            tou.mult : +0.30,
                            spe.mult : +0.10,
                            int.mult : +0.10,
                            lib.mult : +0.25,
                            maxwrath_mult : +0.2
                        }).end();
    }
}


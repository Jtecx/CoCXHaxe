package classes.races;

import classes.bodyParts.*;
import classes.geneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: jiangshi
 */
class JiangshiRace extends Race
{
    
    public static var JiangshiSkinColors : Array<Dynamic> = ["ghostly pale", "light blue", "snow white"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Jiangshi", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Human", 
        /*Eyes*/"Jiangshi", 
        /*Face*/"Jiangshi", 
        /*Gills*/"None", 
        /*Hair*/"Human", 
        /*Horns*/"Jiangshi", 
        /*LowerBody*/"Jiangshi", 
        /*RearBody*/"Human", 
        /*Skin*/"Jiangshi", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Human", 
        /*Wings*/"Human", 
        /*Penis*/"Human", 
        /*Vagina*/"Human", 
        /*Perks*/"Jiangshi"
    ];
    
    public function new(id : Int)
    {
        super("Jiangshi", id, RaceBody);
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().skinPlainOnly(+1).skinBaseAdj(cast(("slippery"), NOT), 0, -1).skinColor1(cast((JiangshiSkinColors), ANY), +1).hairType(Hair.NORMAL, +1).faceType(Face.JIANGSHI, +1).eyeType(Eyes.JIANGSHI, +2).earType(Ears.HUMAN, +1).tongueType(Tongue.HUMAN, +1).noGills(+1).noAntennae(+1).hornType(Horns.SPELL_TAG, +1).noWings(+2).noTail(+1).armType(Arms.JIANGSHI, +1).legType(LowerBody.JIANGSHI, +1).noRearBody(+1).skinBasePattern(Skin.PATTERN_NONE, +1).hasPerk(PerkLib.Undeath, +2);
        
        buildTier(15, "Half Jiangshi").requireHornType(Horns.SPELL_TAG).buffs({
                            str.mult : +0.75,
                            spe.mult : -0.40,
                            int.mult : -0.40,
                            wis.mult : +0.70,
                            lib.mult : +1.00
                        }).end();
        
        buildTier(20, "Jiangshi").requirePerk(PerkLib.Undeath).buffs({
                            str.mult : +1.50,
                            spe.mult : -0.90,
                            int.mult : -0.90,
                            wis.mult : +1.30,
                            lib.mult : +2.00
                        }).end();
    }
}


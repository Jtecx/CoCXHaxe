package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

class CaveWyrmRace extends Race
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
        super("Cave Wyrm", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().skinCoatType(Skin.SCALES, +1).skinCoatTypeAndColor1(Skin.SCALES, "midnight black", +1).skinColor1("grayish-blue", +1).earType(Ears.CAVE_WYRM, +1).eyeType(Eyes.CAVE_WYRM, +1).eyeColor("neon blue", +1).tongueType(Tongue.CAVE_WYRM, +1).faceType(Face.SALAMANDER_FANGS, +1).armType(Arms.CAVE_WYRM, +1).legType(LowerBody.CAVE_WYRM, +1).tailType(Tail.CAVE_WYRM, +1).customRequirement("", "glowing nipples or asshole", 
                                        function(body : BodyData) : Bool
                                        {
                                            return body.player.hasStatusEffect(StatusEffects.GlowingNipples) || body.player.hasStatusEffect(StatusEffects.GlowingAsshole);
                                        }, +1
                    ).cockOrVaginaOfType(CockTypesEnum.CAVE_WYRM, VaginaClass.CAVE_WYRM, +1).hasPerk(PerkLib.AcidSpit, +1).hasPerk(PerkLib.AzureflameBreath, +1);
        
        addMutation(IMutationsLib.CaveWyrmLungsIM);
        
        buildTier(10, "cave wyrm").namesTauric("cave wyrm", "cave wyrm-taur").buffs({
                            str.mult : +0.60,
                            tou.mult : +0.70,
                            wis.mult : -0.30,
                            lib.mult : +0.50
                        }).end();
        
        buildTier(16, "elder cave wyrm").namesTauric("elder cave wyrm", "elder cave wyrm-taur").buffs({
                            str.mult : +0.90,
                            tou.mult : +1.15,
                            wis.mult : -0.30,
                            lib.mult : +0.65
                        }).end();
    }
}


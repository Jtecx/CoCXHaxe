package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class WendigoRace extends Race
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
        super("Wendigo", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().hairColor1("silver-white", +1).furColor1("snow white", +1).eyeType(Eyes.DEAD, +1).eyeColor("spectral blue", +1).tongueType(Tongue.RAVENOUS_TONGUE, +1).hornTypeAndCount(Horns.ANTLERS, cast((4), AT_LEAST), +2).hornTypeAndCount(Horns.ANTLERS, cast((30), AT_LEAST), +2).earType(Ears.DEER, +1).tailType(Tail.WENDIGO, +1).legType(LowerBody.WENDIGO, +1).legType(NONE(LowerBody.CLOVEN_HOOFED, LowerBody.CLOVEN_HOOFED_2), 0, -5).armType(Arms.WENDIGO, +1).armType(NONE(Arms.DEER, Arms.REINDEER), 0, -5).faceType(ANY(Face.DEER, Face.ANIMAL_TOOTHS), +1).rearType(RearBody.FUR_COAT, +2).wingType(Wings.LEVITATION, +3).skinType(ANY(Skin.PLAIN, Skin.FUR), +1).cockOrVaginaOfType(CockTypesEnum.HORSE, VaginaClass.EQUINE, +1).customRequirement("", "big E-cup if has vagina, flat chest otherwise", 
                        function(body : BodyData) : Bool
                        {
                            return body.hasVagina && body.biggestTitSize >= 8 || !body.hasVagina && body.biggestTitSize == 0;
                        }, +1
            ).hasPerk(PerkLib.EndlessHunger, +1);
        
        buildTier(10, "wendigo").buffs({
                            str.mult : +0.70,
                            tou.mult : +0.70,
                            int.mult : +0.60,
                            wis.mult : -0.50,
                            lib.mult : +0.50,
                            sens : +50
                        }).end();
        
        buildTier(25, "great wendigo").buffs({
                            str.mult : +1.60,
                            tou.mult : +1.40,
                            int.mult : +0.85,
                            wis.mult : -0.50,
                            lib.mult : +1.25,
                            sens : +85
                        }).end();
    }
}


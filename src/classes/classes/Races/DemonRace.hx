package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class DemonRace extends Race
{
    public static var DemonSkinColors : Array<Dynamic> = ["olive", "tan", "fair", "shiny black", "sky blue", "indigo", "ghostly white", "leaf green", "light green", "light purple", "purple", "red", "grey", "blue", "snow white", "midnight black", "pink"];
    public static var DemonSkin2Colors : Array<Dynamic> = ["light pink", "purple", "turquoise", "light green", "snow white"];
    public static var DemonEyeColors : Array<Dynamic> = ["fiendish pink", "pink", "red", "yellow", "blue", "turquoise", "light green"];
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
        super("Demon", id, []);  //RaceBody);  
        mutationThreshold = 6;
    }
    
    override public function setup() : Void
    {
        addScores().hornType(Horns.DEMON, +1).hornType(cast((Horns.GOAT), NOT), 0, -10).faceType(Face.DEMON, +1).faceType(cast((Face.VAMPIRE), NOT), 0, -10).tongueType(Tongue.DEMONIC, +1).earType(ANY(Ears.ELFIN, Ears.ELVEN), +1).eyeType(ANY(Eyes.DEMON, Eyes.DEVIL), +1).eyeColor(cast((DemonEyeColors), ANY), +1).armType(Arms.DEMON, +1).legType(ANY(LowerBody.DEMONIC_HIGH_HEELS, LowerBody.DEMONIC_GRACEFUL_FEET, LowerBody.DEMONIC_CLAWS), +1).tailType(Tail.DEMONIC, +1).wingType(Wings.BAT_LIKE_TINY, +2).wingType(Wings.BAT_LIKE_LARGE, +4).wingType(cast((Wings.VAMPIRE), NOT), 0, -10).plainSkinOfAdj(cast(("slippery"), NOT), +1).skinColor1(cast((DemonSkinColors), ANY), +1).skinColor2(cast((DemonSkin2Colors), ANY), +1).skinBasePattern(Skin.PATTERN_DEMONIC_PLEASURE_RUNE, +1).cockOrVaginaOfType(CockTypesEnum.DEMON, VaginaClass.DEMONIC, +1).customRequirement("", "vagina and D+ tits or 12\"+ long cock", 
                                                                function(body : BodyData) : Bool
                                                                {
                                                                    return body.hasVagina && body.biggestTitSize >= 4 || body.biggestCockSize > 12;
                                                                }, +1
                                ).hornTypeAndCount(Horns.DEMON, cast((4), GREATER_THAN), +4).corruption(cast((50), AT_LEAST), +1).corruption(cast((75), AT_LEAST), +1).corruption(cast((100), AT_LEAST), +1).hasPerk(PerkLib.DemonicLethicite, +1).hasPerk(PerkLib.Soulless, +4);
        
        addMutation(IMutationsLib.BlackHeartIM);
        addMutation(IMutationsLib.FiendishMetabolismIM);
        addMutation(IMutationsLib.FiendishBallsIM);
        addMutation(IMutationsLib.FiendishOvariesIM);
        
        buildTier(15, "succubi-kin/incubi-kin").namesMaleFemaleTaur("incubi-kin", "succubi-kin", "incubi-kintaur", "succubi-kintaur").buffs({
                            spe.mult : +0.25,
                            int.mult : +0.50,
                            lib.mult : +1.50,
                            maxmana_mult : +0.8,
                            maxwrath_mult : -0.3,
                            maxsf_mult : -0.8,
                            maxlust_mult : +0.6
                        }).end();
        
        buildTier(21, "succubus/incubus").namesMaleFemaleTaur("incubus", "succubus", "incubi-taur", "succubi-taur").requirePerk(PerkLib.Soulless).buffs({
                            spe.mult : +0.65,
                            int.mult : +0.70,
                            lib.mult : +2.00,
                            sens : +20,
                            maxmana_mult : +1.2,
                            maxwrath_mult : -0.45,
                            maxlust_mult : +1.2
                        }).end();
        
        buildTier(29, "elder succubus/incubus").namesMaleFemaleTaur("elder incubus", "elder succubus", "elder incubi-taur", "elder succubi-taur").requirePerk(PerkLib.Soulless).buffs({
                            spe.mult : +1.00,
                            int.mult : +1.10,
                            lib.mult : +2.75,
                            sens : +50,
                            maxmana_mult : +1.5,
                            maxwrath_mult : -0.5,
                            maxlust_mult : +1.5
                        }).end();
        
        buildTier(38, "arch succubus/incubus").namesMaleFemaleTaur("arch incubus", "arch succubus", "arch incubi-taur", "arch succubi-taur").requirePerk(PerkLib.Soulless).buffs({
                            spe.mult : +2.00,
                            int.mult : +2.50,
                            lib.mult : +3.20,
                            sens : +200,
                            maxmana_mult : +1.8,
                            maxwrath_mult : -0.55,
                            maxlust_mult : +1.8
                        }).end();
    }
}


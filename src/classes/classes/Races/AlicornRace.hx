package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.internals.Utils;

class AlicornRace extends Race
{
    public static var NightmareFurColors : Array<Dynamic> = UnicornRace.BicornFurColors;
    public static var NightmareHairColors : Array<Dynamic> = UnicornRace.BicornHairColors;
    public static var AlicornFurColors : Array<Dynamic> = UnicornRace.UnicornFurColors;
    public static var AlicornHairColors : Array<Dynamic> = UnicornRace.UnicornHairColors;
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Human", 
        /*Balls*/"Human", 
        /*Breasts*/"Normal", 
        /*Nips*/"Human", 
        /*Ears*/"Horse", 
        /*Eyes*/"Alicorn", 
        /*Face*/"Human", 
        /*Gills*/"None", 
        /*Hair*/"Alicorn", 
        /*Horns*/"Unicorn", 
        /*LowerBody*/"Horse", 
        /*RearBody*/"Human", 
        /*Skin*/"Alicorn", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Horse", 
        /*Tongue*/"Human", 
        /*Wings*/"Alicorn", 
        /*Penis*/"Horse", 
        /*Vagina*/"Horse", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Alicorn", id, RaceBody);
        chimeraTier = 2;
        grandChimeraTier = 3;
    }
    
    
    
    override public function setup() : Void
    {
        addScores().faceType(ANY(Face.HUMAN, Face.HORSE), +1, -1000).hornType(ANY(Horns.UNICORN, Horns.BICORN), 0, -1000).earType(Ears.HORSE, +1).tailType(Tail.HORSE, +1).legType(ANY(LowerBody.CLOVEN_HOOFED, LowerBody.HOOFED), +2).eyeType(Eyes.HUMAN, +1).skinPlainOnly(+1).hasCockOfType(CockTypesEnum.HORSE, +1).vaginaType(VaginaClass.EQUINE, +1).hornTypeAndCount(Horns.UNICORN, cast((6), LESS_THAN), +1, 0, "Alicorn branch - size 1-5 unicorn horn").hornTypeAndCount(Horns.UNICORN, cast((6), AT_LEAST), +2, 0, "Alicorn branch - size 6+ unicorn horn").hornTypeAndCount(Horns.BICORN, cast((6), LESS_THAN), +1, 0, "Nightmare branch - size 1-5 bicorn horns").hornTypeAndCount(Horns.BICORN, cast((6), AT_LEAST), +2, 0, "Nightmare branch - size 6+ bicorn horns").customRequirement("", 
                "Wings match horns", 
                function(body : BodyData) : Bool
                {
                    if (body.hornType == Horns.UNICORN)
                    {
                        return body.wingType == Wings.FEATHERED_ALICORN;
                    }
                    if (body.hornType == Horns.BICORN)
                    {
                        return body.wingType == Wings.NIGHTMARE;
                    }
                    return false;
                }, 0, -1000
        );
        
        addConditionedScores(
                                                function(body : BodyData) : Bool
                                                {
                                                    return body.hornType == Horns.UNICORN;
                                                }, "Alicorn branch;"
                        ).wingType(Wings.FEATHERED_ALICORN, +4).customRequirement(
                                "", 
                                "hair color: " + AlicornHairColors.join("/") +
                                "; coat color: " + AlicornFurColors.join("/"), 
                                function(body : BodyData) : Bool
                                {
                                    return Utils.InCollection(body.hairColor1, AlicornHairColors) &&
                                    Utils.InCollection(body.furColor1, AlicornFurColors);
                                }, 
                                +1
                ).eyeColor("blue", +1).hasPerk(PerkLib.AvatorOfPurity, +1)  // can't -1000 here because condition is &&'d with the horn type  ;
        addConditionedScores(
                                                function(body : BodyData) : Bool
                                                {
                                                    return body.hornType == Horns.BICORN;
                                                }, "Nightmare branch;"
                        ).wingType(Wings.NIGHTMARE, +4).customRequirement(
                                "", 
                                "hair color: " + NightmareHairColors.join("/") +
                                "; coat color: " + NightmareFurColors.join("/"), 
                                function(body : BodyData) : Bool
                                {
                                    return Utils.InCollection(body.hairColor1, NightmareHairColors) &&
                                    Utils.InCollection(body.furColor1, NightmareFurColors);
                                }, 
                                +1
                ).eyeColor("red", +1).hasPerk(PerkLib.AvatorOfCorruption, +1);
        
        addMutation(IMutationsLib.TwinHeartIM, +2);
        addMutation(IMutationsLib.EclipticMindIM);
        addMutation(IMutationsLib.EquineMuscleIM);
        
        buildTier(8, "Half Alicorn/Nightmare").customNamingFunction(Utils.curry(nameFn, 1)).buffs({
                            tou.mult : +0.15,
                            spe.mult : +0.50,
                            int.mult : +0.55
                        }).end();
        
        buildTier(18, "Alicorn/Nightmare").customNamingFunction(Utils.curry(nameFn, 2)).buffs({
                                    tou.mult : +0.55,
                                    spe.mult : +1.20,
                                    int.mult : +0.95,
                                    maxhp_base : +250,
                                    maxfatigue_base : +50,
                                    maxsf_mult : +0.2
                                }).withExtraBonuses(
                        "Mana & SF recovery +10%", 
                        "Combat HP regen +200", 
                        "Healing / Regenerate Spell +300% for Alicorn / Nightmare"
            ).end();
        
        buildTier(27, "True Alicorn/Nightmare").customNamingFunction(Utils.curry(nameFn, 3)).buffs({
                                    str.mult : +0.60,
                                    tou.mult : +0.70,
                                    spe.mult : +1.50,
                                    int.mult : +1.25,
                                    maxhp_base : +250,
                                    maxfatigue_base : +50,
                                    maxsf_mult : +0.2
                                }).withExtraBonuses(
                        "Mana & SF recovery +10%", 
                        "Combat HP regen +200", 
                        "Healing / Regenerate Spell +300% for Alicorn / Nightmare"
            ).end();
    }
    private function nameFn(tier : Int, body : BodyData) : String
    {
        var s : String = "";
        
        if (tier == 1)
        {
            s = "half ";
        }
        else if (tier == 3)
        {
            s = "true ";
        }
        
        if (body.hornType == Horns.UNICORN)
        {
            s += "alicorn";
        }
        else
        {
            s += "nightmare";
        }
        
        if (!body.isTaur)
        {
            s += "-kin";
        }
        
        return s;
    }
}


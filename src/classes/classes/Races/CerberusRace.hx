package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class CerberusRace extends Race
{
    public static var CerberusEyeColors : Array<Dynamic> = ["red", "green"];
    public static var CerberusSkinColors : Array<Dynamic> = ["dark"];
    public static var CerberusFurColors : Array<Dynamic> = ["midnight black"];
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
        super("Cerberus", id, []);
    }
    
    override public function setup() : Void
    //.hairType(Hair.WILD, +1)
    {
        addScores().faceType(Face.CERBERUS, +1, -1000).tongueType(Tongue.DOG, +1).eyeType(Eyes.INFERNAL, +1).eyeColor(cast((CerberusEyeColors), ANY), +1).earType(Ears.DOG, +1).tailType(Tail.DOG, +1).armType(Arms.HOUND, +1).legType(LowerBody.DOG, +1).rearType(RearBody.HELLHOUND_COLLAR, +1).hasCockOfType(CockTypesEnum.DOG, +1).customRequirement("", "twin cocks", 
                                                                                                                function(body : BodyData) : Bool
                                                                                                                {
                                                                                                                    return body.hasCock && body.cockCount == 2;
                                                                                                                }, +1, -10
                                                        ).hasBalls(+1).customRequirement("", "quad balls", 
                                                                                                function(body : BodyData) : Bool
                                                                                                {
                                                                                                    return body.hasBalls && body.ballCount == 4;
                                                                                                }, +1
                                                ).skinCoatType(Skin.FUR, +1).furColor1(cast((CerberusFurColors), ANY), +1).hairColor1(cast((CerberusFurColors), ANY), +1).skinColor1("grayish-blue", +1).noWings(+4).height(cast((11 * 12), AT_LEAST), +1).tone(cast((80), AT_LEAST), +1).corruption(cast((50), AT_LEAST), +1).hasPerk(PerkLib.Hellfire, +1).hasPerk(PerkLib.TransformationImmunity2, +3);
        
        addMutation(IMutationsLib.AlphaHowlIM);
        addMutation(IMutationsLib.HellhoundFireBallsIM);
        
        buildTier(24, "Cerberus").namesMaleFemaleMorphTaur("Hellhound Cerberus", "Barghest Cerberus", "Cerberus", "Cerberus-taur").buffs({
                                    str.mult : +3.5,
                                    spe.mult : +2.6,
                                    tou.mult : +2.1,
                                    lib.mult : +2.6
                                }).requirePerk(PerkLib.TransformationImmunity2).end();
        
        buildTier(27, "Greater Cerberus").requirePreviousTier().namesMaleFemale("Greater Hellhound Cerberus", "Greater Barghest Cerberus").buffs({
                            str.mult : +4.1,
                            spe.mult : +2.9,
                            tou.mult : +2.25,
                            lib.mult : +2.9
                        }).end();
        
        buildTier(30, "Cerberus Lord").requirePreviousTier().namesMaleFemale("Hellhound Cerberus Lord", "Barghest Cerberus Lord").buffs({
                            str.mult : +4.7,
                            spe.mult : +3.2,
                            tou.mult : +2.4,
                            lib.mult : +3.2
                        }).end();
        
        buildTier(33, "Alpha Cerberus").requirePreviousTier().namesMaleFemale("Alpha Hellhound Cerberus", "Alpha Barghest Cerberus").buffs({
                            str.mult : +5.3,
                            spe.mult : +3.5,
                            tou.mult : +2.55,
                            lib.mult : +3.5
                        }).end();
    }
    
    public static function isCerberus(body : BodyData) : Bool
    {
        return body.faceType == Face.CERBERUS;
    }
}


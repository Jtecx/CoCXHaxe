package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class TrollRace extends Race
{
    public static var TrollEyeColors : Array<Dynamic> = ["green", "grey"];
    public static var TrollFurColors : Array<Dynamic> = ["green", "grey"];
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
        super("Troll", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.TROLL, +1).earType(Ears.TROLL, +1).eyeTypeAndColor(Eyes.HUMAN, cast((TrollEyeColors), ANY), +2).armType(Arms.TROLL, +2).legType(LowerBody.TROLL, +2).skinCoatTypeAndColor1(Skin.FUR, cast((TrollFurColors), ANY), +2).biggestTitSize(cast((2), AT_MOST), +1).height(cast((84), AT_LEAST), +1).customRequirement("", "Glacial Troll Tail and having cock OR having human vagina", 
                        function(body : BodyData) : Bool
                        {
                            return (body.tailType == Tail.TROLL && body.player.hasCock()) || (body.player.hasVagina() && body.player.vaginaType() == VaginaClass.HUMAN);
                        }, +1
            ).customRequirement("", "Feminity less than 71", 
                function(body : BodyData) : Bool
                {
                    return body.player.femininity <= 70;
                }, +1
        );
        
        buildTier(10, "troll").buffs({
                            str.mult : +0.30,
                            tou.mult : +0.30,
                            spe.mult : +0.20,
                            int.mult : +0.20,
                            wis.mult : +0.60
                        }).end();
    }
}


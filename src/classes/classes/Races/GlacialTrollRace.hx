package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class GlacialTrollRace extends Race
{
    public static var GlacialTrollFurColors : Array<Dynamic> = ["blue", "white"];
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
        super("Glacial Troll", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.GLACIAL_TROLL, +1).earType(Ears.GLACIAL_TROLL, +1).eyeTypeAndColor(Eyes.HUMAN, "blue", +2).armType(Arms.GLACIAL_TROLL, +2).legType(LowerBody.GLACIAL_TROLL, +2).skinCoatTypeAndColor1(Skin.FUR, cast((GlacialTrollFurColors), ANY), +2).biggestTitSize(cast((2), AT_MOST), +1).height(cast((84), AT_LEAST), +1).customRequirement("", "Troll Tail and having cock OR having human vagina", 
                        function(body : BodyData) : Bool
                        {
                            return (body.tailType == Tail.TROLL && body.player.hasCock()) || (body.player.hasVagina() && body.player.vaginaType() == VaginaClass.HUMAN);
                        }, +1
            ).customRequirement("", "Feminity less than 56", 
                function(body : BodyData) : Bool
                {
                    return body.player.femininity <= 55;
                }, +1
        );
        
        buildTier(10, "glacial troll").buffs({
                            str.mult : +0.30,
                            tou.mult : +0.40,
                            spe.mult : +0.10,
                            int.mult : +0.20,
                            wis.mult : +0.50
                        }).end();
    }
}


package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.CockTypesEnum;
import classes.Race;
import classes.VaginaClass;

class SatyrRace extends Race
{
    public static var SatyrHairColors : Array<Dynamic> = ["red", "mahogany", "brown"];
    public static var SatyrFurColors : Array<Dynamic> = ["red", "mahogany", "brown"];
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
        super("Satyr", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().hornType(ANY(Horns.GOAT, Horns.GOATQUAD), +1).eyeType(Eyes.GOAT, +1).eyeColor("golden", +1).skinPlainOnly(+1).faceType(Face.HUMAN, +1).hairType(Hair.NORMAL, +1).hairColor1(cast((SatyrHairColors), ANY), +1).furColor01(cast((SatyrFurColors), ANY), +1).earType(Ears.ELFIN, +1).tongueType(Tongue.ELF, +1).armType(Arms.SATYR, +1).tailType(Tail.GOAT, +1).legType(LowerBody.CLOVEN_HOOFED, +1).customRequirement("", "High Masculinity Satyr", 
                                function(body : BodyData) : Bool
                                {
                                    return (body.player.femininity < 50 && body.player.hasCock());
                                }, +1
                ).customRequirement("", "High Feminity Faun", 
                        function(body : BodyData) : Bool
                        {
                            return (body.player.femininity > 50 && body.player.hasVagina());
                        }, +1
            ).cockOrVaginaOfType(CockTypesEnum.HUMAN, VaginaClass.HUMAN, +1);
        
        addMutation(IMutationsLib.MelkieLungIM);
        
        buildTier(12, "satyr").namesMaleFemale("satyr", "faun").buffs({
                            str.mult : +0.50,
                            tou.mult : +0.40,
                            lib.mult : +1.50,
                            sens : +60
                        }).end();
        
        buildTier(18, "elder satyr").namesMaleFemale("elder satyr", "elder faun").buffs({
                            str.mult : +0.85,
                            tou.mult : +0.70,
                            lib.mult : +1.75,
                            sens : +60
                        }).end();
    }
}


package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.Race;
import classes.Races;

class PlantRace extends Race
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
        super("Plant", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    //	if (skinType == 6)/zielona skóra +1, bark skin +2
    {
        addScores().faceType(Face.HUMAN, +1).faceType(cast((Face.PLANT_DRAGON), NOT), 0, -1).hornType(ANY(Horns.OAK, Horns.ORCHID), +1).earType(Ears.ELFIN, +1).earType(cast((Ears.LIZARD), NOT), 0, -1).hairTypeAndColor1(ANY(Hair.LEAF, Hair.GRASS), "green", +1).plainSkinOfColor1(ANY("leaf green", "lime green", "turquoise", "light green"), +1).customRequirement("skin", "bark skin", function(body : BodyData) : Bool
                                                                {
                                                                    return body.player.isBarkSkin();
                                                                }, +2).armType(Arms.PLANT, +1).legType(ANY(LowerBody.PLANT_HIGH_HEELS, LowerBody.PLANT_ROOT_CLAWS), +1).hasCockOfType(CockTypesEnum.TENTACLE, +1).wingType(Wings.PLANT, +1).customRequirement("", "not alraune", 
                        function(body : BodyData) : Bool
                        {
                            return !body.player.isRace(Races.ALRAUNE);
                        }, 0, -7
            ).customRequirement("", "not yggdrasil", 
                function(body : BodyData) : Bool
                {
                    return !body.player.isRace(Races.YGGDRASIL);
                }, 0, -4
        );
        
        buildTier(7, "plant-morph").buffs({
                            str.mult : +0.25,
                            tou.mult : +0.75,
                            spe.mult : -0.25,
                            def : +5
                        }).end();
        
        buildTier(10, "treant").namesMaleFemaleTaur("treant", "dryad", "treant-taur", "dryad-taur").buffs({
                            str.mult : +0.40,
                            tou.mult : +1.30,
                            spe.mult : -0.50,
                            def : +10,
                            mdef : +2
                        }).end();
    }
}


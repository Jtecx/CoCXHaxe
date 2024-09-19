package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class DogRace extends Race
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
        super("Dog", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.DOG, +1).earType(Ears.DOG, +1).tailType(Tail.DOG, +1).legType(LowerBody.DOG, +1).hasCockOfType(CockTypesEnum.DOG, +1).breastRowCount(2, +1).breastRowCount(3, +2).skinCoatType(Skin.FUR, +1).customRequirement("", "not Cerberus", 
                function(body : BodyData) : Bool
                {
                    return !(CerberusRace.isCerberus(body));
                }, 0, -1000
        );
        
        buildTier(4, "dog-morph").namesMaleFemaleMorphTaur("dog-boy", "dog-girl", "dog-morph", "dog-taur").buffs({
                            str.mult : +0.15,
                            tou.mult : +0.15,
                            spe.mult : +0.35,
                            int.mult : -0.05
                        }).end();
    }
}


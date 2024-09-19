package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

class LaquineRace extends Race
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
        super("Laquine", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(ANY(Face.BUNNY, Face.BUCKTEETH), +1).earType(Ears.BUNNY, +1, -10).eyeType(Eyes.HUMAN, +1).armType(Arms.HUMAN, +1).legType(LowerBody.BUNNY, +1).skinCoatType(Skin.FUR, +2).tailType(ANY(Tail.RABBIT, Tail.HORSE), +1).noAntennae(+1).noWings(+1).tone(cast((60), AT_LEAST), +1).tone(cast((80), AT_LEAST), +1).tone(cast((100), AT_LEAST), +1).hasBalls(+1).height(cast((84), GREATER_THAN), +1).hasCockOfType(CockTypesEnum.HORSE, +1).vaginaType(VaginaClass.EQUINE, +1).customRequirement("", "No easter bunny balls", 
                function(body : BodyData) : Bool
                {
                    return !body.player.hasPerk(PerkLib.EasterBunnyBalls);
                }, 0, -10
        );
        
        addMutation(IMutationsLib.EquineMuscleIM);
        addMutation(IMutationsLib.MightyLegsIM);
        
        buildTier(12, "laquine").namesMaleFemale("laquine-boy", "laquine-girl").buffs({
                            str.mult : +0.80,
                            tou.mult : -0.10,
                            spe.mult : +0.80,
                            wis.mult : -0.20,
                            lib.mult : +1.00,
                            sens : +50
                        }).end();
        
        buildTier(20, "elder laquine").namesMaleFemale("elder laquine-boy", "elder laquine-girl").buffs({
                            str.mult : +1.50,
                            tou.mult : -0.20,
                            spe.mult : +1.20,
                            wis.mult : -0.50,
                            lib.mult : +2.00,
                            sens : +100
                        }).end();
    }
}


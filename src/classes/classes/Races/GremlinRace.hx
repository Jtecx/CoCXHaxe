package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.lists.BreastCup;

class GremlinRace extends Race
{
    public static var GremlinEyeColors : Array<Dynamic> = ["red", "yellow", "purple"];
    public static var GremlinSkinColors : Array<Dynamic> = ["light", "tan", "dark", "olive"];
    public static var GremlinHairColors : Array<Dynamic> = ["emerald", "green", "dark green", "aqua", "light green", "olive", "lime green", "turquoise"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Human", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Snake", 
        /*Eyes*/"Gorgon", 
        /*Face*/"Snake", 
        /*Gills*/"None", 
        /*Hair*/"Gorgon", 
        /*Horns*/"Human", 
        /*LowerBody*/"Snake", 
        /*RearBody*/"Human", 
        /*Skin*/"Snake", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Snake", 
        /*Wings*/"Human", 
        /*Penis*/"Lizard", 
        /*Vagina*/"Lizard", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Gremlin", id, []);
    }
    
    override public function setup() : Void
    {
        addScores().faceType(Face.CRAZY, +1).earType(Ears.GREMLIN, +1, -1000).hairType(Hair.CRAZY, +1).eyeType(Eyes.GREMLIN, +1).eyeColor(cast((GremlinEyeColors), ANY), +1).skinColor1(cast((GremlinSkinColors), ANY), +1, -1000).hairColor1(cast((GremlinHairColors), ANY), +1).armType(Arms.HUMAN, +1).legType(LowerBody.HUMAN, +1).skinPlainOnly(+1).noWings(0, -1).noTail(0, -1).noHorns(0, -1).height(cast((48), LESS_THAN), +2).hasVagina(+1).biggestTitSize(cast((BreastCup.A), GREATER_THAN), 0, +1).customRequirement("", "A cup tits or flat", 
                                                        function(body : BodyData) : Bool
                                                        {
                                                            return body.biggestTitSize <= 1;
                                                        }, +1
                            ).femininity(cast((70), GREATER_THAN), +1).corruption(cast((30), AT_LEAST), +2).hasPerk(PerkLib.GoblinoidBlood, +1).hasPerk(PerkLib.BouncyBody, +1).hasPerk(PerkLib.Soulless, +4);
        
        addBloodline(PerkLib.GoblinsDescendant, PerkLib.BloodlineGoblin);
        addMutation(IMutationsLib.NaturalPunchingBagIM);
        addMutation(IMutationsLib.GoblinOvariesIM);
        addMutation(IMutationsLib.BlackHeartIM);
        
        buildTier(15, "gremlin-kin").buffs({
                            str.mult : -0.50,
                            spe.mult : +0.75,
                            int.mult : +1.20,
                            lib.mult : +1.00,
                            sens : +20
                        }).end();
        
        buildTier(24, "gremlin").requirePerk(PerkLib.Soulless).buffs({
                            str.mult : -0.50,
                            spe.mult : +1.00,
                            int.mult : +1.80,
                            lib.mult : +1.50,
                            sens : +20
                        }).end();
        
        buildTier(36, "arch gremlin").requirePerk(PerkLib.Soulless).buffs({
                            str.mult : -0.50,
                            spe.mult : +1.60,
                            int.mult : +2.50,
                            lib.mult : +2.00,
                            sens : +20
                        }).end();
    }
}


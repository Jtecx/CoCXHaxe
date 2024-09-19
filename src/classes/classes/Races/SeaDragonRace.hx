package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class SeaDragonRace extends Race
{
    public static var SeaDragonEyeColors : Array<Dynamic> = ["orange", "yellow", "light green"];
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
        super("Sea Dragon", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().hornType(Horns.SEA_DRAGON, +1).antennaeType(Antennae.SEA_DRAGON, +1).earType(Ears.ORCA, +1).tailType(Tail.ORCA, +1).faceType(Face.ORCA, +1, -1000).tongueType(Tongue.DRACONIC, +1).eyeType(Eyes.DRACONIC, +1).eyeColor(cast((SeaDragonEyeColors), ANY), +1).hairType(Hair.PRISMATIC, +1).legType(LowerBody.SEA_DRAGON, +1, -1000).armType(Arms.SEA_DRAGON, +1, -1000).rearType(RearBody.ORCA_BLOWHOLE, +1).skinPlainOnly(+1).skinBaseAdj("glossy", +1).skinBasePattern(Skin.PATTERN_SEA_DRAGON_UNDERBODY, +1).wingType(Wings.SEA_DRAGON, +6, -1000).customRequirement("body", "not toned", 
                                                function(body : BodyData) : Bool
                                                {
                                                    return body.player.tone < 10;
                                                }, +1
                        ).height(cast((84), AT_LEAST), +1).customRequirement("", "big breasted female or futa; or big dragon cock", 
                                function(body : BodyData) : Bool
                                {
                                    return body.hasVagina && body.player.biggestTitSize() > 19 ||
                                    body.player.dragonCocks() > 0;
                                }, 
                                +1
                ).hasPerk(PerkLib.DragonWaterBreath, +1).hasPerk(PerkLib.Dracoforce, +1);
        
        addMutation(IMutationsLib.DrakeBloodIM);
        addMutation(IMutationsLib.DrakeBonesIM);
        addMutation(IMutationsLib.DrakeLungsIM);
        addMutation(IMutationsLib.WhaleFatIM);
        
        buildTier(20, "sea dragon").namesMaleFemaleTaur("sea dragon-boy", "sea dragon-girl", "sea dragon-taur").buffs({
                            str.mult : +1.10,
                            spe.mult : +0.70,
                            tou.mult : +0.70,
                            int.mult : +0.50,
                            def : +1,
                            mdef : +1
                        }).end();
        
        buildTier(30, "leviathan").namesMaleFemaleTaur("leviathan-boy", "leviathan-girl", "leviathan-taur").buffs({
                            str.mult : +2.00,
                            spe.mult : +1.00,
                            tou.mult : +1.00,
                            int.mult : +0.50,
                            def : +5,
                            mdef : +5
                        }).end();
    }
    
    public static function isSeaDragonLike(body : BodyData) : Bool
    {
        return body.wingType == Wings.SEA_DRAGON || body.legType == LowerBody.SEA_DRAGON || body.armType == Arms.SEA_DRAGON;
    }
}


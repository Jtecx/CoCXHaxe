package classes.races;

import haxe.Constraints.Function;
import classes.BodyData;
import classes.bodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Player;
import classes.Race;
import classes.VaginaClass;

import classes.RaceTier;
import classes.Races;
import classes.races.HumanRace;
import classes.stats.StatUtils;

class HumanRace extends Race
{
    public static var HumanSkinColors : Array<Dynamic> = ["tan", "olive", "dark", "light"];
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
        super("Human", id, RaceBody);
        chimeraTier = 0;
        grandChimeraTier = 0;
    }
    
    override public function setup() : Void
    {
        addScores().plainSkinOfAdj(cast(("slippery"), NOT), +1).hairType(Hair.NORMAL, +1).faceType(Face.HUMAN, +1).eyeType(Eyes.HUMAN, +1).earType(Ears.HUMAN, +1).earType(cast((Ears.ELVEN), NOT), 0, -7).tongueType(Tongue.HUMAN, +1).noGills(+1).noAntennae(+1).noHorns(+1).noWings(+1).noTail(+1).armType(Arms.HUMAN, +1).legType(LowerBody.HUMAN, +1).noRearBody(+1).skinBasePattern(Skin.PATTERN_NONE, +1).cockOrVaginaOfType(CockTypesEnum.HUMAN, VaginaClass.HUMAN, +1).customRequirement("", "normal skin and 1 breast row", 
                                                                                                        function(body : BodyData) : Bool
                                                                                                        {
                                                                                                            return (body.player.breastRows.length == 1 && body.player.hasPlainSkinOnly() && body.skinBaseAdj != "slippery");
                                                                                                        }, +1
                                                    ).hasPerk(PerkLib.HumanSupremacyInitial, +2).hasPerk(PerkLib.HumanSupremacyBasic, +2).hasPerk(PerkLib.HumanSupremacyImproved, +3).hasPerk(PerkLib.HumanSupremacySuperior, +4).hasPerk(PerkLib.HumanSupremacyPeerless, +4).customRequirement("", "Bloodline: Common human OR Common human's descendant", 
                                                        function(body : BodyData) : Bool
                                                        {
                                                            return (body.player.hasPerk(PerkLib.CommonHumanBloodline)
                                                            || body.player.hasPerk(PerkLib.CommonHumansDescendant));
                                                        }, +2
                            ).customRequirement("", "Bloodline: Noble human OR Noble human's descendant", 
                                                function(body : BodyData) : Bool
                                                {
                                                    return (body.player.hasPerk(PerkLib.NobleHumanBloodline)
                                                    || body.player.hasPerk(PerkLib.NobleHumansDescendant));
                                                }, +4
                        ).customRequirement("", "Bloodline: Royal human OR Royal human's descendant", 
                                        function(body : BodyData) : Bool
                                        {
                                            return (body.player.hasPerk(PerkLib.RoyalHumanBloodline)
                                            || body.player.hasPerk(PerkLib.RoyalHumansDescendant));
                                        }, +6
                    ).customRequirement("", "Bloodline: Primarch OR Primarch's descendant", 
                                function(body : BodyData) : Bool
                                {
                                    return (body.player.hasPerk(PerkLib.PrimarchBloodline)
                                    || body.player.hasPerk(PerkLib.PrimarchsDescendant));
                                }, +10
                ).hasPerk(PerkLib.AlteredAnima, -10).hasPerk(PerkLib.Soulless, -20);
        
        addMutation(IMutationsLib.HumanAdrenalGlandsIM);
        addMutation(IMutationsLib.HumanBloodstreamIM);
        addMutation(IMutationsLib.HumanBonesIM);
        addMutation(IMutationsLib.HumanDigestiveTractIM);
        addMutation(IMutationsLib.HumanEyesIM);
        addMutation(IMutationsLib.HumanFatIM);
        addMutation(IMutationsLib.HumanMetabolismIM);
        addMutation(IMutationsLib.HumanMusculatureIM);
        addMutation(IMutationsLib.HumanOvariesIM);
        addMutation(IMutationsLib.HumanParathyroidGlandIM);
        addMutation(IMutationsLib.HumanSmartsIM);
        addMutation(IMutationsLib.HumanTesticlesIM);
        addMutation(IMutationsLib.HumanThyroidGlandIM);
        addMutation(IMutationsLib.HumanVersatilityIM);
        
        tiers.push(new HumanRaceTier(1, maxScore - 9, "Human", {
                    str.mult : +0.20,
                    tou.mult : +0.20,
                    spe.mult : +0.20,
                    int.mult : +0.20,
                    wis.mult : +0.20,
                    lib.mult : +0.20
                }));
        tiers.push(new HumanRaceTier(2, maxScore + 1, "Super Human", {
                    str.mult : +0.50,
                    tou.mult : +0.50,
                    spe.mult : +0.50,
                    int.mult : +0.50,
                    wis.mult : +0.50,
                    lib.mult : +0.50,
                    sens : +30
                }));
        tiers.push(new HumanRaceTier(3, maxScore + 19, "Primaris Super Human", {
                    str.mult : +1.00,
                    tou.mult : +1.00,
                    spe.mult : +1.00,
                    int.mult : +1.00,
                    wis.mult : +1.00,
                    lib.mult : +1.00,
                    sens : +60
                }));
        
        debugForms = {
                    human : [
                    game.transformations.SkinPlain, 
                    game.transformations.HairHuman, 
                    game.transformations.FaceHuman, 
                    game.transformations.EyesHuman, 
                    game.transformations.EarsHuman, 
                    game.transformations.TongueHuman, 
                    game.transformations.GillsNone, 
                    game.transformations.AntennaeNone, 
                    game.transformations.HornsNone, 
                    game.transformations.WingsNone, 
                    game.transformations.TailNone, 
                    game.transformations.ArmsHuman, 
                    game.transformations.LowerBodyHuman, 
                    game.transformations.RearBodyNone, 
                    game.transformations.SkinPatternNone, 
                    game.transformations.NipplesPerBreastOne, 
                    game.transformations.BreastRowsRemoveToOne
            ]
                };
    }
    
    public static inline var maxScore : Int = 17;
    
    override public function finalizeScore(body : BodyData, score : Int, checkRP : Bool = true, outputText : Function = null) : Int
    {
        var icsp : Float = 1;
        if (body.player.hasPerk(PerkLib.CommonHumanBloodline) || body.player.hasPerk(PerkLib.CommonHumansDescendant))
        {
            icsp -= 0.1;
        }
        if (body.player.hasPerk(PerkLib.NobleHumanBloodline) || body.player.hasPerk(PerkLib.NobleHumansDescendant))
        {
            icsp -= 0.2;
        }
        if (body.player.hasPerk(PerkLib.RoyalHumanBloodline) || body.player.hasPerk(PerkLib.RoyalHumansDescendant))
        {
            icsp -= 0.3;
        }
        if (body.player.hasPerk(PerkLib.PrimarchBloodline) || body.player.hasPerk(PerkLib.PrimarchsDescendant))
        {
            icsp -= 0.4;
        }
        var ics : Float = (Math.round(body.player.internalChimeraScore() * icsp) - body.player.internalHumanScore());
        if (ics < 0)
        {
            ics = 0;
        }
        if (ics > 0)
        {
            if (outputText != null)
            {
                outputText((ics == 1) ? "Mutation" : "Mutations", -ics);
            }
            score -= as3hx.Compat.parseInt(ics);
        }
        score = super.finalizeScore(body, score, checkRP, outputText);
        return score;
    }
    
    public static function xpBoostBase(player : Player) : Float
    {
        var baseHumBoost1 : Float = 1;
        if (player.level >= 6)
        {
            baseHumBoost1 += 1;
        }
        if (player.level >= 24)
        {
            baseHumBoost1 += 1;
        }
        if (player.level >= 42)
        {
            baseHumBoost1 += 1;
        }
        if (player.level >= 72)
        {
            baseHumBoost1 += 1;
        }
        if (player.level >= 102)
        {
            baseHumBoost1 += 1;
        }
        if (player.level >= 141)
        {
            baseHumBoost1 += 1;
        }
        if (player.level >= 180)
        {
            baseHumBoost1 += 1;
        }
        //if (level >= 274)
        return baseHumBoost1;
    }
    
    public static function xpBoostMultiplier(player : Player, humanScore : Int) : Float
    {
        var boost : Float = 10 + humanScore - maxScore;
        return (boost > 0) ? boost : 0;
    }
    
    public static function xpBoost(player : Player, humanScore : Int) : Float
    {
        return xpBoostBase(player) * xpBoostMultiplier(player, humanScore);
    }
}



class HumanRaceTier extends RaceTier
{
    public function new(tierNumber : Int, minScore : Int, tierName : String, buffs : Dynamic)
    {
        super(
                tierNumber, 
                tierName, 
                /* nameFn */function(body : BodyData) : String
                {
                    return tierName;
                }, 
                minScore, 
                /* buff object */buffs, 
                /* requirement list */[], 
                /* extra bonus names */[]
        );
    }
    
    override public function hasBuffs() : Bool
    {
        return true;
    }
    
    override public function describeBuffs(
            body : BodyData,
            separator : String = ", ",
            withExtraBonuses : Bool = true) : String
    {
        var s : Array<Dynamic> = [];
        if (!withExtraBonuses)
        {
            return "";
        }
        if (body != null)
        {
            var boost : Float = HumanRace.xpBoost(body.player, body.player.racialScore(Races.HUMAN));
            s.push("+" + boost + " bonus EXP gains");
        }
        else
        {
            s.push("Additional EXP gains");
        }
        var buffs : Dynamic = this.buffs(body);
        for (key in Reflect.fields(buffs))
        {
            s.push(StatUtils.explainBuff(key, Reflect.field(buffs, key)));
        }
        return s.join(", ");
    }
}

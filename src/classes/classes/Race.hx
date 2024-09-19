package classes;

import haxe.Constraints.Function;
import classes.transformations.Transformation;
import classes.transformations.transformations.RaceTransformations;
import classes.internals.Utils;
import classes.internals.race.ConditionedRaceScoreBuilder;
import classes.internals.race.RaceScoreBuilder;
import classes.internals.race.RaceTierBuilder;
import classes.internals.race.RaceTierRequirement;
import classes.internals.race.RacialRequirement;
import classes.geneticMemories.RaceMem;
import classes.scenes.Metamorph;

class Race
{
    public var minScore(get, never) : Int;
    private var game(get, never) : CoC;

    public static var RaceById : Dynamic = { };
    
    public static function byId(id : Int) : Race
    {
        return Reflect.field(RaceById, Std.string(id));
    }
    
    public var name : String;
    public var id : Int;
    public var requirements : Array<Dynamic> = [];
    public var tiers : Array<Dynamic> = [];
    public var bloodlinePerks : Array<Dynamic> = [];
    /**
	 * Array of pairs: `[mutationPerk:IMutationPerkType, scorePerStage:int]`
	 */
    public var mutations : Array<Dynamic> = [];
    /**
	 * Min score to get bonuses from mutation
	 */
    public var mutationThreshold : Int = 3;
    
    /**
	 * true - do not display the race in menus
	 */
    public var hidden : Bool = false;
    
    /**
	 * true - do not apply any bonuses
	 */
    public var disabled : Bool = false;
    /**
	 * Tier to contribute to chimera score. 0 or -1 if this race doesn't contribute.
	 */
    public var chimeraTier : Int = 1;
    /**
	 * Tier to contribute to grand chimera score. 0 or -1 if this race doesn't contribute.
	 */
    public var grandChimeraTier : Int = 2;
    
    /**
	 * Used to do Full Body Transformations
     */
    public var tfRace : Int = 0;
    
    /**
     * @param _name Display name of the race
     * @param _id Unique number id
     */
    private function new(_name : String, _id : Int, raceBody : Array<Dynamic>)
    {
        this.name = _name;
        this.id = _id;
        if (Lambda.has(RaceById, _id))
        {
            trace("[ERROR] Duplicate race id " + _id);
        }
        initRaceMemory(_name, raceBody);
        Reflect.setField(RaceById, Std.string(_id), this);
    }
    /**
	 * Configure tiers, requirements & other stuff
	 */
    public function setup() : Void
    {
    }
    
    public function basicScore(body : BodyData) : Int
    {
        var score : Int = 0;
        try
        {
            Utils.Begin("Race", "basicScore", name);
            for (req in requirements)
            {
                score += req.calcScore(body, score);
            }
        };finally;{
            Utils.End("Race", "basicScore");
        }
        return score;
    }
    
    public function totalScore(body : BodyData, checkRP : Bool = true) : Int
    {
        return finalizeScore(body, basicScore(body), checkRP);
    }
    
    /**
	 * Complete racial score calculation
	 * @param body
	 * @param score basic score
	 * @param checkRP set to true to check Racial Paragon and other conditions, setting the score to zero.
	 * @param outputText Optional function `(reason:String, scoreChange:int)=>void` to print reason of score changes.
	 * @return final racial score
	 */
    public function finalizeScore(
            body : BodyData,
            score : Int,
            checkRP : Bool = true,
            outputText : Function = null) : Int
    {
        var player : Player = body.player;
        var bonus : Int;
        if (bloodlinePerks.length > 0)
        {
            bonus = 0;
            for (perk in bloodlinePerks)
            {
                if (score >= mutationThreshold && body.player.hasPerk(perk))
                {
                    bonus += body.player.increaseFromBloodlinePerks();
                    break;
                }
            }
            if (outputText != null)
            {
                outputText("Bloodline", bonus);
            }
            score += bonus;
        }
        if (mutations.length > 0)
        {
            bonus = 0;
            var maxStage : Int = 0;
            for (entry in mutations)
            
            // entry: [mutationPerk:PerkType, scorePerStage:int]{
                
                var pt : PerkType = Reflect.field(entry, Std.string(0));
                var pc : PerkClass = body.player.getPerk(pt);
                var stage : Float = (pc != null) ? pc.value1 : 0;
                bonus = (score >= mutationThreshold) ? stage * Reflect.field(entry, Std.string(1)) : 0;
                if (outputText != null)
                {
                    outputText("Mutation: " + pt.name(pc), bonus);
                }
                score += bonus;
                maxStage = Math.max(maxStage, stage);
            }
            //if (outputText != null) outputText("Mutations", bonus);
            //score += bonus;
            if (body.player.hasPerk(PerkLib.ChimericalBodySemiImprovedStage))
            {
                bonus = (score >= mutationThreshold && maxStage >= 1) ? +1 : 0;
                if (outputText != null)
                {
                    outputText("Chimerical Body: Semi-Improved Stage", bonus);
                }
                score += bonus;
            }
            if (body.player.hasPerk(PerkLib.ChimericalBodySemiImprovedStageEx) || body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStageEx) || body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx))
            {
                bonus = (score >= mutationThreshold && maxStage >= 1) ? +1 : 0;
                if (outputText != null)
                {
                    var s1text : String = "";
                    if (body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx))
                    {
                        s1text = "Epic";
                    }
                    else if (body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStageEx))
                    {
                        s1text = "Superior";
                    }
                    else
                    {
                        s1text = "Improved";
                    }
                    outputText("Chimerical Body: Semi-" + s1text + " (Ex) Stage", bonus);
                }
                score += bonus;
            }
            if (body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))
            {
                bonus = (score >= mutationThreshold && maxStage >= 2) ? +1 : 0;
                if (outputText != null)
                {
                    outputText("Chimerical Body: Semi-Superior Stage", bonus);
                }
                score += bonus;
            }
            if (body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStageEx) || body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx))
            {
                bonus = (score >= mutationThreshold && maxStage >= 2) ? +1 : 0;
                if (outputText != null)
                {
                    var s2text : String = "";
                    if (body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx))
                    {
                        s2text = "Epic";
                    }
                    else
                    {
                        s2text = "Superior";
                    }
                    outputText("Chimerical Body: Semi-" + s2text + " (Ex) Stage", bonus);
                }
                score += bonus;
            }
            if (body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStage))
            {
                bonus = (score >= mutationThreshold && maxStage >= 3) ? +1 : 0;
                if (outputText != null)
                {
                    outputText("Chimerical Body: Semi-Epic Stage", bonus);
                }
                score += bonus;
            }
            if (body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStageEx))
            {
                bonus = (score >= mutationThreshold && maxStage >= 3) ? +1 : 0;
                if (outputText != null)
                {
                    outputText("Chimerical Body: Semi-Epic (Ex) Stage", bonus);
                }
                score += bonus;
            }
        }
        if (this != Races.HUMAN)
        {
            if (player.hasPerk(PerkLib.AscensionCruelChimerasThesis) && score >= minScore - 2)
            {
                if (outputText != null)
                {
                    outputText("Ascension: Cruel Chimera's Thesis", +1);
                }
                score += 1;
            }
            if (player.hasPerk(PerkLib.AscensionHybridTheory) && score >= minScore - 1)
            {
                if (outputText != null)
                {
                    outputText("Ascension: Hybrid Theory", +1);
                }
                score += 1;
            }
            if (player.hasPerk(PerkLib.ChimericalBodyUltimateStage))
            {
                if (outputText != null)
                {
                    outputText("Chimerical Body: Ultimate Stage", +50);
                }
                score += 50;
            }
        }
        if (checkRP)
        {
            if (player.hasPerk(PerkLib.RacialParagon) && this != player.racialParagonSelectedRace())
            {
                if (outputText != null)
                {
                    outputText("Racial Paragon", Math.min(-1, -score));
                }
                return 0;
            }
            if (player.isGargoyle() && this != Races.GARGOYLE)
            {
                if (outputText != null)
                {
                    outputText("Gargoyle", -score);
                }
                return 0;
            }
            if (player.hasPerk(PerkLib.ElementalBody) && this != Races.ELEMENTALFUSION)
            {
                if (outputText != null)
                {
                    outputText("Elemental", -score);
                }
                return 0;
            }
        }
        if (score < 0)
        {
            return 0;
        }
        // TODO: Khovel - Find better place to check for race unlock...
        unlockRaceMetamorph(getTierNumber(body, score, checkRP));
        return score;
    }
    
    
    public function getTier(body : BodyData, score : Int = -1, checkRP : Bool = true) : RaceTier
    {
        if (score < 0)
        {
            score = this.totalScore(body, checkRP);
        }
        var tier : RaceTier = null;
        var prev : Bool = false;
        for (i in tiers)
        {
            if (i.requiresPreviousTier && !prev)
            {
                continue;
            }
            if (i.check(body, score))
            {
                tier = i;
                prev = true;
            }
            else
            {
                prev = false;
            }
        }
        return tier;
    }
    public function getTierNumber(body : BodyData, score : Int = -1, checkRP : Bool = true) : Int
    {
        var tier : RaceTier = getTier(body, score, checkRP);
        if (tier == null)
        {
            return 0;
        }
        return tier.tierNumber;
    }
    public function tier(tierNumber : Int) : RaceTier
    {
        return this.tiers[tierNumber - 1];
    }
    public function maxTier() : Int
    {
        return ((tiers.length == 0)) ? 0 : tiers[tiers.length - 1].tierNumber;
    }
    
    public function nameFor(body : BodyData, score : Int = -1) : String
    {
        if (score < 0)
        {
            score = this.totalScore(body);
        }
        var tier : RaceTier = getTier(body, score);
        if (tier != null)
        {
            return tier.nameFor(body);
        }
        if (tiers.length > 0)
        {
            return tiers[0].nameFor(body);
        }
        return name;
    }
    
    private function get_minScore() : Int
    {
        if (this.tiers.length == 0)
        {
            return 1;
        }
        return this.tiers[0].minScore;
    }
    
    public function printDetails(body : BodyData) : String
    {
        var s : String = "";
        var score : Int = 0;
        var minScore : Int = 0;
        for (rr in requirements)
        {
            if (rr.minScore != minScore)
            {
                s += "\t<b>After score " + rr.minScore + ":</b>\n";
                minScore = rr.minScore;
            }
            s += "\t";
            var pass : Bool = rr.check(body, score);
            var rscore : Int = rr.calcScore(body, score);
            if (pass && rscore >= 0)
            {
                s += "[font-green]";
            }
            else if (pass && rscore < 0)
            {
                s += "[font-yellow]";
            }
            else
            {
                s += "[font-default]";
            }
            score += rscore;
            s += rr.getName();
            if (rr.varyingScore() && !pass)
            
            // do not display (+X) for requirements that have varying values and{
                
                // didn't pass, because value could be incorrect
                if (rscore <= -1000)
                {
                    s += " [/font][font-red](required)";
                }
                else if (rscore != 0)
                {
                    s += " [/font][font-red](" + rscore + " penalty)";
                }
            }
            else
            {
                var pscore : Int = rr.passScore(body);
                s += " (" + ((pscore > 0) ? "+" + pscore : pscore) + ")";
                if (rr.failScore < 0)
                {
                    s += "[/font]";
                    if (!pass && rscore == 0)
                    
                    // failScore < 0, rscore == 0 - this happens if requirement was skipped due to minScore{
                        
                        s += "[font-default]";
                    }
                    else if (!pass)
                    {
                        s += "[font-red]";
                    }
                    else if (rr.failScore <= -1000)
                    {
                        s += "[font-green]";
                    }
                    else
                    {
                        s += "[font-default]";
                    }
                    if (rr.failScore <= -1000)
                    {
                        s += " (required)";
                    }
                    else
                    {
                        s += " (" + rr.failScore + " penalty)";
                    }
                }
            }
            s += "[/font]\n";
        }
        var hasFinalizer : Bool = false;
        var finalizerOutput : String->Int->Void = function(reason : String, change : Int) : Void
        {
            if (!hasFinalizer)
            {
                s += "\t<b>Other:</b>\n";
                hasFinalizer = true;
            }
            s += "\t";
            if (change > 0)
            {
                s += "[font-green]";
            }
            else if (change < 0)
            {
                s += "[font-red]";
            }
            else
            {
                s += "[font-default]";
            }
            s += reason + " (" + ((change > 0) ? "+" + change : change) + ")";
            s += "[/font]\n";
        }
        score = finalizeScore(body, score, true, finalizerOutput);
        if (tiers.length > 0)
        {
            s += "\t<b>Tiers:</b>\n";
        }
        var actualTier : RaceTier = getTier(body, score);
        for (tier in tiers)
        {
            s += "\t<b>";
            var present : Bool = tier.check(body, score);
            if (tier == actualTier)
            {
                s += "[font-lblue]" + tier.nameFor(body);
            }
            else if (present)
            {
                s += "[font-green]" + tier.nameFor(body);
            }
            else
            {
                s += "[font-default]" + tier.name;
            }
            s += " (" + tier.minScore + ")[/font] </b>";
            if (tier == actualTier)
            {
                s += "[font-lblue]";
            }
            else
            {
                s += "[font-default]";
            }
            s += tier.describeBuffs((present) ? body : null);
            s += "[/font]";
            if (tier.requirements.length > 0)
            {
                s += ". Requires ";
                s += tier.requirements.map(Utils.varargify(function(rtr : RaceTierRequirement) : String
                                        // green: pass, red: pass core fail req, black: fail req
                                        {
                                            
                                            //noinspection JSReferencingMutableVariableFromClosure
                                            return ((score < tier.minScore) ? "[font-default]" : 
                                            (rtr.check(body)) ? "[font-green]" : "[font-red]") +
                                            rtr.name + "[/font]";
                                        })).join(", ");
                if (tier.requiresPreviousTier)
                {
                    s += " and previous tier";
                }
                s += ".";
            }
            else if (tier.requiresPreviousTier)
            {
                s += ". Requires previous tier.";
            }
            s += "\n";
        }
        return s;
    }
    
    // Race builder helper functions. Can be used as a substitute for type
    // Ex. faceType( ANY(Face.HUMAN, Face.TROLL), +1)
    // instead of faceType(Face.HUMAN, +1).faceType(Face.TROLL, +1)
    
    private static function ANY(options : Array<Dynamic> = null) : Dynamic
    {
        return {
            operator : "any",
            options : Utils.flatten(options)
        };
    }
    private static function NONE(options : Array<Dynamic> = null) : Dynamic
    {
        return {
            operator : "none",
            options : Utils.flatten(options)
        };
    }
    private static function LESS_THAN(value : Float) : Dynamic
    {
        return {
            operator : "lt",
            value : value
        };
    }
    private static function GREATER_THAN(value : Float) : Dynamic
    {
        return {
            operator : "gt",
            value : value
        };
    }
    private static function AT_MOST(value : Float) : Dynamic
    {
        return {
            operator : "le",
            value : value
        };
    }
    private static function AT_LEAST(value : Float) : Dynamic
    {
        return {
            operator : "ge",
            value : value
        };
    }
    private static function NOT(value : Dynamic) : Dynamic
    {
        return {
            operator : "ne",
            value : value
        };
    }
    
    // Race builder functions
    
    private function addScores() : RaceScoreBuilder
    {
        return new RaceScoreBuilder(this);
    }
    private function addScoresAfter(minScore : Int) : RaceScoreBuilder
    {
        return new RaceScoreBuilder(this, minScore);
    }
    /**
	 * @param conditionFn `(body:BodyData) => boolean`
	 */
    public function addConditionedScores(
            conditionFn : Function,
            conditionName : String,
            minScore : Int = 0) : RaceScoreBuilder
    {
        return new ConditionedRaceScoreBuilder(this, conditionFn, conditionName, minScore);
    }
    private function addBloodline(descendantPerk : PerkType, bloodlinePerk : PerkType) : Void
    {
        bloodlinePerks.push(descendantPerk);
        bloodlinePerks.push(bloodlinePerk);
    }
    private function addMutation(mutation : IMutationPerkType, scorePerStage : Int = +1) : Void
    {
        this.mutations.push([mutation, scorePerStage]);
    }
    private function buildTier(minScore : Int, name : String) : RaceTierBuilder
    {
        return new RaceTierBuilder(this, tiers.length + 1, minScore, name);
    }
    
    /**
	 * Key: debug form name
	 * Value: a list of elements of type:
	 * - function(player:Player):void
	 * - Transformation
	 * - StatusEffectType
	 * - IMutationPerkType
	 * - PerkType
	 * - array of form [StatusEffectType, value1, value2, value3, value4]
	 * - array of form [IMutationPerkType, stage]
	 * - array of form [PerkType, value1, value2, value3, value4]
	 */
    private var debugForms : Dynamic = { };
    public function debugFormNames() : Array<Dynamic>
    {
        return Utils.keys(debugForms);
    }
    public function takeForm(player : Player, tfName : String) : Void
    {
        for (o/* AS3HX WARNING could not determine type for var: o exp: EArray(EIdent(debugForms),EIdent(tfName)) type: Dynamic */ in Reflect.field(debugForms, tfName))
        {
            var f : Function = try cast(o, Function) catch(e:Dynamic) null;
            if (f != null)
            {
                f(player);
                continue;
            }
            var tf : Transformation = try cast(o, Transformation) catch(e:Dynamic) null;
            if (tf != null)
            {
                if (tf.isPossible())
                {
                    tf.applyEffect();
                }
                continue;
            }
            var st : StatusEffectType = try cast(o, StatusEffectType) catch(e:Dynamic) null;
            if (st != null)
            {
                player.createOrFindStatusEffect(st, 0, 0, 0, 0);
                continue;
            }
            var mt : IMutationPerkType = try cast(o, IMutationPerkType) catch(e:Dynamic) null;
            if (mt != null)
            {
                mt.acquireMutation(player, "none", mt.maxLvl);
                continue;
            }
            var pt : PerkType = try cast(o, PerkType) catch(e:Dynamic) null;
            if (pt != null)
            {
                if (!player.hasPerk(pt))
                {
                    player.createPerk(pt, 0, 0, 0, 0);
                }
                continue;
            }
            var a : Array<Dynamic> = try cast(o, Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null;
            if (a != null && a.length > 0)
            {
                st = try cast(a[0], StatusEffectType) catch(e:Dynamic) null;
                if (st != null && a.length == 5)
                {
                    var sec : StatusEffectClass = player.createOrFindStatusEffect(st, a[1], a[2], a[3], a[4]);
                    sec.value1 = a[1];
                    sec.value2 = a[2];
                    sec.value3 = a[3];
                    sec.value4 = a[4];
                    continue;
                }
                
                mt = try cast(o[0], IMutationPerkType) catch(e:Dynamic) null;
                if (mt != null && a.length == 2)
                {
                    mt.acquireMutation(player, "none", a[1]);
                    continue;
                }
                pt = try cast(a[0], PerkType) catch(e:Dynamic) null;
                if (pt != null && a.length == 5)
                {
                    var pc : PerkClass = player.getPerk(pt);
                    if (pc == null)
                    {
                        player.createPerk(pt, a[1], a[2], a[3], a[4]);
                    }
                    else
                    {
                        pc.value1 = a[1];
                        pc.value2 = a[2];
                        pc.value3 = a[3];
                        pc.value4 = a[4];
                    }
                    continue;
                }
            }
            trace("[ERROR] In " + name + ".transform() element " + o);
        }
    }
    
    public function unlockRaceMetamorph(tier : Int = 0) : Void
    {  //if(tier > 0 && tfRace > 0 && tier == maxTier())  
        //     Metamorph.unlockMetamorphMastery(RaceMem.getMemory(tfRace));
        
    }
    public function initRaceMemory(name : String, raceBody : Array<Dynamic>) : Void
    {
        if (raceBody.length > 1)
        {
            tfRace = RaceMem.appendEnumVal(name, RaceTransformations.raceTransform(name, raceBody, this));
        }
    }
    
    
    private function get_game() : CoC
    {
        return CoC.instance;
    }
}


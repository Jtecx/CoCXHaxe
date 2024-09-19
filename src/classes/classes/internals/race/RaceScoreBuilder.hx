package classes.internals.race;

import haxe.Constraints.Function;
import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.PerkType;
import classes.Race;
import classes.StatusEffectType;
import classes.VaginaClass;

class RaceScoreBuilder
{
    @:allow(classes.internals.race)
    private var race : Race;
    @:allow(classes.internals.race)
    private var minScore : Int;
    public function new(
            race : Race,
            minScore : Int = 0)
    {
        this.race = race;
        this.minScore = minScore;
    }
    
    public function armType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_ARM_TYPE, type, score, failScore, customName);
        return this;
    }
    public function antennaeType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_ANTENNAE_TYPE, type, score, failScore, customName);
        return this;
    }
    public function noAntennae(score : Int) : RaceScoreBuilder
    {
        return antennaeType(Antennae.NONE, score);
    }
    public function ballSize(size : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_BALL_SIZE, size, score, failScore, customName);
        return this;
    }
    public function biggestCockLength(length : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_BIGGEST_COCK_LENGTH, length, score, failScore, customName);
        return this;
    }
    public function biggestTitSize(size : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_BIGGEST_TIT_SIZE, size, score, failScore, customName);
        return this;
    }
    public function chitinColors(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_CHITIN_COLORS, color, score, failScore, customName);
        return this;
    }
    public function chitinColor1(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_CHITIN_COLOR1, color, score, failScore, customName);
        return this;
    }
    public function earType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_EAR_TYPE, type, score, failScore, customName);
        return this;
    }
    public function eyeType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_EYE_TYPE, type, score, failScore, customName);
        return this;
    }
    public function eyeColor(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_EYE_COLOR, type, score, failScore, customName);
        return this;
    }
    public function eyeTypeAndColor(type : Dynamic, color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "eyes", 
                        "; ", 
                        slotRequirement(BodyData.SLOT_EYE_COLOR, color, score, failScore), 
                        slotRequirement(BodyData.SLOT_EYE_TYPE, type, score, failScore)
            ), 
                customName
        );
        return this;
    }
    public function faceType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_FACE_TYPE, type, score, failScore, customName);
        return this;
    }
    public function furColors(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "skin coat", 
                        " colored ", 
                        slotRequirement(BodyData.SLOT_FUR_COLORS, color, score, failScore, false), 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FUR, score, failScore)
            ), customName
        );
        return this;
    }
    public function furColor1(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "skin coat", 
                        " colored ", 
                        slotRequirement(BodyData.SLOT_FUR_COLOR1, color, score, failScore, false), 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FUR, score, failScore)
            ), customName
        );
        return this;
    }
    public function furColor01(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_FUR_COLOR1, color, score, failScore, customName);
        return this;
    }
    public function furColor2(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "skin coat", 
                        " colored ", 
                        slotRequirement(BodyData.SLOT_FUR_COLOR2, color, score, failScore, false), 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FUR, score, failScore)
            ), customName
        );
        return this;
    }
    public function gillType(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_GILLS_TYPE, value, score, failScore, customName);
        return this;
    }
    public function noGills(score : Int, failScore : Int = 0) : RaceScoreBuilder
    {
        return gillType(Gills.NONE, score, failScore);
    }
    public function hairType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_HAIR_TYPE, type, score, failScore, customName);
        return this;
    }
    public function hairColors(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_HAIR_COLORS, type, score, failScore, customName);
        return this;
    }
    public function hairColor1(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_HAIR_COLOR1, type, score, failScore, customName);
        return this;
    }
    public function hairColor2(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_HAIR_COLOR2, type, score, failScore, customName);
        return this;
    }
    public function hairTypeAndColor1(type : Dynamic, color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "hair", 
                        "; ", 
                        slotRequirement(BodyData.SLOT_HAIR_COLOR1, color, score, failScore), 
                        slotRequirement(BodyData.SLOT_HAIR_TYPE, type, score, failScore)
            ), customName
        );
        return this;
    }
    public function hornType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_HORN_TYPE, type, score, failScore, customName);
        return this;
    }
    public function hornTypeAndCount(type : Dynamic, count : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "horn", 
                        " ", 
                        slotRequirement(BodyData.SLOT_HORN_COUNT, count, score, failScore, false), 
                        slotRequirement(BodyData.SLOT_HORN_TYPE, type, score, failScore)
            ), customName
        );
        return this;
    }
    public function noHorns(score : Int, failScore : Int = 0) : RaceScoreBuilder
    {
        return hornType(Horns.NONE, score, failScore);
    }
    public function legType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_LEG_TYPE, type, score, failScore, customName);
        return this;
    }
    public function isTaur(score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        return customRequirement("legs", customName || "taur lower body", 
                function(body : BodyData) : Bool
                {
                    return body.isTaur;
                }, 
                score, failScore
        );
    }
    public function isNotTaur(score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        return customRequirement("legs", customName || "not taur lower body", 
                function(body : BodyData) : Bool
                {
                    return !body.isTaur;
                }, 
                score, failScore
        );
    }
    public function isNaga(score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        return customRequirement("legs", customName || "naga-like lower body", 
                function(body : BodyData) : Bool
                {
                    return body.isNaga;
                }, 
                score, failScore
        );
    }
    public function rearType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_REAR_TYPE, type, score, failScore, customName);
        return this;
    }
    public function noRearBody(score : Int, failScore : Int = 0) : RaceScoreBuilder
    {
        return rearType(RearBody.NONE, score, failScore);
    }
    public function scaleColors(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SCALE_COLORS, color, score, failScore, customName);
        return this;
    }
    public function scaleColor1(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SCALE_COLOR1, color, score, failScore, customName);
        return this;
    }
    public function scaleColor2(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SCALE_COLOR2, color, score, failScore, customName);
        return this;
    }
    
    public function featherColors(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "skin coat", 
                        " colored ", 
                        slotRequirement(BodyData.SLOT_FEATHER_COLORS, color, score, failScore, false), 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FEATHER, score, failScore)
            ), customName
        );
        return this;
    }
    
    public function featherColor1(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "skin coat", 
                        " colored ", 
                        slotRequirement(BodyData.SLOT_FEATHER_COLOR1, color, score, failScore, false), 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FEATHER, score, failScore)
            ), customName
        );
        return this;
    }
    
    public function featherColor2(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "skin coat", 
                        " colored ", 
                        slotRequirement(BodyData.SLOT_FEATHER_COLOR2, color, score, failScore, false), 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, Skin.FEATHER, score, failScore)
            ), customName
        );
        return this;
    }
    
    public function skinCoverage(coverage : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_COVERAGE, coverage, score, failScore, customName);
        return this;
    }
    public function skinType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_TYPE, type, score, failScore, customName);
        return this;
    }
    public function bodyColors(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_BODY_COLORS, value, score, failScore, customName);
        return this;
    }
    public function bodyColor1(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_BODY_COLOR1, value, score, failScore, customName);
        return this;
    }
    public function skinBaseType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_BASE_TYPE, type, score, failScore, customName);
        return this;
    }
    public function skinBasePattern(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_BASE_PATTERN, value, score, failScore, customName);
        return this;
    }
    public function skinBaseAdj(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_BASE_ADJ, value, score, failScore, customName);
        return this;
    }
    public function skinCoatType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type, score, failScore, customName);
        return this;
    }
    public function skinColors(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_COLORS, color, score, failScore, customName);
        return this;
    }
    public function skinColor1(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_COLOR1, color, score, failScore, customName);
        return this;
    }
    public function skinColor2(color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_COLOR2, color, score, failScore, customName);
        return this;
    }
    public function skinCoatTypeAndColors(type : Dynamic, color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "skin coat", 
                        " colored ", 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_COLORS, color, score, failScore, false), 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type, score, failScore)
            ), customName
        );
        return this;
    }
    public function skinCoatTypeAndColor1(type : Dynamic, color : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(
                RacialRequirement.joinAnd(
                        "skin coat", 
                        " colored ", 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_COLOR1, color, score, failScore, false), 
                        slotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type, score, failScore)
            ), customName
        );
        return this;
    }
    public function skinCoatPattern(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_COAT_PATTERN, value, score, failScore, customName);
        return this;
    }
    public function skinPlainOnly(score : Int, failScore : Int = 0) : RaceScoreBuilder
    {
        return customRequirement(
                "skin", 
                "plain skin", 
                function(body : BodyData) : Bool
                {
                    return body.player.hasPlainSkinOnly();
                }, 
                score, 
                failScore
        );
    }
    public function plainSkinOfAdj(adj : Dynamic, score : Int, failScore : Int = 0) : RaceScoreBuilder
    {
        var oo : Dynamic = RaceUtils.parseOperatorObject(adj, null);
        return customRequirement(
                "skin", 
                function() : String
                {
                    return oo.nameFn() + " plain skin";
                }, 
                function(body : BodyData) : Bool
                {
                    return body.player.hasPlainSkinOnly() && oo.operatorFn(body.skinBaseAdj);
                }, 
                score, 
                failScore
        );
    }
    public function plainSkinOfColor1(color : Dynamic, score : Int, failScore : Int = 0) : RaceScoreBuilder
    {
        var oo : Dynamic = RaceUtils.parseOperatorObject(color, BodyData.defaultPhraseFn(" plain skin", null));
        return customRequirement(
                "skin", 
                oo.nameFn, 
                function(body : BodyData) : Bool
                {
                    return body.player.hasPlainSkinOnly() && oo.operatorFn(body.skinColor1);
                }, 
                score, 
                failScore
        );
    }
    public function tailType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_TAIL_TYPE, type, score, failScore, customName);
        return this;
    }
    public function noTail(score : Int, failScore : Int = 0) : RaceScoreBuilder
    {
        return tailType(Tail.NONE, score, failScore);
    }
    public function tailTypeAndCount(type : Dynamic, count : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        var req : RacialRequirement = RacialRequirement.joinAnd(
                "tail", 
                " ", 
                slotRequirement(BodyData.SLOT_TAIL_COUNT, count, score, failScore, false), 
                slotRequirement(BodyData.SLOT_TAIL_TYPE, type, score, failScore, false)
        );
        var nameFn : Function = function() : String
        {
            var suffix : String = "";
            if (Std.is(count, Float))
            {
                if (count > 1)
                {
                    suffix = " tails";
                }
                else
                {
                    suffix = " tail";
                }
            }
            else
            {
                suffix = " tail(s)";
            }
            return req.getName() + suffix;
        }
        addRequirement(req.withNameFn(nameFn), customName);
        return this;
    }
    public function tongueType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_TONGUE_TYPE, type, score, failScore, customName);
        return this;
    }
    public function vaginaType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_VAGINA_TYPE, type, score, failScore, customName);
        return this;
    }
    public function wingType(type : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_WING_TYPE, type, score, failScore, customName);
        return this;
    }
    public function noWings(score : Int, failScore : Int = 0) : RaceScoreBuilder
    {
        return wingType(Wings.NONE, score, failScore);
    }
    public function gender(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_GENDER, value, score, failScore, customName);
        return this;
    }
    public function height(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_HEIGHT, value, score, failScore, customName);
        return this;
    }
    public function thickness(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_THICKNESS, value, score, failScore, customName);
        return this;
    }
    public function tone(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_TONE, value, score, failScore, customName);
        return this;
    }
    public function corruption(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addOperatorRequirement(
                "stats", 
                "$value corruption", 
                function(body : BodyData) : Dynamic
                {
                    return body.player.cor;
                }, 
                null, 
                value, 
                score, 
                failScore, 
                customName
        );
        return this;
    }
    public function femininity(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addSlotRequirement(BodyData.SLOT_FEMININITY, value, score, failScore, customName);
        return this;
    }
    public function breastRowCount(value : Dynamic, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addOperatorRequirement(
                "breasts", 
                (value == 1) ? "$value breast row" : "$value breast rows", 
                function(body : BodyData) : Dynamic
                {
                    return body.player.breastRows.length;
                }, 
                null, 
                value, 
                score, 
                failScore, 
                customName
        );
        return this;
    }
    public function cockOrVaginaOfType(cockType : CockTypesEnum, vaginaType : Int, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        if (customName == null)
        {
            var c : String = cockType.DisplayName;
            var v : String = VaginaClass.Types[vaginaType].name;
            if (c == v)
            {
                customName = c + " cock or vagina";
            }
            else
            {
                customName = c + " cock or " + v + " vagina";
            }
        }
        return customRequirement("genitals", 
                customName, 
                function(body : BodyData) : Bool
                {
                    return body.vaginaType == vaginaType || body.player.countCocksWithType(cockType) > 0;
                }, 
                score, 
                failScore
        );
    }
    public function hasCockOfType(type : CockTypesEnum, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "cock", 
                type.DisplayName + " cock", 
                RaceUtils.hasCockOfTypeFn(type), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    public function hasBalls(score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "balls", 
                "has balls", 
                RaceUtils.hasBallsFn(true), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    public function noBalls(score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "balls", 
                "no balls", 
                RaceUtils.hasBallsFn(false), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    public function hasVagina(score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "vagina", 
                "has vagina", 
                RaceUtils.hasVaginaFn(true), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    public function noVagina(score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "vagina", 
                "no vagina", 
                RaceUtils.hasVaginaFn(false), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    public function hasCock(score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "cock", 
                "has cock", 
                RaceUtils.hasCockFn(true), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    public function noCock(score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "cock", 
                "no cock", 
                RaceUtils.hasCockFn(false), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    
    public function hasStatusEffect(effect : StatusEffectType, name : String, score : Int, failScore : Int = 0) : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "", 
                name, 
                function(body : BodyData) : Bool
                {
                    return body.player.hasStatusEffect(effect);
                }, 
                score, 
                failScore, 
                minScore));
        return this;
    }
    
    public function hasPerk(perk : PerkType, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "perk", 
                perk.name() + " perk", 
                RaceUtils.hasPerkFn(perk), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    
    /**
	 * Require having a perk and give racial score = (score + perkv1)
	 */
    public function givePerkV1(perk : PerkType, score : Int = 0, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        return customScoreRequirement(
                "perk", 
                customName || (perk.name() + " perk"), 
                RaceUtils.hasPerkFn(perk), 
                function(body : BodyData) : Int
                {
                    return as3hx.Compat.parseInt(score + body.player.perkv1(perk));
                }, 
                failScore
        );
    }
    public function hasAllPerks(perks : Array<Dynamic>, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                "perk", 
                perks.map(function(e : PerkType, rest : Array<Dynamic> = null) : String
                                {
                                    return e.name();
                                }).join(", ") + " perks", 
                RaceUtils.hasAllPerksFn(perks), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    public function hasAnyPerk(perks : Array<Dynamic>, score : Int, failScore : Int = 0, customName : String = "") : RaceScoreBuilder
    {
        var names : Array<Dynamic> = perks.map(function(e : PerkType, rest : Array<Dynamic> = null) : String
                {
                    return e.name();
                });
        var name : String;
        if (perks.length <= 3)
        {
            name = names.join(" or ") + " perk";
        }
        else
        {
            name = "any of " + names.join(", ") + " perks";
        }
        addRequirement(new RacialRequirement(
                "perk", 
                name, 
                RaceUtils.hasAnyPerkFn(perks), 
                score, 
                failScore, 
                minScore), customName);
        return this;
    }
    
    /**
	 * @param checkFn `function (body:BodyData):Boolean`
	 */
    public function customRequirement(
            group : String,
            name : Dynamic,
            checkFn : Function,
            score : Int,
            failScore : Int = 0) : RaceScoreBuilder
    {
        addRequirement(new RacialRequirement(
                group, 
                name, 
                checkFn, 
                score, 
                failScore, 
                minScore));
        return this;
    }
    
    /**
	 * @param checkFn `function (body:BodyData):Boolean`
	 * @param scoreFn `function (body:BodyData):int`
	 */
    public function customScoreRequirement(
            group : String,
            name : String,
            checkFn : Function,
            scoreFn : Function,
            failScore : Int = 0) : RaceScoreBuilder
    {
        addRequirement(new CustomRacialRequirement(
                group, 
                name, 
                checkFn, 
                scoreFn, 
                failScore, 
                minScore));
        return this;
    }
    
    /*************************************************************************************/
    /* builder functions END */
    /*************************************************************************************/
    
    private function addRequirement(requirement : RacialRequirement,
            customName : String = "") : Void
    {
        if (customName != "")
        {
            requirement.setNameStr(customName);
        }
        race.requirements.push(requirement);
    }
    
    private function addSlotRequirement(
            slot : Int,
            type : Dynamic,
            score : Int,
            failScore : Int,
            customName : String = "") : Void
    {
        var slotName : String = BodyData.Slots[slot].name;
        var argumentFn : Function = RaceUtils.argumentSlotFn(slot);
        var req : Dynamic = parseArgPair(
                argumentFn, BodyData.slotPhraseFn(slot), 
                type, "[" + race.name + " " + slotName + "] "
        );
        addRequirement(new RacialRequirement(
                slotName, 
                customName || req.nameFn, 
                req.check, 
                score, 
                failScore, 
                minScore));
    }
    
    /**
	 * @example
	 * // Would generate requirement named "at least <50> strength"
	 * addOperatorRequirement(
	 *  "stats",
	 *  "$value strength",
	 *  function (body:BodyData):* { return body.player.str; },
	 *  function (value:*):String { return "<"+value+">"; },
	 *  AT_LEAST(50),
	 *  +1,
	 *  0
	 * )
	 *
	 * @param pattern naming template, "$value" is replaced with stringified values
	 * @param argumentFn `(body:BodyData)=>*`
	 * @param nameFn `(value:*)=>String`
	 * @param value Operator descriptor
	 */
    private function addOperatorRequirement(
            group : String,
            pattern : String,
            argumentFn : Function,
            nameFn : Function,
            value : Dynamic,
            score : Int,
            failScore : Int,
            customName : String = "") : Void
    {
        var oo : Dynamic = RaceUtils.parseOperatorObject(value, BodyData.defaultPhraseFn("", nameFn), "[" + race.name + " " + pattern + "]");
        addRequirement(new RacialRequirement(
                group, 
                customName || function() : String
                {
                    return new as3hx.Compat.Regex('\\$value', "g").replace(pattern, oo.nameFn());
                }, 
                RaceUtils.composeOpArg(argumentFn, oo.operatorFn), 
                score, 
                failScore, 
                minScore));
    }
    private function slotRequirement(
            slot : Int,
            type : Dynamic,
            score : Int,
            failScore : Int,
            suffix : Bool = true) : RacialRequirement
    {
        var slotName : String = BodyData.Slots[slot].name;
        var argumentFn : Function = RaceUtils.argumentSlotFn(slot);
        var operatorObject : Dynamic = RaceUtils.parseOperatorObject(
                type, 
                BodyData.slotPhraseFn(slot, suffix), 
                "[" + race.name + " " + slotName + "] "
        );
        return new RacialRequirement(
        slotName, 
        operatorObject.nameFn, 
        RaceUtils.composeOpArg(argumentFn, operatorObject.operatorFn), 
        score, 
        failScore, 
        minScore);
    }
    
    /**
	 * @return {{
	 *     name: String,
	 *     check(body:BodyData, score:int): Boolean
	 * }}
	 */
    private static function parseArgPair(argumentFn : Function, phraseFn : Function, type : Dynamic, errorContext : String = "") : Dynamic
    {
        var operatorObject : Dynamic = RaceUtils.parseOperatorObject(
                type, 
                phraseFn, 
                errorContext
        );
        return {
            nameFn : operatorObject.nameFn,
            check : RaceUtils.composeOpArg(argumentFn, operatorObject.operatorFn)
        };
    }
}


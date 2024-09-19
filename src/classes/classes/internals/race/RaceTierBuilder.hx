package classes.internals.race;

import haxe.Constraints.Function;
import classes.BodyData;
import classes.bodyParts.Face;
import classes.PerkType;
import classes.Race;
import classes.RaceTier;
import classes.stats.StatUtils;
import classes.internals.Utils;

class RaceTierBuilder
{
    public var tierNumber : Int;
    public var race : Race;
    public var minScore : Int;
    public var name : String;
    /**
	 * (body)=>String
	 */
    public var nameFn : Function;
    public var buffObj : Dynamic = { };
    public var requirements : Array<Dynamic> = [];
    public var requiresPreviousTier : Bool = false;
    public var extraBonuses : Array<Dynamic> = [];
    public var dynamicBuffFn : Function;
    public var dynamicBuffDescription : String;
    
    private static var currentBuilder : RaceTierBuilder = null;
    
    public static function ensureEndCalled() : Void
    {
        if (currentBuilder != null)
        {
            trace("[ERROR] Race tier " + currentBuilder.name + " end() was not called.");
        }
    }
    
    public function new(
            race : Race,
            tierNumber : Int,
            minScore : Int,
            name : String)
    {
        ensureEndCalled();
        currentBuilder = this;
        this.race = race;
        this.tierNumber = tierNumber;
        this.minScore = minScore;
        this.name = name;
        this.nameFn = function(body : BodyData) : String
                {
                    return name;
                };
    }
    
    public function namesTauric(nonTaurName : String, taurName : String) : RaceTierBuilder
    {
        this.nameFn = function(body : BodyData) : String
                {
                    if (body.isTaur)
                    {
                        return taurName;
                    }
                    return nonTaurName;
                };
        return this;
    }
    
    /**
	 * Configure gender-dependent naming function
	 */
    public function namesMaleFemale(
            maleName : String,
            femaleName : String) : RaceTierBuilder
    {
        this.nameFn = function(body : BodyData) : String
                {
                    return body.mf(maleName, femaleName);
                };
        return this;
    }
    
    /**
	 * Configure tier naming function as:
	 * {@param taurName}/{@param femaleTaurName} for taurs
	 * {@param maleName}/{@param femaleName} for non-taurs
	 */
    public function namesMaleFemaleTaur(
            maleName : String,
            femaleName : String,
            taurName : String,
            femaleTaurName : String = "") : RaceTierBuilder
    {
        femaleTaurName = (femaleTaurName != null) ? femaleTaurName : taurName;
        this.nameFn = function(body : BodyData) : String
                {
                    if (body.isTaur)
                    {
                        return body.mf(taurName, femaleTaurName);
                    }
                    return body.mf(maleName, femaleName);
                };
        return this;
    }
    /**
	 * Configure tier naming function as:
	 * {@param taurName} for taurs
	 * {@param maleName}/{@param femaleName} for non-taurs with human/human-like face
	 * {@param morphName} otherwise
	 */
    public function namesMaleFemaleMorphTaur(
            maleName : String,
            femaleName : String,
            morphName : String,
            taurName : String) : RaceTierBuilder
    {
        this.nameFn = function(body : BodyData) : String
                {
                    if (body.isTaur)
                    {
                        return taurName;
                    }
                    if (Face.isHumanShaped(body.faceType))
                    {
                        return body.mf(maleName, femaleName);
                    }
                    return morphName;
                };
        return this;
    }
    /**
	 * Configure tier naming function as:
	 * {@param maleName}/{@param femaleName} for human/human-like face
	 * {@param morphName} otherwise
	 */
    public function namesMaleFemaleMorph(
            maleName : String,
            femaleName : String,
            morphName : String) : RaceTierBuilder
    {
        this.nameFn = function(body : BodyData) : String
                {
                    if (Face.isHumanShaped(body.faceType))
                    {
                        return body.mf(maleName, femaleName);
                    }
                    return morphName;
                };
        return this;
    }
    
    /**
	 * @param fn `function (body:BodyData):String` returning gendered/tauric/otherwise special name
	 */
    public function customNamingFunction(fn : Function) : RaceTierBuilder
    {
        this.nameFn = fn;
        return this;
    }
    
    public function buffs(buffObject : Dynamic) : RaceTierBuilder
    {
        this.buffObj = buffObject;
        return this;
    }
    
    /**
	 * @param description Description to show instead of buffs when player doesn't have this tier
	 * @param dynamicBuffFn `(body:BodyData)=>buff object`
	 */
    public function withDynamicBuffs(
            description : String,
            dynamicBuffFn : Function) : RaceTierBuilder
    {
        if (this.dynamicBuffFn != null)
        {
            trace("[ERROR] Race tier " + name + " cannot have multiple dynamic buffs. Merge and provide a single function");
            return this;
        }
        this.dynamicBuffDescription = description;
        this.dynamicBuffFn = dynamicBuffFn;
        return this;
    }
    
    /**
	 * Add description of bonuses other than buffs.
	 */
    public function withExtraBonuses(bonusDescriptions : Array<Dynamic> = null) : RaceTierBuilder
    {
        Utils.pushAll(extraBonuses, bonusDescriptions);
        return this;
    }
    
    public function requireSkinCoatType(type : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_SKIN_COAT_TYPE, type);
        return this;
    }
    public function requireFurColor(color : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_FUR_COLORS, color);
        return this;
    }
    public function requireTailType(type : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_TAIL_TYPE, type);
        return this;
    }
    public function requireTailCount(count : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_TAIL_COUNT, count);
        return this;
    }
    public function requireFaceType(type : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_FACE_TYPE, type);
        return this;
    }
    public function requireArmType(type : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_ARM_TYPE, type);
        return this;
    }
    public function requireLegType(type : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_LEG_TYPE, type);
        return this;
    }
    public function requireHornType(type : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_HORN_TYPE, type);
        return this;
    }
    public function requireWingType(type : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_WING_TYPE, type);
        return this;
    }
    public function requireEyeType(type : Dynamic) : RaceTierBuilder
    {
        addSlotRequirement(BodyData.SLOT_EYE_TYPE, type);
        return this;
    }
    public function requirePerk(perk : PerkType) : RaceTierBuilder
    {
        requirements.push(new RaceTierRequirement(
                perk.name(null) + " perk", 
                RaceUtils.hasPerkFn(perk)));
        return this;
    }
    public function requirePreviousTier() : RaceTierBuilder
    {
        requiresPreviousTier = true;
        return this;
    }
    
    /**
	 * @param checkFn (body:BodyData)=>Boolean
	 * @return
	 */
    public function require(name : String, checkFn : Function) : RaceTierBuilder
    {
        requirements.push(new RaceTierRequirement(name, checkFn));
        return this;
    }
    
    public function end() : Void
    {
        for (stat in Reflect.fields(buffObj))
        {
            if (!StatUtils.isKnownStat(stat))
            {
                trace("[ERROR] Race " + race.name + " tier " + name + " buffs non-existing stat " + stat);
            }
        }
        var tier : RaceTier;
        if (this.dynamicBuffFn != null)
        {
            tier = new DynamicBuffRaceTier(
                    tierNumber, 
                    name, 
                    nameFn, 
                    minScore, 
                    buffObj, 
                    dynamicBuffFn, 
                    dynamicBuffDescription, 
                    requirements, 
                    extraBonuses);
        }
        else
        {
            tier = new RaceTier(
                    tierNumber, 
                    name, 
                    nameFn, 
                    minScore, 
                    buffObj, 
                    requirements, 
                    extraBonuses);
        }
        tier.requiresPreviousTier = requiresPreviousTier;
        race.tiers.push(tier);
        currentBuilder = null;
    }
    
    /*************************************************************************************/
    /* builder functions END */
    /*************************************************************************************/
    
    private function addSlotRequirement(
            slot : Int,
            type : Dynamic) : Void
    {
        var operatorObject : Dynamic = RaceUtils.parseOperatorObject(
                type, 
                BodyData.slotPhraseFn(slot), 
                "[" + race.name + " " + BodyData.Slots[slot].name + "]"
        );
        var checkFn : Function = RaceUtils.composeOpArg(
                RaceUtils.argumentSlotFn(slot), 
                operatorObject.operatorFn
        );
        requirements.push(new RaceTierRequirement(
                operatorObject.nameFn(), 
                checkFn));
    }
}


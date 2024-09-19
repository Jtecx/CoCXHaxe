/**
 * Created by aimozg on 26.01.14.
 */
package classes;

import haxe.Constraints.Function;
import classes.globalFlags.KFLAGS;
import classes.stats.StatUtils;
import flash.utils.Dictionary;

class PerkType extends BaseContent
{
    public var id(get, never) : String;
    public var longDesc(get, never) : String;

    private static var PERK_LIBRARY : Dictionary = new Dictionary();
    
    // Perk distance values
    // "Distance" is how far perk requirements are from the starting player.
    public static inline var DISTANCE_STARTING : Float = 10;  // all perks start with 10  
    public static inline var DISTANCE_DEFAULT : Float = 10;  // custom requirement default distance  
    public static inline var DISTANCE_PER_LEVEL : Float = 10;
    public static inline var DISTANCE_PER_PERK : Float = 10;  // 1 perk = 1 level  
    public static inline var DISTANCE_PER_NG : Float = 1000;  // 1 NG+ = 100 levels  
    public static inline var DISTANCE_PER_PRIMARY_STAT : Float = 1;  // 10 stat = 1 level  
    public static inline var DISTANCE_PER_SENS : Float = 0.5;  // 20 sens = 1 level  
    public static inline var DISTANCE_PER_COR : Float = 0.5;  // 20 cor = 1 level  
    public static inline var DISTANCE_PER_MINLUST : Float = 0.25;  // 40 minlust = 1 level  
    public static inline var DISTANCE_PER_MAXMANA : Float = 0.25;  // 40 maxmana = 1 level  
    public static inline var DISTANCE_PER_MAXVENOM : Float = 0.25;  // 40 maxvenom = 1 level  
    public static inline var DISTANCE_PER_RACIAL_TIER : Float = 60.0;  // 1 racial tier = 6 levels  
    public static inline var DISTANCE_ADVANCED_JOB_SLOT : Float = 100.0;  // 1 adv job slot = 10 levels  
    public static inline var DISTANCE_HIDDEN_JOB_SLOT : Float = 200.0;  // 1 hidden job slot = 20 levels  
    public static inline var DISTANCE_PRESTIGE_JOB_SLOT : Float = 300.0;  // 1 prestige job slot = 30 levels  
    public static inline var DISTANCE_MUTATION_SLOT : Float = 100.0;  // 1 mutation slot = 10 levels  
    
    public static function lookupPerk(id : String) : PerkType
    {
        return Reflect.field(PERK_LIBRARY, id);
    }
    
    public static function getPerkLibrary() : Dictionary
    {
        return PERK_LIBRARY;
    }
    
    private var _id : String;
    private var _name : String;
    private var _desc : String;
    private var _longDesc : String;
    private var _keepOnAscension : Bool;
    public var buffs : Dynamic;
    public var defaultValue1 : Float = 0;
    public var defaultValue2 : Float = 0;
    public var defaultValue3 : Float = 0;
    public var defaultValue4 : Float = 0;
    public var tierList : Array<Dynamic> = null;
    
    
    public function tierPos() : Int
    {
        return (tierList != null) ? Lambda.indexOf(tierList, this) : -1;
    }
    public function tierNext() : PerkType
    {
        return (tierList != null) ? tierList[tierPos() + 1] : null;
    }
    public function tierPrev() : PerkType
    {
        return (tierList != null) ? tierList[tierPos() - 1] : null;
    }
    
    /**
		 * Unique perk id, should be kept in future game versions
		 */
    private function get_id() : String
    {
        return _id;
    }
    
    /**
		 * Perk short name.
		 * If this is perk player has, `params` is not-null and has value1-4 properties
		 */
    public function name(params : PerkClass = null) : String
    {
        return _name;
    }
    
    /**
		 * Short description used in perk listing
		 */
    public function desc(params : PerkClass = null) : String
    {
        return _desc;
    }
    
    /**
		 * Long description used when offering perk at levelup
		 */
    private function get_longDesc() : String
    {
        return _longDesc;
    }
    
    public function keepOnAscension(respec : Bool = false) : Bool
    {
        if (_keepOnAscension)
        {
            return true;
        }
        
        return _longDesc != _desc && !respec;
    }
    
    public function new(id : String, name : String, desc : String, longDesc : String = null, keepOnAscension : Bool = false)
    {
        super();
        this._id = id;
        this._name = name;
        this._desc = desc;
        this._longDesc = longDesc || _desc;
        this._keepOnAscension = keepOnAscension;
        if (Reflect.field(PERK_LIBRARY, id) != null)
        {
            CoC_Settings.error("Duplicate perk id " + id + ", old perk is " + (try cast(Reflect.field(PERK_LIBRARY, id), PerkType) catch(e:Dynamic) null)._name);
        }
        Reflect.setField(PERK_LIBRARY, id, this);
    }
    
    public function toString() : String
    {
        return "\"" + _name + "\"";
    }
    
    /**
		 * Array of:
		 * {
		 *   fn: (Player)=>Boolean,
		 *   text: String,
		 *   type: String,
		 *   distance: Number,
		 *   distanceFor: (Player)=>Number,
		 *   // additional depending on type
		 * }
		 */
    public var requirements : Array<Dynamic> = [];
    /**
		 * Absolute distance - how "far" is that perk in the progression.
		 */
    public var distance : Float = 0;
    
    /**
		 * Computes relative distance - how "far" is specific player to obtain that perk.
		 * 0 = player has perk.
		 * DISTANCE_STARTING = player doesn't have the perk, but all requirements are passed
		 */
    public function distanceFor(player : Player) : Float
    {
        if (player.hasPerk(this))
        {
            return 0;
        }
        var d : Float = DISTANCE_STARTING;
        for (req in requirements)
        
        // skip if player passes the requirement{
            
            if (req.fn(player))
            {
                continue;
            }
            var x : Float;
            if (Std.is(req.distanceFor, Function))
            {
                x = Math.max(0, req.distanceFor(player));
            }
            else if (Std.is(req.distance, Float) && Math.isFinite(req.distance) && req.distance > 0)
            {
                x = req.distance;
            }
            if (req.type == "allperks")
            {
                x += req.allperks.length * PerkType.DISTANCE_PER_PERK;
                d = Math.max(d, x);
            }
            else if (req.type == "perk" || req.type == "anyperk")
            {
                x += PerkType.DISTANCE_PER_PERK;
                d = Math.max(d, x);
            }
            else
            {
                d += x;
            }
        }
        return d;
    }
    
    public function available(player : Player) : Bool
    {
        for (c in requirements)
        {
            if (!c.fn(player))
            {
                return false;
            }
        }
        return true;
    }
    
    public function requireCustomFunction(playerToBoolean : Function, requirementText : String, distance : Float = DISTANCE_DEFAULT, internalType : String = "custom") : PerkType
    {
        requirements.push({
                    fn : playerToBoolean,
                    text : requirementText,
                    type : internalType,
                    distance : distance
                });
        
        return this;
    }
    
    public function requireLevel(value : Int) : PerkType
    {
        requirements.push({
                    fn : fnRequireAttr("level", value),
                    text : "Level " + value,
                    type : "level",
                    value : value,
                    distance : value * DISTANCE_PER_LEVEL,
                    distanceFor : fnDistanceAttr("level", value, DISTANCE_PER_LEVEL)
                });
        return this;
    }
    public function requireStr(value : Int) : PerkType
    {
        requirements.push({
                    fn : fnRequireAttr("str", value),
                    text : "Strength " + value,
                    type : "attr",
                    attr : "str",
                    value : value,
                    distance : Math.max(1, value * DISTANCE_PER_PRIMARY_STAT),
                    distanceFor : fnDistanceAttr("str", value, DISTANCE_PER_PRIMARY_STAT)
                });
        return this;
    }
    public function requireTou(value : Int) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    // return true if player meets perk requirements
                    {
                        
                        var Attribute : String = "tou";
                        if (player.hasPerk(PerkLib.IcyFlesh))
                        {
                            Attribute = "inte";
                        }
                        if (player.hasPerk(PerkLib.HaltedVitals))
                        {
                            Attribute = "lib";
                        }
                        return Reflect.field(player, Attribute) >= value;
                    },
                    text : function(player : Player) : String
                    // return true if player meets perk requirements
                    {
                        
                        var Attribute : String = "Toughness";
                        if (player.hasPerk(PerkLib.IcyFlesh))
                        {
                            Attribute = "Intelligence";
                        }
                        if (player.hasPerk(PerkLib.HaltedVitals))
                        {
                            Attribute = "Libido";
                        }
                        return Attribute + " " + value;
                    },
                    statictext : "Toughness " + value,
                    type : "attr",
                    attr : "tou",
                    value : value,
                    distance : Math.max(1, value * DISTANCE_PER_PRIMARY_STAT),
                    distanceFor : function(player : Player) : Float
                    {
                        var Attribute : String = "tou";
                        if (player.hasPerk(PerkLib.IcyFlesh))
                        {
                            Attribute = "inte";
                        }
                        if (player.hasPerk(PerkLib.HaltedVitals))
                        {
                            Attribute = "lib";
                        }
                        return (value - Reflect.field(player, Attribute)) * DISTANCE_PER_PRIMARY_STAT;
                    }
                });
        return this;
    }
    public function requireSpe(value : Int) : PerkType
    {
        requirements.push({
                    fn : fnRequireAttr("spe", value),
                    text : "Speed " + value,
                    type : "attr",
                    attr : "spe",
                    value : value,
                    distance : Math.max(1, value * DISTANCE_PER_PRIMARY_STAT),
                    distanceFor : fnDistanceAttr("spe", value, DISTANCE_PER_PRIMARY_STAT)
                });
        return this;
    }
    public function requireInt(value : Int) : PerkType
    {
        requirements.push({
                    fn : fnRequireAttr("inte", value),
                    text : "Intellect " + value,
                    type : "attr",
                    attr : "inte",
                    value : value,
                    distance : Math.max(1, value * DISTANCE_PER_PRIMARY_STAT),
                    distanceFor : fnDistanceAttr("inte", value, DISTANCE_PER_PRIMARY_STAT)
                });
        return this;
    }
    public function requireWis(value : Int) : PerkType
    {
        requirements.push({
                    fn : fnRequireAttr("wis", value),
                    text : "Wisdom " + value,
                    type : "attr",
                    attr : "wis",
                    value : value,
                    distance : Math.max(1, value * DISTANCE_PER_PRIMARY_STAT),
                    distanceFor : fnDistanceAttr("wis", value, DISTANCE_PER_PRIMARY_STAT)
                });
        return this;
    }
    public function requireLib(value : Int) : PerkType
    {
        requirements.push({
                    fn : fnRequireAttr("lib", value),
                    text : "Libido " + value,
                    type : "attr",
                    attr : "lib",
                    value : value,
                    distance : Math.max(1, value * DISTANCE_PER_PRIMARY_STAT),
                    distanceFor : fnDistanceAttr("lib", value, DISTANCE_PER_PRIMARY_STAT)
                });
        return this;
    }
    public function requireSen(value : Int) : PerkType
    {
        requirements.push({
                    fn : fnRequireAttr("sens", value),
                    text : "Sensitivity " + value,
                    type : "attr",
                    attr : "sens",
                    value : value,
                    distance : value * DISTANCE_PER_SENS,
                    distanceFor : fnDistanceAttr("sens", value, DISTANCE_PER_SENS)
                });
        return this;
    }
    public function requireCor(value : Int) : PerkType
    {
        requirements.push({
                    fn : fnRequireAttr("cor", value),
                    text : "Corruption " + value,
                    type : "attr",
                    attr : "cor",
                    value : value,
                    distance : value * DISTANCE_PER_COR,
                    distanceFor : fnDistanceAttr("cor", value, DISTANCE_PER_COR)
                });
        return this;
    }
    public function requireLibLessThan(value : Int) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.lib < value;
                    },
                    text : "Libido &lt; " + value,
                    type : "attr-lt",
                    attr : "lib",
                    value : value,
                    distance : value * DISTANCE_PER_PRIMARY_STAT,
                    distanceFor : fnDistanceAttr("lib", value, -DISTANCE_PER_PRIMARY_STAT)
                });
        return this;
    }
    public function requireNGPlus(value : Int) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.newGamePlusMod() >= value;
                    },
                    text : "New Game+ " + value,
                    type : "ng+",
                    value : value,
                    distance : value * DISTANCE_PER_NG,
                    distanceFor : fnDistanceAttr("newGamePlusMod", value, DISTANCE_PER_NG)
                });
        return this;
    }
    public function requireAdvancedJobSlot() : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.freeAdvancedJobsSlots() > 0;
                    },
                    text : "Free Advanced Job Slot",
                    type : "advanced",
                    distance : DISTANCE_ADVANCED_JOB_SLOT
                });
        return this;
    }
    public function requireHiddenJobSlot() : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.freeHiddenJobsSlots() > 0;
                    },
                    text : "Free Hidden Job Slot",
                    type : "hidden",
                    distance : DISTANCE_HIDDEN_JOB_SLOT
                });
        return this;
    }
    public function requirePrestigeJobSlot() : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.freePrestigeJobsSlots() > 0;
                    },
                    text : "Free Prestige Job Slot",
                    type : "prestige",
                    distance : DISTANCE_PRESTIGE_JOB_SLOT
                });
        return this;
    }
    public function requireMutationSlot(slot : String) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.maxCurrentMutationsInSlot(slot) > 0;
                    },
                    text : "Free " + IMutationPerkType.Slots[slot].name + " Mutation Slot",
                    type : "mutationslot",
                    slot : slot,
                    distance : DISTANCE_MUTATION_SLOT
                });
        return this;
    }
    public function requireHeartMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_HEART);
    }
    public function requireMusclesMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_MUSCLE);
    }
    public function requireMouthMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_MOUTH);
    }
    public function requireAdrenalGlandsMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_ADRENALS);
    }
    public function requireBloodsteamMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_BLOODSTREAM);
    }
    public function requireFatTissueMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_FAT);
    }
    public function requireLungsMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_LUNGS);
    }
    public function requireMetabolismMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_METABOLISM);
    }
    public function requireOvariesMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_OVARIES);
    }
    public function requireBallsMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_TESTICLES);
    }
    public function requireEyesMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_EYES);
    }
    public function requirePeripheralNervSysMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_NERVSYS);
    }
    public function requireBonesAndMarrowMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_BONE);
    }
    public function requireThyroidGlandMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_THYROID);
    }
    public function requireParathyroidGlandMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_PARATHYROID);
    }
    public function requireAdaptationsMutationSlot() : PerkType
    {
        return requireMutationSlot(IMutationPerkType.SLOT_ADAPTATIONS);
    }
    public function requireHungerEnabled() : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return CoC.instance.flags[kFLAGS.HUNGER_ENABLED] > 0;
                    },
                    text : "Hunger enabled",
                    type : "hungerflag",
                    distance : DISTANCE_DEFAULT
                });
        return this;
    }
    public function requireMinLust(value : Int) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return EngineCore.minLust() >= value;
                    },
                    text : "Min. Lust " + value,
                    type : "minlust",
                    value : value,
                    distance : value * DISTANCE_PER_MINLUST,
                    distanceFor : fnDistanceAttr("minLust", value, DISTANCE_PER_MINLUST)
                });
        return this;
    }
    public function requireMinSens(value : Int) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return CoC.instance.player.minSens() >= value;
                    },
                    text : "Min. Sensitivity " + value,
                    type : "minsensitivity",
                    value : value,
                    distance : DISTANCE_DEFAULT
                });
        return this;
    }
    public function requireMaxSoulforce(value : Int) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.maxSoulforce() >= value;
                    },
                    text : "Max. Soulforce " + value,
                    type : "soulforce",
                    value : value,
                    distance : DISTANCE_DEFAULT
                });
        return this;
    }
    public function requireMaxMana(value : Int) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.maxMana() >= value;
                    },
                    text : "Max. Mana " + value,
                    type : "mana",
                    value : value,
                    distance : value * DISTANCE_PER_MAXMANA,
                    distanceFor : fnDistanceAttr("maxMana", value, DISTANCE_PER_MAXMANA)
                });
        return this;
    }
    public function requireMaxVenom(value : Int) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.maxVenom() >= value;
                    },
                    text : "Max. Venom/Web " + value,
                    type : "venom_web",
                    value : value,
                    distance : value * DISTANCE_PER_MAXVENOM,
                    distanceFor : fnDistanceAttr("maxVenom", value, DISTANCE_PER_MAXMANA)
                });
        return this;
    }
    private function fnRequireAttr(attrname : String, value : Int) : Function
    {
        return function(player : Player) : Bool
        {
            return Reflect.field(player, attrname) >= value;
        };
    }
    
    /**
		 * Create a relative distance computing function that returns a score for player's property "attrname"
		 * distance to "target" value.
		 * For example, fnDistanceAttr("str", 60, 0.5) creates a function that counts 0.5 per player strength below 60.
		 * If property goes down, for example "corruption no more than 50", multiply scale by -1.
		 * @param attrname Player property name. Should be a number or no-arg function returning number
		 * @param target Target value.
		 * @param scale Score per 1 of difference
		 * @return {(Player)=>Number} distance function
		 */
    private function fnDistanceAttr(attrname : String, target : Float, scale : Float) : Function
    {
        return function(player : Player) : Float
        {
            var attr : Dynamic = Reflect.field(player, attrname);
            if (Std.is(attr, Function))
            {
                attr = attr();
            }
            return (target - attr) * scale;
        };
    }
    public function requireStatusEffect(effect : StatusEffectType, text : String, distance : Float = DISTANCE_DEFAULT) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.hasStatusEffect(effect);
                    },
                    text : text,
                    type : "effect",
                    effect : effect,
                    distance : distance
                });
        return this;
    }
    
    /**
		 * Require player to be of specified race with optional minimum tier
		 * @example
		 * requireRace(Races.KITSUNE)
		 * -> name: "Kitsune race"
		 * -> fn: player.isRace(Races.KITSUNE, 1)
		 * @example
		 * requireRace(Races.KITSUNE, 3)
		 * -> name: "Nine-tailed kitsune of balance race"
		 * -> fn: player.isRace(Races.KITSUNE, 3)
		 */
    public function requireRace(race : Race, minTier : Int = 1) : PerkType
    {
        var text : String;
        if (minTier == 1)
        {
            text = capitalizeFirstLetter(race.name) + " race";
        }
        else
        {
            text = capitalizeFirstLetter(race.tiers[minTier - 1].name) + " race";
        }
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.isRace(race, minTier);
                    },
                    text : text,
                    type : "race",
                    race : race,
                    tier : minTier,
                    distance : minTier * DISTANCE_PER_RACIAL_TIER,
                    distanceFor : function(player : Player) : Float
                    {
                        return (minTier - player.racialTier(race)) * DISTANCE_PER_RACIAL_TIER;
                    }
                });
        return this;
    }
    
    /**
		 * Require player to be at tier 1+ in any of listed races.
		 * Consider using `requireRacialGroup` if too many races
		 * @param {Race[]} races
		 * @example
		 * requireAnyRace(Races.KITSUNE, Races.FOX)
		 * -> name: "Kitsune or Fox race"
		 * -> fn: player.isRace(Races.KITSUNE) || player.isRace(Races.FOX)
		 */
    public function requireAnyRace(races : Array<Dynamic> = null) : PerkType
    {
        return requireRacialGroup(try cast(races, Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null);
    }
    /**
		 * Require player to be at tier 1+ in any of listed races.
		 * Can provide a custom name for this requirement
		 * @example
		 * requireRacialGroup([Races.KITSUNE, Races.FOX], "Any vulpine race")
		 * -> name: "Any vulpine race"
		 * -> fn: player.isRace(Races.KITSUNE) || player.isRace(Races.FOX)
		 */
    public function requireRacialGroup(races : Array<Dynamic>, text : String = "") : PerkType
    {
        races = flatten(races);
        if (text == null)
        {
            text = mergeSentences(mapOneProp(races, "name"), ", or ", ", ", false) + " race";
        }
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        for (race in races)
                        {
                            if (player.isRace(race))
                            {
                                return true;
                            }
                        }
                        return false;
                    },
                    text : text,
                    type : "anyrace",
                    races : races,
                    distance : DISTANCE_PER_RACIAL_TIER
                });
        return this;
    }
    public function requirePerk(perk : PerkType) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.hasPerk(perk);
                    },
                    text : perk.name(),
                    type : "perk",
                    perk : perk,
                    distanceFor : function(player : Player) : Float
                    {
                        return perk.distanceFor(player);
                    }
                });
        return this;
    }
    public function requireAnyPerk(perks : Array<Dynamic> = null) : PerkType
    {
        if (perks.length == 0)
        {
            throw ("Incorrect call of requireAnyPerk() - should NOT be empty");
        }
        var text : Array<Dynamic> = [];
        for (perk in perks)
        {
            text.push(perk.name());
        }
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        for (perk in perks)
                        {
                            if (player.hasPerk(perk))
                            {
                                return true;
                            }
                        }
                        return false;
                    },
                    text : text.join(" or "),
                    type : "anyperk",
                    perks : perks,
                    distanceFor : function(player : Player) : Float
                    {
                        var mindist : Float = Infinity;
                        for (perk in perks)
                        {
                            mindist = Math.min(mindist, perk.distanceFor(player));
                        }
                        return DISTANCE_PER_PERK + ((Math.isFinite(mindist)) ? mindist : 0);
                    }
                });
        return this;
    }
    public function requireOrPerks(perk1 : PerkType, perk2 : PerkType, v1 : Float) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return (player.hasPerk(perk1) || (player.hasPerk(perk2) && player.perkv1(perk2) == v1));
                    },
                    text : perk1.name(),
                    type : "perk",
                    perk : perk1,
                    distanceFor : function(player : Player) : Float
                    {
                        return perk1.distanceFor(player);
                    }
                });
        return this;
    }
    public function requirePerks(perks : Array<Dynamic> = null) : PerkType
    //As opposed to requirePerk or requireAnyPerk, this checks for if player has all required perks instead of any of them or just the one.
    {
        
        if (perks.length == 0)
        {
            throw ("Incorrect call of requirePerks() - should NOT be empty");
        }
        var text : Array<Dynamic> = [];
        for (perk in perks)
        {
            text.push(perk.name());
        }
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        var allPerksYes : Bool = true;
                        for (perk in perks)
                        {
                            if (!player.hasPerk(perk))
                            {
                                allPerksYes = false;
                                break;
                            }
                        }
                        return allPerksYes;
                    },
                    text : text.join(" and "),
                    type : "allperks",
                    allperks : perks,
                    distanceFor : function(player : Player) : Float
                    {
                        var maxdist : Float = -Infinity;
                        for (perk in perks)
                        {
                            maxdist = Math.max(maxdist, perk.distanceFor(player));
                        }
                        return DISTANCE_PER_PERK * perks.length + ((Math.isFinite(maxdist)) ? maxdist : 0);
                    }
                });
        return this;
    }
    public function requireNotThosePerks(perks : Array<Dynamic> = null) : PerkType
    {
        if (perks.length == 0)
        {
            throw ("Incorrect call of requireNotThosePerk() - should NOT be empty");
        }
        var text : Array<Dynamic> = [];
        for (perk in perks)
        {
            text.push(perk.name());
        }
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        var allPerksYes : Bool = true;
                        for (perk in perks)
                        {
                            if (player.hasPerk(perk))
                            {
                                allPerksYes = false;
                                break;
                            }
                        }
                        return allPerksYes;
                    },
                    text : "Blocked by " + ((text.length > 1) ? "perks: " : "perk ") + text.join(", "),
                    type : "noperks",
                    perks : perks
                });
        return this;
    }
    
    public function withBuffs(buffs : Dynamic, showText : Bool = true) : PerkType
    {
        this.buffs = buffs;
        var tempText : String = "";
        if (showText)
        {
            var key : String;
            for (key in Reflect.fields(this.buffs))
            {
                StatUtils.validateBuff(key, "perk " + this.id);
                tempText += " " + StatUtils.explainBuff(key, Reflect.field(buffs, key)) + ",";
            }
            tempText = tempText.substring(0, tempText.length - 1) + ".";
            _desc += tempText;
            _longDesc += tempText;
        }
        return this;
    }
    
    public function requireMutation(mutation : IMutationPerkType) : PerkType
    {
        requirements.push({
                    fn : function(player : Player) : Bool
                    {
                        return player.hasMutation(mutation);
                    },
                    text : mutation.name(),
                    type : "mutation",
                    perk : mutation,
                    distance : DISTANCE_PER_PERK,
                    distanceFor : function(player : Player) : Float
                    {
                        return mutation.distanceFor(player);
                    }
                });
        return this;
    }
    
    public function mDesc(params : PerkClass, tier : Int = 0) : String  //Can't overload the function, and override won't do it.  
    {
        return _desc;
    }
}


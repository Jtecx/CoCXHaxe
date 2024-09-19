package classes.items;

import classes.ItemType;
import classes.items.dynamic.effects.RaceTfEnchantmentType;
import classes.items.dynamic.effects.SimpleEnchantmentType;
import classes.items.dynamic.effects.SimpleRaceEnchantment;
import classes.items.dynamic.effects.SimpleRaceEnchantmentType;
import classes.items.dynamic.effects.StatEnchantmentType;
import classes.Races;

class EnchantmentLib extends ItemConstants
{
    public static var instance(get, never) : EnchantmentLib;

    // See EnchatmentType.parseEnchantmentText for description expression syntax
    
    /*
	 * template
	 *
	 * public static const Xxxx:EnchantmentType = mk(UNIQUE_ID, "Name", {
	 * 	curse: true, // optional, default false. Guarantees cursed item
	 * 	negative: true, // optional, default false. Bigger chance for cursed item
	 * 	prefix: "Xxxx ", // optional, default empty
	 * 	suffix: " of Xxxx", // optional, default empty
	 * 	shortSuffix: "Xx", // optional, default empty. Button label. 2-3 chars!
	 * 	description: "{X;+d} to Xxxx", // required. See EnchantmentType.parseEnchantmentText for formatter description
	 * 	rarity: RARITY_LEGENDARY, // optional, default = RARITY_MAGICAL. don't use RARITY_RARE or RARITY_COMMON.
	 * 	minLevel: 5, // optional, default = 1. min level to spawn the enchantment
	 * 	categories: [CATEGORY_WEAPON_MELEE], // optional, default = all categories
	 * 	chance: 2.0, // optional, relative spawn chance, default 1
	 * 	minPower: 0, // optional, default 1
	 * 	maxPower: 10, // optional, default 1
	 * 	value: 100, // optional, default 0
	 * 	valuePerPower: 100, // optional, default 0
	 * 	valueX: 1.2, // optional, default 1
	 * 	valueXPerPower: 0.1, // optional, default 0
	 * 	onAdd: function(item:ItemType, power:Number, enchantment:Enchantment):void { ... }, // optional, default null
	 * });
	 *
	 * extra params for mkRacials:
	 * 	races: array of allowed races, or array of objects {
	 * 		race: Race,
	 * 		chance: Number, // default 1
	 * 		value: Number, // default 1.0, value multiplier
	 * 	}
	 */
    
    // Number IDs are written in saved and should never change across versions!
    // Everything else - can.
    
    private static inline var SPAWN_COMMON : Float = 1.0;
    private static inline var SPAWN_UNCOMMON : Float = 0.25;  //   4x are  
    private static inline var SPAWN_RARE : Float = 0.1;  //  10x rare  
    private static inline var SPAWN_VERY_RARE : Float = 0.025;  //  40x rare  
    private static inline var SPAWN_SUPER_RARE : Float = 0.01;  // 100x rare  
    
    private static var CATEGORIES_WEARABLE : Array<Dynamic> = [
        CATEGORY_ARMOR, CATEGORY_UNDERGARMENT, 
        CATEGORY_NECKLACE, CATEGORY_JEWELRY_RING, CATEGORY_JEWELRY_MISC, CATEGORY_JEWELRY_HEAD
    ];
    private static var CATEGORIES_JEWELRY : Array<Dynamic> = [
        CATEGORY_NECKLACE, CATEGORY_JEWELRY_RING, CATEGORY_JEWELRY_MISC, CATEGORY_JEWELRY_HEAD
    ];
    private static var CATEGORIES_WEAPONS : Array<Dynamic> = [
        CATEGORY_WEAPON_MELEE, CATEGORY_WEAPON_RANGED
    ];
    
    public static var Strength : EnchantmentType = new StatEnchantmentType(1, "Strength", 
                // curse, statName
                false, "str.mult", 
                // prefix, suffix, shortSuffix, rarity
                "Strong ", " of Strength", "St", RARITY_MAGICAL, 
                // minLevel, minPower, maxPower, statPerPower, value, valuePerPower, valueX, valueXPerPower
                2, 3, 6, 0.05, 0, 150).setSpawnChance(SPAWN_COMMON);
    public static var Toughness : EnchantmentType = new StatEnchantmentType(2, "Toughness", 
                false, "tou.mult", 
                "Tough ", " of Toughness", "To", RARITY_MAGICAL, 
                2, 3, 6, 0.05, 0, 150).setSpawnChance(SPAWN_COMMON);
    public static var Speed : EnchantmentType = new StatEnchantmentType(3, "Speed", 
                false, "spe.mult", 
                "Fast ", " of Speed", "Sp", RARITY_MAGICAL, 
                2, 3, 6, 0.05, 0, 150).setSpawnChance(SPAWN_COMMON);
    public static var Intelligence : EnchantmentType = new StatEnchantmentType(4, "Intelligence", 
                false, "int.mult", 
                "Smart ", " of Intellect", "In", RARITY_MAGICAL, 
                2, 3, 6, 0.05, 0, 150).setSpawnChance(SPAWN_COMMON);
    public static var Wisdom : EnchantmentType = new StatEnchantmentType(5, "Wisdom", 
                false, "wis.mult", 
                "Wise ", " of Wisdom", "Ws", RARITY_MAGICAL, 
                2, 3, 6, 0.05, 0, 150).setSpawnChance(SPAWN_COMMON);
    public static var Libido : EnchantmentType = new StatEnchantmentType(6, "Libido", 
                false, "lib.mult", 
                "Libidinous ", " of Libido", "Lb", RARITY_MAGICAL, 
                2, 3, 6, 0.05, 0, 150).setSpawnChance(SPAWN_COMMON);
    public static var Sensitivity : EnchantmentType = new StatEnchantmentType(7, "Sensitivity", 
                false, "sens", 
                "Sensitive ", " of Sensitivity", "Sn", RARITY_MAGICAL, 
                2, 3, 6, 2, 0, 150).setSpawnChance(SPAWN_COMMON);
    public static var StrengthMinus : EnchantmentType = new StatEnchantmentType(8, "Strength-", 
                        false, "str.mult", 
                        "Weak ", " of Weakness", "St-", RARITY_MAGICAL, 
                        // minLevel, minPower, maxPower, statPerPower, value, valuePerPower, valueX, valueXPerPower
                        1, 3, 6, -0.05, 0, 0).setNegative().setSpawnChance(SPAWN_RARE);
    public static var ToughnessMinus : EnchantmentType = new StatEnchantmentType(9, "Toughness-", 
                        false, "tou.mult", 
                        "Frail ", " of Frailty", "To-", RARITY_MAGICAL, 
                        1, 3, 6, -0.05, 0, 0).setNegative().setSpawnChance(SPAWN_RARE);
    public static var SpeedMinus : EnchantmentType = new StatEnchantmentType(10, "Speed-", 
                        false, "spe.mult", 
                        "Slow ", " of Slowliness", "Sp-", RARITY_MAGICAL, 
                        1, 3, 6, -0.05, 0, 0).setNegative().setSpawnChance(SPAWN_RARE);
    public static var IntelligenceMinus : EnchantmentType = new StatEnchantmentType(11, "Intelligence-", 
                        false, "int.mult", 
                        "Dumb ", " of Dumbness", "In-", RARITY_MAGICAL, 
                        1, 3, 6, -0.05, 0, 0).setNegative().setSpawnChance(SPAWN_RARE);
    public static var WisdomMinus : EnchantmentType = new StatEnchantmentType(12, "Wisdom-", 
                        false, "wis.mult", 
                        "Fool's ", " of Fool", "Ws-", RARITY_MAGICAL, 
                        1, 3, 6, -0.05, 0, 0).setNegative().setSpawnChance(SPAWN_RARE);
    public static var LibidoMinus : EnchantmentType = new StatEnchantmentType(13, "Libido-", 
                        false, "lib.mult", 
                        "Frigid ", " of Frigidity", "Lb-", RARITY_MAGICAL, 
                        1, 3, 6, -0.05, 0, 0).setNegative().setSpawnChance(SPAWN_RARE);
    public static var SensitivityMinus : EnchantmentType = new StatEnchantmentType(14, "Sensitivity-", 
                        false, "sens", 
                        "Numb ", " of Numbness", "Sn-", RARITY_MAGICAL, 
                        1, 3, 6, -2, 0, 0).setNegative().setSpawnChance(SPAWN_RARE);
    public static var MinLust : EnchantmentType = new StatEnchantmentType(15, "MinLust", 
                        false, "minlustx", 
                        "Hotblooded ", " of hot blood", "HB", RARITY_MAGICAL, 
                        1, 1, 10, +0.01, 0, 100).setItemCategories(CATEGORIES_WEARABLE).setSpawnChance(SPAWN_COMMON);
    public static var MinFem : EnchantmentType = mk(16, "MinFem", {
                    prefix : "Feminine ",
                    suffix : " of Femininity",
                    shortSuffix : "Fem",
                    description : "Min. femininity {power;+d}",
                    hide : true,
                    minLevel : 1,
                    categories : CATEGORIES_WEARABLE,
                    chance : SPAWN_UNCOMMON,
                    minPower : 1,
                    maxPower : 10,
                    value : 0,
                    valuePerPower : 50,
                    onAdd : function(item : ItemType, power : Float) : Void
                    {
                        item.withEffect(IELib.MinFem, power);
                    }
                });
    public static var MaxFem : EnchantmentType = mk(17, "MaxFem", {
                    prefix : "Masculine ",
                    suffix : " of Masculinity",
                    shortSuffix : "Mas",
                    description : "Max. femininity {0-power;+d}",
                    hide : true,
                    minLevel : 1,
                    categories : CATEGORIES_WEARABLE,
                    chance : SPAWN_UNCOMMON,
                    minPower : 1,
                    maxPower : 10,
                    value : 0,
                    valuePerPower : 50,
                    onAdd : function(item : ItemType, power : Float) : Void
                    {
                        item.withEffect(IELib.MaxFem, -power);
                    }
                });
    public static var Androgyny : EnchantmentType = mk(18, "Androgyny", {
                    prefix : "Androgynous ",
                    suffix : " of Androgyny",
                    shortSuffix : "AG",
                    description : "Min. femininity {power;+d}, max. femininity {0-power;+d}",
                    hide : true,
                    minLevel : 1,
                    categories : CATEGORIES_WEARABLE,
                    chance : SPAWN_UNCOMMON,
                    minPower : 1,
                    maxPower : 10,
                    value : 0,
                    valuePerPower : 75,
                    onAdd : function(item : ItemType, power : Float) : Void
                    {
                        item.withEffect(IELib.MaxFem, -power);
                        item.withEffect(IELib.MinFem, power);
                    }
                });
    public static var BonusXp : EnchantmentType = mk(19, "BonusXp", {
                    prefix : "Sagely ",
                    suffix : " of Sages",
                    shortSuffix : "XP",
                    description : "XP gain {power*5;+d}%",
                    hide : true,
                    minLevel : 1,
                    chance : SPAWN_RARE,
                    minPower : 1,
                    maxPower : 3,
                    valueX : 1.0,
                    valueXPerPower : 0.5,
                    onAdd : function(item : ItemType, power : Float) : Void
                    {
                        item.withEffect(IELib.BonusXp, power * 5);
                    }
                });
    public static var TfImmunity : EnchantmentType = mk(20, "TfImmunity", {
                    prefix : "Immutable ",
                    suffix : " of Immutability",
                    shortSuffix : "Im",
                    description : "Transformation immunity",
                    hide : true,
                    minLevel : 20,
                    chance : SPAWN_VERY_RARE,
                    value : 10000,
                    categories : CATEGORIES_WEARABLE,
                    onAdd : function(item : ItemType, power : Float) : Void
                    {
                        item.withEffect(IELib.TfImmunity, 0);
                    }
                });
    /**
	 * TF player into race.
	 * When wearing multiple items:
	 * - Only TF into first race equipped
	 * - Multiple enchanted items of same race - use max power
	 * - Unequipping all current race TF items - pick any other race TF item
	 */
    public static var RaceTf : RaceTfEnchantmentType = new RaceTfEnchantmentType(21, "RaceTf", RARITY_MAGICAL, 1);
    public static var RaceAttackBonus : SimpleRaceEnchantmentType = mkRacial(22, "RaceAttackBonus", {
                    prefix : "{race.name;C} ",
                    suffix : " of {race.name;C}",
                    shortSuffix : "RAt",
                    description : "+{power*5}% Attack per {race.name} racial tier.",
                    hide : true,
                    minLevel : 1,
                    chance : SPAWN_COMMON,
                    minPower : 1,
                    maxPower : 5,
                    valuePerPower : 100,
                    categories : CATEGORIES_WEAPONS,
                    onAdd : function(item : ItemType, power : Float, enchantment : Enchantment) : Void
                    {
                        item.withEffect(IELib.AttackMult_RaceTier, power * 5, (try cast(enchantment, SimpleRaceEnchantment) catch(e:Dynamic) null).race);
                    }
                });
    public static var RaceDefenseBonus : SimpleRaceEnchantmentType = mkRacial(23, "RaceDefenseBonus", {
                    prefix : "{race.name;C} ",
                    suffix : " of {race.name;C}",
                    shortSuffix : "RDf",
                    description : "+{power*5}% Defense per {race.name} racial tier.",
                    hide : true,
                    minLevel : 1,
                    chance : SPAWN_COMMON,
                    minPower : 1,
                    maxPower : 5,
                    valuePerPower : 100,
                    categories : [CATEGORY_ARMOR, CATEGORY_SHIELD],
                    onAdd : function(item : ItemType, power : Float, enchantment : Enchantment) : Void
                    {
                        item.withEffect(IELib.DefenseMult_RaceTier, power * 5, (try cast(enchantment, SimpleRaceEnchantment) catch(e:Dynamic) null).race);
                    }
                });
    public static var RaceSpellPowerBonus : SimpleRaceEnchantmentType = mkRacial(24, "RaceSpellPowerBonus", {
                    prefix : "{race.name;C} ",
                    suffix : " of {race.name;C}",
                    shortSuffix : "RSp",
                    description : "+{power*2}% Spellpower per {race.name} racial tier.",
                    hide : true,
                    minLevel : 1,
                    chance : SPAWN_COMMON,
                    minPower : 1,
                    maxPower : 5,
                    valuePerPower : 100,
                    categories : CATEGORIES_JEWELRY,
                    onAdd : function(item : ItemType, power : Float, enchantment : Enchantment) : Void
                    {
                        item.withEffect(IELib.Spellpower_RaceTier, power * 2, (try cast(enchantment, SimpleRaceEnchantment) catch(e:Dynamic) null).race);
                    }
                });
    public static var ResistFire : EnchantmentType = new StatEnchantmentType(25, "ResistFire", 
                        false, "res_fire", 
                        "Firestrider's ", " of Firestrider", "RF", RARITY_MAGICAL, 
                        10, 1, 10, +1, 0, 300).setItemCategories(CATEGORIES_WEARABLE).setSpawnChance(SPAWN_COMMON);
    public static var ResistIce : EnchantmentType = new StatEnchantmentType(26, "ResistIce", 
                        false, "res_ice", 
                        "Snowstrider's ", " of Snowstrider", "RI", RARITY_MAGICAL, 
                        10, 1, 10, +1, 0, 300).setItemCategories(CATEGORIES_WEARABLE).setSpawnChance(SPAWN_COMMON);
    public static var ResistDarkness : EnchantmentType = new StatEnchantmentType(27, "ResistIce", 
                        false, "res_darkness", 
                        "Darkstrider's ", " of Darkstrider", "RD", RARITY_MAGICAL, 
                        10, 1, 10, +1, 0, 300).setItemCategories(CATEGORIES_WEARABLE).setSpawnChance(SPAWN_COMMON);
    public static var ResistLightning : EnchantmentType = new StatEnchantmentType(28, "ResistLightning", 
                        false, "res_lightning", 
                        "Stormstrider's ", " of Stormstrider", "RL", RARITY_MAGICAL, 
                        10, 1, 10, +1, 0, 300).setItemCategories(CATEGORIES_WEARABLE).setSpawnChance(SPAWN_COMMON);
    public static var WeaknessFire : EnchantmentType = new StatEnchantmentType(29, "WeaknessFire", 
                                false, "res_fire", 
                                "Fireblighted ", " of Fire blight", "VF", RARITY_MAGICAL, 
                                1, 10, 20, -1, 0, 0).setItemCategories(CATEGORIES_WEARABLE).setNegative().setSpawnChance(SPAWN_UNCOMMON);
    public static var WeaknessIce : EnchantmentType = new StatEnchantmentType(30, "WeaknessIce", 
                                false, "res_ice", 
                                "Snowblighted ", " of Snow blight", "VI", RARITY_MAGICAL, 
                                1, 10, 20, -1, 0, 0).setItemCategories(CATEGORIES_WEARABLE).setNegative().setSpawnChance(SPAWN_UNCOMMON);
    public static var WeaknessDarkness : EnchantmentType = new StatEnchantmentType(31, "WeaknessIce", 
                                false, "res_darkness", 
                                "Darkblighted ", " of Dark blight", "VD", RARITY_MAGICAL, 
                                1, 10, 20, -1, 0, 0).setItemCategories(CATEGORIES_WEARABLE).setNegative().setSpawnChance(SPAWN_UNCOMMON);
    public static var WeaknessLightning : EnchantmentType = new StatEnchantmentType(32, "WeaknessLightning", 
                                false, "res_lightning", 
                                "Stormblighted ", " of Storm blight", "VL", RARITY_MAGICAL, 
                                1, 10, 20, -1, 0, 0).setItemCategories(CATEGORIES_WEARABLE).setNegative().setSpawnChance(SPAWN_UNCOMMON);
    public static var RaceSpellPowerDoubled : SimpleRaceEnchantmentType = EnchantmentLib.mkRacial(33, "RaceSpellPowerDoubled", {
                    prefix : "",
                    suffix : " of {race.name;C}",
                    shortSuffix : "RSp",
                    description : "Increase Spellpower by {power*100}%. Effect doubled for {race.name} race",
                    hide : true,
                    minLevel : 1,
                    chance : 1,
                    minPower : 1,
                    maxPower : 2,
                    valuePerPower : 200,
                    categories : [CATEGORY_SHIELD],
                    onAdd : function(item : ItemType, power : Float, enchantment : Enchantment) : Void
                    {
                        item.withEffect(IELib.Spellpower_RaceX2, power * 100, (try cast(enchantment, SimpleRaceEnchantment) catch(e:Dynamic) null).race);
                    }
                });
    public static var RaceTeasePowerDoubled : SimpleRaceEnchantmentType = EnchantmentLib.mkRacial(34, "RaceTeasePowerDoubled", {
                    prefix : "",
                    suffix : " of {race.name;C}",
                    shortSuffix : "RTp",
                    description : "Increase Tease potency by {power*200}%. Effect doubled for {race.name} race",
                    hide : true,
                    minLevel : 1,
                    chance : 1,
                    minPower : 1,
                    maxPower : 2,
                    valuePerPower : 200,
                    categories : [CATEGORY_SHIELD],
                    onAdd : function(item : ItemType, power : Float, enchantment : Enchantment) : Void
                    {
                        item.withEffect(IELib.Tease_RaceX2, power * 200, (try cast(enchantment, SimpleRaceEnchantment) catch(e:Dynamic) null).race);
                    }
                });
    
    public static function decode(o : Array<Dynamic>) : Enchantment
    {
        var id : Int = o[1];
        var type : EnchantmentType = EnchantmentType.ENCHANTMENT_TYPES[id];
        if (type == null)
        {
            return null;
        }
        return type.decode(o);
    }
    
    /**
	 * (itemCategory+"/"+rarity) -> weighted table of enchantment types
	 */
    private var categoryTables : Dynamic = { };
    
    public function getWeightedTable(itemCategory : String, rarity : Int, level : Int) : Array<Dynamic>
    {
        var key : String = itemCategory + "/" + rarity;
        if (!(Lambda.has(categoryTables, key)))
        {
            var table : Array<Dynamic> = [];
            var etype : EnchantmentType;
            for (etype/* AS3HX WARNING could not determine type for var: etype exp: ECall(EIdent(values),[EField(EIdent(EnchantmentType),ENCHANTMENT_TYPES)]) type: null */ in values(EnchantmentType.ENCHANTMENT_TYPES))
            {
                if (etype.rarity == rarity && etype.itemCategories.indexOf(itemCategory) >= 0)
                {
                    table.push([etype.weight, etype]);
                }
            }
            Reflect.setField(categoryTables, key, table);
        }
        return Reflect.field(categoryTables, key).slice().filter(varargify(function(pair : Array<Dynamic>) : Bool
                        {
                            return level >= (try cast(pair[1], EnchantmentType) catch(e:Dynamic) null).minLevel;
                        }));
    }
    
    /**
	 * Might return null if no suitable enchantment types
	 */
    public function randomEnchantmentType(itemCategory : String, rarity : Int, level : Int) : EnchantmentType
    {
        return weightedRandom(getWeightedTable(itemCategory, rarity, level));
    }
    
    /**
	 * Might return null if no suitable enchantment types
	 * @param level Pick enchantments with minLvl <= level
	 * @param options passed to EnchantmentType to fine-tune the roll
	 */
    public function randomEnchantment(itemCategory : String, rarity : Int, level : Int, options : Dynamic = null) : Enchantment
    {
        var etype : EnchantmentType = randomEnchantmentType(itemCategory, rarity, level);
        if (etype == null)
        {
            return null;
        }
        return etype.generateRandom(options);
    }
    
    private static var _instance : EnchantmentLib;
    private static function get_instance() : EnchantmentLib
    {
        if (_instance == null)
        {
            new EnchantmentLib();
        }
        return _instance;
    }
    
    public function new()
    {
        super();
        _instance = this;
    }
    
    public static function mk(id : Int, name : String, params : Dynamic) : EnchantmentType
    {
        var enchantmentType : EnchantmentType = new SimpleEnchantmentType(
        id, 
        name, 
        valueOr(params.curse, false), 
        valueOr(params.prefix, ""), 
        valueOr(params.suffix, ""), 
        valueOr(params.shortSuffix, ""), 
        valueOrThrow(params.description, "Missing description"), 
        valueOr(params.hide, false), 
        valueOr(params.rarity, RARITY_MAGICAL), 
        valueOr(params.minLevel, 0), 
        valueOr(params.minPower, 1), 
        valueOr(params.maxPower, 1), 
        valueOr(params.value, 0), 
        valueOr(params.valuePerPower, 0), 
        valueOr(params.valueX, 1), 
        valueOr(params.valueXPerPower, 0), 
        valueOr(params.onAdd, null));
        if (Lambda.has(params, "chance"))
        {
            enchantmentType.setSpawnChance(params.chance);
        }
        if (Lambda.has(params, "categories"))
        {
            enchantmentType.setItemCategories(params.categories.slice());
        }
        if (Reflect.field(params, "negative") != null)
        {
            enchantmentType.setNegative();
        }
        return enchantmentType;
    }
    public static function mkRacial(id : Int, name : String, params : Dynamic) : SimpleRaceEnchantmentType
    {
        var enchantmentType : SimpleRaceEnchantmentType = new SimpleRaceEnchantmentType(
        id, 
        name, 
        valueOr(params.curse, false), 
        valueOr(params.prefix, ""), 
        valueOr(params.suffix, ""), 
        valueOr(params.shortSuffix, ""), 
        valueOrThrow(params.description, "Missing description"), 
        valueOr(params.hide, false), 
        valueOr(params.rarity, RARITY_MAGICAL), 
        valueOr(params.races, Races.RacesForRandomEnchantments), 
        valueOr(params.minLevel, 0), 
        valueOr(params.minPower, 1), 
        valueOr(params.maxPower, 1), 
        valueOr(params.value, 0), 
        valueOr(params.valuePerPower, 0), 
        valueOr(params.valueX, 1), 
        valueOr(params.valueXPerPower, 0), 
        valueOr(params.onAdd, null));
        if (Lambda.has(params, "chance"))
        {
            enchantmentType.setSpawnChance(params.chance);
        }
        if (Lambda.has(params, "categories"))
        {
            enchantmentType.setItemCategories(params.categories.slice());
        }
        if (Reflect.field(params, "negative") != null)
        {
            enchantmentType.setNegative();
        }
        return enchantmentType;
    }
}


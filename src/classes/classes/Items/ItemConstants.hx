package classes.items;

import classes.ItemType;
import classes.internals.EnumValue;
import classes.internals.Utils;

/**
 * Names & constants shared across various item types
 */
class ItemConstants extends Utils
{
    
    ///////////////////////////////
    // Constants for all/any items
    ///////////////////////////////
    
    // Item categories
    public static inline var CATEGORY_WEAPON_MELEE : String = "weapon";
    //public static const CATEGORY_WEAPON_MELEE_OFF:String	= "weaponoff";
    public static inline var CATEGORY_WEAPON_RANGED : String = "weaponranged";
    public static inline var CATEGORY_SHIELD : String = "shield";
    public static inline var CATEGORY_ARMOR : String = "armor";
    public static inline var CATEGORY_UNDERGARMENT : String = "undergarment";
    public static inline var CATEGORY_NECKLACE : String = "necklace";
    public static inline var CATEGORY_JEWELRY_HEAD : String = "headjewelry";
    public static inline var CATEGORY_JEWELRY_RING : String = "jewelry";
    public static inline var CATEGORY_JEWELRY_MISC : String = "miscjewelry";
    public static inline var CATEGORY_VEHICLE : String = "vehicle";
    public static inline var CATEGORY_FLYING_SWORD : String = "flyingsword";
    public static inline var CATEGORY_CONSUMABLE : String = "consumable";
    public static inline var CATEGORY_USABLE : String = "useable";
    public static inline var CATEGORY_OTHER : String = "other";
    
    // Item tags
    
    /**
	 * To legendary items, which will have a level requirement to equip
	 */
    public static inline var I_LEGENDARY : String = "Legendary";
    /**
	 * For consumables that trigger a transformation
	 */
    public static inline var U_TF : String = "tf";
    
    /////////////////////
    // Generic equipable
    /////////////////////
    /**
	 * EnumValue properties:
	 * - id ("WEAPON_MELEE")
	 * - value (0)
	 * - name ("Weapon")
	 * - category: CATEGORY_XXXX
	 * - nothing: function():Equipable
	 */
    public static var EquipmentSlots : Array<Dynamic> = [];
    
    public static inline var SLOT_WEAPON_MELEE : Int = 0;
    
    public static inline var SLOT_WEAPON_RANGED : Int = 1;
    
    public static inline var SLOT_ARMOR : Int = 2;
    
    public static inline var SLOT_SHIELD : Int = 3;
    
    public static inline var SLOT_UNDER_TOP : Int = 4;
    
    public static inline var SLOT_UNDER_BOTTOM : Int = 5;
    
    public static inline var SLOT_RING_1 : Int = 6;
    
    public static inline var SLOT_RING_2 : Int = 7;
    
    public static inline var SLOT_RING_3 : Int = 8;
    
    public static inline var SLOT_RING_4 : Int = 9;
    
    public static inline var SLOT_JEWELRY_MISC_1 : Int = 10;
    
    public static inline var SLOT_JEWELRY_MISC_2 : Int = 11;
    
    public static inline var SLOT_HEAD : Int = 12;
    
    public static inline var SLOT_NECK : Int = 13;
    
    public static inline var SLOT_FLYING_SWORD : Int = 14;
    
    public static inline var SLOT_VEHICLE : Int = 15;
    
    public static inline var SLOT_WEAPON_MELEE_OFF : Int = 16;
    
    
    public static var EquipmentSlotIds : Array<Dynamic>;  // can't do = ... because of the init. order  
    
    
    /////////////////
    // Armors
    /////////////////
    
    // Armor 'perks'
    public static inline var AP_LIGHT : String = "Light";
    public static inline var AP_MEDIUM : String = "Medium";
    public static inline var AP_HEAVY : String = "Heavy";
    public static inline var AP_LIGHT_AYO : String = "Light Ayo";
    public static inline var AP_HEAVY_AYO : String = "Heavy Ayo";
    public static inline var AP_ULTRA_HEAVY_AYO : String = "Ultra Heavy Ayo";
    // Armor tags
    /**
	 * For armors that display a lot of skin and thus count as naked for tease purpose and perks such as naked truth
	 * Value: none.
	 */
    public static inline var A_REVEALING : String = "Revealing";
    /**
	 * For armors that are flexible or nearly as flexible as if wearing nothing
	 * Value: none.
	 */
    public static inline var A_AGILE : String = "Agile";
    
    /////////////////
    // Weapons
    /////////////////
    
    // Weapon classes
    public static inline var WT_FISTS : String = "Fists";  // Only for *the* fists (no weapon equipped)  
    public static inline var WT_BOW : String = "Bow";
    public static inline var WT_AXE : String = "Axe";
    public static inline var WT_DAGGER : String = "Dagger";
    public static inline var WT_DUELING : String = "Dueling";
    public static inline var WT_EXOTIC : String = "Exotic";
    public static inline var WT_GAUNTLET : String = "Gauntlet";
    public static inline var WT_MACE_HAMMER : String = "Mace/Hammer";
    public static inline var WT_POLEARM : String = "Polearm";
    public static inline var WT_RIBBON : String = "Ribbon";
    public static inline var WT_SCYTHE : String = "Scythe";
    public static inline var WT_SPEAR : String = "Spear";
    public static inline var WT_STAFF : String = "Staff";
    public static inline var WT_SWORD : String = "Sword";
    public static inline var WT_WHIP : String = "Whip";
    public static inline var WT_WAND : String = "Wand";
    // Ranged weapon classes
    public static inline var WT_CROSSBOW : String = "Crossbow";
    public static inline var WT_THROWING : String = "Throwing";
    public static inline var WT_DUAL_FIREARMS : String = "Dual Firearms";
    public static inline var WT_PISTOL : String = "Pistol";
    public static inline var WT_RIFLE : String = "Rifle";
    public static inline var WT_2H_FIREARM : String = "2H Firearm";
    public static inline var WT_DUAL_2H_FIREARMS : String = "Dual 2H Firearms";
    public static inline var WT_TOME : String = "Tome";
    
    // Weapon sizes - not saved anywhere, can be changed between game versions
    public static inline var WSZ_SMALL : Int = 0;
    public static inline var WSZ_MEDIUM : Int = 1;
    public static inline var WSZ_LARGE : Int = 2;
    public static inline var WSZ_MASSIVE : Int = 3;
    
    public static var WeaponSizeNames : Array<Dynamic> = [
        "Small", "Medium", "Large", "Massive"
    ];
    // Weapon tags.
    public static inline var W_HYBRID : String = "Hybrid";
    public static inline var W_WHIPPING : String = "Whipping";
    public static inline var W_WHIRLWIND : String = "Whirlwind";
    public static inline var W_STAFFPART : String = "StaffPart";
    public static inline var W_THROWN : String = "Thrown";
    public static inline var W_TETSUBO : String = "Tetsubo";
    public static inline var W_MUSICINSTR : String = "MusicalInstrument";
    public static inline var W_HTECHWEAPON : String = "High Tech Weapon";
    public static inline var W_LGWRATH : String = "LGWrath";
    public static inline var W_MGWRATH : String = "MGWrath";
    public static inline var W_RAPIER : String = "Rapier";  // Gets bonus from Raphael training  
    public static inline var W_PURE_TYPE : String = "Pure-type Weapon";
    public static inline var W_CORRUPT_TYPE : String = "Corrupt-type Weapon";
    public static inline var W_FIRE_TYPE : String = "Fire-type Weapon";
    public static inline var W_ICE_TYPE : String = "Ice-type Weapon";
    public static inline var W_LIGHTNING_TYPE : String = "Lightning-type Weapon";
    public static inline var W_DARKNESS_TYPE : String = "Darkness-type Weapon";
    
    ///////////////////
    // Jewelry (rings)
    ///////////////////
    
    // Modifiers
    public static inline var RINGEFF_MINLUST : Int = 1;
    public static inline var RINGEFF_FERTILITY : Int = 2;
    public static inline var RINGEFF_SF : Int = 3;
    public static inline var RINGEFF_MP : Int = 4;
    public static inline var RINGEFF_HP : Int = 5;
    public static inline var RINGEFF_ATTACK_POWER : Int = 6;
    public static inline var RINGEFF_SPELL_POWER : Int = 7;
    public static inline var RINGEFF_PURITY : Int = 8;
    public static inline var RINGEFF_CORRUPTION : Int = 9;
    public static inline var RINGEFF_WR : Int = 10;
    public static inline var RINGEFF_R_ATTACK_POWER : Int = 11;
    public static inline var RINGEFF_SOUL_POWER : Int = 12;
    
    ////////////////
    // Head jewelry
    ////////////////
    
    // Types
    public static inline var HJT_CROWN : String = "Crown";
    public static inline var HJT_HAIRPIN : String = "Hairpin";
    public static inline var HJT_HELMET : String = "Helmet";
    public static inline var HJT_TIARA : String = "Tiara";
    
    // Modifiers
    
    public static inline var HEADEFF_SF : Int = 1;
    public static inline var HEADEFF_MP : Int = 2;
    public static inline var HEADEFF_HP : Int = 3;
    public static inline var HEADEFF_ATTACK_POWER : Int = 4;
    public static inline var HEADEFF_SPELL_POWER : Int = 5;
    public static inline var HEADEFF_R_ATTACK_POWER : Int = 6;
    //public static const HEADEFF_:int             = 7;
    public static inline var HEADEFF_WR : Int = 8;
    public static inline var HEADEFF_FIRE_R : Int = 9;
    public static inline var HEADEFF_ICE_R : Int = 10;
    public static inline var HEADEFF_LIGH_R : Int = 11;
    public static inline var HEADEFF_DARK_R : Int = 12;
    public static inline var HEADEFF_POIS_R : Int = 13;
    public static inline var HEADEFF_MAGIC_R : Int = 14;
    public static inline var HEADEFF_LUST_R : Int = 15;
    public static inline var HEADEFF_PHYS_R : Int = 16;
    
    ///////////////////
    // Undergarment
    ///////////////////
    
    // Types
    public static var UT_ANY : Int = -1;  // NOTHING only  
    public static inline var UT_TOP : Int = 0;
    public static inline var UT_BOTTOM : Int = 1;
    public static inline var UT_FULL : Int = 2;
    
    ////////////////
    // Tag names  //
    ////////////////
    
    // Add an empty string if the tag should be hidden in the description
    public static var ItemTagNames : Dynamic = createMapFromPairs([
                [W_LGWRATH, "Low Grade Wrath"], 
                [W_MGWRATH, "Mid Grade Wrath"], 
                [W_STAFFPART, "Staff Part"], 
                [U_TF, ""]
        ]);
    
    ///////////////////////
    // Item Effect Flags //
    ///////////////////////
    // bit flags from 1 << 1 to 1 << 31
    public static var IEF_REQUIREMENT : Int = 1 << 1;  // equipment requirement  
    public static var IEF_ATTACK : Int = 1 << 2;  // attack bonus/penalty  
    public static var IEF_DEFENSE : Int = 1 << 3;  // defense bonus/penalty  
    public static var IEF_ONEQUIP : Int = 1 << 4;  // invokes onequip/unequip  
    public static var ItemEffectLastFlag : Int = 1 << 4;  // keep updated  
    
    ///////////////////
    // Enchanted items
    ///////////////////
    
    /**
	 * EnumValue properties:
	 * - value: code (1)
	 * - id: var name ("MAGICAL")
	 *
	 * - name: display name ("magical")
	 * - buttonColor: button label color
	 * - valueMul: Base value multiplier
	 */
    public static var Rarities : Array<Dynamic> = [];
    
    public static inline var RARITY_COMMON : Int = 0;
    public static inline var RARITY_MAGICAL : Int = 1;
    public static inline var RARITY_RARE : Int = 2;
    public static inline var RARITY_LEGENDARY : Int = 3;
    public static inline var RARITY_DIVINE : Int = 4;
    
    
    
    
    
    
    public static inline var BTNCOLOR_CURSED : String = "#800000";
    
    public static inline var CS_HIDDEN_UNCURSED : Int = 0;
    public static inline var CS_KNOWN_UNCURSED : Int = 1;
    public static inline var CS_HIDDEN_CURSED : Int = 2;
    public static inline var CS_KNOWN_CURSED : Int = 3;
    
    public static inline var CSBITMASK_CURSED : Int = 2;  // 0b10  
    public static inline var CSBITMASK_KNOWN : Int = 1;  // 0b01  
    
    public function new()
    {
        super();
    }
    private static var ItemConstants_static_initializer = {
        EnumValue.add(EquipmentSlots, SLOT_WEAPON_MELEE, "WEAPON_MELEE", {
                    name : "Weapon (Melee)",
                    category : CATEGORY_WEAPON_MELEE,
                    nothing : function() : ItemType
                    {
                        return WeaponLib.FISTS;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_WEAPON_RANGED, "WEAPON_RANGED", {
                    name : "Weapon (Ranged)",
                    category : CATEGORY_WEAPON_RANGED,
                    nothing : function() : ItemType
                    {
                        return WeaponRangeLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_ARMOR, "ARMOR", {
                    name : "Armor",
                    category : CATEGORY_ARMOR,
                    nothing : function() : ItemType
                    {
                        return ArmorLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_SHIELD, "SHIELD", {
                    name : "Shield",
                    category : CATEGORY_SHIELD,
                    nothing : function() : ItemType
                    {
                        return ShieldLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_UNDER_TOP, "UNDER_TOP", {
                    name : "Upper underwear",
                    category : CATEGORY_UNDERGARMENT,
                    nothing : function() : ItemType
                    {
                        return UndergarmentLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_UNDER_BOTTOM, "UNDER_BOTTOM", {
                    name : "Lower underwear",
                    category : CATEGORY_UNDERGARMENT,
                    nothing : function() : ItemType
                    {
                        return UndergarmentLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_RING_1, "RING_1", {
                    name : "Ring (1st)",
                    category : CATEGORY_JEWELRY_RING,
                    nothing : function() : ItemType
                    {
                        return JewelryLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_RING_2, "RING_2", {
                    name : "Ring (2nd)",
                    category : CATEGORY_JEWELRY_RING,
                    nothing : function() : ItemType
                    {
                        return JewelryLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_RING_3, "RING_3", {
                    name : "Ring (3rd)",
                    category : CATEGORY_JEWELRY_RING,
                    nothing : function() : ItemType
                    {
                        return JewelryLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_RING_4, "RING_4", {
                    name : "Ring (4th)",
                    category : CATEGORY_JEWELRY_RING,
                    nothing : function() : ItemType
                    {
                        return JewelryLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_JEWELRY_MISC_1, "JEWELRY_MISC_1", {
                    name : "Accessory (1st)",
                    category : CATEGORY_JEWELRY_MISC,
                    nothing : function() : ItemType
                    {
                        return MiscJewelryLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_JEWELRY_MISC_2, "JEWELRY_MISC_2", {
                    name : "Accessory (2nd)",
                    category : CATEGORY_JEWELRY_MISC,
                    nothing : function() : ItemType
                    {
                        return MiscJewelryLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_HEAD, "HEAD", {
                    name : "Head Accessory",
                    category : CATEGORY_JEWELRY_HEAD,
                    nothing : function() : ItemType
                    {
                        return HeadJewelryLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_NECK, "NECK", {
                    name : "Necklace",
                    category : CATEGORY_NECKLACE,
                    nothing : function() : ItemType
                    {
                        return NecklaceLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_FLYING_SWORD, "FLYING_SWORD", {
                    name : "Flying Sword",
                    category : CATEGORY_FLYING_SWORD,
                    nothing : function() : ItemType
                    {
                        return FlyingSwordsLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_VEHICLE, "VEHICLE", {
                    name : "Vehicle",
                    category : CATEGORY_VEHICLE,
                    nothing : function() : ItemType
                    {
                        return VehiclesLib.NOTHING;
                    }
                });
        EnumValue.add(EquipmentSlots, SLOT_WEAPON_MELEE_OFF, "WEAPON_MELEE_OFF", {
                    name : "Weapon (Melee Offhand)",
                    category : CATEGORY_WEAPON_MELEE,
                    nothing : function() : ItemType
                    {
                        return WeaponLib.FISTS;
                    }
                });
        EquipmentSlotIds = Utils.mapOneProp(EquipmentSlots, "value");
        EnumValue.add(Rarities, RARITY_COMMON, "COMMON", {
                    name : "common",
                    buttonColor : "#000000",
                    valueMul : 1
                });
        EnumValue.add(Rarities, RARITY_MAGICAL, "MAGICAL", {
                    name : "magical",
                    buttonColor : "#0000C0",
                    valueMul : 1
                });
        EnumValue.add(Rarities, RARITY_RARE, "RARE", {
                    name : "rare",
                    buttonColor : "#006000",
                    valueMul : 2
                });
        EnumValue.add(Rarities, RARITY_LEGENDARY, "LEGENDARY", {
                    name : "legendary",
                    buttonColor : "#FFFF40",
                    valueMul : 3
                });
        EnumValue.add(Rarities, RARITY_DIVINE, "DIVINE", {
                    name : "divine",
                    buttonColor : "#80EEEE",
                    valueMul : 4
                });
        true;
    }

}


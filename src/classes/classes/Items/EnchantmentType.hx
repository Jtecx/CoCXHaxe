package classes.items;

import flash.errors.Error;
import classes.CoC;
import classes.CoCSettings;
import classes.Player;
import coc.script.Eval;
import flash.utils.Dictionary;

class EnchantmentType extends ItemConstants
{
    private static var game(get, never) : CoC;

    public static var ENCHANTMENT_TYPES : Dictionary = new Dictionary();
    
    public var id : Int;
    public var name : String;
    /** Always makes a cursed item */
    public var curse : Bool;
    /** Negative effect, greater cursed item chance */
    public var negative : Bool = false;
    public var descPattern : String;
    public var rarity : Int;
    public var minLevel : Int;
    public var itemCategories : Array<Dynamic> = [
        CATEGORY_WEAPON_MELEE, 
        CATEGORY_WEAPON_RANGED, 
        CATEGORY_SHIELD, 
        CATEGORY_ARMOR, 
        CATEGORY_UNDERGARMENT, 
        CATEGORY_NECKLACE, 
        CATEGORY_JEWELRY_HEAD, 
        CATEGORY_JEWELRY_RING, 
        CATEGORY_JEWELRY_MISC, 
        CATEGORY_VEHICLE, 
        CATEGORY_FLYING_SWORD
    ];
    public var weight : Float = 1;
    
    public function decode(o : Array<Dynamic>) : Enchantment
    {
        var identified : Bool = o[0];
        return doDecode(identified, o.slice(2));
    }
    
    /**
	 * Generate random enchantment of this type
	 * @param options.identified Should be identified
	 */
    public function generateRandom(options : Dynamic = null) : Enchantment
    // Implement in subclass
    {
        
        CoC_Settings.errorAMC("EnchantmentType", "generateRandom");
        return null;
    }
    
    /**
	 * Enchantment text patterns:
	 * <pre>
	 * {expression} - evaluated with Enchantment as context
	 * {expression;format} - also apply number formatting:
	 *   d - integer
	 *  +d - signed integer
	 *  2f - float 2 decimals (or any other number)
	 * +2f - signed float 2 decimals
	 *   C - capitalize first letter
	 *
	 * Examples for enchantment of power=5:
	 * "{power} fire damage" -> "5 fire damage"
	 * "{power*5;+d}% strength" -> "+50% strength"
	 * "{power*0.5;+1f}% fire resistance" -> "+2.5% fire resistance"
	 * </pre>
	 */
    public static function parseEnchantmentText(pattern : String, enchantment : Enchantment) : String
    {
        var context : Dynamic = (CoC.instance) ? {
            player : CoC.instance.player,
            game : CoC.instance
        } : { };
        return substitute(pattern, enchantment, context);
    }
    
    /**
	 * Decode enchantment.
	 * @param identified return identified enchantment
	 * @param paramsOnly raw enchantment params (minus identified flag and id)
	 */
    private function doDecode(identified : Bool, paramsOnly : Array<Dynamic>) : Enchantment
    // implement in subclasses
    {
        
        CoC_Settings.errorAMC("EnchantmentType", "doDecode");
        return null;
    }
    
    /**
	 * Apply effects when enchanted item is equipped
	 */
    public function onEquip(player : Player, enchantment : Enchantment, item : Equipable) : Void
    {  // override in subclasses  
        
    }
    
    /**
	 * Remove effects when enchanted item is unequipped
	 */
    public function onUnequip(player : Player, enchantment : Enchantment, item : Equipable) : Void
    {  // override in subclasses  
        
    }
    
    /**
	 * Enchantment is added to an item during construction.
	 * Only called for identified items
	 */
    public function onAdd(enchantment : Enchantment, item : Equipable) : Void
    {  // override in subclasses  
        
    }
    
    /**
	 * Do not add the enchantment description to the list.
	 */
    public function hideDescription(enchantment : Enchantment) : Bool
    {
        return false;
    }
    
    public function setSpawnChance(weight : Float) : EnchantmentType
    {
        this.weight = weight;
        return this;
    }
    public function setNegative() : EnchantmentType
    {
        this.negative = true;
        return this;
    }
    public function setItemCategories(categories : Array<Dynamic>) : EnchantmentType
    {
        this.itemCategories = categories.copy();
        return this;
    }
    
    public function new(
            id : Int,
            name : String,
            curse : Bool,
            descPattern : String,
            rarity : Int,
            minLevel : Int)
    {
        super();
        if (Lambda.has(ENCHANTMENT_TYPES, id))
        {
            throw new Error("Duplicate enchantment ID " + id);
        }
        ENCHANTMENT_TYPES[id] = this;
        this.id = id;
        this.name = name;
        this.curse = curse;
        this.descPattern = descPattern;
        this.rarity = rarity;
        this.minLevel = minLevel;
    }
    
    private static function get_game() : CoC
    {
        return CoC.instance;
    }
}


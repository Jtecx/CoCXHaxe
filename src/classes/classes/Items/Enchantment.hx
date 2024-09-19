package classes.items;

import flash.errors.Error;
import classes.Player;

class Enchantment
{
    public var id(get, never) : Int;
    public var rarity(get, never) : Int;
    public var curse(get, never) : Bool;
    public var description(get, never) : String;

    public var identified : Bool;
    public var type : EnchantmentType;
    public var prefix : String;
    public var suffix : String;
    public var shortSuffix : String;
    public var power : Float;
    public var params : Array<Dynamic>;
    public var valueAdd : Float;
    public var valueMul : Float;
    
    private function get_id() : Int
    {
        return type.id;
    }
    
    private function get_rarity() : Int
    {
        return type.rarity;
    }
    
    private function get_curse() : Bool
    {
        return type.curse;
    }
    
    public function encode() : Array<Dynamic>
    {
        return [(identified) ? 1 : 0, type.id].concat(params);
    }
    
    public function new(
            identified : Bool,
            type : EnchantmentType,
            prefix : String,
            suffix : String,
            shortSuffix : String,
            power : Float,
            params : Array<Dynamic>,
            valueAdd : Float,
            valueMul : Float,
            genText : Bool = true)
    {
        this.identified = identified;
        this.type = type;
        this.prefix = prefix;
        this.suffix = suffix;
        this.shortSuffix = shortSuffix;
        this.power = power;
        this.params = params;
        this.valueAdd = valueAdd;
        this.valueMul = valueMul;
        if (genText)
        {
            this.genDescription();
        }
    }
    private function genDescription() : Void
    {
        try
        {
            this.prefix = EnchantmentType.parseEnchantmentText(prefix, this);
            this.suffix = EnchantmentType.parseEnchantmentText(suffix, this);
        }
        catch (e : Error)
        {
            trace(e.getStackTrace());
        }
    }
    private function get_description() : String
    {
        var description : String = "";
        try
        {
            description = EnchantmentType.parseEnchantmentText(type.descPattern, this);
        }
        catch (e : Error)
        {
            trace(e.getStackTrace());
            description = "ERROR " + e.message + "\n" + e.getStackTrace();
        }
        return description;
    }
    
    /**
	 * Apply effects when enchanted item is equipped
	 */
    public function onEquip(player : Player, item : Equipable) : Void
    {
        type.onEquip(player, this, item);
    }
    
    /**
	 * Remove effects when enchanted item is unequipped
	 */
    public function onUnequip(player : Player, item : Equipable) : Void
    {
        type.onUnequip(player, this, item);
    }
}


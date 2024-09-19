package classes.items.dynamic.effects;

import haxe.Constraints.Function;
import classes.ItemType;
import classes.items.Enchantment;
import classes.items.EnchantmentType;
import classes.items.Equipable;
import classes.Player;

class SimpleEnchantmentType extends EnchantmentType
{
    public var prefix : String;
    public var suffix : String;
    public var shortSuffix : String;
    public var minPower : Int;
    public var maxPower : Int;
    public var valueAddBase : Int;
    public var valueAddPerPower : Int;
    public var valueMulBase : Float;
    public var valueMulPerPower : Float;
    public var fHideDescription : Bool;
    public var onAddFn : Function;
    
    override public function hideDescription(enchantment : Enchantment) : Bool
    {
        return fHideDescription;
    }
    
    override private function doDecode(identified : Bool, paramsOnly : Array<Dynamic>) : Enchantment
    {
        var power : Float = paramsOnly[0];
        var valueAdd : Float = valueAddBase + valueAddPerPower * power;
        var valueMul : Float = valueMulBase + valueMulPerPower * power;
        
        return new Enchantment(
        identified, 
        this, 
        prefix, 
        suffix, 
        shortSuffix, 
        power, 
        paramsOnly, 
        valueAdd, 
        valueMul);
    }
    
    public function spawn(identified : Bool, power : Int) : Enchantment
    {
        return doDecode(identified, [power]);
    }
    
    override public function generateRandom(options : Dynamic = null) : Enchantment
    {
        var power : Int = randIntIn(minPower, maxPower);
        return doDecode(valueOr(options.identified, false), [power]);
    }
    
    public function new(id : Int,
            name : String,
            curse : Bool,
            prefix : String,
            suffix : String,
            shortSuffix : String,
            descPattern : String,
            hideDescription : Bool,
            rarity : Int,
            minLevel : Int,
            minPower : Int,
            maxPower : Int,
            valueAddBase : Int,
            valueAddPerPower : Int,
            valueMulBase : Float,
            valueMulPerPower : Float,
            onAddFn : Function = null)
    {
        super(id, name, curse, descPattern, rarity, minLevel);
        this.fHideDescription = hideDescription;
        this.prefix = prefix;
        this.suffix = suffix;
        this.shortSuffix = shortSuffix;
        this.minPower = minPower;
        this.maxPower = maxPower;
        this.valueAddBase = valueAddBase;
        this.valueAddPerPower = valueAddPerPower;
        this.valueMulBase = valueMulBase;
        this.valueMulPerPower = valueMulPerPower;
        this.onAddFn = onAddFn;
    }
    
    override public function onAdd(enchantment : Enchantment, item : Equipable) : Void
    {
        super.onAdd(enchantment, item);
        if (onAddFn != null)
        {
            varargify(onAddFn)(item, enchantment.power, enchantment);
        }
    }
}


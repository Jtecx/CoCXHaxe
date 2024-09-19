package classes.items.dynamic.effects;

import classes.ItemType;
import classes.items.Enchantment;
import classes.items.Equipable;
import classes.Player;
import classes.stats.StatUtils;

/**
 * Buff stat by (power x 0.5%)
 */
class StatEnchantmentType extends SimpleEnchantmentType
{
    public var statName : String;
    public var statPerPower : Float;
    
    public function new(
            id : Int,
            name : String,
            curse : Bool,
            statName : String,
            prefix : String,
            suffix : String,
            shortSuffix : String,
            rarity : Int,
            minLevel : Int,
            minPower : Int,
            maxPower : Int,
            statPerPower : Float,
            valueAddBase : Int,
            valueAddPerPower : Int,
            valueMulBase : Float = 1.0,
            valueMulPerPower : Float = 0.0)
    {
        this.statName = statName;
        this.statPerPower = statPerPower;
        var displayName : String = StatUtils.nameOfStat(statName);
        var descPattern : String;
        if (StatUtils.isPercentageStat(statName))
        {
            descPattern = displayName + " {power*" + (statPerPower * 100) + ";+d}%";
        }
        else
        {
            descPattern = displayName + " {power*" + statPerPower + ";+d}%";
        }
        super(id, name, curse, prefix, suffix, shortSuffix, descPattern, true, 
                rarity, minLevel, 
                minPower, maxPower, valueAddBase, valueAddPerPower, valueMulBase, valueMulPerPower
        );
    }
    
    override public function onAdd(enchantment : Enchantment, item : Equipable) : Void
    {
        super.onAdd(enchantment, item);
        item.withBuff(statName, statPerPower * enchantment.power);
    }
}


package classes.items.dynamic.effects;

import classes.items.Enchantment;
import classes.items.EnchantmentType;
import classes.Race;

class SimpleRaceEnchantment extends Enchantment
{
    public var race : Race;
    public function new(
            identified : Bool,
            type : EnchantmentType,
            prefix : String,
            suffix : String,
            shortSuffix : String,
            power : Float,
            race : Race,
            params : Array<Dynamic>,
            valueAdd : Float,
            valueMul : Float)
    {
        super(identified, type, prefix, suffix, shortSuffix, power, params, valueAdd, valueMul, false);
        this.race = race;
        genDescription();
    }
}


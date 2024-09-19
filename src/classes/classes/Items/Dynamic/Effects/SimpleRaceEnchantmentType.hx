package classes.items.dynamic.effects;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.items.Enchantment;
import classes.Race;

class SimpleRaceEnchantmentType extends SimpleEnchantmentType
{
    private var allowedRaces : Dynamic;
    
    override private function doDecode(identified : Bool, paramsOnly : Array<Dynamic>) : Enchantment
    {
        var power : Float = paramsOnly[0];
        var race : Race = Race.byId(paramsOnly[1]);
        var valueAdd : Float = valueAddBase + valueAddPerPower * power;
        var valueMul : Float = valueMulBase + valueMulPerPower * power;
        
        if (!(Std.is(allowedRaces, Array)))
        {
            valueAdd *= valueOr(Reflect.field(allowedRaces, Std.string(race.id)).value, 1);
            if (valueMul != 1)
            {
                valueMul *= valueOr(Reflect.field(allowedRaces, Std.string(race.id)).value, 1);
            }
        }
        
        return new SimpleRaceEnchantment(
        identified, 
        this, 
        prefix, 
        suffix, 
        shortSuffix, 
        power, 
        race, 
        paramsOnly, 
        valueAdd, 
        valueMul);
    }
    
    @:meta(Deprecated(message="Use spawn2"))

    override public function spawn(identified : Bool, power : Int) : Enchantment
    {
        throw new Error("Call spawn2");
    }
    public function spawn2(identified : Bool, power : Int, race : Race) : SimpleRaceEnchantment
    {
        return try cast(doDecode(identified, [power, race.id]), SimpleRaceEnchantment) catch(e:Dynamic) null;
    }
    
    override public function generateRandom(options : Dynamic = null) : Enchantment
    {
        var power : Int = randIntIn(minPower, maxPower);
        var race : Race;
        if (Std.is(allowedRaces, Array))
        {
            race = randomChoice(allowedRaces);
        }
        else
        {
            race = weightedRandomBy(allowedRaces, "chance").race;
        }
        return doDecode(valueOr(options.identified, false), [power, race.id]);
    }
    
    public function new(
            id : Int,
            name : String,
            curse : Bool,
            prefix : String,
            suffix : String,
            shortSuffix : String,
            descPattern : String,
            hasDescription : Bool,
            rarity : Int,
            allowedRaces : Dynamic,
            minLevel : Int,
            minPower : Int,
            maxPower : Int,
            valueAddBase : Int,
            valueAddPerPower : Int,
            valueMulBase : Float,
            valueMulPerPower : Float,
            onAddFn : Function = null)
    {
        super(id, name, curse, prefix, suffix, shortSuffix, descPattern, hasDescription, rarity, minLevel, minPower, maxPower, valueAddBase, valueAddPerPower, valueMulBase, valueMulPerPower, onAddFn);
        this.allowedRaces = allowedRaces;
    }
}


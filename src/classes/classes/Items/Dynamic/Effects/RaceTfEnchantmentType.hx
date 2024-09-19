package classes.items.dynamic.effects;

import classes.EngineCore;
import classes.ItemType;
import classes.items.Armor;
import classes.items.effects.RaceTfItemEffect;
import classes.items.Enchantment;
import classes.items.EnchantmentLib;
import classes.items.EnchantmentType;
import classes.items.Equipable;
import classes.items.IDynamicItem;
import classes.items.IELib;
import classes.items.Shield;
import classes.items.Weapon;
import classes.items.WeaponRange;
import classes.Player;
import classes.Race;
import classes.Races;
import classes.StatusEffectClass;
import classes.StatusEffects;
import classes.transformations.PossibleEffect;
import classes.transformations.TransformationUtils;

class RaceTfEnchantmentType extends EnchantmentType
{
    
    /**
	 * Player has been TF'd into race. Remove enchantment and curse status
	 */
    public static function disenchant(race : Race) : Void
    {
        trace("RaceTf disencnant");
        EngineCore.outputText("\n\n<b>Your transformation into " + race.nameFor(game.player.bodyData()));
        if (game.player.raceObject() == race)
        {
            EngineCore.outputText(" is complete, and the curse is lifted!</b>");
        }
        // main race is different, but player is tier1 at least
        else
        {
            
            EngineCore.outputText(" has advanced enough to lift the curse!</b>");
        }
        for (i/* AS3HX WARNING could not determine type for var: i exp: ECall(EField(EField(EIdent(game),player),allEquipment),[]) type: null */ in game.player.allEquipment())
        {
            var e : SimpleRaceEnchantment = try cast(i.enchantmentOfType(EnchantmentLib.RaceTf), SimpleRaceEnchantment) catch(e:Dynamic) null;
            if (e == null)
            {
                continue;
            }
            if (e.race == race)
            {
                var e2 : Enchantment;
                if (Std.is(i, Weapon) || Std.is(i, WeaponRange))
                {
                    e2 = EnchantmentLib.RaceAttackBonus.spawn2(true, e.power, e.race);
                }
                else if (Std.is(i, Armor) || Std.is(i, Shield))
                {
                    e2 = EnchantmentLib.RaceDefenseBonus.spawn2(true, e.power, e.race);
                }
                else
                {
                    e2 = EnchantmentLib.RaceSpellPowerBonus.spawn2(true, e.power, e.race);
                }
                var i2 : ItemType = i;
                i2 = (try cast(i2, IDynamicItem) catch(e:Dynamic) null).copyWithoutEnchantment(e);
                i2 = (try cast(i2, IDynamicItem) catch(e:Dynamic) null).uncursedCopy();
                i2 = (try cast(i2, IDynamicItem) catch(e:Dynamic) null).copyWithEnchantment(e2);
                game.player.replaceEquipment(try cast(i, Equipable) catch(e:Dynamic) null, try cast(i2, Equipable) catch(e:Dynamic) null);
                EngineCore.outputText(" Your " + i.longName + " turns into " + i2.longName + "!");
            }
        }
    }
    
    public function new(
            id : Int,
            name : String,
            rarity : Int,
            minLevel : Int)
    {
        var curse : Bool = true;
        var descPattern : String = "Every {30-6*power} hours transforms you into {race.name}.";
        super(id, name, curse, descPattern, rarity, minLevel);
        negative = true;
    }
    
    
    override public function hideDescription(enchantment : Enchantment) : Bool
    {
        return true;
    }
    
    override private function doDecode(identified : Bool, paramsOnly : Array<Dynamic>) : Enchantment
    {
        var power : Float = paramsOnly[0];
        var race : Race = Race.byId(paramsOnly[1]);
        var valueAddBase : Int = 0;
        var valueAddPerPower : Int = 250;
        var valueMulBase : Float = 1.0;
        var valueMulPerPower : Float = 0.0;
        var valueAdd : Float = valueAddBase + valueAddPerPower * power;
        var valueMul : Float = valueMulBase + valueMulPerPower * power;
        var prefix : String = "{race.name;C} nature ";
        var suffix : String = " of {race.name;C} nature ";
        var shortSuffix : String = "RTF";
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
    
    public function spawn(identified : Bool, power : Int, race : Race, permEffect : Bool = false) : SimpleRaceEnchantment
    {
        return try cast(doDecode(identified, [power, race.id, permEffect]), SimpleRaceEnchantment) catch(e:Dynamic) null;
    }
    
    override public function generateRandom(options : Dynamic = null) : Enchantment
    {
        var minPower : Int = 1;
        var maxPower : Int = 4;
        var power : Int = randIntIn(minPower, maxPower);
        var race : Race = weightedRandomBy(RaceTfItemEffect.RaceGen, "chance", "race");
        return doDecode(valueOr(options.identified, false), [power, race.id]);
    }
    
    override public function onAdd(enchantment : Enchantment, item : Equipable) : Void
    {
        item.withEffect(IELib.RaceTf, 30 - enchantment.power * 3, (try cast(enchantment, SimpleRaceEnchantment) catch(e:Dynamic) null).race);
    }
}


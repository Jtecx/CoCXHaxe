package classes.items.effects;

import classes.CoC;
import classes.EngineCore;
import classes.ItemType;
import classes.items.dynamic.effects.RaceTfEnchantmentType;
import classes.items.dynamic.effects.SimpleRaceEnchantment;
import classes.items.EnchantmentLib;
import classes.items.Equipable;
import classes.items.IELib;
import classes.items.ItemConstants;
import classes.items.ItemEffect;
import classes.items.ItemEffectType;
import classes.Player;
import classes.Race;
import classes.Races;
import classes.StatusEffectClass;
import classes.StatusEffects;
import classes.transformations.PossibleEffect;
import classes.transformations.TransformationUtils;
import classes.internals.Utils;

class RaceTfItemEffect extends ItemEffectType
{
    public static var RaceGen(get, never) : Array<Dynamic>;

    /**
	 * Element properties:
	 * - chance:Number, spawn weight, default 1
	 * - race:Race
	 * - tfs:Transformation[]
	 */
    private static var RaceGen_field : Array<Dynamic> = null;
    private static function get_RaceGen() : Array<Dynamic>
    {
        if (RaceGen_field == null)
        {
            RaceGen_field = [{
                        chance : 1.0,
                        race : Races.BEE,
                        tfs : Races.BEE.TfList,
                        tfPerm : false
                    }, {
                        chance : 1.0,
                        race : Races.CAT,
                        tfs : Races.CAT.TfList,
                        tfPerm : false
                    }, {
                        chance : 1.0,
                        race : Races.FOX,
                        tfs : Races.FOX.TfList,
                        tfPerm : false
                    }, {
                        chance : 1.0,
                        race : Races.GOBLIN,
                        tfs : Races.GOBLIN.TfList,
                        tfPerm : false
                    }, {
                        chance : 0.1,
                        race : Races.IMP,
                        tfs : Races.IMP.TfList,
                        tfPerm : false
                    }, {
                        chance : 0.5,
                        race : Races.KITSUNE,
                        tfs : Races.KITSUNE.TfList,
                        tfPerm : false
                    }, {
                        chance : 1.0,
                        race : Races.LIZARD,
                        tfs : Races.LIZARD.TfList,
                        tfPerm : false
                    }, {
                        chance : 1.0,
                        race : Races.WOLF,
                        tfs : Races.WOLF.TfList,
                        tfPerm : false
                    }];
        }
        return RaceGen_field;
    }
    
    public function new()
    {
        super("RaceTf");
        withFlags(ItemConstants.IEF_ONEQUIP);
    }
    
    override public function description(effect : ItemEffect, item : ItemType) : String
    {
        return "Every " + Utils.numberOfThings(effect.power, "hour") + " hours transforms you into " + (try cast(effect.value1, Race) catch(e:Dynamic) null).name;
    }
    
    public static function allEnchantedEquipment(player : Player, race : Race) : Array<Dynamic>
    {
        return player.allEquipment().filter(Utils.varargify(function(it : Equipable) : Bool
                        {
                            var e : ItemEffect = it.findEffect(IELib.RaceTf);
                            return e && (e.value1 == race || race == null);
                        }));
    }
    
    /**
	 * Advance the TF from the status effect
	 * @param effect
	 * @return true if text was printed
	 */
    public static function advance(player : Player, effect : StatusEffectClass) : Bool
    // v1: hours till next TF, v2: race id, v3: no. of equipped items of that race
    {
        
        var race : Race = Race.byId(effect.value2);
        var items : Array<Dynamic> = allEnchantedEquipment(player, race);
        var removeEffect : Bool = true;
        var entry : Dynamic = Utils.findByProp(RaceGen, "race", Race.byId(effect.value2));
        if (entry.tfPerm)
        {
            removeEffect = false;
        }
        // Sanity check
        if (items.length == 0)
        {
            EngineCore.outputText("\n<b>ERROR</b> ItemEffectRaceTf effect (" + race.name + ") present but no such item equipped (this is a bug). ");
            items = allEnchantedEquipment(player, null);
            player.removeStatusEffectInstance(effect);
            if (items.length > 0)
            {
                var e : ItemEffect = items[0].findEffect(IELib.RaceTf);
                EngineCore.outputText("Replacing with " + (try cast(e.value1, Race) catch(e:Dynamic) null).name + ". \n");
                e.onEquip(player, items[0]);
            }
            else
            {
                EngineCore.outputText("Effect removed. \n");
            }
            return true;
        }
        if (player.blockingBodyTransformations())
        {
            return false;
        }
        
        //
        var hasEnchantments : Bool = false;
        for (item in items)
        {
            var enchantment : SimpleRaceEnchantment = try cast(item.enchantmentOfType(EnchantmentLib.RaceTf), SimpleRaceEnchantment) catch(e:Dynamic) null;
            if (enchantment != null && enchantment.race == race)
            {
                hasEnchantments = true;
                break;
            }
        }
        if (!hasEnchantments)
        {
            removeEffect = false;
        }
        
        if (removeEffect && player.isRace(race, 1, false))
        
        // If player is target race before tick, disenchant the item{
            
            RaceTfEnchantmentType.disenchant(race);
            return true;
        }
        effect.value1--;
        trace("RaceTf tick-->" + effect.value1);
        var textOutput : Bool = false;
        if (effect.value1 <= 0)
        {
            var tfList : Array<Dynamic> = entry.tfs;
            var tf : PossibleEffect = TransformationUtils.randomPossibleEffect(tfList);
            if (tf != null)
            {
                trace("RaceTf tf");
                EngineCore.outputText("\n<b>Your " + items[0].longName + " twists your body...</b> ");
                tf.applyEffect(true);
                textOutput = true;
                if (removeEffect && player.isRace(race, 1, false))
                
                // if player becomes target race, disenchant the item{
                    
                    RaceTfEnchantmentType.disenchant(race);
                }
                else
                {
                    var hoursBetween : Int = 30;
                    for (item in items)
                    {
                        hoursBetween = Math.min(hoursBetween, item.effectPower(IELib.RaceTf));
                    }
                    effect.value1 = hoursBetween;
                    trace("RaceTf tick reset to " + effect.value1);
                }
            }
        }
        else if (effect.value1 == 1)
        {
            EngineCore.outputText("\n<b>Your " + items[0].longName + " is almost charged...</b> ");
            textOutput = true;
        }
        return textOutput;
    }
    
    override public function onEquip(player : Player, item : Equipable, effect : ItemEffect) : Void
    {
        if (CoC.instance.isLoadingSave)
        {
            return;
        }
        var race : Race = try cast(effect.value1, Race) catch(e:Dynamic) null;
        var eff : StatusEffectClass = player.statusEffectByType(StatusEffects.ItemEffectRaceTf);
        trace("RaceTf equip " + race.name + " " + effect.power + " " + eff);
        if (eff != null)
        
        // Player is already TF'ing.{
            
            if (eff.value2 == race.id)
            
            // same race{
                
                eff.value3++;
            }
        }
        // This is first TF item
        else
        {
            
            eff = player.createStatusEffect(StatusEffects.ItemEffectRaceTf, effect.power, race.id, 1, 0);
        }
        trace("      -> " + eff);
    }
    
    override public function onUnequip(player : Player, item : Equipable, effect : ItemEffect) : Void
    {
        if (CoC.instance.isLoadingSave)
        {
            return;
        }
        var race : Race = try cast(effect.value1, Race) catch(e:Dynamic) null;
        var eff : StatusEffectClass = player.statusEffectByType(StatusEffects.ItemEffectRaceTf);
        trace("RaceTf unequip " + race.name + " " + effect.power + " " + eff);
        if (eff == null)
        {
            return;
        }  // something very wrong here  
        if (eff.value2 != race.id)
        {
            return;
        }  // unequip RaceA TF while player is TF'ing into RaceB  
        // unequip RaceA TF enchantment
        eff.value3--;
        trace("      -> " + eff);
        if (eff.value3 > 0)
        {
            return;
        }  // still more TF enchantment of that race  
        // last TF enchantment of RaceA unequipped.
        player.removeStatusEffectInstance(eff);
        // Check if player has other TF items
        var ench : Array<Dynamic> = player.findItemEffectAndItem(IELib.RaceTf);
        if (ench != null && ench[1].category != item.category)
        
        // Don't call onEquip of item in the same slot - it will be called by its afterEquip instead{
            
            (try cast(ench[0], ItemEffect) catch(e:Dynamic) null).onEquip(player, ench[1]);
        }
    }
}


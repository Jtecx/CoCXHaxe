package classes.items.effects;

import haxe.Constraints.Function;
import classes.ItemType;
import classes.items.Equipable;
import classes.items.ItemEffect;
import classes.items.ItemEffectType;
import classes.Player;
import classes.internals.Utils;

class SimpleItemEffect extends ItemEffectType
{
    private var descPattern : String;
    private var onEquipFn : Function;
    private var onUnequipFn : Function;
    
    public function new(name : String, descPattern : String, priority : Int, onEquipFn : Function, onUnequipFn : Function)
    {
        super(name);
        this.priority = priority;
        this.descPattern = descPattern;
        this.onEquipFn = onEquipFn;
        this.onUnequipFn = onUnequipFn;
    }
    
    override public function description(prop : ItemEffect, item : ItemType) : String
    {
        if (descPattern == null)
        {
            return "";
        }
        return Utils.substitute(descPattern, prop, {
                    item : item
                });
    }
    
    override public function onEquip(player : Player, item : Equipable, effect : ItemEffect) : Void
    {
        if (onEquipFn != null)
        {
            onEquipFn(player, item, effect);
        }
    }
    
    override public function onUnequip(player : Player, item : Equipable, effect : ItemEffect) : Void
    {
        if (onUnequipFn != null)
        {
            onUnequipFn(player, item, effect);
        }
    }
}


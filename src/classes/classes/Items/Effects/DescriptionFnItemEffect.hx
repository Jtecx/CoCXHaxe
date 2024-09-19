package classes.items.effects;

import haxe.Constraints.Function;
import classes.ItemType;
import classes.items.Equipable;
import classes.items.ItemEffect;
import classes.items.ItemEffectType;
import classes.Player;

class DescriptionFnItemEffect extends ItemEffectType
{
    private var descFn : Function;
    private var onEquipFn : Function;
    private var onUnequipFn : Function;
    
    /**
	 *
	 * @param name
	 * @param descFn `function(prop:ItemEffect, item:ItemType):String` returning a tooltip
	 * @param priority
	 */
    public function new(name : String, descFn : Function, priority : Int, onEquipFn : Function, onUnequipFn : Function)
    {
        super(name);
        this.priority = priority;
        this.descFn = descFn;
        this.onEquipFn = onEquipFn;
        this.onUnequipFn = onUnequipFn;
    }
    
    override public function description(prop : ItemEffect, item : ItemType) : String
    {
        if (as3hx.Compat.getFunctionLength(descFn) == 2)
        {
            return descFn(prop, item);
        }
        if (as3hx.Compat.getFunctionLength(descFn) == 1)
        {
            return descFn(prop);
        }
        return descFn();
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


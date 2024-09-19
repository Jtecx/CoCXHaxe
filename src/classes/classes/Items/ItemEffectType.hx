package classes.items;

import classes.ItemType;
import classes.Player;
import flash.utils.Dictionary;

class ItemEffectType
{
    
    public function new(name : String)
    {
        this.name = name;
    }
    
    /** For debugging */
    public var name : String;
    /**
	 * Description priority in the tooltip
	 */
    public var priority : Int = 80;
    /**
	 * A bit mask of IEF_XXXX
	 */
    public var flags : Int = 0;
    /**
	 * Tooltip description for itemeffect instance. Return empty string to hide.
	 * @param effect Actual effect with values
	 * @param item Reference item (can be null)
	 * @return
	 */
    public function description(effect : ItemEffect, item : ItemType) : String
    {
        return "";
    }
    
    /**
	 * Invoked after item with this effect is equipped.
	 *
	 * <b>The effect type MUST have tag IEF_ONEQUIP</b>
	 * @param player
	 * @param item Item with this effect
	 * @param effect Actual effect
	 */
    public function onEquip(player : Player, item : Equipable, effect : ItemEffect) : Void
    {
    }
    /**
	 * Invoked after item with this effect is unequipped.
	 *
	 * <b>The effect type MUST have tag IEF_ONEQUIP</b> (yes, IEF_ONEQUIP)
	 * @param player
	 * @param item Item with this effect
	 * @param effect Actual effect
	 */
    public function onUnequip(player : Player, item : Equipable, effect : ItemEffect) : Void
    {
    }
    
    /**
	 * (ItemEffectType construction only!) Set this effect flags. A |-masked IEF_XXX constants
	 * @example
	 * new ItemEffectType("name", 80).withFlags(IEF_ATTACK | IEF_REQUIREMENT);
	 */
    public function withFlags(flags : Int) : ItemEffectType
    {
        this.flags = flags;
        return this;
    }
}


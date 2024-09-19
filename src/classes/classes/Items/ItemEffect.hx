package classes.items;

import classes.ItemType;
import classes.Player;

class ItemEffect
{
    public var priority(get, never) : Int;

    public var type : ItemEffectType;
    /**
	 * Effect strength
	 */
    public var power : Float;
    public var value1 : Dynamic;
    public var value2 : Dynamic;
    public var value3 : Dynamic;
    public var value4 : Dynamic;
    
    public function new(
            type : ItemEffectType,
            power : Float,
            value1 : Dynamic = null,
            value2 : Dynamic = null,
            value3 : Dynamic = null,
            value4 : Dynamic = null)
    {
        this.type = type;
        this.power = power;
        this.value1 = value1;
        this.value2 = value2;
        this.value3 = value3;
        this.value4 = value4;
    }
    
    /**
	 * Description priority, smaller = appears first in the list.
	 */
    private function get_priority() : Int
    {
        return type.priority;
    }
    
    /**
	 * Tooltip description. Empty string to hide.
	 * @param item Item (can be null)
	 * @return
	 */
    public function description(item : ItemType) : String
    {
        return type.description(this, item);
    }
    public function onEquip(player : Player, item : Equipable) : Void
    {
        type.onEquip(player, item, this);
    }
    public function onUnequip(player : Player, item : Equipable) : Void
    {
        type.onUnequip(player, item, this);
    }
}


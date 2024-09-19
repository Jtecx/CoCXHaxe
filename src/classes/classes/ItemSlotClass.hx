package classes;

import classes.internals.Utils;

class ItemSlotClass extends Dynamic
{
    public var quantity(get, set) : Float;
    public var itype(get, never) : ItemType;
    public var unlocked(get, set) : Bool;
    public var storageType(get, never) : Int;

    // storage types (for determining stack size)
    public static inline var STORAGE_NORMAL : Int = 0;
    public static inline var STORAGE_PEARL : Int = 1;
    
    //constructor
    public function new(storageType : Int = STORAGE_NORMAL)
    {
        super();
        _storageType = storageType;
    }
    
    //data
    private var _quantity : Float = 0;
    private var _itype : ItemType = ItemType.NOTHING;
    private var _unlocked : Bool = false;
    private var _storageType : Int = STORAGE_NORMAL;
    
    public function clone() : ItemSlotClass
    {
        var other : ItemSlotClass = new ItemSlotClass();
        other._quantity = _quantity;
        other._itype = _itype;
        other._unlocked = _unlocked;
        return other;
    }
    
    public function setItemAndQty(itype : ItemType, quant : Float) : Void
    {
        if (itype == null)
        {
            itype = ItemType.NOTHING;
        }
        if (quant == 0 && itype.isNothing)
        {
            emptySlot();
            return;
        }
        if (quant < 0 || quant == 0 && !itype.isNothing || quant > 0 && itype == ItemType.NOTHING)
        {
            CoC_Settings.error("Inconsistent setItemAndQty call: " + quant + " " + itype);
            quant = 0;
            itype = ItemType.NOTHING;
        }
        if (quant > defaultStackSize())
        {
            CoC_Settings.error("Setting item quantity greater than the slot's maximum stack size!");
        }
        this._quantity = quant;
        this._itype = itype;
    }
    
    
    public function emptySlot() : Void
    {
        this._quantity = 0;
        this._itype = ItemType.NOTHING;
    }
    
    public function removeOneItem() : Void
    {
        if (this._quantity == 0)
        {
            CoC_Settings.error("Tried to remove item from empty slot!");
        }
        if (this._quantity > 0)
        {
            this._quantity -= 1;
        }
        
        if (this._quantity == 0)
        {
            this._itype = ItemType.NOTHING;
        }
    }
    /**
		 * Remove at most `count` items.
		 * @param count
		 * @return number of actual items removed
		 */
    public function removeMany(count : Int) : Int
    {
        count = Utils.boundInt(0, count, _quantity);
        _quantity -= count;
        if (_quantity == 0)
        {
            _itype = ItemType.NOTHING;
        }
        return count;
    }
    
    private function get_quantity() : Float
    {
        return _quantity;
    }
    
    private function set_quantity(value : Float) : Float
    {
        if (value > 0 && _itype == null)
        {
            CoC_Settings.error("ItemSlotClass.quantity set with no item; use setItemAndQty instead!");
        }
        if (value < 0)
        {
            value = 0;
        }
        if (value == 0)
        {
            _itype = ItemType.NOTHING;
        }
        if (value > stackSize())
        {
            CoC_Settings.error("Setting item quantity greater than its stack size!");
        }
        _quantity = value;
        return value;
    }
    
    private function get_itype() : ItemType
    {
        return _itype;
    }
    
    private function get_unlocked() : Bool
    {
        return _unlocked;
    }
    
    private function set_unlocked(value : Bool) : Bool
    {
        if (_unlocked != value)
        {
            emptySlot();
        }
        _unlocked = value;
        return value;
    }
    
    public function isEmpty() : Bool
    {
        return _quantity <= 0;
    }
    
    private function get_storageType() : Int
    {
        return _storageType;
    }
    
    // returns the stack size for the current *item*. That means, 1 for dynamic.
    // See also: `defaultStackSize()
    public function stackSize() : Int
    {
        return (_itype.isNothing) ? defaultStackSize() : 
        (_storageType == STORAGE_PEARL) ? _itype.pearlStackSize : _itype.stackSize;
    }
    
    // returns the default stack size for the *storage*. Works for "nothing",
    public function defaultStackSize() : Int
    {
        return (_storageType == STORAGE_PEARL) ? ItemType.DEFAULT_PEARL_STACK_SIZE : ItemType.DEFAULT_STACK_SIZE;
    }
    
    // get available space
    public function roomLeft() : Int
    {
        return (_itype.isNothing) ? defaultStackSize() : stackSize() - _quantity;
    }
    
    public function hasRoom() : Bool
    {
        return roomLeft() > 0;
    }
}


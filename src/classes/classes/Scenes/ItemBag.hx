package classes.scenes;

import classes.BaseContent;
import classes.ItemType;

class ItemBag extends BaseContent
{
    public var Slots : Array<Dynamic> = [];
    public var SlotCaps : Array<Dynamic> = [];
    public var SlotCount : Int;
    public var itemTypes : Array<Dynamic>;
    private static var itemIdToSlotIndex : Dynamic = { };
    
    /**
	 * @param itemTypes Slot item types. Must be unique (except null/nothing)
	 * @param slotCount Number of slots, 0 = same as items in slotDefs
	 */
    public function new(itemTypes : Array<Dynamic>, slotCount : Int = 0)
    {
        super();
        this.itemTypes = itemTypes;
        this.SlotCount = Math.max(slotCount, itemTypes.length);
        for (i in 0...itemTypes.length)
        {
            var itype : ItemType = itemTypes[i];
            if (itype != null && !itype.isNothing)
            {
                Reflect.setField(itemIdToSlotIndex, Std.string(itype.id), i);
            }
        }
        for (i in itemTypes.length...SlotCount)
        {
            itemTypes[i] = ItemType.NOTHING;
        }
        resetState();
    }
    
    public function resetState() : Void
    {
        for (i in 0...SlotCount)
        {
            Slots[i] = 0;
            SlotCaps[i] = 0;
        }
    }
    
    
    /** item type stored in slot */
    public function slotType(slot : Int) : ItemType
    {
        if (slot < 0 || slot > itemTypes.length)
        {
            return ItemType.NOTHING;
        }
        return itemTypes[slot];
    }
    /** slot for item type, -1 if no item */
    public function slotForItem(itype : ItemType) : Int
    {
        if (Lambda.has(itemIdToSlotIndex, itype.id))
        {
            return Reflect.field(itemIdToSlotIndex, Std.string(itype.id));
        }
        return -1;
    }
    /** current number of items of that type stored in loot bag */
    public function itemCount(itype : ItemType) : Int
    {
        var slot : Int = slotForItem(itype);
        if (slot < 0)
        {
            return 0;
        }
        return Slots[slot];
    }
    /** current slot cap for item type, 0 if no such item */
    public function itemCap(itype : ItemType) : Int
    {
        var slot : Int = slotForItem(itype);
        if (slot < 0)
        {
            return 0;
        }
        return SlotCaps[slot];
    }
    public function setItemCap(itype : ItemType, cap : Int) : Bool
    {
        var slot : Int = slotForItem(itype);
        if (slot < 0)
        {
            return false;
        }
        SlotCaps[slot] = cap;
        return true;
    }
    /** try to remove items from loot bag, return number of remvoed items (0 if no such item) */
    public function removeItem(itype : ItemType, n : Int) : Int
    {
        if (n <= 0)
        {
            return 0;
        }
        var slot : Int = slotForItem(itype);
        if (slot < 0)
        {
            return 0;
        }
        n = Math.min(Slots[slot], n);
        Slots[slot] -= n;
        return n;
    }
    /** try to add items to loot bag, return number of items added (0 if no such item or no place) */
    public function addItem(itype : ItemType, n : Int) : Int
    {
        if (n <= 0)
        {
            return 0;
        }
        var slot : Int = slotForItem(itype);
        if (slot < 0)
        {
            return 0;
        }
        n = boundInt(0, n, SlotCaps[slot] - Slots[slot]);
        Slots[slot] += n;
        return n;
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            Slots : Slots.copy(),
            SlotCaps : SlotCaps.copy()
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            if (Lambda.has(o, "Slots"))
            
            // new version{
                
                Slots = Reflect.field(o, "Slots").slice();
                SlotCaps = Reflect.field(o, "SlotCaps").slice();
                while (Slots.length < SlotCount)
                {
                    Slots.push(0);
                }
                while (SlotCaps.length < SlotCount)
                {
                    SlotCaps.push(0);
                }
            }
            else if (Lambda.has(o, "Slot01"))
            
            // old version: "Slot01".."Slot30", "Slot01Cap".."Slot30Cap"{
                
                for (i in 0...SlotCount)
                {
                    var s : String = padStart(Std.string(i + 1), 2, "0");
                    Slots[i] = numberOr(Reflect.field(o, Std.string("Slot" + s)), 0);
                    SlotCaps[i] = numberOr(Reflect.field(o, Std.string("Slot" + s + "Cap")), 0);
                }
            }
            else
            {
                resetState();
            }
        }
        // loading from old save
        else
        {
            
            resetState();
        }
    }
}


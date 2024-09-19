package classes.items;

import classes.ItemTemplate;
import classes.ItemType;

class SimpleItemTemplate extends ItemTemplate
{
    private var itemClass : Class<Dynamic>;
    
    /**
	 * @param itemClass constructor should be (id:String, params:Object)
	 */
    public function new(templateId : String, name : String, itemClass : Class<Dynamic>, metadata : Dynamic)
    {
        super(templateId, name, metadata || { });
        this.itemClass = itemClass;
    }
    
    override public function createItem(parameters : Dynamic) : ItemType
    {
        var itemId : String = ItemType.dynamicItemId(templateId, parameters);
        var item : ItemType = ItemType.lookupCachedItem(itemId);
        if (item != null)
        {
            return item;
        }
        return try cast(Type.createInstance(itemClass, [itemId, parameters]), ItemType) catch(e:Dynamic) null;
    }
}


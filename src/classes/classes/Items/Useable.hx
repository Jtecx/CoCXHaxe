/**
 * Created by aimozg on 09.01.14.
 */
package classes.items;

import classes.CoCSettings;
import classes.scenes.SceneLib;

/**
	 * Represent item that can be used but does not necessarily disappears on use. Direct subclasses should overrride
	 * "useItem" method.
	 */
class Useable extends CommonItem
{
    
    override private function get_category() : String
    {
        return CATEGORY_USABLE;
    }
    
    public function new(id : String, shortName : String = null, longName : String = null, value : Float = 0, description : String = null)
    {
        super(id, shortName, longName, value, description);
    }
    
    override private function get_description() : String
    {
        var desc : String = _description;
        //Type
        desc += "\n\nType: ";
        if (shortName == "Condom" || shortName == "GldStat")
        {
            desc += "Miscellaneous";
        }
        else if (shortName == "Debug Wand")
        {
            desc += "Miscellaneous (Cheat Item)";
        }
        else
        {
            desc += "Material";
        }
        //Value
        desc += "\nBase value: " + Std.string(value);
        return desc;
    }
    
    public function canUse() : Bool
    {
        return true;
    }  //If an item cannot be used it should provide some description of why not  
    
    public function useItem() : Bool
    {
        CoC_Settings.errorAMC("Useable", "useItem", id);
        return false;
    }
    
    public function useText() : Void
    {
    }  //Produces any text seen when using or equipping the item normally  
}


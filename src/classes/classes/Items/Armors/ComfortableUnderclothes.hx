/**
 * Created by aimozg on 10.01.14.
 */
package classes.items.armors;

import classes.ItemType;
import classes.items.Armor;
import classes.items.ArmorLib;
import classes.Player;

@:final class ComfortableUnderclothes extends Armor
{
    
    public function new()
    {
        super("c.under", "c.under", "comfortable underclothes", "comfortable underclothes", 0, 0, 1, "comfortable underclothes", "Light");
    }
    
    override public function beforeUnequip(doOutput : Bool, slot : Int) : ItemType
    {
        return ArmorLib.NOTHING;
    }
}


/**
 * Created by aimozg on 18.01.14.
 */
package classes.items.armors;

import classes.ItemType;
import classes.items.Armor;
import classes.Player;

class LeatherArmorSegments extends Armor
{
    
    public function new()
    {
        super("UrtaLta", "UrtaLta", "leather armor segments", "leather armor segments", 18, 2, 500, null, "Light", true);
    }
    
    override public function unequipText(slot : Int) : Void
    {
        outputText("You have your old set of " + game.armors.LEATHRA.longName + " left over.  ");
    }
    
    override public function beforeUnequip(doOutput : Bool, slot : Int) : ItemType
    {
        super.beforeUnequip(doOutput, slot);
        return game.armors.LEATHRA;
    }
}


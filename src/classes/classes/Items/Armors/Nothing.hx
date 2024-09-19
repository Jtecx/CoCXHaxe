package classes.items.armors;

import classes.ItemType;
import classes.items.Armor;
import classes.Player;

@:final class Nothing extends Armor
{
    
    public function new()
    {
        super("nothing", "nothing", "nothing", "nothing", 0, 0, 0, "nothing", "Light");
        withTag(A_REVEALING);
        withTag(A_AGILE);
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}



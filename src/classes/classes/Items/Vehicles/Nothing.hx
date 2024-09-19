package classes.items.vehicles;

import classes.ItemType;
import classes.items.Vehicles;
import classes.Player;

class Nothing extends Vehicles
{
    
    public function new()
    {
        super("novehicle", "novehicle", "nothing", "nothing", 0, 0, 0, "no vehicle", "vehicle");
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}


package classes.items.shields;

import classes.items.Shield;

class Nothing extends Shield
{
    public function new()
    {
        super("noshild", "noshield", "nothing", "nothing", 0, 0, "no shield", "shield");
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}


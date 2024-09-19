package classes.items.headJewelries;

import classes.items.HeadJewelry;

class Nothing extends HeadJewelry
{
    public function new()
    {
        super("noheadjewel", "noheadjewel", "nothing", "nothing", 0, 0, 0, "no jewelry", "headacc");
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}


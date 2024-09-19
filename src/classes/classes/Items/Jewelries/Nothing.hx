package classes.items.jewelries;

import classes.items.Jewelry;

class Nothing extends Jewelry
{
    public function new()
    {
        super("nojewel", "nojewel", "nothing", "nothing", 0, 0, 0, "no jewelry");
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}


package classes.items.necklaces;

import classes.items.Necklace;

class Nothing extends Necklace
{
    public function new()
    {
        super("noneckjewel", "noneckjewel", "nothing", "nothing", 0, 0, 0, "no jewelry", "necklace");
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}


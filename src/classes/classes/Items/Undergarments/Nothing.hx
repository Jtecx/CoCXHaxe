package classes.items.undergarments;

import classes.items.Undergarment;

class Nothing extends Undergarment
{
    public function new()
    {
        super("nounder", "nounder", "nothing", "nothing", UT_ANY, 0, 0, 0, 0, "nothing", "light");
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}


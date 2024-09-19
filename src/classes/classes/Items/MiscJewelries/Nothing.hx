/**
 * ...
 * @author Ormael
 */
package classes.items.miscJewelries;

import classes.items.MiscJewelry;

class Nothing extends MiscJewelry
{
    
    public function new()
    {
        super("nomiscjewel", "nomiscjewel", "nothing", "nothing", 0, 0, 0, 0, "no jewelry", "miscacc");
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}


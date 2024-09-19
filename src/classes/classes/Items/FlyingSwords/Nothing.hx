/**
 * ...
 * @author Ormael
 */
package classes.items.flyingSwords;

import classes.items.FlyingSwords;

class Nothing extends FlyingSwords
{
    
    public function new()
    {
        super("noflysword", "noflysword", "nothing", "no flying sword \nAttack: 0", "nothing", 0);
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}


/**
 * ...
 * @author Ormael
 */
package classes.items.weaponsRange;

import classes.ItemType;
import classes.items.WeaponRange;
import classes.Player;

class Nothing extends WeaponRange
{
    public function new()
    {
        super("norange", "norange", "nothing", "no range weapon \nAttack: 0", "nothing", 0);
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}


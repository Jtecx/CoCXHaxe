/**
 * ...
 * @author ...
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;

class HookedGauntlets extends Weapon
{
    
    public function new()
    {
        super("H.Gaunt", "H.Gaunt", "hooked gauntlets", "a set of hooked gauntlets", "clawing punch", 0, 400, 
                "These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm.", 
                WT_GAUNTLET, WSZ_MEDIUM
        );
        withEffect(IELib.Bleed, 25);
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
}

/**
 * ...
 * @author Ormael
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;

class GauntletWithClaws extends Weapon
{
    
    public function new()
    {
        super("Claws", "Claws", "gauntlet with claws", "a gauntlet with claws", "rend", 0, 100, 
                "Those metal gauntlets have tips of the fingers shaped like sharp natural claws.  Though they lacks the damaging potential of other weapons, they have a chance to leave bleeding wounds.", 
                WT_GAUNTLET, WSZ_SMALL
        );
        withEffect(IELib.Bleed, 10);
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
}

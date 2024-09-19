/**
 * ...
 * @author ...
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;

class SpikedGauntlet extends Weapon
{
    
    public function new()
    {
        super("S.Gaunt", "S.Gauntlet", "spiked gauntlet", "a spiked gauntlet", "spiked punch", 0, 200, 
                "Those metal gauntlets has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent.", 
                WT_GAUNTLET, WSZ_MEDIUM
        );
        withEffect(IELib.Stun, 10);
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
}

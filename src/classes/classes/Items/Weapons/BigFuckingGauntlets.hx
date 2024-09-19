/**
 * ...
 * @author Ormael
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;

class BigFuckingGauntlets extends Weapon
{
    
    public function new()
    {
        super("BFGaunt", "B.F.Gauntlets", "big fucking gauntlets", "a big fucking gauntlets", "smash", 0, 1600, 
                "Big Fucking Gauntlets - the best solution for a tiny e-pen complex at this side of the Mareth!  This huge gauntlets signed by mysterious 'Vi' requires 150 strength to fully unleash it power.\nIncreases unarmed damage by 2x.\nIncreases stun chance by 40.", WT_GAUNTLET, WSZ_LARGE
        );
        withEffect(IELib.Stun, 40);
        withTags(W_LGWRATH);
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
}

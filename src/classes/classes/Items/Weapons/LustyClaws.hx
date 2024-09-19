/**
 * ...
 * @author Ormael
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;

class LustyClaws extends Weapon
{
    
    public function new()
    {
        super("L.Claws", "LustyClaws", "gauntlet with an aphrodisiac-coated claws", "a gauntlet with an aphrodisiac-coated claws", "rend", 0, 200, 
                "Those metal gauntlets have tips of the fingers shaped like natural claws.  They seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.", 
                WT_GAUNTLET, WSZ_MEDIUM
        );
        withEffect(IELib.Bleed, 10);
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
}

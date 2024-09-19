/**
 * ...
 * @author Ormael
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;

class MoonlightClaws extends Weapon
{
    
    public function new()
    {
        super("MClaws", "MoonlightClaws", "moonlight claws", "a pair of moonlight claws", "clawing punch", 25, 4000, 
                "This pair of claws is imbued with magic, which shall be unleashed as a wave of moonlight. The magic within this will grant greated boon when charged with magic.", 
                WT_GAUNTLET, WSZ_MEDIUM
        );
        withEffect(IELib.Bleed, 25);
        withEffect(IELib.ScaleAttack_Str, 50);
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
}

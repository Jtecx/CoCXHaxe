/**
 * ...
 * @author Liadri
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;

class MasterGloves extends Weapon
{
    
    public function new()
    {
        super("MastGlo", "MasterGloves", "Master Gloves", "a Master Gloves", "punch", 0, 400, 
                "These gloves belonged to Chi Chi. They seem to naturally strengthen the soulforce techniques of the user.", 
                WT_GAUNTLET, WSZ_MEDIUM
        );
        withBuffs({
                    psoulskillpower : +0.4
                });
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
}

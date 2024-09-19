/**
 * ...
 * @author Liadri
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;

class YamaRajaGrasp extends Weapon
{
    
    public function new()
    {
        super("YamaRG", "YamaRajaGrasp", "Yama-Raja gloves", "a pair of Yama-Raja gloves", "punch", 0, 1600, "These black gloves are made in black leather and an ebony alloy. Their corrupt touch seeks to destroy the pure and innocent. As such, it will seek the weak points of its victims when striking.", WT_GAUNTLET, WSZ_MEDIUM);
        withBuffs({
                    psoulskillpower : +1.5
                });
        withTags(I_LEGENDARY, W_CORRUPT_TYPE);
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
}

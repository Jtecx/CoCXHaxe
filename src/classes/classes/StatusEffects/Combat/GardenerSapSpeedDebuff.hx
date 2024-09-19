/**
 * Coded by aimozg on 01.09.2017.
 */
package classes.statusEffects.combat;

import classes.StatusEffectType;

class GardenerSapSpeedDebuff extends CombatBuff
{
    public static var TYPE : StatusEffectType = register("Sap Speed", GardenerSapSpeedDebuff);
    public function new()
    {
        super(TYPE, "spe");
    }
    
    public function increase() : Void
    {
        buffHost("spe", -host.spe * 0.2);
    }
}



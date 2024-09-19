/**
 * Coded by aimozg on 01.09.2017.
 */
package classes.statusEffects.combat;

import classes.StatusEffectType;

class LizanBlowpipeDebuff extends CombatBuff
{
    public static var TYPE : StatusEffectType = register("Lizan Blowpipe", LizanBlowpipeDebuff);
    public function new()
    {
        super(TYPE, "str", "tou", "spe", "sen");
    }
    public function debuffStrSpe() : Void
    {
        var power : Float = 20;
        // don't want to have corruptionTolerance in Creature in favour of future (?) corruptAtLeast/corruptAtMost
        if (host.cor > 50 + ((playerHost) ? playerHost.corruptionTolerance : 0))
        {
            power = 40;
        }
        buffHost("str", -power, "spe", -power);
    }
    public function debuffTouSens() : Void
    {
        var power : Float = 20;
        if (host.cor > 50 + ((playerHost) ? playerHost.corruptionTolerance : 0))
        {
            power = 40;
        }
        buffHost("tou", -power, "sens", power);
    }
}



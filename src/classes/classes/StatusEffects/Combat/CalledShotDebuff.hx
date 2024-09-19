package classes.statusEffects.combat;

import classes.StatusEffectType;
import classes.statusEffects.CombatStatusEffect;

class CalledShotDebuff extends CombatBuff
{
    
    public static var TYPE : StatusEffectType = register("Called Shot", CalledShotDebuff);
    public function new()
    {
        super(TYPE, "spe");
    }
    
    public function increase() : Void
    {
        buffHost("spe", -20 - rand(5));
    }
}


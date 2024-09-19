/**
 * Created by aimozg on 31.01.14.
 */
package classes.statusEffects;

import classes.StatusEffectClass;
import classes.StatusEffectType;

class CombatStatusEffect extends StatusEffectClass
{
    
    public function new(stype : StatusEffectType)
    {
        super(stype);
    }
    
    override public function onCombatEnd() : Void
    {
        remove();
    }
}


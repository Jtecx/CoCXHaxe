package classes.statusEffects.combat;

import classes.StatusEffectType;
import classes.statusEffects.TemporaryBuff;

class CombatBuff extends TemporaryBuff
{
    public function new(stype : StatusEffectType, stat1 : String, stat2 : String = "", stat3 : String = "", stat4 : String = "")
    {
        super(stype, stat1, stat2, stat3, stat4);
    }
    
    override public function onCombatEnd() : Void
    {
        super.onCombatEnd();
        remove();
    }
}


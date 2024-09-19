package classes.statusEffects.combat;

import classes.StatusEffectType;

class AnemoneVenomDebuff extends CombatBuff
{
    public static var TYPE : StatusEffectType = register("Anemone Venom", AnemoneVenomDebuff);
    public function new()
    {
        super(TYPE, "str", "spe");
    }
    
    public function applyEffect(amt : Float) : Void
    {
        host.takeLustDamage(2 * amt, true);
        var debuff : Dynamic = buffHost("str", -amt, "spe", -amt);
        //Str bottommed out, convert to lust
        if (debuff.str == 0)
        {
            host.takeLustDamage(amt, true);
        }
        //Spe bottommed out, convert to lust
        if (debuff.spe == 0)
        {
            host.takeLustDamage(amt, true);
        }
    }
}



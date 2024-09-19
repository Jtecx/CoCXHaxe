package classes.statusEffects;

import classes.StatusEffectClass;
import classes.StatusEffectType;

class RutEffect extends StatusEffectClass
{
    public static var TYPE : StatusEffectType = register("rut", RutEffect);
    public function new()
    {
        super(TYPE);
    }
    
    override public function onAttach() : Void
    {
        ApplyEffect();
    }
    
    public function ApplyEffect() : Void
    {
        host.buff("Rut").setStats({
                            lib.mult : value2,
                            sens : value2 * 100 / 2
                        }).withText("Rut");
    }
    
    override public function onRemove() : Void
    {
        host.buff("Rut").remove();
    }
}




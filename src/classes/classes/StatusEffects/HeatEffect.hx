package classes.statusEffects;

import classes.StatusEffectClass;
import classes.StatusEffectType;

class HeatEffect extends StatusEffectClass
{
    public static var TYPE : StatusEffectType = register("heat", HeatEffect);
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
        host.buff("Heat").setStats({
                            lib.mult : value2,
                            sens : value2 * 100 / 2
                        }).withText("Heat");
    }
    
    override public function onRemove() : Void
    {
        host.buff("Heat").remove();
    }
}



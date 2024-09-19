package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;
import classes.scenes.SceneLib;

class ScarredBlade extends Weapon
{
    
    public function new()
    {
        super("ScarBld", "ScarBlade", "scarred blade", "a scarred blade", "slash", 10, 800, "This saber, made from lethicite-imbued metal, eagerly seeks flesh; it resonates with disdain and delivers deep, jagged wounds as it tries to bury itself in the bodies of others. It only cooperates with the corrupt.", WT_SWORD, WSZ_MEDIUM);
        withEffect(IELib.Require_Cor, 66);
        withEffect(IELib.AttackBonus_Cor, 1 / 3);
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.cor >= (66 - game.player.corruptionTolerance))
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            SceneLib.sheilaScene.rebellingScarredBlade(true);
        }
        return false;
    }
}


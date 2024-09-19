/**
 * ...
 * @author Canadian Snas
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;
import classes.Player;
import classes.PerkLib;
import classes.StatusEffects;

class ThePhalluspears extends Weapon
{
    
    public function new()
    {
        super("D.Phallus", "Phalluspears", "The Phalluspears", "The Phalluspears", "piercing stab", 40, 2600, 
                "Those spears are a polearms with a dick-shaped point. You can rotate the shaft to reveal or conceal a wicked, poison-dripping blade hidden within the phalluses. Pleasure or pain, this weapon can do both.", 
                WT_SPEAR, WSZ_LARGE, true
        );
        withEffect(IELib.ScaleAttack_Spe, 200);
    }
    
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        game.player.createStatusEffect(StatusEffects.ThePhalluspear1, 0, 0, 0, 0);
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        while (game.player.hasStatusEffect(StatusEffects.ThePhalluspear1))
        {
            game.player.removeStatusEffect(StatusEffects.ThePhalluspear1);
        }
        super.afterUnequip(doOutput, slot);
    }
}


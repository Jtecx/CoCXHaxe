/**
 * ...
 * @author Ormael
 */
package classes.items.weaponsRange;

import classes.items.WeaponRange;
import classes.PerkLib;
import classes.Player;

class TwinSixShooter extends WeaponRange
{
    
    public function new()
    {
        super("TwinSixS", "TwinSixShooter", "Twin Six shooter", "a Twin Six shooter", "shot", 20, 1160, "A two revolvers with six chambers. Their shots are deadly and precise.", "Dual Firearms");
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity))
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            outputText("You aren't skilled enough to handle this pair of firearms! (req. Dual Wield/Anty-Dexternity)  ");
        }
        return false;
    }
}


/**
 * ...
 * @author Liadri
 */
package classes.items.weaponsRange;

import classes.items.WeaponRange;
import classes.PerkLib;
import classes.Player;

class TwinGrakaturd extends WeaponRange
{
    
    public function new()
    {
        super("TwinGra", "TwinGrakaturd", "Twin Grakaturd", "a Twin Grakaturd", "shot", 25, 860, "A pair of weapon favored by gunners who like to charge in gun blazing and think after.\n\nGoblin Mech Compatibile", "Dual Firearms");
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


/**
 * ...
 * @author Ormael
 */
package classes.items.weaponsRange;

import classes.items.WeaponRange;
import classes.PerkLib;
import classes.Player;

class TwinDesertEagles extends WeaponRange
{
    
    public function new()
    {
        super("TDeEagl", "TDesertEagles", "Twin Desert Eagles", "a Twin Desert Eagles", "shot", 25, 1240, "A twin hand firearms, the desert eagles has the largest bullets out of the pistol family. Their shots are deadly and precises through the guns has one hell of a recoil.\n\nGoblin Mech Compatibile", "Dual Firearms");
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


/**
 * ...
 * @author Lord Shadeogorath
 */
package classes.items.weaponsRange;

import classes.items.WeaponRange;
import classes.PerkLib;
import classes.Player;

class DuAlakablam extends WeaponRange
{
    
    public function new()
    {
        super("D.Alakabl", "DuAlakablam", "DuAlakablam", "a DuAlakablam", "shot", 20, 1520, "This is a two double barrel shotguns. Not the most accurate weapons but each slug deal magical damege.", "Dual 2H Firearms");
        withBuffs({
                    rangedaccuracy : -40
                });
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if ((game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity))) || (game.player.hasPerk(PerkLib.GigantGrip) && game.player.hasPerk(PerkLib.AntyDexterity)))
        {
            return super.canEquip(doOutput, slot);
        }
        if (!game.player.hasPerk(PerkLib.GigantGrip) && !game.player.hasPerk(PerkLib.AntyDexterity))
        {
            if (doOutput)
            {
                outputText("You aren't skilled enough to handle this pair of firearms!  ");
            }
            return false;
        }
        if (doOutput)
        {
            outputText("You aren't skilled in handling large firearms with one hand yet to effectively use those rifles. Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
        }
        return false;
    }
}


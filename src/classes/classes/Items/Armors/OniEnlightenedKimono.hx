/**
 * @author Liadri
 */
package classes.items.armors;

import classes.CoC;
import classes.items.Armor;
import classes.PerkLib;
import classes.Player;

class OniEnlightenedKimono extends Armor
{
    
    public function new()
    {
        super("OE Kimo", "OniEnlightenedKimono", "Oni Noble kimono", "a oni noble kimono", 30, 50, 27000, "This deceptively sturdy kimono belonged to a beloved shogun amonst oni nobility. Despite their natural predisposition for domination over smaller races, some oni lords decides to rule as benevolent rulers rather then slavemasters. These benevolent oni lords more often then not are in search of the so called drunken enlightment.", "Light");
        withTag(A_AGILE);
        withPerk(PerkLib.OniEnlightenedKimono, 0, 0, 0, 0);
        withTag(I_LEGENDARY);
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.tallness >= 80)
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            outputText("You aren't tall enough to wear this kimono!  ");
        }
        return false;
    }
    override private function get_def() : Float
    {
        var mod : Int = as3hx.Compat.parseInt((100 - game.player.cor) / 10);
        return 20 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = as3hx.Compat.parseInt((100 - game.player.cor) / 5);
        return 30 + mod;
    }
}


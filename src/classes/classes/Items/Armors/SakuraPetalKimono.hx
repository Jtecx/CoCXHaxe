/**
 * @author Liadri
 */
package classes.items.armors;

import classes.CoC;
import classes.items.Armor;
import classes.Player;

class SakuraPetalKimono extends Armor
{
    
    public function new()
    {
        super("SP Kimo", "SakuraPetalKimono", "sakura petal kimono", "a sakura petal kimono", 0, 1, 160, "This kimono belonged to Izumi. One of the many dresses she brought from her homeland it is comfortable and fills you with a sense of contained primal strength.", "Light");
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
}


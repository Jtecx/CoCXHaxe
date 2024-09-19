/**
 * ...
 * @author ...
 */
package classes.items.shields;

import classes.globalFlags.KFLAGS;
import classes.CoC;
import classes.items.Shield;
import classes.Player;

class GreatShield extends Shield
{
    
    public function new()
    {
        super("GreatSh", "GreatShld", "greatshield", "a greatshield", 18, 900, "A large metal shield. \nReq 40 strength to fully use it potential.", "Large");
    }
    
    override private function get_block() : Float
    {
        var block : Int = 0;
        if (game.player.str >= 40)
        {
            block += 8;
        }
        if (game.player.str >= 20)
        {
            block += 6;
        }
        return (4 + block);
    }
}

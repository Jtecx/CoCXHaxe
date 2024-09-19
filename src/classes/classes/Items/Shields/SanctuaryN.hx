/**
 * ...
 * @author Liadri
 */
package classes.items.shields;

import classes.items.Shield;
import classes.PerkLib;

class SanctuaryN extends Shield
{
    
    public function new()
    {
        super("SanctN", "SanctuaryN", "Sanctuary shield (N)", "a Sanctuary shield (N)", 21, 1050, "The legendary shield sanctuary. Its power is currently dormant and would require a powerful source of magic to fully unlock.", 
                "Large"
        );
        withPerk(PerkLib.Sanctuary, 0, 0, 0, 0);
    }
    
    override private function get_block() : Float
    {
        var block : Int = 0;
        if (game.player.str >= 40)
        {
            block += 10;
        }
        if (game.player.str >= 20)
        {
            block += 7;
        }
        return (4 + block);
    }
}

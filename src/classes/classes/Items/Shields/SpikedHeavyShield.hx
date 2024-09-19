/**
 * ...
 * @author Ormael
 */
package classes.items.shields;

import classes.items.Shield;

class SpikedHeavyShield extends Shield
{
    
    public function new()
    {
        super("SpiH Sh", "SpikeHShield", "spiked heavy shield", "a spiked heavy shield", 24, 1800, "A large shield with spikes. \nReq 60 strength to fully use it potential.", "Large");
    }
    
    override private function get_block() : Float
    {
        var block : Int = 0;
        if (game.player.str >= 60)
        {
            block += 9;
        }
        if (game.player.str >= 40)
        {
            block += 7;
        }
        if (game.player.str >= 20)
        {
            block += 5;
        }
        return (3 + block);
    }
}

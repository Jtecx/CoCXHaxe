/**
 * ...
 * @author Ormael
 */
package classes.items.shields;

import classes.items.Shield;

class SpikedMassiveShield extends Shield
{
    
    public function new()
    {
        super("SpiM Sh", "SpikeMShield", "spiked massive shield", "a spiked massive shield", 56, 4200, "A massive shield with menacing spikes. \nReq 125 strength to fully use it potential.", "Massive");
    }
    
    override private function get_block() : Float
    {
        var block : Int = 0;
        if (game.player.str >= 125)
        {
            block += 21;
        }
        if (game.player.str >= 100)
        {
            block += 15;
        }
        if (game.player.str >= 75)
        {
            block += 10;
        }
        if (game.player.str >= 50)
        {
            block += 6;
        }
        if (game.player.str >= 25)
        {
            block += 3;
        }
        return (1 + block);
    }
}

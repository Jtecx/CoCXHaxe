package classes.items.shields;

import classes.items.Shield;

class TowerShield extends Shield
{
    
    public function new()
    {
        super("TowerSh", "TowerShld", "tower shield", "a tower shield", 36, 1800, "A towering metal shield.  It looks heavy! \nReq 100 strength to fully use it potential.", "Massive");
    }
    
    override private function get_block() : Float
    {
        var block : Int = 0;
        if (game.player.str >= 100)
        {
            block += 16;
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

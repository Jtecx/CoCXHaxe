/**
 * ...
 * @author Liadri
 */
package classes.items.shields;

import classes.items.Shield;
import classes.PerkLib;

class DarkAegis extends Shield
{
    
    public function new()
    {
        super("SanctD", "Dark Aegis", "dark aegis", "a dark aegis", 55, 5500, 
                "Gleaming in black metal and obsidian plates, this legendary shield is said to heal and protect a fallen knight. Demonic ornaments cover most of its obsidian-carved surface.", 
                "Large"
        );
        withPerk(PerkLib.Sanctuary, 2, 0, 0, 0);
        withTag(I_LEGENDARY);
    }
    
    override private function get_block() : Float
    {
        var block : Int = 0;
        var scal : Float = 10;
        if (game.player.str >= 125)
        {
            block += 10;
            scal -= 1;
        }
        if (game.player.str >= 100)
        {
            block += 10;
            scal -= 1;
        }
        if (game.player.str >= 75)
        {
            block += 5;
            scal -= 1;
        }
        if (game.player.str >= 50)
        {
            block += 5;
            scal -= 1;
        }
        if (game.player.str >= 25)
        {
            block += 3;
            scal -= 1;
        }
        block += Math.round(game.player.cor / scal);
        return (2 + block);
    }
}


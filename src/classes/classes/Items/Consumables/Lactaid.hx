package classes.items.consumables;

import classes.items.Consumable;
import classes.items.ConsumableLib;

/**
	 * Item that boosts lactation.
	 */
class Lactaid extends Consumable
{
    public function new()
    {
        super("Lactaid", "Lactaid", "a pink bottle labelled \"Lactaid\"", ConsumableLib.DEFAULT_VALUE, "Judging by the name printed on this bottle, 'Lactaid' probably has an effect on the ability to lactate, and you doubt that effect is a reduction.");
    }
    
    override public function useItem() : Bool
    {
        clearOutput();
        player.slimeFeed();
        var i : Float = 0;
        outputText("You gulp down the bottle of lactaid, easily swallowing the creamy liquid.");
        //Bump up size!
        if (player.averageBreastSize() < 8)
        {
            outputText("\n\n");
            if (player.breastRows.length == 1)
            {
                player.growTits(1 + rand(5), 1, true, 1);
            }
            else
            {
                player.growTits(1 + rand(2), player.breastRows.length, true, 1);
            }
        }
        //Player doesn't lactate
        if (player.biggestLactation() < 1)
        {
            game.transformations.StartLactation.applyEffect();
        }
        //Boost lactation
        else
        {
            outputText("\n\n");
            outputText("Milk leaks from your [nipple]s in thick streams.  You're lactating even more!");
            for (i in 0...player.breastRows.length)
            {
                player.breastRows[i].lactationMultiplier += 1 + rand(10) / 10;
            }
        }
        dynStats("lus", 10, "scale", false);
        if (rand(3) == 0)
        {
            outputText(player.modFem(95, 1));
        }
        
        return false;
    }
}

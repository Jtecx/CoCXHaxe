package classes.items.consumables;

import classes.items.Consumable;
import classes.items.ConsumableLib;

/**
	 * Raw mint.
	 */
class Mint extends Consumable
{
    public function new()
    {
        super("C. Mint", "C. Mint", "a calm mint", ConsumableLib.DEFAULT_VALUE, "This is a sprig of silver-colored mint.  Its strong scent makes you feel calmer and less lustful.");
    }
    
    override public function useItem() : Bool
    {
        clearOutput();
        outputText("Eating the sprig of raw mint is a bit of a stretch, but you manage to gulp it down.  As the strong minty flavor overwhelms your taste buds, your mind feels calmer, and a relaxed sensation spreads through your body.");
        dynStats("lib", -1, "lust", -10, "inte", 0.5, "scale", false);
        player.refillHunger(5);
        
        return false;
    }
}

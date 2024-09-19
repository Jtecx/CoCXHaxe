package classes.items.consumables;

import classes.EngineCore;
import classes.items.Consumable;

/**
	 * Item that increases VIT
	 */
class VitalityTincture extends Consumable
{
    private static inline var ITEM_VALUE : Int = 15;
    
    public function new()
    {
        super("Vital T", "Vitality T.", "a vitality tincture", ITEM_VALUE, "This potent tea is supposedly good for the strengthening the body.");
    }
    
    override public function useItem() : Bool
    {
        player.slimeFeed();
        clearOutput();
        player.slimeFeed();
        outputText("You down the contents of the bottle. The liquid is thick and tastes remarkably like cherries. Within moments, you feel much more healthy.");
        player.alchemyBonus("tou", 1 + rand(2));
        if (EngineCore.HPChange(50 * player.postConsumptionMlt(), false))
        {
            outputText("  Any aches, pains and bruises you have suffered no longer hurt and you feel much better.");
        }
        player.refillHunger(10);
        
        return false;
    }
}

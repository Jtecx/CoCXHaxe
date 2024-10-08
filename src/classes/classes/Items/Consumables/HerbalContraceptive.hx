package classes.items.consumables;

import classes.items.Consumable;
import classes.items.ConsumableLib;
import classes.StatusEffects;

class HerbalContraceptive extends Consumable
{
    public function new()
    {
        super("HrblCnt", "HrblCnt", "a bundle of verdant green leaves", ConsumableLib.DEFAULT_VALUE, "A small bundle of verdant green leaves.");
    }
    
    override public function useItem() : Bool
    {
        clearOutput();
        
        // Placeholder, sue me
        outputText("You chew on the frankly awfully bitter leaves as quickly as possible before swallowing them down.");
        
        player.createStatusEffect(StatusEffects.Contraceptives, 1, 48, 0, 0);
        
        return false;
    }
}

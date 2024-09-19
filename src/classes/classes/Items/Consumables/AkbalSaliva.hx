package classes.items.consumables;

import classes.EngineCore;
import classes.items.Consumable;
import classes.items.ConsumableLib;

class AkbalSaliva extends Consumable
{
    public function new()
    {
        super("AkbalSl", "AkbalSlv", "a vial of Akbal's saliva", ConsumableLib.DEFAULT_VALUE, "This corked vial of Akbal's saliva is said to contain healing properties. ");
    }
    
    override public function useItem() : Bool
    {
        outputText("You uncork the vial and chug down the saliva.  ");
        EngineCore.HPChange(player.maxHP() / 4, true);
        player.refillHunger(5);
        
        return false;
    }
}

/**
 * Created by aimozg on 10.01.14.
 */
package classes.items.consumables;

import haxe.Constraints.Function;
import classes.items.Consumable;

class SimpleConsumable extends Consumable
{
    private var effect : Function;
    
    /**
		 * @param effect Function(player:Player)
		 */
    public function new(id : String, shortName : String, longName : String, effect : Function, value : Float = 0, description : String = null)
    {
        super(id, shortName, longName, value, description);
        this.effect = effect;
    }
    
    override public function useItem() : Bool
    {
        clearOutput();
        effect(game.player);
        return false;
    }
}


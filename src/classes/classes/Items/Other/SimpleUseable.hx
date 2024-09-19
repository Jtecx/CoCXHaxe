package classes.items.other;

import haxe.Constraints.Function;
import classes.items.Useable;
import classes.Player;

class SimpleUseable extends Useable
{
    //This class should be used for items which the player cannot consume, wear or use directly.
    //The useFunction or useText should describe the item or give a hint as to its purpose. After attempted use SimpleUseables return to the inventory automatically.
    private var canUseFunction : Function;
    private var canUseText : String;
    
    public function new(id : String, shortName : String, longName : String, value : Float, description : String, useText : String, useFunction : Function = null)
    {
        super(id, shortName, longName, value, description);
        canUseFunction = useFunction;
        canUseText = useText;
    }
    
    override public function canUse() : Bool
    {
        clearOutput();
        if (canUseFunction != null)
        {
            canUseFunction();
        }
        else
        {
            outputText(canUseText);
        }
        return false;
    }
}

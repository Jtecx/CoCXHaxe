/**
 * Created by aimozg on 09.01.14.
 */
package classes.items;

import classes.EngineCore;
import classes.CoC;
import classes.ItemType;
import classes.Player;

class CommonItem extends ItemType
{
    public var game(get, never) : CoC;

    
    private function get_game() : CoC
    {
        return CoC.instance;
    }
    
    public function clearOutput() : Void
    {
        EngineCore.clearOutput();
    }
    public function outputText(text : String) : Void
    {
        EngineCore.outputText(text);
    }
    
    public function new(id : String, shortName : String = null, longName : String = null, value : Float = 0, description : String = null)
    {
        super(id, shortName, longName, value, description);
    }
}

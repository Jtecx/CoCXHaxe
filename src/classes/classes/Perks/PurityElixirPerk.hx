/**
 * @author Liadri
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class PurityElixirPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Minimum corruption reduced by " + params.value1 * 20 + " to a minimum of 0.";
    }
    
    public function new()
    {
        super("Purity Elixir", "Purity Elixir", 
                "Minimum corruption reduced by 20 to a minimum of 0."
        );
    }
}


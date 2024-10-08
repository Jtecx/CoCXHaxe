/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class ElvenBountyPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Increases fertility by " + params.value2 + "% and cum production by " + params.value1 + "mLs.";
    }
    
    public function new()
    {
        super("Elven Bounty", "Elven Bounty", 
                "After your encounter with an elf, her magic has left you with increased fertility and virility."
        );
    }
}


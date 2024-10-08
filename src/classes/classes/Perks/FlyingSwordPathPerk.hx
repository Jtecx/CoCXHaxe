/**
 * ...
 * @author Ormael
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class FlyingSwordPathPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Allows you to control flying swords. With spending enough soulforce can even fly on them. (Rank: " + params.value1 + ")";
    }
    
    public function new()
    {
        super("Flying Sword Path", "Flying Sword Path", 
                "Allows you to control flying swords. With spending enough soulforce can even fly on them."
        );
    }
}



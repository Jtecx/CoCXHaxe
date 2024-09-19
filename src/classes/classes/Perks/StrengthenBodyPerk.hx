/**
 * ...
 * @author Liadri
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class StrengthenBodyPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "(Rank: " + params.value1 + ") Consume the stored energy of souls to raise your strength, toughness and speed by " + params.value1 * 5 + "% permanently. This change persists through time.";
    }
    
    public function new()
    {
        super("Strengthen Body", "Strengthen Body", "", "Consume the stored energy of souls to raise your strength, toughness and speed by 5% permanently. This change persists through time.");
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}


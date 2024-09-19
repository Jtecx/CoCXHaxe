/**
 * ...
 * @author Zavos
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class SeersInsightPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Increase spell/magical soulskills power and lower specials fatigue/soulforce cost by " + (params.value1 * 100) + "%.";
    }
    
    public function new()
    {
        super("Seer’s Insight", "Seer’s Insight", 
                "Your equipment boost your spells/magical soulskills power and lowering costs of specials/soulskills!"
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}



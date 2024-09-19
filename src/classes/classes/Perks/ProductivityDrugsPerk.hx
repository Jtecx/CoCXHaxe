package classes.perks;

import classes.PerkClass;
import classes.PerkType;

class ProductivityDrugsPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Libido increased by " + as3hx.Compat.parseInt(params.value1) + "%, minimum corruption increased by 10, cum production (if applicable) increased by " + as3hx.Compat.parseInt(params.value3) + "mL, and milk production (if applicable) increased by " + as3hx.Compat.parseInt(params.value3) + "mL.";
    }
    
    public function new()
    {
        super("Productivity Drugs", "Productivity Drugs", "The drugs from the factory significantly increase your maximum libido, minimum libido, minimum corruption, and fluid production.");
    }
}


package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.CoC;

class CleansingPalmPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        if (CoC.instance.player.cor >= (10 + CoC.instance.player.corruptionTolerance))
        {
            return "<b>DISABLED</b> - Corruption too high!";
        }
        else
        {
            return super.desc(params);
        }
    }
    
    public function new()
    {
        super("Cleansing Palm", "Cleansing Palm", "A ranged fighting technique of Jojo’s order, allows you to blast your enemies with waves of pure spiritual energy, weakening them and hurting the corrupt.");
    }
}


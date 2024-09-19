package classes.perks;

import classes.CoC;
import classes.PerkClass;
import classes.PerkType;
import classes.globalFlags.*;

class RegenerationPerk extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        if (CoC.instance.flags[kFLAGS.HUNGER_ENABLED] > 0 && CoC.instance.player.hunger < 25)
        {
            return "<b>DISABLED</b> - You are too hungry!";
        }
        else
        {
            return super.desc(params);
        }
    }
    
    public function new()
    {
        super("Regeneration I", "Regeneration I", 
                "Regenerates 1% of max HP/hour and 0,5% of max HP/round.", 
                "You choose the 'Regeneration I' perk, allowing you to heal 0,5% of max HP every round of combat and 1% of max HP every hour!"
        );
    }
}



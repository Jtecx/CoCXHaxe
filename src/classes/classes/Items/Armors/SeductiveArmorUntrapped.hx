package classes.items.armors;

import classes.globalFlags.KFLAGS;
import classes.items.Armor;
import classes.Player;
import classes.PerkLib;
import classes.PerkType;

class SeductiveArmorUntrapped extends Armor
{
    
    override public function equipText() : Void
    {
        outputText("\n\nYou are relieved to find out that this armor is not trapped.");
        super.equipText();
    }
    
    public function new()
    {
        super("SeductU", "U.SeductA", "untrapped seductive armor", "a set of untrapped scandalously seductive armor", 10, 0, 1200, "A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.  This armor is not trapped.", "Heavy");
        withBuffs({
                    teasedmg : 5
                });
    }
}



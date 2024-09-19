/**
 * ...
 * @author Liadri
 */
package classes.items.headJewelries;

import classes.items.HeadJewelry;
import classes.PerkLib;

class MachinistGoggles extends HeadJewelry
{
    
    public function new()
    {
        super("MachGog", "MachinistGoggles", "Machinist Goggles", "a Machinist Goggles", 0, 0, 400, "A pair of ordinary machinist goggles. One of the basic tools of anyone working with engines. Helps prevent blindness.", HJT_HELMET);
        withPerk(PerkLib.BlindImmunity, 0, 0, 0, 0);
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (!super.canEquip(doOutput, slot))
        {
            return false;
        }
        if (game.player.basetallness > 48)
        
        //Taller than 4 ft{
            
            if (doOutput)
            {
                outputText("You try to put your goggles on but the things clearly weren't designed for someone your size. Frustrated, you put them back in the bag.\n\n");
            }
            return false;
        }
        return true;
    }
}



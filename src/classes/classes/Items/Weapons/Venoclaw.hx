/**
 * ...
 * @author Liadri
 */
package classes.items.weapons;

import classes.items.IELib;
import classes.items.Weapon;

class Venoclaw extends Weapon
{
    
    public function new()
    {
        super("VenClaw", "Venoclaw", "Venoclaw", "a Venoclaw", "rend", 0, 400, 
                "This set of catclaw gloves was tempered using Etna's own venom and reinforced using some of her tail bone spikes, a proof of her eternal love to you. Its also enchanted to reinforce natural attacks.", 
                WT_GAUNTLET, WSZ_MEDIUM
        );
        withEffect(IELib.Bleed, 10);
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
}

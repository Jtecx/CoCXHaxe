/**
 * ...
 * @author Liadri
 */
package classes.items.weaponsRange;

import classes.items.WeaponRange;
import classes.globalFlags.KFLAGS;

class SeaHuntressHarpoons extends WeaponRange
{
    
    public function new()
    {
        super("SHunHar", "SHuntHarp", "sea huntress harpoons", "a sea huntress harpoons", "shot", 25, 1250, "A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded.", "Throwing");
    }
    
    override private function get_attack() : Float
    {
        var boost : Int = 0;
        if (game.flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 5)
        {
            boost += 10;
        }
        return (15 + boost);
    }
}

/**
 * Created by aimozg on 11.01.14.
 */
package classes.items.consumables;

import classes.globalFlags.KFLAGS;
import classes.items.Consumable;
import classes.Races;
import classes.internals.Utils;
import classes.Player;

@:final class HairExtensionSerum extends Consumable
{
    
    public function new()
    {
        super("ExtSerm", "ExtSerm", "a bottle of hair extension serum", 6, "This is a bottle of foamy pink liquid, purported by the label to increase the speed at which the user's hair grows.");
    }
    
    override public function canUse() : Bool
    {
        if (game.flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] <= 2)
        {
            return true;
        }
        outputText("<b>No way!</b>  Your head itches like mad from using the rest of these, and you will NOT use another.\n");
        return false;
    }
    
    override public function useItem() : Bool
    {
        outputText("You open the bottle of hair extension serum and follow the directions carefully, massaging it into your scalp and being careful to keep it from getting on any other skin.  You wash off your hands with lakewater just to be sure.");
        if (game.flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] <= 0)
        {
            outputText("\n\nThe tingling on your head lets you know that it's working!");
            game.flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] = 7;
            game.flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] = 1;
        }
        else if (game.flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] == 1)
        {
            outputText("\n\nThe tingling intensifies, nearly making you feel like tiny invisible faeries are massaging your scalp.");
            game.flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED]++;
        }
        else if (game.flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] == 2)
        {
            outputText("\n\nThe tingling on your scalp is intolerable!  It's like your head is a swarm of angry ants, though you could swear your hair is growing so fast that you can feel it weighing you down more and more!");
            game.flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED]++;
        }
        if (game.flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0 && (game.player.hairType != 4 || game.player.hairType != 6) && !game.player.isRace(Races.JIANGSHI, 1, false))
        {
            game.flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
            outputText("\n\n<b>Somehow you know that your " + game.player.hairDescript() + " is growing again.</b>");
        }
        if (game.flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] < 7)
        {
            game.flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] = 7;
        }
        return (false);
    }
}


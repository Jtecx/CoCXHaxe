package classes.items.consumables;

import classes.items.Consumable;
import classes.PerkLib;
import classes.Player;

@:final class MindUp extends Consumable
{
    
    public function new()
    {
        super("MindUp", "MindUp", "a bottle marked as 'MindUp'", 250);
    }
    
    override private function get_description() : String
    {
        if (game.player.hasPerk(PerkLib.Insanity))
        {
            return "This should bring your sanity back.  You don't really think anything is wrong with your head.";
        }
        else
        {
            return "This draft is concocted from incense of Insight and who knows what else.  Supposedly it will restore your sanity. \n\nType: Consumable";
        }
    }
    
    override public function canUse() : Bool
    {
        if (game.player.hasPerk(PerkLib.Insanity))
        {
            return true;
        }
        outputText("You can't use this right now, and it's too expensive to waste!\n\n");
        return false;
    }
    
    override public function useItem() : Bool
    {
        outputText("\n\n(<b>Perk Removed:  Insanity - You are no longer insane!</b>)");
        game.player.removePerk(PerkLib.Insanity);
        return (false);
    }
    
    override public function useText() : Void
    {
        outputText("As you take Rathazul concoction you can't help but sigh in relief as whatever messed up knowledge leaves your brain sadly at the same time the loss of such knowledge leaves you diminished, ignorant of whatever terrible truth you uncovered. Ignorance is bliss as they say.");
    }
}

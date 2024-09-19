package classes.items.consumables;

import classes.items.Consumable;
import classes.PerkLib;

/**
	 * Item that boost milk production.
	 */
class MilkPotion extends Consumable
{
    private static inline var ITEM_VALUE : Int = 120;
    
    public function new()
    {
        super("MilkPtn", "ProLactaid", "a bottle labelled \"Pro Lactaid\"", ITEM_VALUE, "A bottle filled with white liquid which is distilled from Lactaid and LaBovas.  Rathazul mentioned that this potion will greatly improve your lactation. There's the possibility of permanently lactating, even if you're a male.");
    }
    
    override public function useItem() : Bool
    {
        clearOutput();
        player.slimeFeed();
        var i : Float = 0;
        outputText("You drink the milk potion.  It tastes like milk.");
        //Player doesn't lactate
        if (player.biggestLactation() < 1)
        {
            outputText("\n\n");
            outputText("You feel your [nipple]s become tight and engorged.  A single droplet of milk escapes each, rolling down the curves of your breasts.  <b>You are now lactating!</b>");
            for (i in 0...player.breastRows.length)
            {
                player.breastRows[i].lactationMultiplier += 5;
            }
        }
        //Boost lactation
        else
        {
            outputText("\n\n");
            outputText("Milk leaks from your [nipple]s in thick streams.  You're lactating even more!");
            for (i in 0...player.breastRows.length)
            {
                player.breastRows[i].lactationMultiplier += 2 + rand(30) / 10;
            }
        }
        //Grant perk or rank it up
        if (rand(1) == 0 && !player.hasPerk(PerkLib.MilkMaid))
        {
            outputText("\n\n");
            outputText("You can feel something inside your [chest] as they feel more dense. Your entire body tingles with a strange feel. Somehow, you know you won't be able to stop lactating.\n");
            outputText("<b>Gained Perk: Milk Maid! (Your milk production is increased by 200mL and you won't stop lactating.)</b>");
            player.createPerk(PerkLib.MilkMaid, 1, 0, 0, 0);
        }
        else if (rand(player.perkv1(PerkLib.MilkMaid)) == 0 && player.perkv1(PerkLib.MilkMaid) < 10)
        {
            outputText("\n\n");
            outputText("You can feel something inside your [chest] as they feel even more dense. Your entire body tingles with a strange feel. Seems like you're going to lactate more milk.\n");
            outputText("<b>Perk Ranked Up: Milk Maid! (Your milk production is increased by additional 100mL.)</b>");
            player.addPerkValue(PerkLib.MilkMaid, 1, 1);
        }
        else if (player.perkv1(PerkLib.MilkMaid) >= 10)
        {
            outputText("\n\n");
            outputText("You can feel something tingling inside your [chest] but nothing special happens. <b>Maybe you've already maxed out your permanent boost to lactation?</b>\n");
        }
        
        return false;
    }
}

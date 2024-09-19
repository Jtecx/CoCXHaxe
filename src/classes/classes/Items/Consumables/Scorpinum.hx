/**
 * Coded by aimozg on 01.06.2017.
 */
package classes.items.consumables;

import classes.bodyParts.Skin;
import classes.bodyParts.Tail;
import classes.CoC;
import classes.items.alchemy.AlchemyLib;
import classes.items.Consumable;

class Scorpinum extends Consumable
{
    public function new()
    {
        super("Scorico", "Scorpinum", "a vial of Scorpinum", 6, "This is a long flared vial with a small label that reads, \"<i>Scorpinum</i>\".  It is likely this potion is tied to scorpions in some way.");
        withTag(U_TF);
        refineableInto(
                AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE, 
                AlchemyLib.DEFAULT_ESSENCE_DROP_TABLE(AlchemyLib.AE_SCORPION)
        );
    }
    
    override public function useItem() : Bool
    {
        var changes : Float = 0;
        var changeLimit : Float = 2;
        if (rand(2) == 0)
        {
            changeLimit++;
        }
        if (rand(2) == 0)
        {
            changeLimit++;
        }
        changeLimit += player.additionalTransformationChances;
        player.slimeFeed();
        clearOutput();
        outputText("You down the potion, grimacing at the strong taste.");
        if (changes < changeLimit && rand(2) == 0 && player.MutagenBonus("tou", 1))
        {
            changes++;
            outputText("\n\nAfter drinking the potion, you feel a bit tougher.");
        }
        if (player.blockingBodyTransformations())
        {
            changeLimit = 0;
        }
        //gain scorpion tail
        if (changes < changeLimit && player.tailType != Tail.SCORPION && player.tailType != Tail.GARGOYLE && rand(2) == 0)
        {
            outputText("\n\n");
            CoC.instance.transformations.TailScorpion.applyEffect();
            changes++;
        }
        //Venom Increase
        if (changes < changeLimit && player.tailType == Tail.SCORPION && player.tailRecharge < 20 && rand(2) == 0)
        {
            if (player.tailRecharge < 10)
            {
                player.tailRecharge += 2;
            }
            if (player.tailRecharge < 15)
            {
                player.tailRecharge += 2;
            }
            if (player.tailRecharge < 20)
            {
                player.tailRecharge += 2;
            }
            player.tailVenom += 50;
            if (player.tailVenom > player.maxVenom())
            {
                player.tailVenom = player.maxVenom();
            }
            outputText("\n\nYour tail swells with vitality and a drop of venom escapes your stinger as it begins producing it in slightly larger quantities.");
            changes++;
        }
        //Gain chitin skin
        if (changes < changeLimit && !player.hasCoatOfType(Skin.CHITIN) && !player.isGargoyle() && player.tailType == Tail.SCORPION && rand(2) == 0)
        {
            CoC.instance.transformations.SkinChitin(Skin.COVERAGE_COMPLETE, {
                                color : "green"
                            }).applyEffect();
            changes++;
        }
        return false;
    }
}


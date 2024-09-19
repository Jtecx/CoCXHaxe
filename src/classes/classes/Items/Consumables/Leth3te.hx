/**
 * Created by aimozg on 10.01.14.
 */
package classes.items.consumables;

import classes.*;
import classes.items.Consumable;
import classes.scenes.SceneLib;

//Checks if the perk is present before use. Algo gives a prompt because why not.
class Leth3te extends Consumable
{
    
    public function new()
    {
        var descr : String;
        descr = "A chunk of grand lethicite. It's rare as lethicite is only produced when a mortal becomes a demon and cums their souls out. A demon's favourite treat.";
        super("Leth3te", "Grand Lethicite", "a chunk of grand lethicite", 15000, descr);
    }
    
    override public function useItem() : Bool
    {
        clearOutput();
        if (!player.hasPerk(PerkLib.SoulEater) && !player.hasPerk(PerkLib.Soulless))
        {
            outputText("You examine the pinkish-purple crystal. It must be lethicite. You know that the demons like to consume them but you're sure there might be a use for it.");
            SceneLib.inventory.returnItemToInventory(this);
        }
        else
        {
            eatIt();
        }
        return true;
    }
    
    public function eatIt() : Void
    {
        clearOutput();
        outputText("You grab the crystal and gulp it down, smiling contently as you feel it dissolve into your core and suffuse your body with raw power.");
        if (player.hasPerk(PerkLib.Soulless))
        {
            var gains : Float = 750;
            if (player.demonicenergy + gains > player.maxDemonicEnergy())
            {
                gains = player.maxDemonicEnergy() - player.demonicenergy;
            }
            player.demonicenergy += gains;
            outputText(" (+" + gains + " DE)");
        }
        else
        {
            player.buff("Soul Eater").addStat("int.mult", 0.15);
            player.buff("Soul Eater").addStat("lib.mult", 0.15);
        }
        SceneLib.inventory.itemGoNext();
    }
}


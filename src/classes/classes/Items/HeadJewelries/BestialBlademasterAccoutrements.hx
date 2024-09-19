/**
 * ...
 * @author Shadeogorath the Zerkaholic
 */
package classes.items.headJewelries;

import classes.items.HeadJewelry;
import classes.scenes.SceneLib;
import classes.PerkLib;

class BestialBlademasterAccoutrements extends HeadJewelry
{
    
    public function new()
    {
        super("BestBlaA", "BestBlaA", "Bestial Blademaster accoutrements", "a Bestial Blademaster accoutrements", 0, 0, 1600, "Armored circlet and cape of a lizan swordswoman who was said to have mastered maintaining a serene state of mind in even the most heated of battles.", HJT_HELMET);
        withPerk(PerkLib.SereneMind, 0, 0, 0, 0);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        SceneLib.setItemsChecks.equipBestialBlademasterItemsSet();
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        SceneLib.setItemsChecks.unequipBestialBlademasterItemsSet();
        super.afterUnequip(doOutput, slot);
    }
}


/**
 * ...
 * @author Shadeogorath the Zerkaholic
 */
package classes.items.armors;

import classes.items.Armor;
import classes.scenes.SceneLib;
import classes.PerkLib;

class BestialBlademasterArmor extends Armor
{
    
    public function new()
    {
        super("BestBlA", "BestBlA", "Bestial Blademaster armor", "a Bestial Blademaster armor", 15, 10, 8000, "An armor that was once worn by a lizan swordswoman with an odd affinity for fire. Designed to cover and sturdily protect the parts of her body her tough scales did not, whilst allowing her to maintain her mobility.", "Medium");
        withBuffs({
                    teasedmg : 8
                });
        withPerk(PerkLib.InfernalRage, 0, 0, 0, 0);
        withTag(A_AGILE);
        withTag(A_REVEALING);
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


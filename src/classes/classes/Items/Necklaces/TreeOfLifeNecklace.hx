/**
 * ...
 * @author Ormael
 */
package classes.items.necklaces;

import classes.globalFlags.KFLAGS;
import classes.items.Necklace;
import classes.scenes.SceneLib;

class TreeOfLifeNecklace extends Necklace
{
    
    public function new()
    {
        super("TreeLNe", "TreeLifeNecklace", "Tree of Life Necklace", "a Tree of Life Necklace", 0, 0, 4000, "A necklace made of branches that symbolize tree of life with strong aura of life surrounding it. Rumored to be blessed by the god of life have amazing effect for any living being that would wear it. \n\nType: Jewelry (Necklace) \nBase value: 4,000 \nSpecial: +2%(+4%)/-2%(-4%) HP regeneration (below 0 HP)(others / undead), +5% diehard for living beings", "Necklace");
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        SceneLib.setItemsChecks.equipTreeOfLifeItemsSet();
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        SceneLib.setItemsChecks.unequipTreeOfLifeItemsSet();
        super.afterUnequip(doOutput, slot);
    }
}


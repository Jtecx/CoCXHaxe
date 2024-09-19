/**
 * ...
 * @author Ormael
 */
package classes.items.headJewelries;

import classes.globalFlags.KFLAGS;
import classes.items.HeadJewelry;
import classes.scenes.SceneLib;

class TreeOfLifeCrown extends HeadJewelry
{
    
    public function new()
    {
        super("TreeLCr", "TreeLifeCrown", "Tree of Life Crown", "a Tree of Life Crown", 0, 0, 8000, "A crown made of branches that symbolize tree of life with strong aura of life surrounding it. Rumored to be blessed by the god of life have amazing effect for any living being that would wear it. \nBase value: 8,000 \nSpecial: +2%(+4%)/-2%(-4%) HP regeneration (below 0 HP)(others / undead), +5% diehard for living beings", HJT_CROWN);
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


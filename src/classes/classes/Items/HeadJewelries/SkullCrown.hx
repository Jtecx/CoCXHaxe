/**
 * ...
 * @author Ormael
 */
package classes.items.headJewelries;

import classes.globalFlags.KFLAGS;
import classes.items.HeadJewelry;
import classes.scenes.SceneLib;

class SkullCrown extends HeadJewelry
{
    
    public function new()
    {
        super("SkullsCr", "SkullsCrown", "Skulls Crown", "a Skull Crown", 0, 0, 8000, "A crown made of skulls with strong aura of death surrounding it. Rumored to be blessed by the god of death have amazing effect for any undead being that would wear it. \nBase value: 8,000 \nSpecial: +2%(+4%)/-2%(-4%) HP regeneration (below 0 HP)(undead / others), +5% diehard for undead", HJT_CROWN);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        SceneLib.setItemsChecks.equippedSkullSetItems();
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        SceneLib.setItemsChecks.unequipSkullItemsSet();
        super.afterUnequip(doOutput, slot);
    }
}


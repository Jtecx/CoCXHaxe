/**
 * ...
 * @author Ormael
 */
package classes.scenes.nPCs;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;
import classes.items.*;
import coc.view.ButtonDataList;

class DianaFollower extends NPCAwareContent
{
    
    /*
public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}*/
    public function uncurseCost(item : IDynamicItem, equipped : Bool) : Int
    {
        var cost : Int = as3hx.Compat.parseInt(250 * (1 + item.rarity));
        if (equipped)
        {
            cost *= 2;
        }
        return as3hx.Compat.parseInt(cost);
    }
    public function dianaAtJttECursedItemsRemoval1() : Void
    {
        clearOutput();
        outputText("Uncurse which item?");
        var buttons : ButtonDataList = new ButtonDataList();
        var cost : Int;
        for (slot/* AS3HX WARNING could not determine type for var: slot exp: ECall(EField(EIdent(player),carriedKnownCursedItems),[]) type: null */ in player.carriedKnownCursedItems())
        {
            cost = uncurseCost(try cast(slot.itype, IDynamicItem) catch(e:Dynamic) null, false);
            buttons.add(slot.itype.shortName, curry(uncurseItem, slot)).hint("Lift the curse from " + slot.itype.longName + " (" + cost + " gems)").disableIf(player.gems < cost, "Not enough gems (" + cost + ")");
        }
        for (item/* AS3HX WARNING could not determine type for var: item exp: ECall(EField(EIdent(player),equippedKnownCursedItems),[]) type: null */ in player.equippedKnownCursedItems())
        {
            cost = uncurseCost(try cast(item, IDynamicItem) catch(e:Dynamic) null, true);
            buttons.add(item.shortName, curry(uncurseEquippedItem, item)).hint("Lift the curse from " + item.longName + " (" + cost + " gems)").disableIf(player.gems < cost, "Not enough gems (" + cost + ")");
        }
        submenu(buttons, SceneLib.journeyToTheEast.dianaAtJttEMain, 0, false);
    }
    public function uncurseItem(slot : ItemSlotClass) : Void
    {
        clearOutput();
        var newItem : ItemType = (try cast(slot.itype, IDynamicItem) catch(e:Dynamic) null).uncursedCopy();
        outputText("The curse is lifted from " + slot.itype.longName);
        slot.setItemAndQty(newItem, slot.quantity);
        doNext(SceneLib.journeyToTheEast.dianaAtJttEMain);
    }
    public function uncurseEquippedItem(item : ItemType) : Void
    {
        clearOutput();
        var newItem : ItemType = (try cast(item, IDynamicItem) catch(e:Dynamic) null).uncursedCopy();
        player.replaceEquipment(try cast(item, Equipable) catch(e:Dynamic) null, try cast(newItem, Equipable) catch(e:Dynamic) null);
        outputText("The curse is lifted from " + newItem.longName + ". You can unequip it now.");
        doNext(SceneLib.journeyToTheEast.dianaAtJttEMain);
    }
    public function dianaAtJttECursedItemsRemoval2() : Void
    {
        clearOutput();
        outputText("As horse healer proceed with the purification ritual you struggle in pain at first as you feel the cursed weapon in your hand resist the unbinding before release washes over you as your grip opens dropping the malevolent item on the ground. ");
        outputText("Horse healer wrap the item in blessed cloth in order to seal its malice before handing you the neutralized cursed item back. Sure you can equip it again anytime but now you know the risks.\n\n");
        player.gems -= 500;
        player.removeStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow);
        player.createStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow, 1, 0, 0, 0);
        if (player.statStore.hasBuff("Sagittarius Curse"))
        {
            player.buff("Sagittarius Curse").remove();
        }
        if (player.statStore.hasBuff("Sagittarius Focus"))
        {
            player.buff("Sagittarius Focus").remove();
        }
        player.unequipWeaponRange(false, true);
        inventory.takeItem(weaponsrange.SAGITTB, SceneLib.journeyToTheEast.dianaAtJttEMain);
    }

    public function new()
    {
        super();
    }
}

//
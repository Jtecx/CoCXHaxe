/**
 * Created by Kitteh6660 on 01.29.15.
 */
package classes.items;

import classes.ItemType;
import classes.PerkLib;
import classes.Player;
import classes.scenes.SceneLib;
import classes.globalFlags.KFLAGS;

/**
	 * ...
	 * @author Kitteh6660
	 */
class Shield extends Equipable
{
    public var block(get, never) : Float;
    public var perk(get, never) : String;

    private var _block : Float;
    private var _perk : String;
    
    override private function get_category() : String
    {
        return CATEGORY_SHIELD;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, block : Float, value : Float = 0, description : String = null, perk : String = "")
    {
        super(id, shortName, name, longName, value, description);
        this._block = block;
        this._perk = perk;
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_SHIELD];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
    
    private function get_block() : Float
    {
        return _block;
    }
    
    private function get_perk() : String
    {
        return _perk;
    }
    
    override public function effectDescriptionParts() : Array<Dynamic>
    {
        var list : Array<Dynamic> = super.effectDescriptionParts();
        // Type
        list.push([10, "Type: Shield"]);
        // Attack
        var block : Float = this.block;
        list.push([20, "Block: " + block]);
        return list;
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.weaponRangePerk == "Dual Firearms" || game.player.weaponRangePerk == "Dual 2H Firearms")
        {
            if (doOutput)
            {
                outputText("Your current range weapons requires two hands. Unequip your current range weapons or switch to one-handed before equipping this shield. ");
            }
            return false;
        }
        else if (game.player.weaponRangePerk == "2H Firearm")
        {
            if (doOutput)
            {
                outputText("Your current range weapon requires two hands. Unequip your current range weapon or switch to one-handed before equipping this shield. ");
            }
            return false;
        }
        else if ((game.player.weapon.isSingleLarge() && !game.player.hasPerk(PerkLib.GigantGrip)) || (game.player.weapon.isSingleMassive() && !game.player.hasPerk(PerkLib.TitanGrip)))
        {
            if (doOutput)
            {
                outputText("Your current melee weapon requires two hands. Unequip your current melee weapon or switch to one-handed before equipping this shield. ");
            }
            return false;
        }
        else if ((game.player.weapon.isDualWielded() && game.player.weapon != WeaponLib.FISTS && game.player.weapon.isGauntletType() && game.player.weapon != game.weapons.AETHERD) || game.player.weaponName == "Daisho")
        {
            if (doOutput)
            {
                outputText("Your current melee weapons requires both hands. Unequip your current melee weapons or switch to one-handed before equipping this shield. ");
            }
            return false;
        }
        else if (!game.player.weaponOff.isNothing)
        {
            if (doOutput)
            {
                outputText("You can't hold with one hand both off hand weapon and shield. Unequip your current melee off hand weapon before equipping this shield. ");
            }
            return false;
        }
        else if (game.player.hasPerk(PerkLib.Rigidity))
        {
            if (doOutput)
            {
                outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
            }
            return false;
        }
        else if (game.player.shieldPerk == "Massive" && !game.player.hasPerk(PerkLib.GigantGrip))
        {
            if (doOutput)
            {
                outputText("This shield requires use of both hands. Unequip your current melee weapon before equipping it. ");
            }
            return false;
        }
        return super.canEquip(doOutput, slot);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        {
            if ((perk == "Massive" && game.player.weapon != WeaponLib.FISTS && !game.player.hasPerk(PerkLib.GigantGrip))
                || (game.player.weapon.isSingleLarge() && !game.player.hasPerk(PerkLib.GigantGrip))
                || (game.player.weapon.isSingleMassive() && !game.player.hasPerk(PerkLib.TitanGrip))
                || ((game.player.weapon.isDualWielded() && game.player.weapon != WeaponLib.FISTS) && game.player.weapon.isGauntletType())
                || game.player.weaponName == "Daisho")
            {
                SceneLib.inventory.unequipWeapon();
            }
            if (!game.player.weaponOff.isNothing)
            {
                SceneLib.inventory.unequipWeaponOff();
            }
            if (game.player.weaponRangePerk == "Dual Firearms" || game.player.weaponRangePerk == "2H Firearm" || game.player.weaponRangePerk == "Dual 2H Firearms")
            {
                SceneLib.inventory.unequipWeaponRange();
            }
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function getItemText(textid : String) : String
    {
        if (textid == "legendary_fail")
        {
            return "You try to equip the legendary shield, but to your disappointment the item simply refuses to stay in your hands. It seems you still lack the right to wield this item.";
        }
        return super.getItemText(textid);
    }
}


/**
 * ...
 * @author Ormael
 */
package classes.items;

import classes.CoC;
import classes.PerkLib;
import classes.Player;
import classes.Race;
import classes.scenes.SceneLib;
import classes.items.ItemConstants;
import coc.view.IconLib;

class WeaponRange extends Equipable
{
    public var verb(get, never) : String;
    public var attack(get, never) : Float;
    public var perk(get, never) : String;

    private var _verb : String;
    private var _attack : Float;
    private var _perk : String;
    
    override private function get_category() : String
    {
        return CATEGORY_WEAPON_RANGED;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, verb : String, attack : Float, value : Float = 0, description : String = null, perk : String = "")
    {
        super(id, shortName, name, longName, value, description);
        this._verb = verb;
        this._attack = attack;
        this._perk = perk;
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_RANGED];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
    override private function get_iconId() : String
    {
        return IconLib.pickIcon(ownIconId, "I_GenericWeapon_" + perk, super.iconId);
    }
    
    private function get_verb() : String
    {
        return _verb;
    }
    
    private function get_attack() : Float
    {
        if (!CoC.instance || !CoC.instance.player)
        {
            return _attack;
        }
        var player : Player = CoC.instance.player;
        
        var baseAttackBonuss : Float = 0;
        var multiplier : Float = 100;
        var bonus : Float = 0;
        
        for (ie/* AS3HX WARNING could not determine type for var: ie exp: ECall(EIdent(effectsFlagged),[EIdent(IEF_ATTACK)]) type: null */ in effectsFlagged(IEF_ATTACK))
        {
            var _sw4_ = (ie.type);            

            switch (_sw4_)
            {
                //------------------------//
                // Multiplicative bonuses //
                //------------------------//
                case IELib.AttackMult_RaceTier:{
                    multiplier += ie.power * player.racialTier(try cast(ie.value1, Race) catch(e:Dynamic) null);
                }
                //------------------//
                // Additive bonuses //
                //------------------//
                case IELib.AttackBonus_RaceTier:{
                    bonus += ie.power * player.racialTier(try cast(ie.value1, Race) catch(e:Dynamic) null);
                }
            }
        }
        
        var attack : Float = (_attack + baseAttackBonuss) * multiplier / 100 + bonus;
        
        return attack;
    }
    
    private function get_perk() : String
    {
        return _perk;
    }
    
    public function hasSpecial(_special : String) : Bool
    {
        return perk.split(", ").indexOf(_special) >= 0;
    }
    
    override public function effectDescriptionParts() : Array<Dynamic>
    {
        var list : Array<Dynamic> = super.effectDescriptionParts();
        // Type
        list.push([10, "Type: Range Weapon"]);
        if (perk != "")
        {
            list.push([15, "Weapon Class: " + perk]);
        }
        // Attack
        list.push([20, "Attack: " + attack]);
        return list;
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.hasPerk(PerkLib.Rigidity))
        {
            if (doOutput)
            {
                outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
            }
            return false;
        }
        return super.canEquip(doOutput, slot);
    }
    
    override public function beforeEquip(doOutput : Bool, slot : Int) : Equipable
    {
        if (perk == "2H Firearm")
        {
            if (doOutput)
            {
                outputText("Because this weapon requires the use of two hands, you have unequipped your shield. ");
            }
            SceneLib.inventory.unequipShield();
        }
        if (perk == "Dual Firearms")
        {
            if (doOutput)
            {
                outputText("Because those weapons requires the use of two hands, you have unequipped your shield. ");
            }
            SceneLib.inventory.unequipShield();
        }
        return super.beforeEquip(doOutput, slot);
    }
    override public function getItemText(textid : String) : String
    {
        if (textid == "legendary_fail")
        {
            var itemType : String = _perk;
            if (Lambda.indexOf([ItemConstants.WT_PISTOL, ItemConstants.WT_RIFLE, ItemConstants.WT_2H_FIREARM, ItemConstants.WT_DUAL_FIREARMS, ItemConstants.WT_DUAL_2H_FIREARMS], _perk) > -1)
            {
                itemType = "firearm";
            }
            else if (_perk == ItemConstants.WT_THROWING || itemType == null)
            {
                itemType = "weapon";
            }
            
            return "You try to equip the legendary " + itemType.toLowerCase() +
            ", but to your disappointment the item simply refuses to stay in your hands. It seems you still lack the right to wield this item.";
        }
        return super.getItemText(textid);
    }
}


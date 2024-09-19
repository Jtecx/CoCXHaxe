/**
 * Created by aimozg on 10.01.14.
 */
package classes.items;

import classes.PerkLib;
import coc.view.IconLib;

class Armor extends Equipable
{
    public var def(get, never) : Float;
    public var mdef(get, never) : Float;
    public var perk(get, never) : String;
    public var supportsBulge(get, never) : Bool;
    public var supportsUndergarment(get, never) : Bool;

    private var _def : Float;
    private var _mdef : Float;
    private var _perk : String;
    private var _supportsBulge : Bool;
    private var _supportsUndergarment : Bool;
    
    override private function get_category() : String
    {
        return CATEGORY_ARMOR;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, def : Float, mdef : Float, value : Float = 0, description : String = null, perk : String = "", supportsBulge : Bool = false, supportsUndergarment : Bool = true)
    {
        super(id, shortName, name, longName, value, description);
        this._def = def;
        this._mdef = mdef;
        this._perk = perk;
        _supportsBulge = supportsBulge;
        _supportsUndergarment = supportsUndergarment;
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_ARMOR];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
    
    override private function get_iconId() : String
    {
        return IconLib.pickIcon(ownIconId, "I_GenericArmor_" + perk, super.iconId);
    }
    
    private function get_def() : Float
    {
        return _def;
    }
    
    private function get_mdef() : Float
    {
        return _mdef;
    }
    
    private function get_perk() : String
    {
        return _perk;
    }
    
    private function get_supportsBulge() : Bool
    {
        return _supportsBulge && game.player.modArmorName == "";
    }
    //For most clothes if the modArmorName is set then it's Exgartuan's doing. The comfortable clothes are the exception, they override this function.
    
    private function get_supportsUndergarment() : Bool
    {
        return _supportsUndergarment;
    }
    
    
    override public function effectDescriptionParts() : Array<Dynamic>
    {
        var list : Array<Dynamic> = super.effectDescriptionParts();
        // Type
        var type : String;
        var name : String = this.name.toLowerCase();
        if (name.indexOf("armor") >= 0 || name.indexOf("armour") >= 0 || name.indexOf("chain") >= 0 || name.indexOf("mail") >= 0 || name.indexOf("plates") >= 0)
        {
            type = "Armor ";
            if (perk == "Light" || perk == "Medium")
            {
                type += "(Light)";
            }
            else if (perk == "Medium")
            {
                type += "(Medium)";
            }
            else if (perk == "Heavy")
            {
                type += "(Heavy)";
            }
            else if (perk == "Light Ayo")
            {
                type += "(Light Ayo)";
            }
            else if (perk == "Heavy Ayo")
            {
                type += "(Heavy Ayo)";
            }
            else if (perk == "Ultra Heavy Ayo")
            {
                type += "(Ultra Heavy Ayo)";
            }
        }
        else
        {
            type = "Clothing ";
        }
        list.push([10, "Type: " + type]);
        // Defense
        if (def > 0)
        {
            list.push([20, "Defense (P): " + def]);
        }
        if (mdef > 0)
        {
            list.push([30, "Defense (M): " + mdef]);
        }
        return list;
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (!this.supportsUndergarment && (!game.player.upperGarment.isNothing || !game.player.lowerGarment.isNothing))
        {
            var output : String = "";
            var wornUpper : Bool = false;
            output += "It would be awkward to put on " + longName + " when you're currently wearing ";
            if (!game.player.upperGarment.isNothing)
            {
                output += game.player.upperGarment.longName;
                wornUpper = true;
            }
            if (!game.player.lowerGarment.isNothing)
            {
                if (wornUpper)
                {
                    output += " and ";
                }
                output += game.player.lowerGarment.longName;
            }
            output += ". You should consider removing them. You put it back into your inventory.";
            if (doOutput)
            {
                outputText(output);
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
        return super.canEquip(doOutput, slot);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        super.afterEquip(doOutput, slot);
        if (!game.isLoadingSave)
        {
            game.player.addToWornClothesArray(this);
        }
    }
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        super.afterUnequip(doOutput, slot);
        game.player.removePerk(PerkLib.BulgeArmor);  //Exgartuan check  
        if (game.player.modArmorName.length > 0)
        {
            game.player.modArmorName = "";
        }
    }
    
    
    override public function getItemText(textid : String) : String
    {
        if (textid == "legendary_fail")
        {
            return "You try to equip the legendary armor, but to your disappointment the item simply refuses to stay on your body. It seems you still lack the right to wear this item.";
        }
        return super.getItemText(textid);
    }
}


package classes.items;

import classes.bodyParts.LowerBody;
import classes.PerkLib;

/**
	 * @author Kitteh6660
	 */
class Undergarment extends Equipable
{
    public var slot(get, never) : Int;
    public var type(get, never) : Float;
    public var perk(get, never) : String;
    public var armorDef(get, never) : Int;
    public var armorMDef(get, never) : Int;
    public var sexiness(get, never) : Int;

    private var _type : Float;
    private var _def : Int;
    private var _mdef : Int;
    private var _sexiness : Int;
    private var _perk : String;
    
    override private function get_category() : String
    {
        return CATEGORY_UNDERGARMENT;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, undergarmentType : Float, value : Float, def : Float, mdef : Float, sexiness : Float, description : String = null, perk : String = "")
    {
        super(id, shortName, name, longName, value, description);
        this._type = undergarmentType;
        this._def = def;
        this._mdef = mdef;
        this._sexiness = sexiness;
        this._perk = perk;
    }
    
    private static var SLOTS_UPPER : Array<Dynamic> = [SLOT_UNDER_TOP];
    private static var SLOTS_LOWER : Array<Dynamic> = [SLOT_UNDER_BOTTOM];
    private static var SLOTS_ANY : Array<Dynamic> = [SLOT_UNDER_TOP, SLOT_UNDER_BOTTOM];
    override public function slots() : Array<Dynamic>
    {
        if (_type == UT_ANY)
        {
            return SLOTS_ANY;
        }
        if (_type == UT_BOTTOM)
        {
            return SLOTS_LOWER;
        }
        return SLOTS_UPPER;
    }
    // preferred slot
    private function get_slot() : Int
    {
        return (_type == UT_BOTTOM) ? SLOT_UNDER_BOTTOM : SLOT_UNDER_TOP;
    }
    
    private function get_type() : Float
    {
        return _type;
    }
    
    private function get_perk() : String
    {
        return _perk;
    }
    
    override private function get_description() : String
    {
        var desc : String = _description;
        //Defense
        if (armorDef > 0)
        {
            desc += "\nDefense (P): " + Std.string(armorDef);
        }
        if (armorMDef > 0)
        {
            desc += "\nDefense (M): " + Std.string(armorMDef);
        }
        //Sexiness
        if (sexiness > 0)
        {
            desc += "\nSexiness: " + Std.string(sexiness);
        }
        //Value
        desc += "\nBase value: " + Std.string(value);
        return desc;
    }
    
    private function get_armorDef() : Int
    {
        return _def;
    }
    
    private function get_armorMDef() : Int
    {
        return _mdef;
    }
    
    private function get_sexiness() : Int
    {
        return _sexiness;
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (!game.player.armor.supportsUndergarment)
        {
            outputText("It would be awkward to put on undergarments when you're currently wearing your type of clothing. You should consider switching to different clothes. You put it back into your inventory.");
            return false;
        }
        if (type == UT_BOTTOM)
        {
            if (!LowerBody.lowerGarmentDisabled(game.player, perk))
            {
                return true;
            }
            else
            {
                outputText("Your form makes it impossible to put this on. You place it back into your inventory.");
                return false;
            }
        }
        if (game.player.hasPerk(PerkLib.Rigidity))
        {
            outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
            return false;
        }
        return super.canEquip(doOutput, slot);
    }
}



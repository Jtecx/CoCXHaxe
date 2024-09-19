/**
 * Created by Ormael on 17.09.18.
 */
package classes.items;

import classes.ItemType;
import classes.PerkLib;
import classes.Player;

class HeadJewelry extends Equipable
{
    public var effectId(get, never) : Float;
    public var effectMagnitude(get, never) : Float;
    public var perk(get, never) : String;

    private var _effectId : Float;
    private var _effectMagnitude : Float;
    private var _perk : String;
    private var _type : String;
    private var _effectDescription : String;
    
    override private function get_category() : String
    {
        return CATEGORY_JEWELRY_HEAD;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, effectId : Float, effectMagnitude : Float, value : Float, description : String, type : String, perk : String = "", effectDescription : String = "")
    {
        super(id, shortName, name, longName, value, description);
        this._effectId = effectId;
        this._effectMagnitude = effectMagnitude;
        this._type = type;
        this._perk = perk;
        this._effectDescription = effectDescription;
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_HEAD];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
    
    private function get_effectId() : Float
    {
        return _effectId;
    }
    
    private function get_effectMagnitude() : Float
    {
        return _effectMagnitude;
    }
    
    private function get_perk() : String
    {
        return _perk;
    }
    
    
    override public function effectDescriptionParts() : Array<Dynamic>
    {
        var list : Array<Dynamic> = super.effectDescriptionParts();
        // Type
        switch (_type)
        {
            case HJT_CROWN:
                list.push([10, "Type: Jewelry (Crown)"]);
            case HJT_HAIRPIN:
                list.push([10, "Type: Jewelry (Hairpin)"]);
            case HJT_HELMET:
                list.push([10, "Type: Armor (Helm)"]);
        }
        // Effect
        switch (effectId)
        {
            case HEADEFF_SF:
                list.push([50, "Special: Increases maximum Soulforce by " + effectMagnitude + "."]);
            case HEADEFF_MP:
                list.push([50, "Special: Increases maximum Mana by " + effectMagnitude + "."]);
            case HEADEFF_HP:
                list.push([50, "Special: Increases maximum HP by " + effectMagnitude + "."]);
            case HEADEFF_ATTACK_POWER:
                list.push([50, "Special: Increases melee damage by " + effectMagnitude + " percent."]);
            case HEADEFF_SPELL_POWER:
                list.push([50, "Special: Increases spellpower by " + effectMagnitude + " percent."]);
            case HEADEFF_R_ATTACK_POWER:
                list.push([50, "Special: Increases ranged damage by " + effectMagnitude + " percent."]);
            case HEADEFF_WR:
                list.push([50, "Special: Increases maximum Wrath by " + effectMagnitude + "."]);
            case HEADEFF_FIRE_R:
                list.push([50, "Special: Increases fire resistance by " + effectMagnitude + "%."]);
            case HEADEFF_ICE_R:
                list.push([50, "Special: Increases ice resistance by " + effectMagnitude + "%."]);
            case HEADEFF_LIGH_R:
                list.push([50, "Special: Increases lightning resistance by " + effectMagnitude + "%."]);
            case HEADEFF_DARK_R:
                list.push([50, "Special: Increases darkness resistance by " + effectMagnitude + "%."]);
            case HEADEFF_POIS_R:
                list.push([50, "Special: Increases poison resistance by " + effectMagnitude + "%."]);
            case HEADEFF_MAGIC_R:
                list.push([50, "Special: Increases magic resistance by " + effectMagnitude + "%."]);
            case HEADEFF_LUST_R:
                list.push([50, "Special: Increases lust resistance by " + effectMagnitude + "%."]);
            case HEADEFF_PHYS_R:
                list.push([50, "Special: Increases physical resistance by " + effectMagnitude + "%."]);
        }
        // Extra effect
        if (_effectDescription != null)
        {
            list.push([70, _effectDescription]);
        }
        return list;
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.hasPerk(PerkLib.Rigidity))
        {
            outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
            return false;
        }
        return super.canEquip(doOutput, slot);
    }
}



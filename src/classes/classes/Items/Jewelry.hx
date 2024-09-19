/**
 * Created by Kitteh6660 on 08.29.14.
 */
package classes.items;

import classes.stats.StatUtils;

class Jewelry extends Equipable
{
    public var effectId(get, never) : Float;
    public var effectMagnitude(get, never) : Float;
    public var perk(get, never) : String;

    private var _effectId : Float;
    private var _effectMagnitude : Float;
    private var _perk : String;
    private var _extraEffectDesc : String;
    
    override private function get_category() : String
    {
        return CATEGORY_JEWELRY_RING;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, effectId : Float, effectMagnitude : Float, value : Float = 0, description : String = null, extraEffectDesc : String = "", perk : String = "")
    {
        super(id, shortName, name, longName, value, description);
        this._effectId = effectId;
        this._effectMagnitude = effectMagnitude;
        this._extraEffectDesc = extraEffectDesc;
        this._perk = perk;
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_RING_1, SLOT_RING_2, SLOT_RING_3, SLOT_RING_4];
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
        list.push([10, "Type: Jewelry (Ring)"]);
        if (effectId != 0 && !Math.isNaN(effectId))
        {
            var desc : String = "Special: ";
            switch (effectId)
            {
                case RINGEFF_MINLUST:
                    if (effectMagnitude > 0)
                    {
                        desc += "Increases minimum lust by " + effectMagnitude + ".";
                    }
                    else
                    {
                        desc += "Reduces minimum lust by " + (-effectMagnitude) + ".";
                    }
                case RINGEFF_FERTILITY:
                    desc += "Increases cum production by " + effectMagnitude + " percent and ferility by " + effectMagnitude + ".";
                case RINGEFF_SF:
                    desc += "Increases maximum Soulforce by " + effectMagnitude + ".";
                case RINGEFF_MP:
                    desc += "Increases maximum Mana by " + effectMagnitude + ".";
                case RINGEFF_HP:
                    desc += "Increases maximum HP by " + effectMagnitude + ".";
                case RINGEFF_ATTACK_POWER:
                    desc += "Increases melee damage by " + effectMagnitude + " percent.";
                case RINGEFF_SPELL_POWER:
                    desc += "Increases spellpower by " + effectMagnitude + " percent.";
                case RINGEFF_PURITY:
                    desc += "Slowly decreases the corruption of the wearer over time. Reduces minimum libido by " + effectMagnitude + ".";
                case RINGEFF_CORRUPTION:
                    desc += "Slowly increases the corruption of the wearer over time.";
                case RINGEFF_WR:
                    desc += "Increases maximum Wrath by " + effectMagnitude + ".";
                case RINGEFF_R_ATTACK_POWER:
                    desc += "Increases range damage by " + effectMagnitude + " percent.";
                case RINGEFF_SOUL_POWER:
                    desc += "Increases soulskill power by " + effectMagnitude + " percent.";
            }
            list.push([50, desc]);
        }
        if (_extraEffectDesc != null)
        {
            list.push([60, _extraEffectDesc]);
        }
        return list;
    }
}


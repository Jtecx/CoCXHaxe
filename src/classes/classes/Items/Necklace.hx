/**
 * Created by Ormael on 17.09.18.
 */
package classes.items;

import classes.ItemType;
import classes.PerkLib;
import classes.Player;

class Necklace extends Equipable
{
    public var effectId(get, never) : Float;
    public var effectMagnitude(get, never) : Float;
    public var perk(get, never) : String;

    private var _effectId : Float;
    private var _effectMagnitude : Float;
    private var _perk : String;
    
    override private function get_category() : String
    {
        return CATEGORY_NECKLACE;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, effectId : Float, effectMagnitude : Float, value : Float = 0, description : String = null, type : String = "", perk : String = "")
    {
        super(id, shortName, name, longName, value, description);
        this._effectId = effectId;
        this._effectMagnitude = effectMagnitude;
        this._perk = perk;
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_NECK];
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
    
    override private function get_description() : String
    {
        var desc : String = _description;
        return desc;
    }
}



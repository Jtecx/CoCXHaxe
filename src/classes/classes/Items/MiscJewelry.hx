/**
 * Created by Ormael on 04.06.21.
 */
package classes.items;


class MiscJewelry extends Equipable
{
    public var effectId(get, never) : Float;
    public var effectMagnitude(get, never) : Float;
    public var perk(get, never) : String;
    public var sexiness(get, never) : Int;

    private var _effectId : Float;
    private var _effectMagnitude : Float;
    private var _sexiness : Int;
    private var _perk : String;
    
    override private function get_category() : String
    {
        return CATEGORY_JEWELRY_MISC;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, effectId : Float, effectMagnitude : Float, value : Float, sexiness : Float, description : String = null, type : String = "", perk : String = "")
    {
        super(id, shortName, name, longName, value, description);
        this._effectId = effectId;
        this._effectMagnitude = effectMagnitude;
        this._perk = perk;
        this._sexiness = sexiness;
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_JEWELRY_MISC_1, SLOT_JEWELRY_MISC_2];
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
    
    private function get_sexiness() : Int
    {
        var _sw1_ = (this.name);        

        switch (_sw1_)
        {
            case "Demonic mage tail ornament":
                return 4;
            default:
                return 0;
        }
    }
}



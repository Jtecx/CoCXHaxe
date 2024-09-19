package classes;


class PerkClass
{
    public var ptype(get, never) : PerkType;
    public var perkName(get, never) : String;
    public var perkDesc(get, never) : String;
    public var perkLongDesc(get, never) : String;

    //constructor
    public function new(perk : PerkType, value1 : Float = 0, value2 : Float = 0, value3 : Float = 0, value4 : Float = 0)
    {
        _ptype = perk;
        this.value1 = value1;
        this.value2 = value2;
        this.value3 = value3;
        this.value4 = value4;
    }
    //data
    private var _ptype : PerkType;
    public var value1 : Float;
    public var value2 : Float;
    public var value3 : Float;
    public var value4 : Float;
    //MEMBER FUNCTIONS
    
    
    private function get_ptype() : PerkType
    {
        return _ptype;
    }
    
    private function get_perkName() : String
    {
        return _ptype.name(this);
    }
    
    private function get_perkDesc() : String
    {
        return _ptype.desc(this);
    }
    
    private function get_perkLongDesc() : String
    {
        return _ptype.longDesc;
    }
}


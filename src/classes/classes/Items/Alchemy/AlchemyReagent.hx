package classes.items.alchemy;

import flash.errors.Error;

typedef DictsTypedef = {
}

class AlchemyReagent
{
    private static var Dicts : Array<DictsTypedef> = [{ }, { }, { }, { }, { }];
    
    /**
     * AlchemyLib.CT_XXXX
     */
    public var type : Int;
    public var intValue : Int;
    public var stringValue : String;
    
    public function new(type : Int, intValue : Int, stringValue : String)
    {
        this.type = type;
        this.intValue = intValue;
        this.stringValue = stringValue;
        var n : String = name();
        if (n.indexOf("ERROR") == 0)
        {
            throw new Error("Invalid AlchemyReagent " + n);
        }
    }
    
    public function name() : String
    {
        switch (type)
        {
            case AlchemyLib.RT_SUBSTANCE:
                return (AlchemyLib.Substances[intValue] || {
                    name : "ERROR " + intValue
                })["name"] + " substance";
            case AlchemyLib.RT_ESSENCE:
                return (AlchemyLib.Essences[intValue] || {
                    name : "ERROR " + intValue
                })["name"] + " essence";
            case AlchemyLib.RT_RESIDUE:
                return (AlchemyLib.Residues[intValue] || {
                    name : "ERROR " + intValue
                })["name"] + " residue";
            case AlchemyLib.RT_PIGMENT:
                return stringValue + " pigment";
        }
        return "ERROR " + type + "/" + intValue + "/" + stringValue;
    }
    
    public function key() : Dynamic
    {
        return ((type == AlchemyLib.RT_PIGMENT)) ? stringValue : intValue;
    }
    
    private static function getAC(key : Dynamic, type : Int, intValue : Int, stringValue : String) : AlchemyReagent
    {
        var dict : Dynamic = Dicts[type];
        if (Lambda.has(dict, key))
        {
            return try cast(Reflect.field(dict, Std.string(key)), AlchemyReagent) catch(e:Dynamic) null;
        }
        return (Reflect.setField(dict, Std.string(key), new AlchemyReagent(type, intValue, stringValue)));
    }
    public static function getReagent(type : Int, value : Dynamic) : AlchemyReagent
    {
        if (type == AlchemyLib.RT_PIGMENT)
        {
            return getAC(value, type, 0, Std.string(value));
        }
        else
        {
            return getAC(value, type, as3hx.Compat.parseInt(value), null);
        }
    }
    public static function substance(substanceId : Int) : AlchemyReagent
    {
        return getAC(substanceId, AlchemyLib.RT_SUBSTANCE, substanceId, null);
    }
    public static function essence(essenceId : Int) : AlchemyReagent
    {
        return getAC(essenceId, AlchemyLib.RT_ESSENCE, essenceId, null);
    }
    public static function residue(residueId : Int) : AlchemyReagent
    {
        return getAC(residueId, AlchemyLib.RT_RESIDUE, residueId, null);
    }
    public static function pigment(pigmentColor : String) : AlchemyReagent
    {
        return getAC(pigmentColor, AlchemyLib.RT_PIGMENT, 0, pigmentColor);
    }
}


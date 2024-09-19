/**
 * Created by aimozg on 31.01.14.
 */
package classes;

import flash.errors.Error;
import flash.utils.Dictionary;

class StatusEffectType
{
    public var id(get, never) : String;

    /**
	 * Do not report an error if one of these was found in save file
	 */
    public static var RemovedIds : Array<Dynamic> = [
        "Str Tou Spe Counter 1", 
        "Str Tou Spe Counter 2", 
        "Int Wis Counter 1", 
        "Int Wis Counter 2", 
        "Lib Sens Counter 1", 
        "Lib Sens Counter 2"
    ];
    
    private static var STATUSAFFECT_LIBRARY : Dictionary = new Dictionary();
    private var arity : Int;
    
    public static function lookupStatusEffect(id : String) : StatusEffectType
    {
        return Reflect.field(STATUSAFFECT_LIBRARY, id);
    }
    
    public static function getStatusEffectLibrary() : Dictionary
    {
        return STATUSAFFECT_LIBRARY;
    }
    
    private var _id : String;
    
    /**
	 * Unique perk id, should be kept in future game versions
	 */
    private function get_id() : String
    {
        return _id;
    }
    
    private var _secClazz : Class<Dynamic>;
    
    /**
	 * @param id Unique status effect id; should persist between game version
	 * @param clazz Class to create instances of
	 * @param arity Class constructor arity: 0: new clazz(), 1: new clazz(thiz:StatusEffectType)
	 */
    public function new(id : String, clazz : Class<Dynamic>, arity : Int)
    {
        this._id = id;
        this.arity = arity;
        this._secClazz = clazz;
        if (Reflect.field(STATUSAFFECT_LIBRARY, id) != null)
        {
            CoC_Settings.error("Duplicate status affect " + id);
        }
        Reflect.setField(STATUSAFFECT_LIBRARY, id, this);
        if (!(arity >= 0 && arity <= 1))
        {
            throw new Error("Unsupported status effect '" + id + "' constructor arity " + arity);
        }
    }
    
    public function create(value1 : Float, value2 : Float, value3 : Float, value4 : Float) : StatusEffectClass
    {
        var sec : StatusEffectClass;
        if (arity == 0)
        {
            sec = Type.createInstance(_secClazz, []);
        }
        else if (arity == 1)
        {
            sec = Type.createInstance(_secClazz, [this]);
        }
        sec.value1 = value1;
        sec.value2 = value2;
        sec.value3 = value3;
        sec.value4 = value4;
        return sec;
    }
    
    
    public function toString() : String
    {
        return "\"" + _id + "\"";
    }
}


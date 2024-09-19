package classes;

import classes.Enum;

import flash.errors.Error;
import flash.utils.*;

/**
	 * Enum Class. http://scottbilas.com/blog/ultimate-as3-fake-enums/
	 * @author scottbilas
	 */
// This whole thing is a fucking abomination and it needs to die in a horrible fucking fire.
class Enum implements IExternalizable
{
    public var Name(get, never) : String;
    public var Index(get, never) : Int;

    private function get_Name() : String
    {
        return _name;
    }
    
    private function get_Index() : Int
    {
        return _index;
    }
    
    /*override*/public function toString() : String
    {
        return Name;
    }
    
    public static function GetConstants(i_type : Class<Dynamic>) : Array<Dynamic>
    {
        var constants : EnumConstants = _enumDb[Type.getClassName(i_type)];
        if (constants == null)
        {
            return null;
        }
        
        // return a copy to prevent caller modifications
        return constants.ByIndex.slice();
    }
    
    public static function ParseConstant(i_type : Class<Dynamic>, i_constantName : String, i_caseSensitive : Bool = false) : Enum
    {
        var constants : EnumConstants = _enumDb[Type.getClassName(i_type)];
        if (constants == null)
        {
            return null;
        }
        
        var constant : Enum = constants.ByName[i_constantName.toLowerCase()];
        if (i_caseSensitive && (constant != null) && (i_constantName != constant.Name))
        {
            return null;
        }
        
        return constant;
    }
    
    public static function ParseConstantByIndex(i_type : Class<Dynamic>, i_constantIndex : Int) : Enum
    {
        var constants : EnumConstants = _enumDb[Type.getClassName(i_type)];
        if (constants == null)
        {
            return null;
        }
        
        var constant : Enum = constants.ByIndex[i_constantIndex];
        if (constant != null && i_constantIndex != constant.Index)
        {
            return null;
        }
        
        return constant;
    }
    
    /*-----------------------------------------------------------------*/
    
    /*protected*/
    private function new()
    {
        var typeName : String = Type.getClassName(Type.getClass(this));
        var db : Dynamic = _enumDb;
        
        // discourage people new'ing up constants on their own instead
        // of using the class constants
        if (Reflect.field(_enumDb, typeName) != null)
        {  //throw new Error("Enum constants can only be constructed as static consts " + "in their own enum class " + "(bad type='" + typeName + "')");  
            
        }
        
        if (Reflect.field(_enumDb, typeName) == null)
        
        // if opening up a new type, alloc an array for its constants{
            
            var constants : Array<Dynamic> = Reflect.field(_pendingDb, typeName);
            if (constants == null)
            {
                Reflect.setField(_pendingDb, typeName, constants = []);
            }
            
            // record
            _index = constants.length;
            constants.push(this);
        }
    }
    
    private static function initEnum(i_type : Class<Dynamic>) : Void
    {
        var typeName : String = Type.getClassName(i_type);
        
        // can't call initEnum twice on same type (likely copy-paste bug)
        if (Reflect.field(_enumDb, typeName) != null)
        {  //throw new Error("Can't initialize enum twice (type='" + typeName + "')");  
            
        }
        
        if (Reflect.field(_enumDb, typeName) == null)
        
        // no constant is technically ok, but it's probably a copy-paste bug{
            
            var constants : Array<Dynamic> = Reflect.field(_pendingDb, typeName);
            if (constants == null)
            {
                throw new Error("Can't have an enum without any constants (type='" + typeName + "')");
            }
            
            // process constants
            var type : FastXML = flash.utils.describeType(i_type);
            for (constant in type.nodes.constant)
            
            // this will fail to coerce if the type isn't inherited from Enum{
                
                var enumConstant : Enum = i_type[constant.att.name];
                
                // if the types don't match then probably have a copy-paste error.
                // this is really common so it's good to catch it here.
                var enumConstantType : Dynamic = enumConstant;
                if (enumConstantType != i_type)
                {
                    throw new Error("Constant type '" + enumConstantType + "' " + "does not match its enum class '" + i_type + "'");
                }
                
                enumConstant._name = constant.att.name;
            }
            
            // now seal it
            Reflect.setField(_pendingDb, typeName, null);
            Reflect.setField(_enumDb, typeName, new EnumConstants(constants));
        }
    }
    
    public function writeExternal(outData : IDataOutput) : Void
    {
        outData.writeInt(_index);
    }
    
    public function readExternal(inData : IDataInput) : Void
    {
        _index = inData.readInt();
    }
    
    private var _name : String = null;
    private var _index : Int = -1;
    
    private static var _pendingDb : Dynamic = { };  // typename -> [constants]  
    private static var _enumDb : Dynamic = { };  // typename -> EnumConstants  
}


// private support class
class EnumConstants
{
    //AS3 won't find Enum if it isn't in the default package
    
    
    public function new(i_byIndex : Array<Dynamic>)
    {
        ByIndex = i_byIndex;
        
        for (i in 0...ByIndex.length)
        {
            var enumConstant : Enum = ByIndex[i];
            ByName[enumConstant.Name.toLowerCase()] = enumConstant;
        }
    }
    
    public var ByIndex : Array<Dynamic>;
    public var ByName : Dynamic = { };
}

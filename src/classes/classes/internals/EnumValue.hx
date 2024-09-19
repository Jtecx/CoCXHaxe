package classes.internals;


/**
 * Usage:
 *
 * public static var Types:/!*EnumValue*!/Array = [];
 * public static var FOO:int = EnumValue.add(Types, 0, 'FOO', {param:"something"});
 * public static var BAR:int = EnumValue.add(Types, 1, 'BAR', {param:"anything"});
 *
 * or
 *
 * public static var Types:/!*EnumValue*!/Array = [];
 * public static var FOO:int = 0;
 * EnumValue.add(Types, FOO, 'FOO', {param:"something"});
 * public static var BAR:int = 1;
 * EnumValue.add(Types, BAR, 'BAR', {param:"anything"});
 *
 * This will populate Types array with EnumValue's like that:
 * Types = [
 *           { value:0, id:'FOO', param:"something" }, // Types[0]
 *           { value:1, id:'BAR', param:"anything" }   // Types[1]
 * ];
 *
 * Scarse arrays are possible, but beware of the undefined in the array when iterating!
 */
class EnumValue
{
    public var list : Array<Dynamic>;
    public var value : Int;
    public var id : String;
    
    public function new(list : Array<Dynamic>, value : Int, id : String, properties : Dynamic = null)
    {
        this.list = list;
        this.value = value;
        this.id = id;
        if (properties != null)
        {
            for (key in Reflect.fields(properties))
            {
                Reflect.setField(this, key, Reflect.field(properties, key));
            }
        }
        if (list[value] != null)
        {
            throw "Duplicate enum value " + value + " of ids " + id + " and " + list[value].id;
        }
        list[value] = this;
    }
    public static function add(list : Array<Dynamic>, value : Int, id : String, properties : Dynamic = null) : Int
    {
        new EnumValue(list, value, id, properties);
        return value;
    }
    public static function findByProperty(list : Array<Dynamic>, propertyName : String, propertyValue : Dynamic) : EnumValue
    {
        for (p in list)
        {
            if (Reflect.field(p, propertyName) == propertyValue)
            {
                return p;
            }
        }
        return null;
    }
    /**
	 * Parses input string as index or enum constant name
	 */
    public static function parse(list : Array<Dynamic>, input : String) : EnumValue
    {
        if (!Math.isNaN(as3hx.Compat.parseInt(input)))
        {
            return list[as3hx.Compat.parseInt(input)];
        }
        else
        {
            return findByProperty(list, "id", input);
        }
    }
}


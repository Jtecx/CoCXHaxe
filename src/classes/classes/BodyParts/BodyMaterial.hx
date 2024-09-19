package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;

class BodyMaterial extends BodyPart
{
    public var name(get, never) : String;
    public var binary(get, never) : Bool;
    public var color(get, set) : String;
    public var color1(get, set) : String;
    public var color2(get, set) : String;

    /**
	 * Entry properties:
	 * - value: numerical id (0, 3)
	 * - id: name of the constant ("SKIN", "SCALES")
	 * - name: short human-readable name, ("skin", "scales")
	 * - plural: name is plural noun (true for scales/feathers)
	 * - defaultColors: initial color is randomly picked from these
	 **/
    public static var Types : Array<Dynamic> = [];
    
    public static inline var SKIN : Int = 0;
    
    public static inline var HAIR : Int = 1;
    
    public static inline var FUR : Int = 2;
    
    public static inline var SCALES : Int = 3;
    
    public static inline var CHITIN : Int = 4;
    
    public static inline var FEATHERS : Int = 5;
    
    public static inline var BARK : Int = 6;
    
    
    // these 4 values are kept in sync in setters
    private var _color : String;
    private var _color1 : String;
    private var _color2 : String;
    private var _binary : Bool;
    
    private function get_name() : String
    {
        return Types[type].name;
    }
    /**
	 * Two different colors
	 */
    private function get_binary() : Bool
    {
        return _binary;
    }
    private function get_color() : String
    {
        return _color;
    }
    private function set_color(value : String) : String
    {
        var i : Int = value.indexOf(" and ");
        _color = value;
        if (i >= 0)
        {
            _binary = true;
            _color1 = value.substr(0, i);
            _color2 = value.substr(i + " and ".length);
        }
        else
        {
            _binary = false;
            _color1 = value;
            _color2 = value;
        }
        return value;
    }
    private function get_color1() : String
    {
        return _color1;
    }
    private function set_color1(value : String) : String
    {
        if (!_binary)
        {
            color = value;
            return value;
        }
        _color1 = value;
        _binary = _color1 != _color2;
        if (_binary)
        {
            _color = value + " and " + _color2;
        }
        else
        {
            _color2 = value;
            _color = value;
        }
        return value;
    }
    private function get_color2() : String
    {
        return _color2;
    }
    private function set_color2(value : String) : String
    {
        _color2 = value;
        _binary = _color1 != _color2;
        if (_binary)
        {
            _color = _color1 + " and " + value;
        }
        else
        {
            _color = value;
        }
        return value;
    }
    
    public function new(creature : Creature, type : Int)
    {
        super(creature, ["color1", "color2"]);
        this.type = type;
        this.color = randomChoice(Types[type].defaultColors);
    }
    private static var BodyMaterial_static_initializer = {
        EnumValue.add(Types, SKIN, "SKIN", {
                    name : "skin",
                    defaultColors : ["light", "fair", "olive", "dark", "ebony", "mahogany", "russet"]
                });
        EnumValue.add(Types, HAIR, "HAIR", {
                    name : "hair",
                    defaultColors : ["blonde", "brown", "black", "red", "gray", "white", "auburn"]
                });
        EnumValue.add(Types, FUR, "FUR", {
                    name : "fur",
                    defaultColors : ["red", "orange", "brown", "white", "silver", "gray", "black"]
                });
        EnumValue.add(Types, SCALES, "SCALES", {
                    name : "scales",
                    plural : true,
                    defaultColors : ["red", "green", "blue", "purple", "pink", "white", "brown", "silver", "gray", "black"]
                });
        EnumValue.add(Types, CHITIN, "CHITIN", {
                    name : "chitin",
                    defaultColors : ["black", "purple", "green", "yellow"]
                });
        EnumValue.add(Types, FEATHERS, "FEATHERS", {
                    name : "feathers",
                    plural : true,
                    defaultColors : ["red", "green", "blue", "purple", "pink", "white", "brown", "silver", "gray", "black"]
                });
        EnumValue.add(Types, BARK, "BARK", {
                    name : "bark",
                    defaultColors : ["mahogany", "brown", "black"]
                });
        true;
    }

}


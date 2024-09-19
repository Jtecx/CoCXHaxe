package classes.bodyParts;

import classes.internals.EnumValue;

class Beard extends BodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NORMAL", "GOATEE")
	 * - name: human-readable default name, ("normal", "goatee")
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var NORMAL : Int = 0;
    
    public static inline var GOATEE : Int = 1;
    
    public static inline var CLEANCUT : Int = 2;
    
    public static inline var MOUNTAINMAN : Int = 3;
    
    
    public var length : Float = 0;
    public function new()
    {
        super(null, null);
    }
    private static var Beard_static_initializer = {
        EnumValue.add(Types, NORMAL, "NORMAL", {
                    name : "normal"
                });
        EnumValue.add(Types, GOATEE, "GOATEE", {
                    name : "goatee"
                });
        EnumValue.add(Types, CLEANCUT, "CLEANCUT", {
                    name : "clean-cut"
                });
        EnumValue.add(Types, MOUNTAINMAN, "MOUNTAINMAN", {
                    name : "mountain-man"
                });
        true;
    }

}


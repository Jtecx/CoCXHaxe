package classes;

import classes.bodyParts.IOrifice;
import classes.internals.Utils;

class AssClass implements IOrifice
{
    public var host(get, set) : Creature;

    //constructor
    public static inline var WETNESS_DRY : Int = 0;
    public static inline var WETNESS_NORMAL : Int = 1;
    public static inline var WETNESS_MOIST : Int = 2;
    public static inline var WETNESS_SLIMY : Int = 3;
    public static inline var WETNESS_DROOLING : Int = 4;
    public static inline var WETNESS_SLIME_DROOLING : Int = 5;
    
    public static inline var LOOSENESS_VIRGIN : Int = 0;
    public static inline var LOOSENESS_TIGHT : Int = 1;
    public static inline var LOOSENESS_NORMAL : Int = 2;
    public static inline var LOOSENESS_LOOSE : Int = 3;
    public static inline var LOOSENESS_STRETCHED : Int = 4;
    public static inline var LOOSENESS_GAPING : Int = 5;
    
    public function new()
    {
    }
    
    //data
    //butt wetness
    public var analWetness : Float = 0;
    /*butt looseness
		0 - virgin
		1 - normal
		2 - loose
		3 - very loose
		4 - gaping
		5 - monstrous*/
    public var analLooseness : Float = 0;
    //Used to determine thickness of knot relative to normal thickness
    //Used during sex to determine how full it currently is.  For multi-dick sex.
    public var fullness : Float = 0;
    public var virgin : Bool = true;  //Not used at the moment.  
    private var _host : Creature = null;
    private function get_host() : Creature
    {
        return _host;
    }
    private function set_host(value : Creature) : Creature
    {
        _host = value;
        return value;
    }
    public function validate() : String
    {
        var error : String = "";
        error += Utils.validateNonNegativeNumberFields(this, "AssClass.validate", [
                "analWetness", "analLooseness", "fullness"
        ]);
        return error;
    }
}

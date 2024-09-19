package classes;

import classes.bodyParts.IOrifice;
import classes.internals.EnumValue;
import classes.internals.Utils;

class VaginaClass implements IOrifice
{
    public var host(get, set) : Creature;

    
    public static var Types : Array<Dynamic> = [];
    
    public static inline var DEFAULT_CLIT_LENGTH : Float = 0.5;
    
    public static inline var HUMAN : Int = 0;
    
    public static inline var EQUINE : Int = 1;
    
    //dragon	= 2;
    //cat		= 3;
    //			= 4;
    public static inline var BLACK_SAND_TRAP : Int = 5;
    
    public static inline var CAVE_WYRM : Int = 6;
    
    public static inline var VENOM_DRIPPING : Int = 7;
    
    public static inline var MANTICORE : Int = 8;
    
    public static inline var CANCER : Int = 9;
    
    public static inline var DEMONIC : Int = 10;
    
    public static inline var ALRAUNE : Int = 11;
    
    public static inline var SCYLLA : Int = 12;
    
    public static inline var NAGA : Int = 13;
    
    public static inline var MINDBREAKER : Int = 14;
    
    public static inline var SHARK : Int = 15;
    
    public static inline var RAIJU : Int = 16;
    
    public static inline var KIRIN : Int = 17;
    
    public static inline var BEE : Int = 18;
    
    public static inline var ARIGEAN : Int = 19;
    
    
    public static inline var WETNESS_DRY : Int = 0;
    public static inline var WETNESS_NORMAL : Int = 1;
    public static inline var WETNESS_WET : Int = 2;
    public static inline var WETNESS_SLICK : Int = 3;
    public static inline var WETNESS_DROOLING : Int = 4;
    public static inline var WETNESS_SLAVERING : Int = 5;
    
    public static inline var LOOSENESS_TIGHT : Int = 0;
    public static inline var LOOSENESS_NORMAL : Int = 1;
    public static inline var LOOSENESS_LOOSE : Int = 2;
    public static inline var LOOSENESS_GAPING : Int = 3;
    public static inline var LOOSENESS_GAPING_WIDE : Int = 4;
    public static inline var LOOSENESS_LEVEL_CLOWN_CAR : Int = 5;
    
    //constructor
    public function new(vaginalWetness : Float = 1, vaginalLooseness : Float = 0, virgin : Bool = false, clitLength : Float = DEFAULT_CLIT_LENGTH)
    {
        this.virgin = virgin;
        this.vaginalWetness = vaginalWetness;
        this.vaginalLooseness = vaginalLooseness;
        this.clitLength = clitLength;
        this.recoveryProgress = 0;
    }
    //data
    //Vag wetness
    public var vaginalWetness : Float = 1;
    /*Vag looseness
		0 - virgin
		1 - normal
		2 - loose
		3 - very loose
		4 - gaping
		5 - monstrous*/
    public var vaginalLooseness : Float = 0;
    //Type
    //0 - Normal
    //5 - Black bugvag
    public var type : Int = 0;
    public var virgin : Bool = true;
    //Used during sex to determine how full it currently is.  For multi-dick sex.
    public var fullness : Float = 0;
    public var labiaPierced : Float = 0;
    public var labiaPShort : String = "";
    public var labiaPLong : String = "";
    public var clitPierced : Float = 0;
    public var clitPShort : String = "";
    public var clitPLong : String = "";
    public var clitLength : Float;
    public var recoveryProgress : Int;
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
        error += Utils.validateNonNegativeNumberFields(this, "VaginaClass.validate", [
                "vaginalWetness", "vaginalLooseness", "type", 
                "fullness", "labiaPierced", "clitPierced", "clitLength", "recoveryProgress"
        ]);
        if (labiaPierced != 0 && !Math.isNaN(labiaPierced))
        {
            if (labiaPShort == "")
            {
                error += "Labia pierced but labiaPShort = ''. ";
            }
            if (labiaPLong == "")
            {
                error += "Labia pierced but labiaPLong = ''. ";
            }
        }
        else
        {
            if (labiaPShort != "")
            {
                error += "Labia not pierced but labiaPShort = '" + labiaPShort + "'. ";
            }
            if (labiaPLong != "")
            {
                error += "Labia not pierced but labiaPLong = '" + labiaPShort + "'. ";
            }
        }
        if (clitPierced != 0 && !Math.isNaN(clitPierced))
        {
            if (clitPShort == "")
            {
                error += "Clit pierced but labiaPShort = ''. ";
            }
            if (clitPLong == "")
            {
                error += "Clit pierced but labiaPLong = ''. ";
            }
        }
        else
        {
            if (clitPShort != "")
            {
                error += "Clit not pierced but labiaPShort = '" + labiaPShort + "'. ";
            }
            if (clitPLong != "")
            {
                error += "Clit not pierced but labiaPLong = '" + labiaPShort + "'. ";
            }
        }
        return error;
    }
    
    public function wetnessFactor() : Float
    {
        if (vaginalWetness == 0)
        {
            return 1.25;
        }
        if (vaginalWetness == 1)
        {
            return 1;
        }
        if (vaginalWetness == 2)
        {
            return 0.8;
        }
        if (vaginalWetness == 3)
        {
            return 0.7;
        }
        if (vaginalWetness == 4)
        {
            return 0.6;
        }
        if (vaginalWetness == 5)
        {
            return 0.5;
        }
        return 1 + vaginalWetness / 10;
    }
    public function capacity() : Float
    {
        if (vaginalLooseness == 0)
        {
            return 8;
        }
        if (vaginalLooseness == 1)
        {
            return 16;
        }
        if (vaginalLooseness == 2)
        {
            return 24;
        }
        if (vaginalLooseness == 3)
        {
            return 36;
        }
        if (vaginalLooseness == 4)
        {
            return 56;
        }
        if (vaginalLooseness == 5)
        {
            return 100;
        }
        return 10000;
    }
    
    /**
		 * Resets the recovery counter.
		 * The counter is used for looseness recovery over time, a reset usualy occurs when the looseness increases.
		 */
    public function resetRecoveryProgress() : Void
    {
        this.recoveryProgress = 0;
    }
    
    /**
		 * Try to stretch the vagina with the given cock area.
		 *
		 * @param cArea the area of the cock doing the stretching
		 * @param hasFeraMilkingTwat true if the player has the given Perk
		 * @return true if the vagina was stretched
		 */
    public function stretch(cArea : Float, hasFeraMilkingTwat : Bool = false) : Bool
    {
        var stretched : Bool = false;
        if (hasFeraMilkingTwat || vaginalLooseness <= LOOSENESS_NORMAL)
        
        //cArea > capacity = autostreeeeetch.{
            
            if (cArea >= capacity())
            {
                vaginalLooseness++;
                stretched = true;
            }
            //If within top 10% of capacity, 50% stretch
            else if (cArea >= .9 * capacity() && Utils.rand(2) == 0)
            {
                vaginalLooseness++;
                stretched = true;
            }
            //if within 75th to 90th percentile, 25% stretch
            else if (cArea >= .75 * capacity() && Utils.rand(4) == 0)
            {
                vaginalLooseness++;
                stretched = true;
            }
        }
        if (vaginalLooseness > LOOSENESS_LEVEL_CLOWN_CAR)
        {
            vaginalLooseness = LOOSENESS_LEVEL_CLOWN_CAR;
        }
        
        if (virgin)
        {
            virgin = false;
        }
        
        if (stretched)
        {
            trace("CUNT STRETCHED TO " + (vaginalLooseness) + ".");
        }
        
        return stretched;
    }
    private static var VaginaClass_static_initializer = {
        EnumValue.add(Types, HUMAN, "HUMAN", {
                    name : "human"
                });
        EnumValue.add(Types, EQUINE, "EQUINE", {
                    name : "equine"
                });
        EnumValue.add(Types, BLACK_SAND_TRAP, "BLACK_SAND_TRAP", {
                    name : "sand trap"
                });
        EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
                    name : "cave wyrm"
                });
        EnumValue.add(Types, VENOM_DRIPPING, "VENOM_DRIPPING", {
                    name : "venom dripping"
                });
        EnumValue.add(Types, MANTICORE, "MANTICORE", {
                    name : "manticore"
                });
        EnumValue.add(Types, CANCER, "CANCER", {
                    name : "cancer"
                });
        EnumValue.add(Types, DEMONIC, "DEMONIC", {
                    name : "demonic"
                });
        EnumValue.add(Types, ALRAUNE, "ALRAUNE", {
                    name : "alraune"
                });
        EnumValue.add(Types, SCYLLA, "SCYLLA", {
                    name : "scylla"
                });
        EnumValue.add(Types, NAGA, "NAGA", {
                    name : "naga"
                });
        EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
                    name : "mindbreaker"
                });
        EnumValue.add(Types, SHARK, "SHARK", {
                    name : "shark"
                });
        EnumValue.add(Types, RAIJU, "RAIJU", {
                    name : "raiju"
                });
        EnumValue.add(Types, KIRIN, "KIRIN", {
                    name : "kirin"
                });
        EnumValue.add(Types, BEE, "BEE", {
                    name : "bee"
                });
        EnumValue.add(Types, ARIGEAN, "ARIGEAN", {
                    name : "arigean"
                });
        true;
    }

}


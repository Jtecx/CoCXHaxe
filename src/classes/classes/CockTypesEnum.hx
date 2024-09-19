package classes;

import classes.Enum;

class CockTypesEnum extends Enum
{
    public var Group(get, never) : String;
    public var DisplayName(get, never) : String;

    
    
    /* Cock types
		 * 0 - human
		 * 1 - horse
		 * 2 - dog
		 * 3 - demon
		 * 4 - tentacle?
		 * 5 - CAT
		 * 6 - Lizard/Naga?
		 * 7 - ANEMONE!
		 * 8 - ugliest wang ever (kangaroo)
		 * 9 - dragon
		 * 10 - displacer
		 * 11 - Fox
		
		 Group Types used for general description code (eventually)
		 * human  	- obvious
		 * mammal 	- obvious again
		 * super 	- supernatural types
		 * tentacle - only one tentacle!
		 * reptile	- make a guess
		 * seaworld - Anything in the water
		 * other	- doesn't fit anywhere else
		 */
    public static var HUMAN : CockTypesEnum = new CockTypesEnum("human", "human");
    public static var HORSE : CockTypesEnum = new CockTypesEnum("horse", "mammal");
    public static var KIRIN : CockTypesEnum = new CockTypesEnum("kirin", "mammal");
    public static var DOG : CockTypesEnum = new CockTypesEnum("dog", "mammal");
    public static var DEMON : CockTypesEnum = new CockTypesEnum("demon", "super");
    public static var TENTACLE : CockTypesEnum = new CockTypesEnum("tentacle", "tentacle");
    public static var SCYLLATENTACLE : CockTypesEnum = new CockTypesEnum("scylla tentacle", "tentacle");
    public static var CAT : CockTypesEnum = new CockTypesEnum("cat", "mammal");
    public static var CANCER : CockTypesEnum = new CockTypesEnum("cancer", "foaming human");
    public static var LIZARD : CockTypesEnum = new CockTypesEnum("lizard", "reptile");
    public static var CAVE_WYRM : CockTypesEnum = new CockTypesEnum("cave wyrm", "reptile");
    public static var ANEMONE : CockTypesEnum = new CockTypesEnum("anemone", "seaworld");
    public static var KANGAROO : CockTypesEnum = new CockTypesEnum("kangaroo", "mammal");
    public static var DRAGON : CockTypesEnum = new CockTypesEnum("dragon", "reptile");
    public static var DISPLACER : CockTypesEnum = new CockTypesEnum("displacer", "other");
    public static var FOX : CockTypesEnum = new CockTypesEnum("fox", "mammal");
    public static var BEE : CockTypesEnum = new CockTypesEnum("bee", "insect");
    public static var PIG : CockTypesEnum = new CockTypesEnum("pig", "mammal");
    public static var AVIAN : CockTypesEnum = new CockTypesEnum("avian", "avian");
    public static var RHINO : CockTypesEnum = new CockTypesEnum("rhino", "mammal");
    public static var ECHIDNA : CockTypesEnum = new CockTypesEnum("echidna", "mammal");
    public static var WOLF : CockTypesEnum = new CockTypesEnum("wolf", "mammal");
    public static var STAMEN : CockTypesEnum = new CockTypesEnum("stamen", "plant");
    public static var RED_PANDA : CockTypesEnum = new CockTypesEnum("red panda", "mammal");
    public static var GRYPHON : CockTypesEnum = new CockTypesEnum("gryphon", "avian");
    public static var OOMUKADE : CockTypesEnum = new CockTypesEnum("oomukade", "venomous");
    public static var MINDBREAKER : CockTypesEnum = new CockTypesEnum("mindbreaker", "eldritch");
    public static var RAIJU : CockTypesEnum = new CockTypesEnum("raiju", "mammal");
    public static var USHI_ONI : CockTypesEnum = new CockTypesEnum("ushi-oni", "other");
    public static var INSECT : CockTypesEnum = new CockTypesEnum("insect", "insect");
    public static var ARIGEAN : CockTypesEnum = new CockTypesEnum("arigean", "");
    public static var UNDEFINED : CockTypesEnum = new CockTypesEnum("undefined", "");
    
    private function new(
            i_displayName : String = "",
            i_group : String = "")
    {
        super();
        _displayName = i_displayName;
        _group = i_group;
    }
    private var _group : String;
    private var _displayName : String;
    
    private function get_Group() : String
    {
        return _group;
    }
    private function get_DisplayName() : String
    {
        return _displayName;
    }
    
    public static function ParseConstant(i_constantName : String, i_caseSensitive : Bool = false) : CockTypesEnum
    {
        return cast((Enum.ParseConstant(CockTypesEnum, i_constantName, i_caseSensitive)), CockTypesEnum);
    }
    
    public static function ParseConstantByIndex(i_constantIndex : Int = 0) : CockTypesEnum
    {
        return cast((Enum.ParseConstantByIndex(CockTypesEnum, i_constantIndex)), CockTypesEnum);
    }
    private static var CockTypesEnum_static_initializer = {
        {initEnum(CockTypesEnum);
        };
        true;
    }

}


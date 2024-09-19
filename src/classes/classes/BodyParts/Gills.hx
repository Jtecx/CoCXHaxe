package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;

class Gills extends BodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "ANEMONE")
	 * - name: human-readable default name, ("non-existant", "anemone")
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var NONE : Int = 0;
    
    public static inline var ANEMONE : Int = 1;
    
    public static inline var FISH : Int = 2;
    
    public static inline var GILLS_IN_TENTACLE_LEGS : Int = 3;
    
    
    public function new(creature : Creature)
    {
        super(creature, null);
    }
    
    public static function getAppearanceDescription(creature : Dynamic) : String
    {
        var id : Int = creature.gills.type;
        
        return formatDescription(((Types[id].appearanceDescFunc) ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
    }
    
    private static function formatDescription(desc : String, creature : Dynamic) : String
    {
        var upperCasePattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('^.', "");
        
        return upperCasePattern.replace(desc, function(__DOLLAR__0 : Dynamic) : Dynamic
                {
                    return __DOLLAR__0.toUpperCase();
                });
    }
    private static var Gills_static_initializer = {
        EnumValue.add(Types, NONE, "NONE", {
                    name : "non-existant",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, ANEMONE, "ANEMONE", {
                    name : "anemone",
                    appearanceDesc : "A pair of feathery gills are growing out just below your neck, spreading out horizontally and draping down your chest. They allow you to stay in the water for quite a long time."
                });
        EnumValue.add(Types, FISH, "FISH", {
                    name : "fish",
                    appearanceDesc : "A set of fish like gills reside on your neck, several small slits that can close flat against your skin. They allow you to stay in the water for quite a long time."
                });
        EnumValue.add(Types, GILLS_IN_TENTACLE_LEGS, "GILLS_IN_TENTACLE_LEGS", {
                    name : "placed in tentacle legs",
                    appearanceDesc : ""
                });
        true;
    }

}


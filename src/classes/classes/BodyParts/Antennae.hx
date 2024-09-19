package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;

class Antennae extends BodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "MANTIS")
	 * - name: human-readable name, ("non-existant", "mantis")
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var NONE : Int = 0;
    
    public static inline var MANTIS : Int = 1;
    
    public static inline var BEE : Int = 2;
    
    public static inline var COCKATRICE : Int = 3;
    
    public static inline var FIRE_SNAIL : Int = 4;
    
    public static inline var MOTH : Int = 5;
    
    public static inline var CENTIPEDE : Int = 6;
    
    public static inline var SEA_DRAGON : Int = 7;
    
    public static inline var JABBERWOCKY : Int = 8;
    
    public static inline var ANT : Int = 9;
    
    
    public function new(creature : Creature)
    {
        super(creature, null);
    }
    
    public static function getAppearanceDescription(creature : Dynamic) : String
    {
        var id : Int = creature.antennae.type;
        
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
    private static var Antennae_static_initializer = {
        EnumValue.add(Types, NONE, "NONE", {
                    name : "non-existant",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, MANTIS, "MANTIS", {
                    name : "mantis",
                    appearanceDesc : "You have long prehensile mantis antennae on your head, bouncing and swaying in the breeze."
                });
        EnumValue.add(Types, BEE, "BEE", {
                    name : "bee",
                    appearanceDesc : "You have floppy bee antennae on your head, bouncing and swaying in the breeze."
                });
        EnumValue.add(Types, COCKATRICE, "COCKATRICE", {
                    name : "cockatrice",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {
                    name : "fire snail",
                    appearanceDesc : "Two horn like antennae grow from your head, feeling the air around and feeding you sensory information."
                });
        EnumValue.add(Types, MOTH, "MOTH", {
                    name : "moth",
                    appearanceDesc : "Floppy moth antennae grow from your head, bouncing and swaying in the breeze."
                });
        EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {
                    name : "centipede",
                    appearanceDesc : "A pair of long antennae have grown on your head, occasionally curling and twitching at the slightest of movements."
                });
        EnumValue.add(Types, SEA_DRAGON, "SEA_DRAGON", {
                    name : "sea dragon",
                    appearanceDesc : "By the sides of your head are four bioluminescent strands that run down your neck, beautifully lighting up your front and giving you an air of mystique."
                });
        EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {
                    name : "jabberwocky",
                    appearanceDesc : "By the sides of your head are two long strands not unlike tentacles that run down your neck enhancing your senses."
                });
        EnumValue.add(Types, ANT, "ANT", {
                    name : "ant",
                    appearanceDesc : "You have long, stiff-yet-prehensile ant antennae on your head, able to feel things just as your fingers do."
                });
        true;
    }

}


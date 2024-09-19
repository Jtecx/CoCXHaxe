package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;

class Tongue extends BodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "SNAKE")
	 * - name: human-readable default name, ("human", "snake")
	 *
	 * - appearanceDesc: description for PlayerAppearance.as (always visible)
	 * - appearanceDescFunc: a function that returns a description for PlayerAppearance.as (appearanceDesc is ignored if this exists)
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var HUMAN : Int = 0;
    
    public static inline var SNAKE : Int = 1;
    
    public static inline var DEMONIC : Int = 2;
    
    public static inline var DRACONIC : Int = 3;
    
    public static inline var ECHIDNA : Int = 4;
    
    public static inline var CAT : Int = 5;
    
    public static inline var ELF : Int = 6;
    
    public static inline var DOG : Int = 7;
    
    public static inline var CAVE_WYRM : Int = 8;
    
    public static inline var GHOST : Int = 9;
    
    public static inline var MELKIE : Int = 10;
    
    public static inline var RATATOSKR : Int = 11;
    
    public static inline var RAVENOUS_TONGUE : Int = 12;
    
    public static inline var MINDBREAKER : Int = 13;
    
    public static inline var MINDBREAKERMALE : Int = 14;
    
    public static inline var BEE : Int = 15;
    
    public static inline var IMPISH : Int = 16;
    
    public static inline var ARIGEAN : Int = 17;
    
    
    public function new(creature : Creature)
    {
        super(creature, null);
    }
    
    public static function getAppearanceDescription(creature : Dynamic) : String
    {
        var id : Int = creature.tongue.type;
        
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
    private static var Tongue_static_initializer = {
        EnumValue.add(Types, HUMAN, "HUMAN", {
                    name : "human",
                    appearanceDesc : "You have a completely normal tongue, unlike a good number of Mareth's denizens."
                });
        EnumValue.add(Types, SNAKE, "SNAKE", {
                    name : "snake",
                    appearanceDesc : "A snake-like tongue occasionally flits between your lips, tasting the air."
                });
        EnumValue.add(Types, DEMONIC, "DEMONIC", {
                    name : "demonic",
                    appearanceDesc : "A slowly undulating tongue occasionally slips from between your lips. It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal."
                });
        EnumValue.add(Types, DRACONIC, "DRACONIC", {
                    name : "draconic",
                    appearanceDesc : "Your mouth contains a thick, fleshy tongue that, if you so desire, can telescope to a distance of about four feet. It has sufficient manual dexterity that you can use it almost like a third arm."
                });
        EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
                    name : "echidna",
                    appearanceDesc : "A thin echidna tongue, at least a foot long, occasionally flits out from between your lips."
                });
        EnumValue.add(Types, CAT, "CAT", {
                    name : "cat",
                    appearanceDesc : "Your tongue is rough like that of a cat. You sometimes groom yourself with it."
                });
        EnumValue.add(Types, ELF, "ELF", {
                    name : "elf",
                    appearanceDesc : "Your voice is unnaturally beautiful and melodious."
                });
        EnumValue.add(Types, DOG, "DOG", {
                    name : "dog",
                    appearanceDesc : "You sometime let your canine tongue out to vent heat."
                });
        EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
                    name : "draconic",
                    appearanceDesc : "A slowly undulating neon blue tongue that glow in the dark occasionally slips from between your lips. It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal."
                });
        EnumValue.add(Types, GHOST, "GHOST", {
                    name : "ghost",
                    appearanceDesc : "Occasionally a long transparent tongue slicks out of your mouth, stretching out about a foot in length."
                });
        EnumValue.add(Types, MELKIE, "MELKIE", {
                    name : "melkie",
                    appearanceDesc : "Your voice is unnaturally beautiful and melodious; your mermaid-like song is capable of captivating the minds of those who listens to it."
                });
        EnumValue.add(Types, RATATOSKR, "RATATOSKR", {
                    name : "ratatoskr",
                    appearanceDesc : "Your tongue is human in appearance but way more dexterous at handling words, able to form sentences and words so good it becomes art or so bad that it bleeds the ears and drives who hear them insane."
                });
        EnumValue.add(Types, RAVENOUS_TONGUE, "RAVENOUS_TONGUE", {
                    name : "ravenous",
                    appearanceDesc : "You constantly hunger for food and your ravenous tongue has gained some unnatural skills of its own, always ready to coax a penis or a pussy into cumming."
                });
        EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
                    name : "mindbreaker",
                    appearanceDesc : "In your mouth hides a long tentacle-like tongue ready to probe the mouth of others."
                });
        EnumValue.add(Types, MINDBREAKERMALE, "MINDBREAKERMALE", {
                    name : "mindbreaker male",
                    appearanceDesc : "Over your mouth are several tentacles, but underneath that is your long tentacle-like tongue, ready to probe the mouth of others."
                });
        EnumValue.add(Types, BEE, "BEE", {
                    name : "bee",
                    appearanceDesc : "Your long black proboscis-like tongue allows you to lick just anything clean."
                });
        EnumValue.add(Types, IMPISH, "IMPISH", {
                    name : "impish",
                    appearanceDesc : "Your voice is far higher pitched than your old human one possibly because it's fit to a small imp body."
                });
        EnumValue.add(Types, ARIGEAN, "ARIGEAN", {
                    name : "arigean",
                    appearanceDesc : "Your tongue is identical to that of a human’s save for it’s light blue color, most likely caused by your blue blood."
                });
        true;
    }

}


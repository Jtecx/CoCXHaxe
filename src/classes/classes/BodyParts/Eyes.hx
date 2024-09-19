package classes.bodyParts;

import classes.Creature;
import classes.PerkLib;
import classes.internals.EnumValue;

class Eyes extends BodyPart
{
    public var noun(get, never) : String;

    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "SPIDER")
	 * - name: human-readable default name, ("human", "4 spider")
	 *
	 * NOTE: ALWAYS MENTION EYECOLOR IN DESCRIPTIONS, IT'S NOT DESCRIBED ANYWHERE ELSE
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var HUMAN : Int = 0;
    
    public static inline var SPIDER : Int = 1;
    
    public static inline var BLACK_EYES_SAND_TRAP : Int = 2;
    
    public static inline var CAT : Int = 3;
    
    public static inline var GORGON : Int = 4;
    
    public static inline var FENRIR : Int = 5;
    
    public static inline var MANTICORE : Int = 6;
    
    public static inline var FOX : Int = 7;
    
    public static inline var LIZARD : Int = 8;
    
    public static inline var SNAKE : Int = 9;
    
    public static inline var DRACONIC : Int = 10;
    
    public static inline var DEVIL : Int = 11;
    
    public static inline var ONI : Int = 12;
    
    public static inline var ELF : Int = 13;
    
    public static inline var RAIJU : Int = 14;  //button 0 on 2nd page of metamorph  
    
    public static inline var VAMPIRE : Int = 15;
    
    public static inline var GEMSTONES : Int = 16;
    
    public static inline var FERAL : Int = 17;
    
    public static inline var GRYPHON : Int = 18;
    
    public static inline var INFERNAL : Int = 19;
    
    public static inline var ORC : Int = 20;
    
    public static inline var CAVE_WYRM : Int = 21;
    
    public static inline var HINEZUMI : Int = 22;
    
    public static inline var BEAR : Int = 23;
    
    public static inline var DISPLACER : Int = 24;
    
    public static inline var FIRE_SNAIL : Int = 25;
    
    public static inline var GHOST : Int = 26;
    
    public static inline var JIANGSHI : Int = 27;
    
    public static inline var GOAT : Int = 28;  //button 0 on 3rd page of metamorph  
    
    public static inline var CENTIPEDE : Int = 29;
    
    public static inline var KRAKEN : Int = 30;
    
    public static inline var FROSTWYRM : Int = 31;
    
    public static inline var CANCER : Int = 32;
    
    public static inline var FAIRY : Int = 33;
    
    public static inline var GREMLIN : Int = 34;
    
    public static inline var WEASEL : Int = 35;
    
    public static inline var MONOEYE : Int = 36;
    
    public static inline var RATATOSKR : Int = 37;
    
    public static inline var FIENDISH : Int = 38;
    
    public static inline var DEAD : Int = 39;
    
    public static inline var MINDBREAKER : Int = 40;
    
    public static inline var MINDBREAKERMALE : Int = 41;
    
    public static inline var SNAKEFIENDISH : Int = 42;
    
    public static inline var WERESPIDER : Int = 43;
    
    public static inline var ARIGEAN : Int = 44;
    
    public static inline var ARIGEANPRINCESS : Int = 45;
    
    public static inline var DEMON : Int = 46;
    
    public static inline var MOTH : Int = 47;
    
    
    public var count : Int;
    public var colour : String = "brown";
    public function new(creature : Creature)
    {
        super(creature, null);
    }
    private function get_noun() : String
    {
        return (type == MONOEYE) ? "eye" : "eyes";
    }
    
    public static function getAppearanceDescription(creature : Dynamic) : String
    {
        var id : Int = creature.eyes.type;
        
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
    private static var Eyes_static_initializer = {
        EnumValue.add(Types, HUMAN, "HUMAN", {
                    name : "human",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, SPIDER, "SPIDER", {
                    name : "six spider",
                    appearanceDesc : "In addition to your primary two [eyecolor] eyes, you have a second, smaller pair on your forehead.",
                    Darkvision : true
                });
        EnumValue.add(Types, BLACK_EYES_SAND_TRAP, "BLACK_EYES_SAND_TRAP", {
                    name : "sandtrap",
                    appearanceDesc : "Your eyes are solid spheres of inky, alien darkness."
                });
        EnumValue.add(Types, CAT, "CAT", {
                    name : "cat",
                    appearanceDesc : "Your [eyecolor] eyes have vertically slit like those of cat.",
                    Darkvision : true
                });
        EnumValue.add(Types, GORGON, "GORGON", {
                    name : "gorgon",
                    appearanceDesc : "Your [eyecolor] eyes are similar to those of snake-like gorgons with ability to temporally petrify.",
                    Darkvision : true
                });
        EnumValue.add(Types, FENRIR, "FENRIR", {
                    name : "fenrir",
                    appearanceDesc : "Your [eyecolor] eyes glow with a freezing blue light, and wisps of icy mist drift from them.",
                    Darkvision : true
                });
        EnumValue.add(Types, MANTICORE, "MANTICORE", {
                    name : "manticore",
                    appearanceDesc : "Your eyes are similar to those of a cat, with slit pupils. However, their [eyecolor] iris dismiss any links to the regular felines in favor of something way more ominous.",
                    Darkvision : true
                });
        EnumValue.add(Types, FOX, "FOX", {
                    name : "fox",
                    appearanceDesc : "Your [eyecolor] eyes look like those of a fox with a slit in the middle."
                });
        EnumValue.add(Types, LIZARD, "LIZARD", {
                    name : "lizard",
                    appearanceDesc : "Your eyes looks like those of a reptile with [eyecolor] irises and a slit."
                });
        EnumValue.add(Types, SNAKE, "SNAKE", {
                    name : "snake",
                    appearanceDesc : "Your [eyecolor] eyes have slitted pupils like that of a snake."
                });
        EnumValue.add(Types, DRACONIC, "DRACONIC", {
                    name : "draconic",
                    appearanceDesc : "Your [eyecolor] eyes have slitted pupils like that of a dragon.",
                    Darkvision : true
                });
        EnumValue.add(Types, DEVIL, "DEVIL", {
                    name : "devil",
                    appearanceDesc : "Your eyes look fiendish, with their black sclera and glowing [eyecolor] iris.",
                    Darkvision : true
                });
        EnumValue.add(Types, ONI, "ONI", {
                    name : "oni",
                    appearanceDesc : "Your eyes look normal enough save for their fiendish [eyecolor] iris and slitted pupils."
                });
        EnumValue.add(Types, ELF, "ELF", {
                    name : "elf",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        desc += " Your [eyecolor] elven eyes looks somewhat human, save for their cat-like vertical slit which draws light right in, allowing you to see with perfect precision both at day and night time.";
                        
                        if (creature.hasPerk(PerkLib.BlessingOfTheAncestorTree))
                        {
                            desc += " Despite their otherwordly beauty, the misty hollow at the center of your eyes denounce the absence of a soul, which now resides with the forest.";
                        }
                        
                        return desc;
                    },
                    Darkvision : true
                });
        EnumValue.add(Types, RAIJU, "RAIJU", {
                    name : "raiju",
                    appearanceDesc : "Your eyes are of an electric [eyecolor] hue that constantly glows with voltage power. They have slitted pupils like those of a beast."
                });
        EnumValue.add(Types, VAMPIRE, "VAMPIRE", {
                    name : "vampire",
                    appearanceDesc : "Your eyes looks somewhat normal, but their [eyecolor] irises seem to have the tendency of drawing in people’s gaze, like moths to a flame.",
                    Darkvision : true
                });
        EnumValue.add(Types, GEMSTONES, "GEMSTONES", {
                    name : "gemstone",
                    appearanceDesc : "Instead of regular eyes you see through a pair of gemstones that change hue based on your mood.",
                    Darkvision : true
                });
        EnumValue.add(Types, FERAL, "FERAL", {
                    name : "feral",
                    appearanceDesc : "In your [eyecolor] eyes, sometimes a green light is visibly dancing. Hinting at the beast within. It encompasses your entire pupil when you let it loose.",
                    Darkvision : true
                });
        EnumValue.add(Types, GRYPHON, "GRYPHON", {
                    name : "gryphon",
                    appearanceDesc : "Your gifted eyes have a bird-like appearance, having an [eyecolor] sclera and a large, black iris. A thin ring of black separates your sclera from your outer iris."
                });
        EnumValue.add(Types, INFERNAL, "INFERNAL", {
                    name : "infernal",
                    appearanceDesc : "Your eyes look fiendish, with their black sclera and glowing [eyecolor] iris. What's more, a small trail of fire blazes on the corners making them all the more intimidating.",
                    Darkvision : true
                });
        EnumValue.add(Types, ORC, "ORC", {
                    name : "orc",
                    appearanceDesc : "Your [eyecolor], slanted eyes have slitted pupils. They usually seem to gleam with a sort of malice, avarice, or lechery, giving off beady-eyed vibe."
                });
        EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
                    name : "cave wyrm",
                    appearanceDesc : "Dark blue iris with [eyecolor] eyes pupil that glow in the dark.",
                    Darkvision : true
                });
        EnumValue.add(Types, HINEZUMI, "HINEZUMI", {
                    name : "hinezumi",
                    appearanceDesc : "Your eyes are human-like. However, their [eyecolor] irises are clearly those of an Hinezumi."
                });
        EnumValue.add(Types, BEAR, "BEAR", {
                    name : "bear",
                    appearanceDesc : "Your eyes are human save for your [eyecolor] pupils closer to those of a bear."
                });
        EnumValue.add(Types, DISPLACER, "DISPLACER", {
                    name : "displacer",
                    appearanceDesc : "Your eyes are similar to those of a cat, with slit pupils. However, their black sclera dismiss any links to the regular felines clearly identifying you to something else.",
                    Darkvision : true
                });
        EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {
                    name : "fire snail",
                    appearanceDesc : "Your eyes are normal save for your [eyecolor] iris which glows like smoldering embers."
                });
        EnumValue.add(Types, GHOST, "GHOST", {
                    name : "ghost",
                    appearanceDesc : "Your eyes glow [eyecolor] with a ghostly aura. You can see clearly in the shadows and might terrify anyone wandering around alone at night.",
                    Darkvision : true
                });
        EnumValue.add(Types, JIANGSHI, "JIANGSHI", {
                    name : "jiangshi",
                    appearanceDesc : "Your [eyecolor] eyes, while humans are vacant and devoid of the warmth of life.",
                    Darkvision : true
                });
        EnumValue.add(Types, GOAT, "GOAT", {
                    name : "goat",
                    appearanceDesc : "Your eyes are like those of a goat with horizontal slit pupils at the center of their [eyecolor] iris."
                });
        EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {
                    name : "centipede",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, KRAKEN, "KRAKEN", {
                    name : "kraken",
                    appearanceDesc : "Your eyes are like those of a octopus with horizontal slit pupils at the center of their [eyecolor] iris.",
                    Darkvision : true
                });
        EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
                    name : "frost wyrm",
                    appearanceDesc : "Your [eyecolor] eyes have slitted pupils and dark sclera like those of a frost wyrm.",
                    Darkvision : true
                });
        EnumValue.add(Types, CANCER, "CANCER", {
                    name : "cancer",
                    appearanceDesc : "Your eyes look human at first glance, save for their natural [eyecolor] irises covered by a completely transparent layer of protective tissue to protect them against things such as salt and sand in the water."
                });
        EnumValue.add(Types, FAIRY, "FAIRY", {
                    name : "fairy",
                    appearanceDesc : "Your beautiful [eyecolor] eyes sparkle with the eternal hope and child-like innocence of fairykind."
                });
        EnumValue.add(Types, GREMLIN, "GREMLIN", {
                    name : "gremlin",
                    appearanceDesc : "Your [eyecolor] eyes looks human enough though your eyelids are dark as if very tired or more likely by traces of demonic corruption."
                });
        EnumValue.add(Types, WEASEL, "WEASEL", {
                    name : "weasel",
                    appearanceDesc : "Your [eyecolor] eyes have slitted pupils like those of a weasel."
                });
        EnumValue.add(Types, MONOEYE, "MONOEYE", {
                    name : "monoeye",
                    appearanceDesc : "Your eye sockets have merged together to reform into a single cyclopean eye charged with powerful magical powers. Your almighty gaze is as peerless as its unsettling.",
                    Darkvision : true
                });
        EnumValue.add(Types, RATATOSKR, "RATATOSKR", {
                    name : "ratatoskr",
                    appearanceDesc : "Your [eyecolor] eyes have slitted pupils like those of a Ratatoskr. Your know it all smug expression plastered in them at all time upsets quite a few."
                });
        EnumValue.add(Types, FIENDISH, "FIENDISH", {
                    name : "fiendish",
                    appearanceDesc : "Your [eyecolor] eyes looks like those of a fiend with a slit in the middle.",
                    Darkvision : true
                });
        EnumValue.add(Types, DEAD, "DEAD", {
                    name : "dead",
                    appearanceDesc : "Your eyes look dead, but the pupils glow in the dark with a [eyecolor].",
                    Darkvision : true
                });
        EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
                    name : "eldritch",
                    appearanceDesc : "In your hair nests many [eyecolor] eyes, granting you a nearly full peripheral vision. The biggest eye rests on your forehead. It is from this eye that you use your formidable mental powers.",
                    Darkvision : true
                });
        EnumValue.add(Types, MINDBREAKERMALE, "MINDBREAKERMALE", {
                    name : "eldritch male",
                    appearanceDesc : "You have three two [eyecolor], predatory eyes at the front of your head, giving you full sight and perfect perception of what’s in front of you. The eye along your forehead is considerably larger, it is where you channel your formidable mental powers.",
                    Darkvision : true
                });
        EnumValue.add(Types, SNAKEFIENDISH, "SNAKEFIENDISH", {
                    name : "fiendish snake",
                    appearanceDesc : "Your [eyecolor] eyes have slitted pupils like that of a snake with black schlera wich betray your corrupted nature."
                });
        EnumValue.add(Types, WERESPIDER, "WERESPIDER", {
                    name : "werespider",
                    appearanceDesc : "In addition to your primary two [eyecolor] eyes, you have a second, smaller pair on your forehead. In your eyes, sometimes a green light is visibly dancing. Hinting at the beast within. It encompasses your entire pupil when you let it loose.",
                    Darkvision : true
                });
        EnumValue.add(Types, ARIGEAN, "ARIGEAN", {
                    name : "arigean",
                    appearanceDesc : "Your milky white eyes give off an alien [eyecolor] glow on the iris."
                });
        EnumValue.add(Types, ARIGEANPRINCESS, "ARIGEANPRINCESS", {
                    name : "arigean princess",
                    appearanceDesc : "Your milky white eyes have a slit down the middle resembling that of a cat, the iris gives off a rich, blue, alien glow."
                });
        EnumValue.add(Types, DEMON, "DEMON", {
                    name : "demon",
                    appearanceDesc : "Your [eyecolor] demonic eyes look somewhat human, save for their cat-like vertical slit which draws light right in, though the real bonus is your ability to see just about anything in a lewd way.",
                    Darkvision : true
                });
        EnumValue.add(Types, MOTH, "MOTH", {
                    name : "moth",
                    appearanceDesc : "Your eyes are like a moth’s eyes",
                    Darkvision : true
                });
        true;
    }

}


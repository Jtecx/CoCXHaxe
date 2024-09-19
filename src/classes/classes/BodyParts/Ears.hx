package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;
import classes.EngineCore;

class Ears extends BodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 10)
	 * - id: name of the constant ("HUMAN", "HORSE")
	 * - name: human-readable name, ("human", "horse")
	 *
	 * - hairy: has hair material
	 * - fur: has fur material
	 * - feathers: has feathers material
	 * - scales: has scales material
	 * - chitin: has chitin material
	 * */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var HUMAN : Int = 0;
    
    public static inline var HORSE : Int = 1;
    
    public static inline var DOG : Int = 2;
    
    public static inline var COW : Int = 3;
    
    public static inline var ELFIN : Int = 4;
    
    public static inline var CAT : Int = 5;
    
    public static inline var LIZARD : Int = 6;
    
    public static inline var BUNNY : Int = 7;
    
    public static inline var KANGAROO : Int = 8;
    
    public static inline var FOX : Int = 9;
    
    public static inline var DRAGON : Int = 10;
    
    public static inline var RACCOON : Int = 11;
    
    public static inline var MOUSE : Int = 12;
    
    public static inline var FERRET : Int = 13;
    
    public static inline var PIG : Int = 14;
    
    public static inline var RHINO : Int = 15;
    
    public static inline var ECHIDNA : Int = 16;
    
    public static inline var DEER : Int = 17;
    
    public static inline var WOLF : Int = 18;
    
    public static inline var LION : Int = 19;
    
    public static inline var YETI : Int = 20;
    
    public static inline var ORCA : Int = 21;
    
    public static inline var ORCA2 : Int = 22;
    
    public static inline var SNAKE : Int = 23;
    
    public static inline var GOAT : Int = 24;
    
    public static inline var ONI : Int = 25;
    
    public static inline var ELVEN : Int = 26;
    
    public static inline var RAIJU : Int = 27;
    
    public static inline var BAT : Int = 28;
    
    public static inline var VAMPIRE : Int = 29;
    
    public static inline var RED_PANDA : Int = 30;
    
    public static inline var AVIAN : Int = 31;
    
    public static inline var GRYPHON : Int = 32;
    
    public static inline var CAVE_WYRM : Int = 33;
    
    public static inline var BEAR : Int = 34;
    
    public static inline var PANDA : Int = 35;
    
    public static inline var SHARK : Int = 36;
    
    public static inline var DISPLACER : Int = 37;
    
    public static inline var MELKIE : Int = 38;
    
    public static inline var GREMLIN : Int = 39;
    
    public static inline var WEASEL : Int = 40;
    
    public static inline var SQUIRREL : Int = 41;
    
    public static inline var INSECT : Int = 42;
    
    public static inline var KIRIN : Int = 43;
    
    public static inline var BIG : Int = 44;
    
    public static inline var FENNEC_FOX : Int = 45;
    
    public static inline var JACKAL : Int = 46;
    
    public static inline var TROLL : Int = 47;
    
    public static inline var GLACIAL_TROLL : Int = 48;
    
    
    public static var HoleEars : Array<Dynamic> = [LIZARD, DRAGON, ORCA2, AVIAN, INSECT];
    
    public function new(creature : Creature)
    {
        super(creature, null);
    }
    
    override public function hasMaterial(type : Int) : Bool
    {
        switch (type)
        {
            case BodyMaterial.SKIN:
                return true;
            case BodyMaterial.HAIR:
                return Types[this.type].hairy;
            case BodyMaterial.FUR:
                return Types[this.type].fur;
            case BodyMaterial.SCALES:
                return Types[this.type].scales;
            case BodyMaterial.CHITIN:
                return Types[this.type].chitin;
            case BodyMaterial.FEATHERS:
                return Types[this.type].feathers;
            default:
                return false;
        }
    }
    
    public static function getAppearanceDescription(creature : Dynamic) : String
    {
        var id : Int = creature.ears.type;
        
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
    private static var Ears_static_initializer = {
        EnumValue.add(Types, HUMAN, "HUMAN", {
                    name : "human",
                    appearanceDesc : "A pair of normal human ears stick out from the sides of your head."
                });
        EnumValue.add(Types, HORSE, "HORSE", {
                    name : "horse",
                    appearanceDesc : "A pair of horse-like ears rise up from the top of your head.",
                    fur : true
                });
        EnumValue.add(Types, DOG, "DOG", {
                    name : "dog",
                    appearanceDesc : "A pair of dog ears protrude from your head, flopping down adorably.",
                    fur : true
                });
        EnumValue.add(Types, COW, "COW", {
                    name : "cow",
                    appearanceDesc : "A pair of round, [fur color] floppy cow ears protrude from the sides of your head.",
                    fur : true
                });
        EnumValue.add(Types, ELFIN, "ELFIN", {
                    name : "elfin",
                    appearanceDesc : "A pair of large pointy ears stick out from your head."
                });
        EnumValue.add(Types, CAT, "CAT", {
                    name : "cat",
                    appearanceDesc : "A pair of cute, fuzzy cat ears have sprouted from the top of your head.",
                    fur : true
                });
        EnumValue.add(Types, LIZARD, "LIZARD", {
                    name : "lizard",
                    appearanceDesc : "A pair of rounded protrusions with small holes on the sides of your head serve as your ears."
                });
        EnumValue.add(Types, BUNNY, "BUNNY", {
                    name : "bunny",
                    appearanceDesc : "A pair of floppy rabbit ears stick up from the top of your head, flopping around as you walk.",
                    fur : true
                });
        EnumValue.add(Types, KANGAROO, "KANGAROO", {
                    name : "kangaroo",
                    appearanceDesc : "",
                    fur : true
                });
        EnumValue.add(Types, FOX, "FOX", {
                    name : "fox",
                    appearanceDesc : "A pair of large, adept fox ears sit high on your head, always listening.",
                    fur : true
                });
        EnumValue.add(Types, DRAGON, "DRAGON", {
                    name : "dragon",
                    appearanceDesc : "A pair of rounded protrusions with small holes on the sides of your head serve as your ears. Bony fins sprout behind them.",
                    scales : true
                });
        EnumValue.add(Types, RACCOON, "RACCOON", {
                    name : "raccoon",
                    appearanceDesc : "A pair of vaguely egg-shaped, furry raccoon ears adorns your head.",
                    fur : true
                });
        EnumValue.add(Types, MOUSE, "MOUSE", {
                    name : "mouse",
                    appearanceDesc : "A pair of large, dish-shaped mouse ears tops your head.",
                    fur : true
                });
        EnumValue.add(Types, FERRET, "FERRET", {
                    name : "ferret",
                    appearanceDesc : "A pair of small, rounded ferret ears sit on top of your head.",
                    fur : true
                });
        EnumValue.add(Types, PIG, "PIG", {
                    name : "pig",
                    appearanceDesc : "A pair of pointy, floppy pig ears have sprouted from the top of your head."
                });
        EnumValue.add(Types, RHINO, "RHINO", {
                    name : "rhino",
                    appearanceDesc : "A pair of open tubular rhino ears protrude from your head."
                });
        EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
                    name : "echidna",
                    appearanceDesc : "A pair of small rounded openings appear on your head that are your ears."
                });
        EnumValue.add(Types, DEER, "DEER", {
                    name : "deer",
                    appearanceDesc : "A pair of deer-like ears rise up from the top of your head.",
                    fur : true
                });
        EnumValue.add(Types, WOLF, "WOLF", {
                    name : "wolf",
                    appearanceDesc : "A pair of pointed wolf ears rise up from the top of your head.",
                    fur : true
                });
        EnumValue.add(Types, LION, "LION", {
                    name : "lion",
                    appearanceDesc : "A pair of lion ears have sprouted from the top of your head.",
                    fur : true
                });
        EnumValue.add(Types, YETI, "YETI", {
                    name : "yeti",
                    appearanceDesc : "A pair of yeti ears, bigger than your old human ones have sprouted from the top of your head."
                });
        EnumValue.add(Types, ORCA, "ORCA", {
                    name : "orca",
                    appearanceDesc : "A pair of very large fin at least twice as large as your head which help you orient yourself underwater have sprouted from the top of your head. Their underside is [skin color2] while the top is [skin color1]."
                });
        EnumValue.add(Types, ORCA2, "ORCA2", {
                    name : "orca",
                    appearanceDesc : "A pair of rounded protrusions with small holes on the sides of your head serve as your ears."
                });
        EnumValue.add(Types, SNAKE, "SNAKE", {
                    name : "snake",
                    appearanceDesc : "A pair of large pointy ears covered in small scales stick out from your head.",
                    scales : true
                });
        EnumValue.add(Types, GOAT, "GOAT", {
                    name : "goat",
                    appearanceDesc : "A long pair of goat-like ears stick out from your head, flapping from time to time in response to sounds.",
                    fur : true
                });
        EnumValue.add(Types, ONI, "ONI", {
                    name : "oni",
                    appearanceDesc : "A pair of pointed elf-like oni ears stick out from your head."
                });
        EnumValue.add(Types, ELVEN, "ELVEN", {
                    name : "elven",
                    appearanceDesc : "A pair of cute, long, elven, pointy ears, bigger than your old human ones and alert to every sound stick out from your head."
                });
        EnumValue.add(Types, RAIJU, "RAIJU", {
                    name : "raiju",
                    appearanceDesc : "A pair of sideways leaning raiju ears stick out from your head, flicking toward every slight sound.",
                    fur : true
                });
        EnumValue.add(Types, BAT, "BAT", {
                    name : "bat",
                    appearanceDesc : "A pair of bat ears sit atop your head, always perked up to catch any stray sound."
                });
        EnumValue.add(Types, VAMPIRE, "VAMPIRE", {
                    name : "vampire",
                    appearanceDesc : "A pair of pointed elfin ears powerful enough to catch even the heartbeat of those around you stick out from your head."
                });
        EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
                    name : "red-panda",
                    appearanceDesc : "Big, white furred, red-panda ears lie atop your head, keeping you well aware to your surroundings.",
                    fur : true
                });
        EnumValue.add(Types, AVIAN, "AVIAN", {
                    name : "avian",
                    appearanceDesc : "Two small holes at each side of your head serve you as ears. Hidden by tufts of feathers, they’re almost unnoticeable."
                });
        EnumValue.add(Types, GRYPHON, "GRYPHON", {
                    name : "gryphon",
                    appearanceDesc : "A duo of triangular, streamlined ears are located at each side of your head, helping you to pinpoint sounds. They’re covered in soft, [fur color] fur and end in tufts.",
                    fur : true
                });
        EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
                    name : "cave wyrm",
                    appearanceDesc : "Your ears are furry yet they do not actually belong to any known type of mammal. You suspect them to be related to an ancestry closer to that of the serpentine dragons they emulate.",
                    fur : true
                });
        EnumValue.add(Types, BEAR, "BEAR", {
                    name : "bear",
                    appearanceDesc : "A pair of two round fuzzy bear ears covered with [fur color] and alert to sound stick out from your head.",
                    fur : true
                });
        EnumValue.add(Types, PANDA, "PANDA", {
                    name : "panda",
                    appearanceDesc : "A pair of two round fuzzy panda ears covered with black fur just like a panda and alert to sound stick out from your head.",
                    fur : true
                });
        EnumValue.add(Types, SHARK, "SHARK", {
                    name : "shark",
                    appearanceDesc : "A pair of fin like ears with fins stick out from your head. They allow you to hear every sound with perfect clarity while underwater."
                });
        EnumValue.add(Types, DISPLACER, "DISPLACER", {
                    name : "displacer",
                    appearanceDesc : "A large long furry ears atop your head, always perked up to catch any stray sound.",
                    fur : true
                });
        EnumValue.add(Types, MELKIE, "MELKIE", {
                    name : "melkie",
                    appearanceDesc : "Your furry Melkie ears are long and flat, reaching all the way down to your waist.",
                    fur : true
                });
        EnumValue.add(Types, GREMLIN, "GREMLIN", {
                    name : "gremlin",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "Your [hair] is parted by two sideways leaning furry ears that flick toward every slight sound. They don’t belong to any known animal but like anything demonic related help improve your devilish charm." + ((EngineCore.silly()) ? " With ears like that anyone would be hard pressed to resist the urge to headpat you." : "");
                        
                        return desc;
                    }
                });
        EnumValue.add(Types, WEASEL, "WEASEL", {
                    name : "weasel",
                    appearanceDesc : "A pair of two round fuzzy weasel ears covered with [fur color] and alert to sound stick out from your head.",
                    fur : true
                });
        EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
                    name : "squirrel",
                    appearanceDesc : "A pair of sideways round squirrel ears stick out from the side of your head, they flick toward every slight sound.",
                    fur : true
                });
        EnumValue.add(Types, INSECT, "INSECT", {
                    name : "insect",
                    appearanceDesc : "A pair of rounded chitin plates with small holes in their bottom on the sides of your head serve as your ears."
                });
        EnumValue.add(Types, KIRIN, "KIRIN", {
                    name : "kirin",
                    appearanceDesc : "A pair of animal like ears rise up from the top of your head. Well animal like is the proper therm seeing as your kirin ears are covered with scales.",
                    fur : true
                });
        EnumValue.add(Types, BIG, "BIG", {
                    name : "big",
                    appearanceDesc : "Your oversized ears almost look comical on your head. They are long and very mobile and tend to move up and down, flapping around when you have a burst of emotion or when you deliver a vengeful spell at the reaction of them being mocked."
                });
        EnumValue.add(Types, FENNEC_FOX, "FENNEC_FOX", {
                    name : "fennec fox",
                    appearanceDesc : "A pair of unusual large, adept fox ears sit high on your head, always listening.",
                    fur : true
                });
        EnumValue.add(Types, JACKAL, "JACKAL", {
                    name : "jackal fox",
                    appearanceDesc : "A pair of jackal ears that gives you an austere outlook. With that kind of getup no one can question that you are the one in charge.",
                    fur : true
                });
        EnumValue.add(Types, TROLL, "TROLL", {
                    name : "troll",
                    appearanceDesc : "A pair of troll ears stick out from the sides of your head, each covered in soft, green fur.",
                    fur : true
                });
        EnumValue.add(Types, GLACIAL_TROLL, "GLACIAL_TROLL", {
                    name : "g.troll",
                    appearanceDesc : "A pair of glacial troll ears stick out from the sides of your head, each covered in soft, white fur.",
                    fur : true
                });
        true;
    }

}


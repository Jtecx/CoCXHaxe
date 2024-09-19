package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;

class Arms extends SaveableBodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "HARPY")
	 * - name: human-readable default name, ("human", "harpy")
	 *
	 * - appearanceDesc: description for PlayerAppearance.as (always visible)
	 * - appearanceDescFunc: a function that returns a description for PlayerAppearance.as (appearanceDesc is ignored if this exists)
	 *
	 * - claw: whether the arms include claws
	 * - scythe: whether the arms include scythe-like claws
	 * - armSlam: whether the arms enable armSlam
	 * - canFly: [for winged arms] whether allows flight at the expense of using both arms
	 * - wingSlap: [for winged arms] whether part allows a wing slap
	 * - fourArms: whenever arms are four not two
	 *
	 * - hairy: has hair material
	 * - fur: has fur material
	 * - feathers: has feathers material
	 * - scales: has scales material
	 * - chitin: has chitin material
	 * */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var HUMAN : Int = 0;
    
    
    public static inline var HARPY : Int = 1;
    
    
    public static inline var SPIDER : Int = 2;
    
    
    public static inline var MANTIS : Int = 3;
    
    
    public static inline var BEE : Int = 4;
    
    
    public static inline var SALAMANDER : Int = 5;
    
    
    public static inline var PHOENIX : Int = 6;
    
    
    public static inline var PLANT : Int = 7;
    
    
    public static inline var SHARK : Int = 8;
    
    
    public static inline var GARGOYLE : Int = 9;
    
    
    public static inline var WOLF : Int = 10;
    
    
    public static inline var LION : Int = 11;
    
    
    public static inline var KITSUNE : Int = 12;
    
    
    public static inline var FOX : Int = 13;
    
    
    public static inline var LIZARD : Int = 14;  //button 0 on 2nd page of metamorph  
    
    
    public static inline var DRACONIC : Int = 15;
    
    
    public static inline var YETI : Int = 16;
    
    
    public static inline var ORCA : Int = 17;
    
    
    public static inline var PLANT2 : Int = 18;
    
    
    public static inline var DEVIL : Int = 19;
    
    
    public static inline var ONI : Int = 20;
    
    
    public static inline var ELF : Int = 21;
    
    
    public static inline var RAIJU : Int = 22;
    
    
    public static inline var RED_PANDA : Int = 23;
    
    
    public static inline var GARGOYLE_2 : Int = 24;
    
    
    public static inline var CAT : Int = 25;
    
    
    public static inline var AVIAN : Int = 26;
    
    
    public static inline var GRYPHON : Int = 27;
    
    
    public static inline var SPHINX : Int = 28;
    
    
    public static inline var PIG : Int = 29;
    
    
    public static inline var BOAR : Int = 30;
    
    
    public static inline var ORC : Int = 31;
    
    
    public static inline var DISPLACER : Int = 32;
    
    
    public static inline var CAVE_WYRM : Int = 33;
    
    
    public static inline var HINEZUMI : Int = 34;
    
    
    public static inline var BEAR : Int = 35;
    
    
    public static inline var GOO : Int = 36;
    
    
    public static inline var HYDRA : Int = 37;
    
    
    public static inline var GHOST : Int = 38;
    
    
    public static inline var JIANGSHI : Int = 39;
    
    
    public static inline var RAIJU_PAWS : Int = 40;
    
    
    public static inline var YUKI_ONNA : Int = 41;
    
    
    public static inline var MELKIE : Int = 42;
    
    
    public static inline var CENTIPEDE : Int = 43;
    
    
    public static inline var KRAKEN : Int = 44;
    
    
    public static inline var FROSTWYRM : Int = 45;
    
    
    public static inline var CANCER : Int = 46;
    
    
    public static inline var USHI_ONI : Int = 47;
    
    
    public static inline var KAMAITACHI : Int = 48;
    
    
    public static inline var GAZER : Int = 49;
    
    
    public static inline var RACCOON : Int = 50;
    
    
    public static inline var WEASEL : Int = 51;
    
    
    public static inline var SQUIRREL : Int = 52;
    
    
    public static inline var WENDIGO : Int = 53;
    
    
    public static inline var BAT : Int = 54;
    
    
    public static inline var SEA_DRAGON : Int = 55;
    
    
    public static inline var MINDBREAKER : Int = 56;
    
    
    public static inline var JABBERWOCKY : Int = 57;
    
    
    public static inline var ANT : Int = 58;
    
    
    public static inline var FEY_DRACONIC : Int = 59;
    
    
    public static inline var HOUND : Int = 60;
    
    
    public static inline var TINY : Int = 61;
    
    
    public static inline var CANINE : Int = 62;
    
    
    public static inline var ABYSSAL_SHARK : Int = 63;
    
    
    public static inline var ARMORED_FOREARMS : Int = 64;
    
    
    public static inline var DEMON : Int = 65;
    
    
    public static inline var DEER : Int = 66;
    
    
    public static inline var REINDEER : Int = 67;
    
    
    public static inline var MOTH : Int = 68;
    
    
    public static inline var SATYR : Int = 69;
    
    
    public static inline var TROLL : Int = 70;
    
    
    public static inline var GLACIAL_TROLL : Int = 71;
    
    
    public static function canFly(id : Int) : Bool
    {
        return Types[id].canFly || false;
    }
    
    public function new(creature : Creature)
    {
        super(creature, "arms", ["armCount"]);
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
    
    /*
	override protected function loadFromOldSave(savedata:Object):void {
		type = intOr(savedata.arms, HUMAN);
		//armCount = intOr(savedata.armCount,2);
	}

	override protected function saveToOldSave(savedata:Object):void {
		savedata.arms = type;
		savedata.armCount = armCount;
	}
	 */
    
    public static function getAppearanceDescription(creature : Dynamic) : String
    {
        var id : Int = creature.arms.type;
        
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
    
    public static function hasFelineArms(creature : Dynamic) : Bool
    {
        var id : Int = creature.arms.type;
        
        return Types[id].feline || false;
    }
    
    public function hasPawsOrHands() : String
    {
        return (Types[type].canPounce) ? "paws" : "hands";
    }
    
    public function hasFourArms() : Bool
    {
        return Types[type].fourArms || false;
    }
    private static var Arms_static_initializer = {
        EnumValue.add(Types, HUMAN, "HUMAN", {
                    name : "human",
                    appearanceDesc : "You have a pair of normal human arms without any unusual traits."
                });
        EnumValue.add(Types, HARPY, "HARPY", {
                    name : "harpy",
                    appearanceDesc : "Feathers hang off your arms from shoulder to wrist.",
                    feathers : true
                });
        EnumValue.add(Types, SPIDER, "SPIDER", {
                    name : "spider",
                    appearanceDesc : "A shining [chitin color1] exoskeleton covers your arms from the biceps down, resembling a pair of long [chitin color1] gloves from a distance.",
                    chitin : true
                });
        EnumValue.add(Types, MANTIS, "MANTIS", {
                    name : "mantis",
                    scythe : true,
                    appearanceDesc : "A shining [chitin color1] exoskeleton covers your arms from the biceps down, with long and sharp scythes extending from the wrists.",
                    chitin : true
                });
        EnumValue.add(Types, BEE, "BEE", {
                    name : "bee",
                    appearanceDesc : "A shining [chitin color2] exoskeleton covers your arms from the biceps down, resembling a pair of long [chitin color2] gloves ending with a [chitin color1] fuzz from a distance.",
                    chitin : true
                });
        EnumValue.add(Types, SALAMANDER, "SALAMANDER", {
                    name : "salamander",
                    appearanceDesc : "Thick, leathery red scales cover your arms from the biceps down, and your fingernails are short curved claws.",
                    claw : true,
                    scales : true
                });
        EnumValue.add(Types, PHOENIX, "PHOENIX", {
                    name : "phoenix",
                    appearanceDesc : "Crimson feathers hang off your arms from shoulder to wrist.",
                    feathers : true
                });
        EnumValue.add(Types, PLANT, "PLANT", {
                    name : "plant",
                    appearanceDesc : "Delicate vines covered by spade-like leaves crawl down from your shoulders to your wrists, bobbing whenever you move."
                });
        EnumValue.add(Types, SHARK, "SHARK", {
                    name : "shark",
                    appearanceDesc : "A pair of shark fins have sprouted on each of your forearms near your elbows, and the skin between your fingers forms a small webbing which assists your swimming."
                });
        EnumValue.add(Types, GARGOYLE, "GARGOYLE", {
                    name : "gargoyle",
                    appearanceDesc : "Your [gargoylematerial] arms end in stone sharp clawed hands.",
                    claw : true
                });
        EnumValue.add(Types, WOLF, "WOLF", {
                    name : "wolf",
                    appearanceDesc : "Your arms are covered by thick fur, ending in clawed hands with paw pads.",
                    claw : true,
                    canPounce : true,
                    fur : true
                });
        EnumValue.add(Types, LION, "LION", {
                    name : "lion",
                    appearanceDesc : "Your arms are covered by [fur color] fur up to your shoulders, where it turns white, and end in a pair of five-toed lion paws armed with lethal claws.",
                    claw : true,
                    canPounce : true,
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, KITSUNE, "KITSUNE", {
                    name : "kitsune",
                    appearanceDesc : "Your arms are mostly human, save for your sharp nails.",
                    claw : true
                });
        EnumValue.add(Types, FOX, "FOX", {
                    name : "fox",
                    appearanceDesc : "Your arms are covered by thick fur, ending in clawed hands with paw pads.",
                    claw : true,
                    canPounce : true,
                    fur : true
                });
        EnumValue.add(Types, LIZARD, "LIZARD", {
                    name : "lizard",
                    appearanceDesc : "Thick, leathery scales cover your arms from the biceps down, and your fingernails are short curved claws.",
                    claw : true,
                    scales : true
                });
        EnumValue.add(Types, DRACONIC, "DRACONIC", {
                    name : "dragon",
                    appearanceDesc : "Thick, leathery scales cover your arms from the biceps down, and your fingernails are short curved claws.",
                    claw : true,
                    scales : true
                });
        EnumValue.add(Types, YETI, "YETI", {
                    name : "yeti",
                    appearanceDesc : "Your two arms covered by thick fur end in large and powerful yeti hands. You can use them to smash or punch things when you're angry.",
                    armSlam : true,
                    fur : true
                });
        EnumValue.add(Types, ORCA, "ORCA", {
                    name : "orca",
                    appearanceDesc : "A pair of orca fins have sprouted on each of your forearms near your elbows, and the skin between your fingers forms a small webbing which assists your swimming."
                });
        EnumValue.add(Types, PLANT2, "PLANT2", {
                    name : "tentacle-covered",
                    appearanceDesc : "Vines crawl down from your shoulders to your wrists, tipped with slits that drool precum. They look like innocent decorations from a distance."
                });
        EnumValue.add(Types, DEVIL, "DEVIL", {
                    name : "devil",
                    appearanceDesc : "Your forearms are covered by fur and end in four-fingered paw-like hands armed with claws. Despite their weird shape, you have more than enough dexterity to draw even the most complex magical signs when spellcasting.",
                    claw : true,
                    fur : true
                });
        EnumValue.add(Types, ONI, "ONI", {
                    name : "oni",
                    appearanceDesc : "Your arms are mostly human besides sharp black nails, and covered by war tattoos.",
                    armSlam : true
                });
        EnumValue.add(Types, ELF, "ELF", {
                    name : "elf",
                    appearanceDesc : "Your delicate elven hands are almost supernaturally dexterous, allowing you to manipulate objects or cast spells with unbelievable ease."
                });
        EnumValue.add(Types, RAIJU, "RAIJU", {
                    name : "raiju",
                    appearanceDesc : "Your arms are practically human, save for the sharp white claws you have in place of normal nails.",
                    claw : true,
                    fur : true
                });
        EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
                    name : "red-panda",
                    appearanceDesc : "Soft, black-brown fluff covers your arms. Your paws have cute, pink paw pads and short claws.",
                    claw : true,
                    fur : true
                });
        EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {
                    name : "gargoyle",
                    appearanceDesc : "Your [gargoylematerial] arms end in normal human like hands.",
                    armSlam : true
                });
        EnumValue.add(Types, CAT, "CAT", {
                    name : "cat",
                    appearanceDesc : "Your arms are covered by [fur color] fur up to your shoulder. They end in a pair of five-toed cat paws armed with lethal claws.",
                    claw : true,
                    canPounce : true,
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, AVIAN, "AVIAN", {
                    name : "avian",
                    appearanceDesc : "Your arms are covered by [feather color] colored feathers just a bit past your elbow. Your humanoid hands have [skin color], slightly rough skin, and end in short claws.",
                    claw : true,
                    feathers : true
                });
        EnumValue.add(Types, GRYPHON, "GRYPHON", {
                    name : "gryphon",
                    appearanceDesc : "The feathers on your arms reach a bit past your elbows, with a fringe of [feather color] plumage leading to your [skin color], slightly rough-skinned hands equipped with short, avian claws.",
                    claw : true,
                    canPounce : true,
                    feahers : true,
                    fur : true
                });
        EnumValue.add(Types, SPHINX, "SPHINX", {
                    name : "sphinx",
                    appearanceDesc : "Your arms are covered by [fur color] fur. They end in somewhat human-like hands armed with lethal claws.",
                    claw : true,
                    canPounce : true,
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, PIG, "PIG", {
                    name : "pig",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, BOAR, "BOAR", {
                    name : "boar",
                    appearanceDesc : "Your arms are covered by thick [fur color] fur, ending in hands with sharp black nails.",
                    fur : true
                });
        EnumValue.add(Types, ORC, "ORC", {
                    name : "orc",
                    appearanceDesc : "Although your nails are rather sharp, your arms covered in scar-like tattoos look mostly human, aside from being a bit longer than usual."
                });
        EnumValue.add(Types, DISPLACER, "DISPLACER", {
                    name : "displacer",
                    appearanceDesc : "Where a normal creature would have only two arms, you instead have four [fur color] furred appendages, all of which end in a pair of five-toed lion paws armed with lethal claws.",
                    fourArms : true,
                    claw : true,
                    canPounce : true,
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
                    name : "cave wyrm",
                    appearanceDesc : "Thick, leathery black scales cover your arms from the biceps down, and your fingernails are short curved claws.",
                    claw : true,
                    scales : true
                });
        EnumValue.add(Types, HINEZUMI, "HINEZUMI", {
                    name : "hinezumi",
                    armSlam : true,
                    appearanceDesc : "Your forearms, while human in shape, are covered by a thick coat of flames that burn depending on your mood."
                });
        EnumValue.add(Types, BEAR, "BEAR", {
                    name : "bear",
                    appearanceDesc : "You have [fur color] furry arms, ending in a pair of powerful five-toed bear paws armed with lethal claws.",
                    claw : true,
                    fur : true
                });
        EnumValue.add(Types, GOO, "GOO", {
                    name : "goo",
                    appearanceDesc : "While usually kept in a human shape, your constantly dripping arms are actually liquid, allowing you to shape them to your convenience."
                });
        EnumValue.add(Types, HYDRA, "HYDRA", {
                    name : "hydra",
                    appearanceDesc : "Plate-like scales cover your arms from the biceps down, and your fingernails are sharp curved claws perfect for tearing through flesh.",
                    claw : true,
                    scales : true
                });
        EnumValue.add(Types, GHOST, "GHOST", {
                    name : "ghost",
                    appearanceDesc : "Your arms and hands are practically human, save for the fact that they are ghastly in nature."
                });
        EnumValue.add(Types, JIANGSHI, "JIANGSHI", {
                    name : "jiangshi",
                    appearanceDesc : "Your arms are essentially human, but underneath your purple nails is a thick layer of deadly poison.",
                    claw : true
                });
        EnumValue.add(Types, RAIJU_PAWS, "RAIJU_PAWS", {
                    name : "raiju paws",
                    appearanceDesc : "Your forearms are covered by dense fur upon which an electric current runs free. Your pawed hands end in sharp claws capable of delivering powerful discharges.",
                    claw : true,
                    fur : true
                });
        EnumValue.add(Types, YUKI_ONNA, "YUKI_ONNA", {
                    name : "yuki onna",
                    appearanceDesc : "Your arms and hands are human in appearance, but your blue-nailed hands are colder than death."
                });
        EnumValue.add(Types, MELKIE, "MELKIE", {
                    name : "melkie",
                    appearanceDesc : "Your arms and hands are human in appearance, but your blue-nailed hands are colder than death.",
                    claw : true
                });
        EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {
                    name : "centipede",
                    appearanceDesc : "Your arms and hands are mostly human in shape, ending in sharp purple nails. Intricate flowing purple markings stretch from your shoulders to your hands."
                });
        EnumValue.add(Types, KRAKEN, "KRAKEN", {
                    name : "kraken",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
                    name : "frostwyrm",
                    appearanceDesc : "Your forearms are covered by scales which themselves are covered by fur, ending in five fingered clawed hands. Your claws are strong enough to rip and tear through next to anything.",
                    claw : true,
                    scales : true
                });
        EnumValue.add(Types, CANCER, "CANCER", {
                    name : "cancer",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, USHI_ONI, "USHI_ONI", {
                    name : "ushi-oni",
                    appearanceDesc : "You have ushi-oni arms, longer and thicker than those of most races. A strange pattern of fur descends from your middle biceps down to your hands, where you have bone-like claws rather than fingers.",
                    fur : true
                });
        EnumValue.add(Types, KAMAITACHI, "KAMAITACHI", {
                    name : "kamaitachi",
                    appearanceDesc : "Your arms are covered by [fur color] fur up to your shoulders. They end in a pair of five-toed weasel paws armed with claws. Your forearms' fur part ways slightly as a pair of long scythes-like blades curves outward toward your elbow, sharper than any sword.",
                    scythe : true,
                    fur : true
                });
        EnumValue.add(Types, GAZER, "GAZER", {
                    name : "gazer",
                    appearanceDesc : "Your arms are human in appearance, but drip with oily black fluid."
                });
        EnumValue.add(Types, RACCOON, "RACCOON", {
                    name : "raccoon",
                    appearanceDesc : "",
                    claw : true
                });
        EnumValue.add(Types, WEASEL, "WEASEL", {
                    name : "weasel",
                    appearanceDesc : "",
                    claw : true
                });
        EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
                    name : "squirrel",
                    appearanceDesc : "Your arms are covered by [fur color] fur up to your shoulders. They end in a pair of five-toed squirrel paws, armed with claws which can assist you when climbing trees.",
                    claw : true,
                    fur : true
                });
        EnumValue.add(Types, WENDIGO, "WENDIGO", {
                    name : "wendigo",
                    appearanceDesc : "Your arms and hands are practically human, save for the sharp white claws you have in place of normal nails.",
                    claw : true
                });
        EnumValue.add(Types, BAT, "BAT", {
                    name : "bat",
                    appearanceDesc : "The bones in your arms are thin and light, granting you the ability to take flight. Instead of the five fingers you started out with, you now have three that are both larger and stronger. Besides the occasional troubles with an awkward grip, you can still hold various items even with your abnormal hands, albeit at the cost of preventing flight while doing so.",
                    claw : true,
                    canFly : true,
                    wingSlap : true
                });
        EnumValue.add(Types, SEA_DRAGON, "SEA_DRAGON", {
                    name : "sea dragon",
                    appearanceDesc : "A pair of fins have sprouted on each of your forearms near your elbows, and the skin between your fingers forms a small webbing which assists your swimming. You have sharp and deadly claws which allow you to impale your prey or rip your foes to shreds.",
                    claw : true
                });
        EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
                    name : "mindbreaker",
                    appearanceDesc : "Your arms are sleeved up in a web-like membrane, it’s very likely that they could be good for swimming too."
                });
        EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {
                    name : "jabberwocky",
                    appearanceDesc : "Your forearms are covered by scales which themselves are covered by fur, ending in five fingered clawed hands. Your claws are strong enough to rip and tear through next to anything though you tend to use your arms as a mean to keep your partners pinned down so they don't move during sex.",
                    claw : true,
                    scales : true
                });
        EnumValue.add(Types, ANT, "ANT", {
                    name : "ant",
                    appearanceDesc : "Where a normal creature would have only two arms, you instead have four, with shining [chitin color] exoskeleton covering them from the biceps down, resembling a pair of long [chitin color] gloves from a distance.",
                    fourArms : true,
                    claw : true,
                    chitin : true
                });
        EnumValue.add(Types, FEY_DRACONIC, "FEY_DRACONIC", {
                    name : "fae dragon",
                    appearanceDesc : "Leathery scales cover your arms from the biceps down. While soft to the touch, the scales are rigid, acting as sturdy natural armour. Your fingernails are short, and as you flex your fingers, they extend out into thin curved claws.",
                    claw : true,
                    scales : true
                });
        EnumValue.add(Types, HOUND, "HOUND", {
                    name : "hound",
                    appearanceDesc : "Your lower arms are covered by thick fur, ending in clawed hands with paw pads.",
                    claw : true,
                    canPounce : true,
                    fur : true
                });
        EnumValue.add(Types, TINY, "TINY", {
                    name : "tiny",
                    appearanceDesc : "Your arms look human save for the disproportion between your clawed hands and body which make them look way too large for the limbs they are attached to.",
                    claw : true
                });
        EnumValue.add(Types, CANINE, "CANINE", {
                    name : "canine",
                    appearanceDesc : "Your arms are covered in thick [fur color] fur ending up with clawed hands with animal like paw pads.",
                    claw : true
                });
        EnumValue.add(Types, ABYSSAL_SHARK, "ABYSSAL_SHARK", {
                    name : "a.shark",
                    appearanceDesc : "A pair of large shark fins have sprouted on each of your forearms, just past the elbows. The skin between your fingers has become webbed to further assist with your swimming. At the tip of your fingers, you have sharp, deadly claws that allow you to shred and impale foes with ease.",
                    claw : true
                });
        EnumValue.add(Types, ARMORED_FOREARMS, "ARMORED_FOREARMS", {
                    name : "arigean",
                    appearanceDesc : "Your arms are identical to those of a human, However your forearms seem to be covered in fragments of a black, glossy metal acting as natural bracers.",
                    claw : true
                });
        EnumValue.add(Types, DEMON, "DEMON", {
                    name : "demon",
                    appearanceDesc : "Your arms and hands are human in appearance save for your pointy claw like demonic nails.",
                    claw : true
                });
        EnumValue.add(Types, DEER, "DEER", {
                    name : "deer",
                    appearanceDesc : "Your arms are covered by thick [fur color] fur, ending in hands with paw pads and three fingers ending with hoof-like fingernails.",
                    fur : true
                });
        EnumValue.add(Types, REINDEER, "REINDEER", {
                    name : "reindeer",
                    appearanceDesc : "Your arms are covered by thick [fur color] fur, ending in hands with paw pads and four fingers ending with hoof-like fingernails.",
                    fur : true
                });
        EnumValue.add(Types, MOTH, "MOTH", {
                    name : "moth",
                    appearanceDesc : "Where a normal creature would have only two arms, you instead have four covered in a sleeve like fuzzy mass.",
                    fourArms : true
                });
        EnumValue.add(Types, SATYR, "SATYR", {
                    name : "satyr",
                    appearanceDesc : "Your arms are covered with [fur color] fur. They end with somewhat human-like hands with sharp nails. Such dexterous hands are as adept at playing a piper as they would to draw out moans out of a partner.",
                    claw : true,
                    fur : true
                });
        EnumValue.add(Types, TROLL, "TROLL", {
                    name : "troll",
                    appearanceDesc : "Your arms are covered with [fur color] fur. They end with somewhat human-like hands with sharp nails. Such dexterous hands are as adept at playing a piper as they would to draw out moans out of a partner.",
                    fur : true
                });
        EnumValue.add(Types, GLACIAL_TROLL, "GLACIAL_TROLL", {
                    name : "g.troll",
                    appearanceDesc : "Your arms are covered with [fur color] fur. They end with somewhat human-like hands with sharp nails. Such dexterous hands are as adept at playing a piper as they would to draw out moans out of a partner.",
                    claw : true,
                    fur : true
                });
        true;
    }

}


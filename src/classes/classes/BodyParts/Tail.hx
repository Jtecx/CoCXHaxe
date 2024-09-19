/**
 * Created by aimozg on 27.04.2017.
 */
package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;

class Tail extends SaveableBodyPart
{
    
    // A number of tails; legacy version used venom for counting
    public var count : Int = 0;
    //Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
    public var venom : Float = 0;
    //Tail recharge determines how fast venom/webs comes back per hour.
    public var recharge : Float = 5;
    
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "HORSE")
	 * - name: human-readable default name, ("non-existant", "horse")
	 *
	 * - hairy: has hair material
	 * - fur: has fur material
	 * - feathers: has feathers material
	 * - scales: has scales material
	 * - chitin: has chitin material
	 *
	 * - appearanceDesc: description for PlayerAppearance.as
	 * - appearanceDescFunc: a function that returns a description for PlayerAppearance.as (appearanceDesc is ignored if this exists)
	 *
	 * - draconic: part counts as "dragon or variant"
	 *
	 * - stinger: whether part has a stringer
	 * - tailSlam: whether part enables tail slam
	 * - isLong: Wwhether the tail is long
	 * - bite: whether the part allows attacking with teeth
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var NONE : Int = 0;
    
    public static inline var HORSE : Int = 1;
    
    public static inline var DOG : Int = 2;
    
    public static inline var DEMONIC : Int = 3;
    
    public static inline var COW : Int = 4;
    
    public static inline var SPIDER_ADBOMEN : Int = 5;
    
    public static inline var BEE_ABDOMEN : Int = 6;
    
    public static inline var SHARK : Int = 7;
    
    public static inline var CAT : Int = 8;
    
    public static inline var LIZARD : Int = 9;
    
    public static inline var RABBIT : Int = 10;
    
    public static inline var HARPY : Int = 11;
    
    public static inline var KANGAROO : Int = 12;
    
    public static inline var FOX : Int = 13;
    
    public static inline var DRACONIC : Int = 14;
    
    public static inline var RACCOON : Int = 15;
    
    public static inline var MOUSE : Int = 16;
    
    public static inline var FERRET : Int = 17;
    
    public static inline var BEHEMOTH : Int = 18;
    
    public static inline var PIG : Int = 19;  //button 0 on 3rd page of metamorph  
    
    public static inline var SCORPION : Int = 20;
    
    public static inline var GOAT : Int = 21;
    
    public static inline var RHINO : Int = 22;
    
    public static inline var ECHIDNA : Int = 23;
    
    public static inline var DEER : Int = 24;
    
    public static inline var SALAMANDER : Int = 25;
    
    public static inline var KITSHOO : Int = 26;
    
    public static inline var MANTIS_ABDOMEN : Int = 27;
    
    public static inline var MANTICORE_PUSSYTAIL : Int = 28;
    
    public static inline var WOLF : Int = 29;
    
    public static inline var GARGOYLE : Int = 30;
    
    public static inline var ORCA : Int = 31;
    
    public static inline var YGGDRASIL : Int = 32;
    
    public static inline var RAIJU : Int = 33;
    
    public static inline var RED_PANDA : Int = 34;
    
    public static inline var GARGOYLE_2 : Int = 35;
    
    public static inline var AVIAN : Int = 36;
    
    public static inline var GRIFFIN : Int = 37;
    
    public static inline var LION : Int = 38;
    
    public static inline var BURNING : Int = 39;
    
    public static inline var NEKOMATA_FORKED_1_3 : Int = 40;
    
    public static inline var NEKOMATA_FORKED_2_3 : Int = 41;
    
    public static inline var CAVE_WYRM : Int = 42;
    
    public static inline var HINEZUMI : Int = 43;
    
    public static inline var THUNDERBIRD : Int = 44;
    
    public static inline var BEAR : Int = 45;
    
    public static inline var TWINKASHA : Int = 46;
    
    public static inline var USHI_ONI : Int = 47;
    
    public static inline var WEASEL : Int = 48;
    
    public static inline var SQUIRREL : Int = 49;
    
    public static inline var MONKEY : Int = 50;
    
    public static inline var WENDIGO : Int = 51;
    
    public static inline var ANT_ABDOMEN : Int = 52;
    
    public static inline var KIRIN : Int = 53;
    
    public static inline var FEY_DRACONIC : Int = 54;
    
    public static inline var AZAZEL : Int = 55;
    
    public static inline var ABYSSAL_SHARK : Int = 56;
    
    public static inline var ARIGEAN_GREEN : Int = 57;
    
    public static inline var ARIGEAN_RED : Int = 58;
    
    public static inline var ARIGEAN_YELLOW : Int = 59;
    
    public static inline var ARIGEAN_PRINCESS : Int = 60;
    
    public static inline var MOTH_ABDOMEN : Int = 61;
    
    public static inline var TROLL : Int = 62;
    
    public static inline var GLACIAL_TROLL : Int = 63;
    
    
    override private function set_type(value : Int) : Int
    {
        var old : Int = type;
        super.type = value;
        if (count < 1 || value != FOX)
        {
            count = 1;
        }
        if (value == NONE)
        {
            count = 0;
            venom = 0;
        }
        return value;
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
    
    public function new(creature : Creature)
    {
        super(creature, "tail", ["count", "venom", "recharge"]);
    }
    
    public function isLong() : Bool
    {
        if (creature.isNaga())
        {
            return true;
        }
        
        return Types[type].isLong || false;
    }
    
    override private function loadFromOldSave(savedata : Dynamic) : Void
    {
        count = (savedata.tailCount || savedata.tailVenum) ? 1 : 0;
        venom = savedata.tailVenum;
        recharge = savedata.tailRecharge;
        type = savedata.tailType;
    }
    override private function saveToOldSave(savedata : Dynamic) : Void
    {
        savedata.tailVenum = (type == FOX) ? count : venom;
        savedata.tailRecharge = recharge;
        savedata.tailType = type;
    }
    
    public static function getAppearanceDescription(player : Dynamic) : String
    {
        var id : Int = player.tailType;
        
        return formatDescription(((Types[id].appearanceDescFunc) ? Types[id].appearanceDescFunc(player) : Types[id].appearanceDesc) || "", player);
    }
    
    private static function formatDescription(desc : String, creature : Dynamic) : String
    {
        var upperCasePattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('^.', "");
        var legCountPattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('{legCount}', "g");
        var legCountMinusTwoPattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('{legCountMinusTwo}', "g");
        
        return legCountPattern.replace(desc, num2Text(creature.legCount)).replace(legCountMinusTwoPattern, num2Text(creature.legCount - 2)).replace(upperCasePattern, function(__DOLLAR__0 : Dynamic) : Dynamic
                {
                    return __DOLLAR__0.toUpperCase();
                });
    }
    
    public static function hasDraconicTail(creature : Dynamic) : Bool
    {
        var id : Int = creature.tailType;
        
        return Types[id].draconic || false;
    }
    
    public static function hasFelineTail(creature : Dynamic) : Bool
    {
        var id : Int = creature.tail.type;
        
        return Types[id].feline || false;
    }
    private static var Tail_static_initializer = {
        EnumValue.add(Types, NONE, "NONE", {
                    name : "non-existant",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, HORSE, "HORSE", {
                    name : "horse",
                    appearanceDesc : "A long [fur color] horse tail hangs from your [butt], smooth and shiny.",
                    fur : true
                });
        EnumValue.add(Types, DOG, "DOG", {
                    name : "dog",
                    appearanceDesc : "A fuzzy [fur color] dog tail sprouts just above your [butt], wagging to and fro whenever you're happy.",
                    isLong : true,
                    fur : true
                });
        EnumValue.add(Types, DEMONIC, "DEMONIC", {
                    name : "demonic",
                    appearanceDesc : "A narrow tail ending in a spaded tip curls down from your [butt], wrapping around your [leg] sensually at every opportunity.",
                    isLong : true
                });
        EnumValue.add(Types, COW, "COW", {
                    name : "cow",
                    appearanceDesc : "A long cow tail with a puffy tip swishes back and forth, as if swatting at flies.",
                    isLong : true
                });
        EnumValue.add(Types, SPIDER_ADBOMEN, "SPIDER_ADBOMEN", {
                    name : "spider abdomen",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "A large, spherical spider abdomen has grown out from your backside, covered in shiny [chitin color] chitin. Though it's heavy and bobs with every motion, it doesn't seem to slow you down.";
                        
                        if (player.tailVenom > (player.maxVenom() * 0.5) && player.tailVenom < (player.maxVenom() * 0.8))
                        {
                            desc += " Your bulging arachnid posterior feels fairly full of webbing.";
                        }
                        else if (player.tailVenom >= (player.maxVenom() * 0.8) && player.tailVenom < player.maxVenom())
                        {
                            desc += " Your arachnid rear bulges and feels very full of webbing.";
                        }
                        else if (player.tailVenom == player.maxVenom())
                        {
                            desc += " Your swollen spider-butt is distended with the sheer amount of webbing it's holding.";
                        }
                        
                        return desc;
                    }
                });
        EnumValue.add(Types, BEE_ABDOMEN, "BEE_ABDOMEN", {
                    name : "bee abdomen",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "A large bee abdomen dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard chitin with black and yellow stripes, and tipped with a dagger-like stinger.";
                        
                        if (player.tailVenom > (player.maxVenom() * 0.5) && player.tailVenom < (player.maxVenom() * 0.8))
                        {
                            desc += " A single drop of poison hangs from your exposed stinger.";
                        }
                        else if (player.tailVenom >= (player.maxVenom() * 0.8) && player.tailVenom < player.maxVenom())
                        {
                            desc += " Poisonous bee venom coats your stinger completely.";
                        }
                        else if (player.tailVenom == player.maxVenom())
                        {
                            desc += " Venom drips from your poisoned stinger regularly.";
                        }
                        
                        return desc;
                    },
                    stinger : true,
                    chitin : true
                });
        EnumValue.add(Types, SHARK, "SHARK", {
                    name : "shark",
                    appearanceDesc : "A long shark tail trails down from your backside, swaying to and fro while giving you a dangerous air.",
                    tailSlam : true,
                    isLong : true
                });
        EnumValue.add(Types, CAT, "CAT", {
                    name : "cat",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "A soft [fur color] cat tail sprouts just above your [butt], curling and twisting with every step to maintain perfect balance.";
                        
                        if (player.tailCount == 2)
                        {
                            desc = "A pair of soft [fur color] cat tails sprout just above your [butt], curling and twisting with every step to maintain perfect balance.";
                        }
                        
                        return desc;
                    },
                    isLong : true,
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, LIZARD, "LIZARD", {
                    name : "lizard",
                    appearanceDesc : "A tapered tail hangs down from just above your [butt]. It sways back and forth, assisting you in keeping your balance.",
                    tailSlam : true,
                    isLong : true,
                    scales : true
                });
        EnumValue.add(Types, RABBIT, "RABBIT", {
                    name : "rabbit",
                    appearanceDesc : "A short, soft bunny tail sprouts just above your [butt], twitching constantly even when you don't think about it.",
                    fur : true
                });
        EnumValue.add(Types, HARPY, "HARPY", {
                    name : "harpy",
                    appearanceDesc : "A tail of feathers fans out from just above your [butt], twitching instinctively to help guide you if you were to take flight.",
                    feathers : true
                });
        EnumValue.add(Types, KANGAROO, "KANGAROO", {
                    name : "kangaroo",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "A conical, ";
                        
                        if (player.isFurCovered())
                        {
                            desc += "furry, and [fur color] ";
                        }
                        else
                        {
                            desc += "gooey, and [color] ";
                        }
                        desc += "tail extends from your [butt], bouncing up and down as you move to assist in your balance.";
                        return desc;
                    },
                    isLong : true
                });
        EnumValue.add(Types, FOX, "FOX", {
                    name : "fox",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "A swishing [fur color] fox brush extends from your [butt], curling around your body; the soft fur feels lovely, and you wonder how many would be enticed by it.";
                        
                        if (player.tailCount > 1)
                        {
                            desc = "[TailCount] swishing [fur color] fox tails extend from your [butt], curling around your body; the soft fur feels lovely, and you wonder how many would be enticed by it.";
                        }
                        
                        return desc;
                    },
                    isLong : true,
                    fur : true
                });
        EnumValue.add(Types, DRACONIC, "DRACONIC", {
                    name : "draconic",
                    appearanceDesc : "A thin, scaly, prehensile reptilian tail, almost as long as you are tall, swings behind you like a living bullwhip. The end of its tip is equipped with spikes of bone, meant to deliver painful blows.",
                    draconic : true,
                    tailSlam : true,
                    isLong : true,
                    scales : true
                });
        EnumValue.add(Types, RACCOON, "RACCOON", {
                    name : "raccoon",
                    appearanceDesc : "A black-and-[fur color]-ringed raccoon tail waves behind you.",
                    isLong : true,
                    fur : true
                });
        EnumValue.add(Types, MOUSE, "MOUSE", {
                    name : "mouse",
                    appearanceDesc : "A naked, [color] mouse tail pokes from your butt, dragging on the ground and twitching occasionally.",
                    isLong : true
                });
        EnumValue.add(Types, FERRET, "FERRET", {
                    name : "ferret",
                    appearanceDesc : "",
                    isLong : true
                });
        EnumValue.add(Types, BEHEMOTH, "BEHEMOTH", {
                    name : "behemoth",
                    appearanceDesc : "A long, seemingly tapering behemoth tail pokes from your butt, ending in spikes.",
                    tailSlam : true,
                    isLong : true
                });
        EnumValue.add(Types, PIG, "PIG", {
                    name : "pig",
                    appearanceDesc : "A short, curly pig tail sprouts from just above your butt."
                });
        EnumValue.add(Types, SCORPION, "SCORPION", {
                    name : "scorpion",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "A large insectile scorpion tail dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard chitin and tipped with a stinger.";
                        
                        if (player.tailVenom > (player.maxVenom() * 0.5) && player.tailVenom < (player.maxVenom() * 0.8))
                        {
                            desc += "A single drop of poison hangs from your exposed stinger.";
                        }
                        else if (player.tailVenom >= (player.maxVenom() * 0.8) && player.tailVenom < player.maxVenom())
                        {
                            desc += "Poisonous bee venom coats your stinger completely.";
                        }
                        else if (player.tailVenom == player.maxVenom())
                        {
                            desc += "Venom drips from your poisoned stinger regularly.";
                        }
                        
                        return desc;
                    },
                    stinger : true,
                    isLong : true
                });
        EnumValue.add(Types, GOAT, "GOAT", {
                    name : "goat",
                    appearanceDesc : "A stubby goat tail sprouts from just above your butt.",
                    fur : true
                });
        EnumValue.add(Types, RHINO, "RHINO", {
                    name : "rhino",
                    appearanceDesc : "A ropey rhino tail sprouts from just above your butt, swishing from time to time."
                });
        EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
                    name : "echidna",
                    appearanceDesc : "A stumpy echidna tail forms just above your [butt]."
                });
        EnumValue.add(Types, DEER, "DEER", {
                    name : "deer",
                    appearanceDesc : "A stubby deer tail sprouts from just above your butt.",
                    fur : true
                });
        EnumValue.add(Types, SALAMANDER, "SALAMANDER", {
                    name : "salamander",
                    appearanceDesc : "A tapered tail covered in red scales hangs down from just above your [butt]. It sways back and forth, improving your balance, and you can set it ablaze in red-hot fire whenever you want.",
                    tailSlam : true,
                    isLong : true,
                    scales : true
                });
        EnumValue.add(Types, KITSHOO, "KITSHOO", {
                    name : "kitsumori",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "A swishing [fur color] tail extends from your [butt], fur fanning out like a paintbrush. Your tail curls around your body; the soft fur feels smooth, soothing against your [skin]...But you know at any moment, you could cause that soft fur to erupt into an incandescent flame.";
                        
                        if (player.tailCount > 1)
                        {
                            desc = "[TailCount] swishing fox tails extend from your [butt], vibrant [fur color] fur fanning out behind you. Running your hands along them feels simply divine, sending sparks flickering from the fur beneath. At any moment, you could cause your lovely fur to erupt into flames: the mere thought sends a shiver of excitement up your spine.";
                        }
                        
                        return desc;
                    },
                    tailSlam : true,
                    isLong : true,
                    fur : true
                });
        EnumValue.add(Types, MANTIS_ABDOMEN, "MANTIS_ABDOMEN", {
                    name : "mantis abdomen",
                    appearanceDesc : "A large insectile mantis abdomen dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard [chitin color] chitinous material.",
                    chitin : true
                });
        EnumValue.add(Types, MANTICORE_PUSSYTAIL, "MANTICORE_PUSSYTAIL", {
                    name : "manticore pussytail",
                    appearanceDesc : "Your tail is covered in armored chitin from the base to the tip, ending in a flower-like bulb. You can open and close your tail tip at will, and its pussy-like interior can be used to milk male organs. The deadly set of spikes covering the tip regularly drips with your potent venom. When impaling your tail spikes in a prey isn’t enough, you can fling them at a target with a precision matching a talented archer.",
                    feline : true,
                    stinger : true
                });
        EnumValue.add(Types, WOLF, "WOLF", {
                    name : "wolf",
                    appearanceDesc : "A bushy [fur color] wolf tail sprouts just above your [butt], wagging to and fro whenever you are happy.",
                    isLong : true,
                    fur : true
                });
        EnumValue.add(Types, GARGOYLE, "GARGOYLE", {
                    name : "mace-shaped gargoyle",
                    appearanceDesc : "A long spiked tail hangs down from just above your [butt]. It sways back and forth, improving your balance.",
                    tailSlam : true
                });
        EnumValue.add(Types, ORCA, "ORCA", {
                    name : "orca",
                    appearanceDesc : "A long, powerful orca tail trails down from your backside, swaying to and fro, always ready to propulse you through the water or smack an opponent on the head. It has a huge fin at the end, and a smaller one not so far from your ass.",
                    draconic : true,
                    tailSlam : true
                });
        EnumValue.add(Types, YGGDRASIL, "YGGDRASIL", {
                    name : "yggdrasil",
                    appearanceDesc : "A thin, prehensile reptilian tail swings behind you, covered in [skin coat]. Adorning its tip is a leaf, bobbing with each of your tail's movements.",
                    draconic : true,
                    isLong : true
                });
        EnumValue.add(Types, RAIJU, "RAIJU", {
                    name : "raiju",
                    appearanceDesc : "Your silky tail extends out from just above your [butt]. Its fur is lovely to the touch and glows with lightning at the tip.",
                    energy : true,
                    fur : true
                });
        EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
                    name : "red-panda",
                    appearanceDesc : "Sprouting from your [ass] is a long, bushy tail adorned by a beautiful pattern of [fur color] rings. It waves playfully as you walk, giving your step a mesmerizing touch.",
                    fur : true
                });
        EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {
                    name : "axe-shaped gargoyle",
                    appearanceDesc : "A long tail ending with an axe blade on both sides hangs down from just above your [butt]. It sways back and forth, improving your balance.",
                    tailSlam : true
                });
        EnumValue.add(Types, AVIAN, "AVIAN", {
                    name : "avian",
                    appearanceDesc : "A fan-like tail made of [feather color] feathers rests above your [butt], twitching instinctively to help guide you if you were to take flight.",
                    feathers : true
                });
        EnumValue.add(Types, GRIFFIN, "GRIFFIN", {
                    name : "griffin",
                    appearanceDesc : "From your backside hangs a long tail, leonine in shape and covered mostly by a layer of [fur color2] fur, featuring a tip made of a tuft of [fur color] feathers. It moves sinuously as you walk.",
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, LION, "LION", {
                    name : "lion",
                    appearanceDesc : "A soft [fur color] lion tail sprouts just above your [butt], curling and twisting with every step to maintain perfect balance. It ends in a small puffy hair.",
                    isLong : true,
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, BURNING, "BURNING", {
                    name : "burning",
                    appearanceDesc : "A blazing cat tail pokes out from your [butt]. It has a tendency to light things on fire if you are not careful, but at least it assists with your balance.",
                    isLong : true,
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, NEKOMATA_FORKED_1_3, "NEKOMATA_FORKED_1_3", {
                    name : "forked cat",
                    appearanceDesc : "A soft [fur color] cat-tail, forked on its one-third length, sprouts just above your [butt], curling and twisting with every step to maintain perfect balance.",
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, NEKOMATA_FORKED_2_3, "NEKOMATA_FORKED_2_3", {
                    name : "forked cat",
                    appearanceDesc : "A soft [fur color] cat-tail, forked on its two-thirds length, sprouts just above your [butt], curling and twisting with every step to maintain perfect balance.",
                    feline : true,
                    fur : true
                });
        EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
                    name : "cave wyrm",
                    appearanceDesc : "A large newt tail trails down from your [butt], tapering on the ground behind you. While it is heavy and plump, it allows you to swim underwater like a fish, if necessary.",
                    tailSlam : true,
                    isLong : true
                });
        EnumValue.add(Types, HINEZUMI, "HINEZUMI", {
                    name : "hinezumi",
                    appearanceDesc : "A blazing, [color] mouse tail pokes out from your [butt]. It has a tendency to light things on fire if you are not careful."
                });
        EnumValue.add(Types, THUNDERBIRD, "THUNDERBIRD", {
                    name : "thunderbird",
                    appearanceDesc : "From just above your [butt] extends a long thin sinuous tail, tipped with feathers shaped like a lightning bolt.",
                    energy : true,
                    feathers : true
                });
        EnumValue.add(Types, BEAR, "BEAR", {
                    name : "bear",
                    appearanceDesc : "A cute, furry ursan tail sits up from your backside.",
                    fur : true
                });
        EnumValue.add(Types, TWINKASHA, "TWINKASHA", {
                    name : "twinkasha",
                    appearanceDesc : "A pair blazing cat tail pokes out from your [butt]. They have a tendency to light things on fire if you are not careful, but at least they assist with your balance. From these tails you draw in tremendous fell power.",
                    feline : true
                });
        EnumValue.add(Types, USHI_ONI, "USHI_ONI", {
                    name : "ushi-oni",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "You have an ushi-oni tail whose furred member is " + ((player.tallness > 72) ? "five" : "four") + " feet long and prehensile. Its tip can shoot very thick and strong web strings which double as an aphrodisiac when in contact with the victim.";
                        
                        return desc;
                    }
                });
        EnumValue.add(Types, WEASEL, "WEASEL", {
                    name : "weasel",
                    appearanceDesc : "Your short, silky weasel tail extends out from just above your [butt]. Its fur is lovely to the touch.",
                    fur : true
                });
        EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
                    name : "squirrel",
                    appearanceDesc : "From your back sprouts a furry, striped squirrel tail that curves upwards.",
                    fur : true
                });
        EnumValue.add(Types, MONKEY, "MONKEY", {
                    name : "monkey",
                    appearanceDesc : ""
                });
        EnumValue.add(Types, WENDIGO, "WENDIGO", {
                    name : "wendigo",
                    appearanceDesc : "Your silky tail extends out from just above your [butt]. Its fur is lovely to the touch and warm, and it protects you well against the cold."
                });
        EnumValue.add(Types, ANT_ABDOMEN, "ANT_ABDOMEN", {
                    name : "ant abdomen",
                    appearanceDesc : "A large insectile ant abdomen dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard [chitin color] chitinous material.",
                    chitin : true
                });
        EnumValue.add(Types, KIRIN, "KIRIN", {
                    name : "horse",
                    appearanceDesc : "A spiky [fur color] kirin  tail hangs from your [butt], wild and bushy. It might be due to the constant static gathering around it.",
                    energy : true,
                    fur : true
                });
        EnumValue.add(Types, FEY_DRACONIC, "FEY_DRACONIC", {
                    name : "fae draconic",
                    appearanceDesc : "A thin, scaly, prehensile reptilian tail, almost as long as you are tall, swings behind you like a living bullwhip. The end of its tip is equipped with opalescent spikes. As your tail moves, it reflects the light around you, and you occasionally feel the urge to twirl, letting the reflective light scatter in your wake.",
                    draconic : true,
                    tailSlam : true,
                    isLong : true,
                    scales : true
                });
        EnumValue.add(Types, AZAZEL, "AZAZEL", {
                    name : "azazel",
                    appearanceDesc : "A thin, scaly, prehensile reptilian tail almost as long as you are tall and covered in [fur color] fur, swings behind you like a living bullwhip. The end of its tip is tapered and thin like the end of a whip.",
                    isLong : true
                });
        EnumValue.add(Types, ABYSSAL_SHARK, "ABYSSAL_SHARK", {
                    name : "abyssal shark",
                    appearanceDesc : "A long shark tail trails down from your back side with two large fins at the base and another pair of smaller fins near the mid-section, both equally as firm as it sways behind you seamlessly, giving you a dangerous air.",
                    tailSlam : true,
                    isLong : true
                });
        EnumValue.add(Types, ARIGEAN_GREEN, "ARIGEAN_GREEN", {
                    name : "arigean (G)",
                    appearanceDesc : "A duo of black, parasitic-like organisms seem to sprout from the end of your tailbone with an additional skeletal tail sporting green highlights, each seems to sport a large set of teeth, and are covered in black armor-like skin with glowing green markings. You seem to feel everything they feel.",
                    tailSlam : true,
                    bite : true,
                    isLong : true
                });
        EnumValue.add(Types, ARIGEAN_RED, "ARIGEAN_RED", {
                    name : "arigean (R)",
                    appearanceDesc : "Your duo of slack Symbiotes sprout from the end of your tailbone with an additional skeletal tail bearing red highlights, each seems to sport a large set of teeth, and are covered in black armor-like skin with glowing red markings. You feel everything they feel and are able to communicate with ease.",
                    tailSlam : true,
                    bite : true,
                    isLong : true
                });
        EnumValue.add(Types, ARIGEAN_YELLOW, "ARIGEAN_YELLOW", {
                    name : "arigean (Y)",
                    appearanceDesc : "Your duo of black, Beautiful Symbiotes sprout from the end of your tailbone with an additional skeletal bearing yellow highlights, each sports a lovely, large set of lethal teeth to bite through foes, and are covered in reliable black armor-like skin with glowing yellow markings. You're able to coordinate with them as if they were just extra limbs.",
                    tailSlam : true,
                    bite : true,
                    isLong : true
                });
        EnumValue.add(Types, ARIGEAN_PRINCESS, "ARIGEAN_PRINCESS", {
                    name : "a. princess",
                    appearanceDesc : "Your large, glorious tail-like mouth is attached to you at the end of your tailbone, you can’t help but giggle at the thought of a foe being crushed by the large teeth found in your lipless extra mouth, your able to easily and comfortably rest upon its strong natural armor-like hide. You silently exhale a blue haze through its teeth every few seconds.",
                    tailSlam : true,
                    bite : true,
                    isLong : true
                });
        EnumValue.add(Types, MOTH_ABDOMEN, "MOTH_ABDOMEN", {
                    name : "moth abdomen",
                    appearanceDesc : "You have a moth abdomen"
                });
        EnumValue.add(Types, TROLL, "TROLL", {
                    name : "troll",
                    appearanceDesc : "Your long, green silky troll tail extends out from just above your [butt]. The fur is luxurious, especially in the tuft of hair at the tip of your tail.",
                    isLong : true
                });
        EnumValue.add(Types, GLACIAL_TROLL, "GLACIAL_TROLL", {
                    name : "glacial troll",
                    appearanceDesc : "Your long, white silky troll tail extends out from just above your [butt]. The fur is luxurious, especially in the tuft of hair at the tip of your tail.",
                    isLong : true
                });
        true;
    }

}


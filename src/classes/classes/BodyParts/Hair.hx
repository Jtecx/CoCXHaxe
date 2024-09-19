package classes.bodyParts;

import classes.Creature;
import classes.bodyParts.*;
import classes.internals.EnumValue;
import classes.StatusEffects;
import classes.internals.Utils;

class Hair extends BodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NORMAL", "FEATHER")
	 * - name: human-readable default name, ("normal", "feather")
	 *
	 * - shortDesc: simple description of the hair
	 * - shortDescFunc: function that returns a shortDesc value (shortDesc is ignored if this exists)
	 *
	 * - appearanceDesc: detailed description of the hair for PlayerAppearance.as
	 * - appearanceDescFunc: function that returns an appearanceDesc value (appearanceDesc is ignored if this exists)
	 *
	 * - beardDesc: description of the beard linked to the hair type
	 *
	 * - ignoresStyle: hair's unique appearance ignores normal hairstyles (plain, wild, etc.)
	 */
    
    public static var Types : Array<Dynamic> = [];
    
    public static inline var NORMAL : Int = 0;
    
    
    public static inline var FEATHER : Int = 1;
    
    
    public static inline var GHOST : Int = 2;
    
    
    public static inline var GOO : Int = 3;
    
    
    public static inline var ANEMONE : Int = 4;
    
    
    public static inline var QUILL : Int = 5;
    
    
    public static inline var GORGON : Int = 6;
    
    
    public static inline var LEAF : Int = 7;
    
    
    public static inline var FLUFFY : Int = 8;
    
    
    public static inline var GRASS : Int = 9;
    
    
    public static inline var SILKEN : Int = 10;
    
    
    public static inline var STORM : Int = 11;
    
    
    public static inline var BURNING : Int = 12;
    
    
    public static inline var SNOWY : Int = 13;
    
    
    public static inline var FAIRY : Int = 14;
    
    
    public static inline var CRAZY : Int = 15;
    
    
    public static inline var WINDSWEPT : Int = 16;
    
    
    public static inline var RATATOSKR : Int = 17;
    
    
    public static inline var PRISMATIC : Int = 18;
    
    
    public static inline var MINDBREAKER : Int = 19;
    
    
    public static inline var MINDBREAKERMALE : Int = 20;
    
    
    public static inline var COW : Int = 21;
    
    
    public static inline var DRIPPING : Int = 22;
    
    
    public static inline var PEAFOWL : Int = 23;
    
    
    // Additional modifiers for hair descriptions
    public static var Styles : Array<Dynamic> = [];
    
    public static inline var PLAIN : Int = 0;
    
    
    public static inline var WILD : Int = 1;
    
    
    public static inline var PONYTAIL : Int = 2;
    
    
    public static inline var LONGTRESSES : Int = 3;
    
    
    public static inline var TWINTAILS : Int = 4;
    
    
    public static inline var DWARVEN : Int = 5;
    
    
    public static inline var SNOWLILY : Int = 6;
    
    
    public static inline var FOURWIND : Int = 7;
    
    
    public static inline var FOURWINDL : Int = 8;
    
    
    public static inline var TAURPONYTAIL : Int = 9;
    
    
    public static inline var TWINRIBBON : Int = 10;
    
    
    public static inline var DESERTGRACE : Int = 11;
    
    
    public var color : String = "no";
    public var length : Float = 0.0;
    
    public function new()
    {
        super(null, null);
    }
    
    override public function restore(keepColor : Bool = true) : Void
    {
        super.restore();
        color = "no";
        length = 0.0;
    }
    
    public static function getDescription(creature : Dynamic) : String
    {
        if (creature.hairLength == 0)
        {
            if (creature.skinType == Skin.FUR)
            {
                return "furry head";
            }
            else
            {
                return getHairLength(creature) + " head";
            }
        }
        
        var id : Int = creature.hairType;
        var idStyle : Int = creature.hairStyle;
        
        return ((Types[id].ignoresStyle) ? "" : Styles[idStyle].adjective + " ") + getHairLength(creature) + " " + creature.hairColor + " " + formatDescription(Types[id].shortDesc || "{hair}", creature);
    }
    
    public static function getShortDescription(creature : Dynamic) : String
    {
        if (creature.hairLength == 0)
        {
            if (creature.skinType == Skin.FUR)
            {
                return "furry head";
            }
            else
            {
                return getHairLength(creature) + " head";
            }
        }
        
        var id : Int = creature.hairType;
        
        return formatDescription(Types[id].shortDesc || "{hair}", creature);
    }
    
    public static function getAppearanceDescription(creature : Dynamic) : String
    {
        if (creature.hairLength == 0)
        {
            if (creature.skinType == Skin.FUR)
            {
                return "You have no hair, only a thin layer of fur atop of your head.";
            }
            else
            {
                return "You have a completely " + getHairLength(creature) + " head, showing only shiny [color] [skin.type].";
            }
        }
        
        var id : Int = creature.hairType;
        
        return formatDescription(((Types[id].appearanceDescFunc) ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
    }
    
    public static function getStyleDescription(creature : Dynamic) : String
    {
        var id : Int = creature.hairStyle;
        var hairId : Int = creature.hairType;
        
        var hair : String = "hair";
        
        //If furry and longish hair sometimes call it a mane (50%)
        if (creature.isFurCovered() == 1 && creature.hairLength > 3 && rand(2) == 0)
        {
            hair = "mane";
        }
        
        if (Types[hairId].ignoresStyle)
        {
            return formatDescription(Types[hairId].shortDesc || "{hair}", creature);
        }
        else
        {
            return formatDescription((Styles[id].adjective + " " || "") + "{hair}", creature);
        }
    }
    
    private static function formatDescription(desc : String, creature : Dynamic) : String
    {
        var id : Int = creature.hairType;
        var idStyle : Int = creature.hairStyle;
        
        var hair : String = "hair";
        
        //If furry and longish hair sometimes call it a mane (50%)
        if (creature.isFurCovered() == 1 && creature.hairLength > 3 && rand(2) == 0)
        {
            hair = "mane";
        }
        
        var hairPattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('{hair}', "g");
        var hairInfoPattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('{hairInfo}', "g");
        
        return hairPattern.replace(desc, hair).replace(hairInfoPattern, ((Types[id].ignoresStyle) ? "" : Styles[idStyle].adjective + " ") + getHairLength(creature) + " " + creature.hairColor + " " + hair);
    }
    
    public static function getHairLength(creature : Dynamic) : String
    {
        var options : Array<Dynamic>;
        var hairscale : Float = creature.hairLength / creature.tallness;
        if (hairscale == 0)
        {
            options = ["shaved", "bald", "smooth", "hairless", "glabrous"];
            return randomChoice(options);
        }
        else if (hairscale <= 0.05)
        {
            options = ["close-cropped", "trim", "very short"];
            return randomChoice(options);
        }
        else if (hairscale > 0.05 && hairscale <= 0.1)
        {
            return "short";
        }
        else if (hairscale > 0.1 && hairscale <= 0.14)
        {
            return "shaggy";
        }
        else if (hairscale > 0.14 && hairscale <= 0.17)
        {
            return "moderately long";
        }
        else if (hairscale > 0.17 && hairscale <= 0.2)
        {
            if (rand(2) == 0)
            {
                return "long";
            }
            else
            {
                return "shoulder-length";
            }
        }
        else if (hairscale > 0.2 && hairscale <= 0.25)
        {
            return "very long";
        }
        else if (hairscale > 0.25 && hairscale <= 0.4)
        {
            return "back-covering";
        }
        else if (hairscale > 0.4 && hairscale <= 0.5)
        {
            return "ass-length";
        }
        else if (hairscale > 0.5 && hairscale <= 1)
        {
            return "obscenely long";
        }
        else if (hairscale > 1)
        {
            return "floor-length";
        }
        
        return "";
    }
    
    public static function ignoresStyle(creature : Dynamic) : Bool
    {
        var id : Int = creature.hairType;
        
        return Types[id].ignoresStyle || false;
    }
    private static var Hair_static_initializer = {
        EnumValue.add(Types, NORMAL, "NORMAL", {
                    name : "normal",
                    appearanceDesc : "Although not particularly remarkable, your {hairInfo} looks good on you, accentuating your features well."
                });
        EnumValue.add(Types, FEATHER, "FEATHER", {
                    name : "feather",
                    shortDesc : "feather-{hair}",
                    appearanceDesc : "Your {hairInfo} is made completely out of feathers rather than actual strands.",
                    ignoresStyle : true
                });
        EnumValue.add(Types, GHOST, "GHOST", {
                    name : "ghost",
                    shortDesc : "transparent {hair}",
                    appearanceDesc : "Although your {hairInfo} technically has the features of normal human hair, it is also completely transparent.",
                    beardDesc : "transparent "
                });
        EnumValue.add(Types, GOO, "GOO", {
                    name : "goopy",
                    shortDesc : "goo-{hair}",
                    appearanceDesc : "Atop your head is a gooey {hairInfo}, more like an amorphous blob imitating the familiar shape than the real deal.",
                    beardDesc : "gooey "
                });
        EnumValue.add(Types, ANEMONE, "ANEMONE", {
                    name : "tentacle",
                    shortDesc : "tentacle-{hair}",
                    appearanceDesc : "Your {hairInfo} is in truth made out of anemone tentacles, only vaguely resembling the real deal.",
                    beardDesc : "tentacley ",
                    ignoresStyle : true
                });
        EnumValue.add(Types, QUILL, "QUILL", {
                    name : "quill",
                    shortDesc : "quill-{hair}",
                    appearanceDesc : "Your {hairInfo} is made completely out of quills rather than actual strands.",
                    ignoresStyle : true
                });
        EnumValue.add(Types, GORGON, "GORGON", {
                    name : "snake-like",
                    shortDesc : "snakes-{hair}",
                    appearanceDesc : "Atop your head is technically {hairInfo}, if one were to ignore that it is made of snakes rather than actual hair.",
                    ignoresStyle : true
                });
        EnumValue.add(Types, LEAF, "LEAF", {
                    name : "leaf",
                    shortDesc : "leaf-{hair}",
                    appearanceDesc : "Considering how your {hairInfo} is made completely out of leaves, you seem to have some sort of connection to nature.",
                    beardDesc : "moss "
                });
        EnumValue.add(Types, FLUFFY, "FLUFFY", {
                    name : "fluffy",
                    shortDesc : "fluffy {hair}",
                    appearanceDesc : "You have a white pillowy {hair}, very much wooly to the touch and constantly trying to lull you to sleep anytime you lie against a surface.",
                    ignoresStyle : true
                });
        EnumValue.add(Types, GRASS, "GRASS", {
                    name : "grass",
                    shortDesc : "grass-{hair}",
                    appearanceDesc : "Rather than normal strands, your {hairInfo} is actually made entirely of grass, like some sort of nature spirit's."
                });
        EnumValue.add(Types, SILKEN, "SILKEN", {
                    name : "silky",
                    shortDesc : "elven {hair}",
                    appearanceDesc : "Your {hairInfo} is extremely glossy and smooth, its elvish features so perfect by human standards to the point of feeling unnatural."
                });
        EnumValue.add(Types, STORM, "STORM", {
                    name : "glowing lightning-shaped",
                    shortDesc : "lightning {hair}",
                    appearanceDesc : "Your {hairInfo}'s tips end in glowing lightning-shaped locks, crackling with electricity whenever you will them to."
                });
        EnumValue.add(Types, BURNING, "BURNING", {
                    name : "burning",
                    shortDesc : "burning hair",
                    appearanceDesc : "Your {hairInfo} has its tips overtaken by a magic flame, burning anything you wish it to and nothing more."
                });
        EnumValue.add(Types, SNOWY, "SNOWY", {
                    name : "snowy",
                    shortDesc : "snowy {hair}",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "Your {hairInfo} is human in appearance, but cold to the touch and regularly used as a nest by snow flurries";
                        
                        if (creature.rearBody.type == RearBody.GLACIAL_AURA)
                        {
                            desc += ", an effect amplified by your bone-chilling aura";
                        }
                        
                        desc += ".";
                        
                        return desc;
                    }
                });
        EnumValue.add(Types, FAIRY, "FAIRY", {
                    name : "otherworldly silky and almost translucent",
                    shortDesc : "silky fairy {hair}",
                    appearanceDesc : "Despite looking almost human, your {hairInfo} is otherworldly smooth and almost translucent, its fairy traits easy to notice if not identify."
                });
        EnumValue.add(Types, CRAZY, "CRAZY", {
                    name : "crazy",
                    shortDesc : "crazy {hair}",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "Your wild {hairInfo} is positively crazy. They are permanently stuck in a messed up spiky shape";
                        
                        if (creature.headjewelryName == "Machinist Goggles" || creature.headjewelryName == "Scanner goggles" || creature.headjewelryName == "S.A Tech Goggles")
                        {
                            desc += ". On top of them is your pair of trusty " + creature.headjewelryName + ". You never remove them, even for sex";
                        }
                        
                        desc += ".";
                        
                        return desc;
                    },
                    ignoresStyle : true
                });
        EnumValue.add(Types, WINDSWEPT, "WINDSWEPT", {
                    name : "windswept",
                    appearanceDesc : "Your {hairInfo} is quite aerodynamic, shaped as to avoid encumbering you even in a windstorm."
                });
        EnumValue.add(Types, RATATOSKR, "RATATOSKR", {
                    name : "stripped",
                    shortDesc : "stripped {hair}",
                    appearanceDesc : "Though your {hairInfo} could almost pass for human, it's stripped at the center with light tips not unlike the head of a chipmunk."
                });
        EnumValue.add(Types, PRISMATIC, "PRISMATIC", {
                    name : "prismatic",
                    shortDesc : "prismatic {hair}",
                    appearanceDesc : "Although your {hairInfo} looks mostly human, that notion is quickly discarded by its prismatic strands, varying in hue along their length to display all the colors of a rainbow."
                });
        EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
                    name : "mindbreaker",
                    shortDesc : "slimy tentacle {hair}",
                    appearanceDesc : "Your {hairInfo} is made out of tentacles, only vaguely resembling the real deal."
                });
        EnumValue.add(Types, MINDBREAKERMALE, "MINDBREAKERMALE", {
                    name : "mindbreaker",
                    shortDesc : "slimy tentacle {hair}",
                    appearanceDesc : "Smaller webbings frill along the top of your head, forming a crown-like ring. Along these frills are longer hair-like tentacles that reach down to drape past your shoulders, just above your pectorals."
                });
        EnumValue.add(Types, COW, "COW", {
                    name : "cow like",
                    shortDesc : "dark spoted {hair}",
                    appearanceDesc : "Your {hairInfo} looks about normal except that they have darker spot reminding of cow fur."
                });
        EnumValue.add(Types, DRIPPING, "DRIPPING", {
                    name : "dripping",
                    shortDesc : "dripping {hair}",
                    appearanceDesc : "Your {hairInfo} hair looks human at a first glance, but are, in fact, fine tendrils of flesh imitating human hairs, after all this body of yours is but a fleshy tongue mimicking human shape."
                });
        EnumValue.add(Types, PEAFOWL, "PEAFOWL", {
                    name : "p.feather",
                    shortDesc : "peafowl feather-{hair}",
                    appearanceDesc : "Your {hairInfo} is made completely out of feathers rather than actual strands. A beautiful crest adorns your head with small feathers that stick straight up, like a Mohawk.",
                    ignoresStyle : true
                });
        EnumValue.add(Styles, PLAIN, "PLAIN", {
                    name : "plain",
                    adjective : ""
                });
        EnumValue.add(Styles, WILD, "WILD", {
                    name : "wild",
                    adjective : "wild"
                });
        EnumValue.add(Styles, PONYTAIL, "PONYTAIL", {
                    name : "ponytail",
                    adjective : "ponytailed"
                });
        EnumValue.add(Styles, LONGTRESSES, "LONGTRESSES", {
                    name : "low ponytail",
                    adjective : "low-ponytailed"
                });
        EnumValue.add(Styles, TWINTAILS, "TWINTAILS", {
                    name : "twintails",
                    adjective : "twintailed"
                });
        EnumValue.add(Styles, DWARVEN, "DWARVEN", {
                    name : "dwarven",
                    adjective : "Dwarven"
                });
        EnumValue.add(Styles, SNOWLILY, "SNOWLILY", {
                    name : "snowlily",
                    adjective : "snowlily"
                });
        EnumValue.add(Styles, FOURWIND, "FOURWIND", {
                    name : "fourwind",
                    adjective : "fourwind"
                });
        EnumValue.add(Styles, FOURWINDL, "FOURWINDL", {
                    name : "long fourwind",
                    adjective : "long fourwind"
                });
        EnumValue.add(Styles, TAURPONYTAIL, "TAURPONYTAIL", {
                    name : "centaur ponytail",
                    adjective : "centaur ponytail"
                });
        EnumValue.add(Styles, TWINRIBBON, "TWINRIBBON", {
                    name : "twin ribbon",
                    adjective : "twin ribbon"
                });
        EnumValue.add(Styles, DESERTGRACE, "DESERTGRACE", {
                    name : "desert grace",
                    adjective : "desert grace"
                });
        true;
    }

}


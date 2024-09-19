/**
 * Created by aimozg on 27.04.2017.
 */
package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;
import classes.bodyParts.*;
import classes.internals.Utils;

class Face extends SaveableBodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 10)
	 * - id: name of the constant ("HUMAN", "SPIDER_FANGS")
	 * - name: human-readable name, ("human", "spider")
	 *
	 * - appearanceDesc: detailed description of the hair for PlayerAppearance.as
	 * - appearanceDescFunc: function that returns an appearanceDesc value (appearanceDesc is ignored if this exists)
	 *
	 * - humanShaped: whether the face still resembles a human
	 * - bite: whether the part allows attacking with teeth
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var HUMAN : Int = 0;
    
    public static inline var HORSE : Int = 1;
    
    public static inline var DOG : Int = 2;
    
    public static inline var COW_MINOTAUR : Int = 3;
    
    public static inline var SHARK_TEETH : Int = 4;
    
    public static inline var SNAKE_FANGS : Int = 5;
    
    public static inline var CAT : Int = 6;
    
    public static inline var LIZARD : Int = 7;
    
    public static inline var BUNNY : Int = 8;
    
    public static inline var KANGAROO : Int = 9;
    
    public static inline var SPIDER_FANGS : Int = 10;
    
    public static inline var FOX : Int = 11;
    
    public static inline var DRAGON : Int = 12;
    
    public static inline var RACCOON_MASK : Int = 13;
    
    public static inline var RACCOON : Int = 14;
    
    public static inline var BUCKTEETH : Int = 15;
    
    public static inline var MOUSE : Int = 16;
    
    public static inline var FERRET_MASK : Int = 17;
    
    public static inline var FERRET : Int = 18;
    
    public static inline var PIG : Int = 19;
    
    public static inline var BOAR : Int = 20;
    
    public static inline var RHINO : Int = 21;
    
    public static inline var ECHIDNA : Int = 22;
    
    public static inline var DEER : Int = 23;
    
    public static inline var WOLF : Int = 24;
    
    public static inline var MANTICORE : Int = 25;
    
    public static inline var SALAMANDER_FANGS : Int = 26;
    
    public static inline var YETI_FANGS : Int = 27;
    
    public static inline var ORCA : Int = 28;  //button 0 on 3rd page of metamorph  
    
    public static inline var PLANT_DRAGON : Int = 29;
    
    public static inline var DRAGON_FANGS : Int = 30;
    
    public static inline var DEVIL_FANGS : Int = 31;
    
    public static inline var ONI_TEETH : Int = 32;
    
    public static inline var WEASEL : Int = 33;
    
    public static inline var VAMPIRE : Int = 34;
    
    public static inline var BUCKTOOTH : Int = 35;
    
    public static inline var JABBERWOCKY : Int = 36;
    
    public static inline var RED_PANDA : Int = 37;
    
    public static inline var CAT_CANINES : Int = 38;
    
    public static inline var CHESHIRE : Int = 39;
    
    public static inline var CHESHIRE_SMILE : Int = 40;
    
    public static inline var AVIAN : Int = 41;
    
    public static inline var WOLF_FANGS : Int = 42;  //button 0 on 4th page of metamorph  
    
    public static inline var ORC_FANGS : Int = 43;
    
    public static inline var ANIMAL_TOOTHS : Int = 44;
    
    public static inline var BEAR : Int = 45;
    
    public static inline var PANDA : Int = 46;
    
    public static inline var FIRE_SNAIL : Int = 47;
    
    public static inline var GHOST : Int = 48;
    
    public static inline var JIANGSHI : Int = 49;
    
    public static inline var YUKI_ONNA : Int = 50;
    
    public static inline var KUDERE : Int = 51;
    
    public static inline var USHI_ONI : Int = 52;
    
    public static inline var FAIRY : Int = 53;
    
    public static inline var CRAZY : Int = 54;
    
    public static inline var SMUG : Int = 55;
    
    public static inline var SQUIRREL : Int = 56;
    
    public static inline var ELF : Int = 57;
    
    public static inline var ANT : Int = 58;
    
    public static inline var INNOCENT : Int = 59;
    
    public static inline var CERBERUS : Int = 60;
    
    public static inline var FOX_FANGS : Int = 61;
    
    public static inline var ABYSSAL_SHARK : Int = 62;
    
    public static inline var ARIGEAN : Int = 63;
    
    public static inline var DEMON : Int = 64;
    
    public static inline var TROLL : Int = 65;
    
    public static inline var GLACIAL_TROLL : Int = 66;
    
    
    public function new(creature : Creature)
    {
        super(creature, "facePart", []);
    }
    
    override public function restore(keepColor : Bool = true) : Void
    {
        super.restore(keepColor);
    }
    public function hasMuzzle() : Bool
    {
        return Types[type].hasMuzzle || false;
    }
    
    public function hasBeak() : Bool
    {
        return Types[type].hasBeak || false;
    }
    
    public function hasBeard() : Bool
    {
        return creature.beardLength > 0;
    }
    
    public function beard() : String
    {
        if (hasBeard())
        {
            return "beard";
        }
        //CoC_Settings.error("");
        else
        {
            
            return "ERROR: NO BEARD! <b>YOU ARE NOT A VIKING AND SHOULD TELL KITTEH IMMEDIATELY.</b>";
        }
    }
    public static function isHumanShaped(faceId : Int) : Bool
    {
        return Types[faceId].humanShaped || false;
    }
    public function nounPhrase() : String
    {
        var stringo : String = "";
        if (type == HUMAN)
        {
            return "face";
        }
        if (hasMuzzle())
        {
            if (trueOnceInN(3))
            {
                if (type == HORSE)
                {
                    stringo = "long ";
                }
                if (type == CAT)
                {
                    stringo = "feline ";
                }
                if (type == RHINO)
                {
                    stringo = "rhino ";
                }
                if (type == LIZARD || type == DRAGON)
                {
                    stringo = "reptilian ";
                }
                if (type == WOLF)
                {
                    stringo = "canine ";
                }
            }
            return stringo + randomChoice("muzzle", "snout", "face");
        }
        //3 - cowface
        if (type == COW_MINOTAUR)
        {
            if (trueOnceInN(4))
            {
                stringo = "bovine ";
            }
            return randomChoice("muzzle", stringo + "face");
        }
        //4 - sharkface-teeth
        if (type == SHARK_TEETH)
        {
            if (trueOnceInN(4))
            {
                stringo = "angular ";
            }
            return stringo + "face";
        }
        if (type == PIG || type == BOAR)
        {
            if (trueOnceInN(4))
            {
                stringo = ((type == PIG) ? "pig" : "boar") + "-like ";
            }
            if (trueOnceInN(4))
            {
                return stringo + "snout";
            }
            return stringo + "face";
        }
        return "face";
    }
    
    override public function descriptionFull() : String
    {
        return describe(false, true);
    }
    /**
	 * @param article (default false): Add an article a/an/the (default false): Describe femininity level
	 * @param deco (default false): If has decoration
	 */
    public function describe(article : Bool = false, deco : Bool = false) : String
    {
        var femininity : Float = creature.femininity;
        var a : String = "";
        var an : String = "";
        var the : String = "";
        if (article)
        {
            a = "a ";
            an = "an ";
            the = "the ";
        }
        return a + nounPhrase();
    }
    public function describeMF(article : Bool = false) : String
    {
        var faceo : String = "";
        var femininity : Float = creature.femininity;
        var a : String = "";
        var an : String = "";
        var the : String = "";
        if (article)
        {
            a = "a ";
            an = "an ";
            the = "the ";
        }
        //0-10
        if (femininity < 10)
        {
            faceo = a + "square chin";
            if (!hasBeard())
            {
                faceo += " and chiseled jawline";
            }
            else
            {
                faceo += ", chiseled jawline, and " + beard();
            }
            return faceo;
        }
        //10+ -20
        else if (femininity < 20)
        {
            faceo = a + "rugged look ";
            if (hasBeard())
            {
                faceo += "and " + beard();
            }
            return faceo + "that's surely handsome";
        }
        //21-28
        else if (femininity < 28)
        {
            return a + "well-defined jawline and a fairly masculine profile";
        }
        //28+-35
        else if (femininity < 35)
        {
            return a + "somewhat masculine, angular jawline";
        }
        //35-45
        else if (femininity < 45)
        {
            return the + "barest hint of masculinity on its features";
        }
        //45-55
        else if (femininity <= 55)
        {
            return an + "androgynous appearance that would look normal on a male or female";
        }
        //55+-65
        else if (femininity <= 65)
        {
            return a + "tiny touch of femininity to it, with gentle curves";
        }
        //65+-72
        else if (femininity <= 72)
        {
            return a + "nice set of cheekbones and lips that have the barest hint of pout";
        }
        //72+-80
        else if (femininity <= 80)
        {
            return a + "beautiful, feminine shapeliness that's sure to draw the attention of males";
        }
        //81-90
        else if (femininity <= 90)
        {
            return a + "gorgeous profile with full lips, a button nose, and noticeable eyelashes";
        }
        //91-100
        else
        {
            
            return a + "jaw-droppingly feminine shape with full, pouting lips, an adorable nose, and long, beautiful eyelashes";
        }
    }
    override private function loadFromOldSave(savedata : Dynamic) : Void
    {
        type = intOr(savedata.faceType, HUMAN);
    }
    override private function saveToOldSave(savedata : Dynamic) : Void
    {
        savedata.faceType = type;
    }
    
    public static function getAppearanceDescription(creature : Dynamic) : String
    {
        var id : Int = creature.faceType;
        
        var desc : String = "";
        
        
        if (Face.isHumanShaped(id))
        {
            if (creature.skin.coverage < Skin.COVERAGE_COMPLETE)
            {
                desc += "Your face is human in shape and structure";
                if (creature.skin.isCoverLowMid())
                {
                    desc += ", and on your cheeks you have [skin coat]";
                }
                desc += ".";
            }
            else
            {
                desc += "Under your [skin coat], you have a face which is human in shape and structure.";
            }
        }
        
        // Links the descriptions properly if the face is human-shaped
        return Utils.mergeSentences([desc, formatDescription(((Types[id].appearanceDescFunc) ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature)], "; however, ");
    }
    
    private static function formatDescription(desc : String, creature : Dynamic) : String
    {
        var upperCasePattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('^.', "");
        
        return upperCasePattern.replace(desc, function(__DOLLAR__0 : Dynamic) : Dynamic
                {
                    return __DOLLAR__0.toUpperCase();
                });
    }
    private static var Face_static_initializer = {
        EnumValue.add(Types, HUMAN, "HUMAN", {
                    name : "human",
                    appearanceDesc : "",
                    humanShaped : true
                });
        EnumValue.add(Types, HORSE, "HORSE", {
                    name : "horse",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        if (!creature.hasCoat())
                        {
                            desc += "Your face is equine in shape and structure. The odd visage is hairless and covered with [skin base]";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "Your face is almost entirely equine in appearance, even having [skin coat]. Underneath the fur, you believe you have [skin base].";
                        }
                        else
                        {
                            desc += "You have the face and head structure of a horse, overlaid with glittering [skin coat].";
                        }
                        return desc;
                    },
                    hasMuzzle : true
                });
        EnumValue.add(Types, DOG, "DOG", {
                    name : "dog",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        if (!creature.hasCoat())
                        {
                            desc += "You have a dog-like face, complete with a wet nose. The odd visage is hairless and covered with [skin base].";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "You have a dog's face, complete with wet nose and panting tongue. You've got [skin coat], hiding your [skin base] underneath your furry visage.";
                        }
                        else
                        {
                            desc += "You have the facial structure of a dog, wet nose and all, but overlaid with glittering patches of [skin coat]";
                        }
                        return desc;
                    },
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, COW_MINOTAUR, "COW_MINOTAUR", {
                    name : "cow",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        if (!creature.hasCoat())
                        {
                            desc += "You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose. Despite your lack of fur elsewhere, your visage does have a short layer of [haircolor] fuzz.";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose. Your [skin coat] thickens noticeably on your head, looking shaggy and more than a little monstrous once laid over your visage.";
                        }
                        else if (creature.hasFullCoat())
                        {
                            desc += "Your face resembles a minotaur's, though strangely it is covered in shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.";
                        }
                        else
                        {
                            desc += "Your face resembles a minotaur's, though strangely it is covered small patches of shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.";
                        }
                        return desc;
                    }
                });
        EnumValue.add(Types, SHARK_TEETH, "SHARK_TEETH", {
                    name : "shark",
                    appearanceDesc : "A set of razor-sharp, retractable shark-teeth fill your mouth and gives your visage a slightly angular appearance.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, SNAKE_FANGS, "SNAKE_FANGS", {
                    name : "snake",
                    appearanceDesc : "A pair of fangs hang over your lower lip, dripping with venom.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, CAT, "CAT", {
                    name : "cat",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        if (!creature.hasCoat())
                        {
                            desc += "You have a cat-like face, complete with a cute, moist nose and whiskers. The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face.";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "You have a cat-like face, complete with moist nose and whiskers. Your [skin coat.nocolor] is [fur color], hiding your [skin base] underneath.";
                        }
                        else
                        {
                            desc += "Your facial structure blends humanoid features with those of a cat. A moist nose and whiskers are included, but overlaid with glittering patches of [skin coat].";
                        }
                        
                        return desc;
                    },
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, LIZARD, "LIZARD", {
                    name : "lizard",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        if (!creature.hasCoat())
                        {
                            desc += "You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage. The reptilian visage does look a little odd with just [skin].";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "You have a face resembling that of a lizard. Between the toothy maw, pointed snout, and the layer of [skin coat] covering your face, you have quite the fearsome visage.";
                        }
                        else if (creature.hasFullCoat())
                        {
                            desc += "Your face is that of a lizard, complete with a toothy maw and pointed snout. Reflective [skin coat] complete the look, making you look quite fearsome.";
                        }
                        else
                        {
                            desc += "You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage. The reptilian visage does look a little odd with just [skin coat].";
                        }
                        
                        return desc;
                    },
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, BUNNY, "BUNNY", {
                    name : "bunny",
                    appearanceDesc : "The constant twitches of your nose and the length of your incisors gives your visage a hint of bunny-like cuteness.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, KANGAROO, "KANGAROO", {
                    name : "kangaroo",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        desc += "Your face is ";
                        if (!creature.hasCoat())
                        {
                            desc += "bald";
                        }
                        else
                        {
                            desc += "covered with [skin coat]";
                        }
                        desc += " and shaped like that of a kangaroo, somewhat rabbit-like except for the extreme length of your odd visage.";
                        
                        return desc;
                    },
                    hasMuzzle : true
                });
        EnumValue.add(Types, SPIDER_FANGS, "SPIDER_FANGS", {
                    name : "spider",
                    appearanceDesc : "A set of retractable, needle-like fangs sit in place of your canines and are ready to dispense their venom.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, FOX, "FOX", {
                    name : "fox",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        desc += "You have a tapered, shrewd-looking vulpine face with a speckling of downward-curved whiskers just behind the nose.";
                        if (!creature.hasCoat())
                        {
                            desc += " Oddly enough, there's no fur on your animalistic muzzle, just [skin coat].";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += " A coat of [skin coat] decorates your muzzle.";
                        }
                        else if (creature.skin.isCoverLowMid())
                        {
                            desc += " Strangely, [skin coat] adorn your animalistic visage.";
                        }
                        else
                        {
                            desc += " Strangely, [skin coat] adorn every inch of your animalistic visage.";
                        }
                        
                        return desc;
                    },
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, DRAGON, "DRAGON", {
                    name : "dragon",
                    appearanceDesc : "Your face is a narrow, reptilian muzzle. It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw. It gives you a regal but fierce visage. Opening your mouth reveals several rows of dagger-like sharp teeth. The fearsome visage is decorated by [skin coat].",
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, RACCOON_MASK, "RACCOON_MASK", {
                    name : "raccoon mask",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        desc += "You have a sly-looking raccoon mask over your eyes";
                        
                        if (!creature.hasCoat())
                        {
                            if (InCollection(creature.skin.base.color, "ebony", "black"))
                            {
                                desc += ", although it isn't properly visible with your dusky hue";
                            }
                        }
                        else if (InCollection(creature.skin.base.color, "black", "midnight", "black", "midnight", "black", "midnight"))
                        {
                            desc += ", hidden under your [skin coat] and barely visible due to your inky hue";
                        }
                        
                        desc += ".";
                        
                        return desc;
                    },
                    humanShaped : true
                });
        EnumValue.add(Types, RACCOON, "RACCOON", {
                    name : "raccoon",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        desc += "You have a triangular raccoon face, including sensitive whiskers and a little black nose; a mask shades the space around your eyes, ";
                        if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "set apart from your [skin coat] by a band of white.";
                        }
                        else
                        {
                            desc += "encircled by a band of white.";
                        }
                        
                        if (creature.hasPlainSkinOnly())
                        {
                            desc += " It looks a bit strange with no fur coverage.";
                        }
                        else if (creature.hasScaleMaterial())
                        {
                            desc += " The presence of said scales gives your visage an eerie look, more reptile than mammal.";
                        }
                        else if (creature.hasChitinMaterial())
                        {
                            desc += " The presence of said chitin gives your visage an eerie look, more insect than mammal.";
                        }
                        
                        return desc;
                    },
                    bite : true
                });
        EnumValue.add(Types, BUCKTEETH, "BUCKTEETH", {
                    name : "buckteeth",
                    appearanceDesc : "You have very noticeably mousey buckteeth.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, MOUSE, "MOUSE", {
                    name : "mouse",
                    appearanceDesc : "You have a snubby, tapered mouse's face, with whiskers and a little pink nose. Two large incisors complete it.",
                    bite : true
                });
        EnumValue.add(Types, FERRET_MASK, "FERRET_MASK", {
                    name : "ferret mask",
                    appearanceDesc : "The [skinFurScales] around your eyes is significantly darker than the rest of your face, giving you a cute little ferret mask.",
                    humanShaped : true
                });
        EnumValue.add(Types, FERRET, "FERRET", {
                    name : "ferret",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "Your face is coated in [skin coat] with [skin base] underneath, an adorable cross between human and ferret features. It is complete with a wet nose and whiskers.";
                        }
                        else if (creature.hasCoat())
                        {
                            desc += "Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers. The only oddity is [skin base] covered with [skin coat].";
                        }
                        else
                        {
                            desc += "Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers. The only oddity is your lack of fur, leaving only [skin] visible on your ferret-like face.";
                        }
                        
                        return desc;
                    },
                    bite : true
                });
        EnumValue.add(Types, PIG, "PIG", {
                    name : "pig",
                    appearanceDesc : "Your face is like that of a pig, complete with a snout that is always wiggling."
                });
        EnumValue.add(Types, BOAR, "BOAR", {
                    name : "boar",
                    appearanceDesc : "Your face is like that of a boar, complete with tusks and a snout that is always wiggling."
                });
        EnumValue.add(Types, RHINO, "RHINO", {
                    name : "rhino",
                    appearanceDesc : "Your face is like that of a rhino, complete with a long muzzle and a horns on your nose.",
                    hasMuzzle : true
                });
        EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
                    name : "echidna",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        desc += "Your odd visage consists of a long, thin echidna snout";
                        
                        if (!creature.hasCoat())
                        {
                            desc += ", though it looks rather strange without any coverage whatsoever";
                        }
                        
                        desc += ".";
                        
                        return desc;
                    },
                    hasMuzzle : true
                });
        EnumValue.add(Types, DEER, "DEER", {
                    name : "deer",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        desc += "Your face is like that of a deer, with a nose at the end of your muzzle";
                        
                        if (!creature.hasCoat())
                        {
                            desc += ", though it looks rather strange without any coverage whatsoever";
                        }
                        
                        desc += ".";
                        
                        return desc;
                    },
                    hasMuzzle : true
                });
        EnumValue.add(Types, WOLF, "WOLF", {
                    name : "wolf",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        if (!creature.hasCoat())
                        {
                            desc += "You have a wolf-like face, complete with a wet nose. ";
                            if (creature.hasKeyItem("Gleipnir Collar") >= 0)
                            {
                                desc += "Your breath freezes the air, and cold mist leaks from your jaws. ";
                            }
                            desc += "The odd visage is hairless and covered with [skin coat].";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "You have a wolf’s face, complete with wet nose a panting tongue and threatening teeth. ";
                            if (creature.hasKeyItem("Gleipnir Collar") >= 0)
                            {
                                desc += "Your breath freezes the air, and cold mist leaks from your jaws. ";
                            }
                            desc += "You've got [skin coat], hiding your [skin noadj] underneath your furry visage.";
                        }
                        else
                        {
                            desc += "You have the facial structure of a wolf, wet nose and all, but overlaid with glittering patches of [skin coat].";
                            if (creature.hasKeyItem("Gleipnir Collar") >= 0)
                            {
                                desc += " Your breath freezes the air, and cold mist leaks from your jaws.";
                            }
                        }
                        
                        return desc;
                    },
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, MANTICORE, "MANTICORE", {
                    name : "manticore",
                    appearanceDesc : "You have a set of sharp cat-like teeth in your mouth.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, SALAMANDER_FANGS, "SALAMANDER_FANGS", {
                    name : "salamander",
                    appearanceDesc : "A pair of salamander fangs grows out of your mouth giving you a menacing smile.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, YETI_FANGS, "YETI_FANGS", {
                    name : "yeti",
                    appearanceDesc : "Your mouth, while human-looking, has sharp yeti fangs.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, ORCA, "ORCA", {
                    name : "orca",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        if (creature.skin.hasPlainSkinOnly() && creature.skinAdj == "glossy" && creature.skinColor == "white and black")
                        {
                            desc += "You have a wider yet adorable nose, and your face is pitch black with a white underbelly; from your neck up to your mouth and lower cheeks your face is white with two extra white circles right under and above your eyes.";
                        }
                        else
                        {
                            desc += "You have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.";
                        }
                        
                        return desc;
                    },
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, PLANT_DRAGON, "PLANT_DRAGON", {
                    name : "plant dragon",
                    appearanceDesc : "Your face is a narrow, reptilian and regal, reminiscent of a dragon. A [skin coat] decorates your visage.",
                    bite : true
                });
        EnumValue.add(Types, DRAGON_FANGS, "DRAGON_FANGS", {
                    name : "dragon fangs",
                    appearanceDesc : "Your mouth is somewhat human save for your draconic fangs giving you a menacing smile. It's decorated by [skin coat].",
                    bite : true
                });
        EnumValue.add(Types, DEVIL_FANGS, "DEVIL_FANGS", {
                    name : "devil fangs",
                    appearanceDesc : "Your mouth looks human enough, save for your fiendish canines. It's decorated by [skin coat].",
                    bite : true
                });
        EnumValue.add(Types, ONI_TEETH, "ONI_TEETH", {
                    name : "oni teeth",
                    appearanceDesc : "You have two large ogre canines in your mouth.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, WEASEL, "WEASEL", {
                    name : "weasel",
                    appearanceDesc : "You have two sharp weasel canines in your mouth.",
                    bite : true
                });
        EnumValue.add(Types, VAMPIRE, "VAMPIRE", {
                    name : "vampire",
                    appearanceDesc : "You own a pair of long and pointy vampire canines meant to pierce into victims and reach their blood.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, BUCKTOOTH, "BUCKTOOTH", {
                    name : "jabberwocky bucktooth",
                    appearanceDesc : "You have two abnormally large buck tooth, like a Jabberwocky.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {
                    name : "jabberwocky",
                    appearanceDesc : "Your face is a narrow, reptilian muzzle. It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw. It gives you a regal but fierce visage. Opening your mouth reveals two buck tooth, which are abnormally large, like a rabbit, or rather a Jabberwocky. The fearsome visage is decorated by [skin coat].",
                    bite : true
                });
        EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
                    name : "red panda",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        desc += "Your face has a distinctive animalistic muzzle, proper from a red-panda, complete with a cute pink nose";
                        
                        if (!creature.hasCoat())
                        {
                            desc += ", though it looks rather strange without any coverage whatsoever";
                        }
                        
                        desc += ".";
                        
                        return desc;
                    },
                    bite : true
                });
        EnumValue.add(Types, CAT_CANINES, "CAT_CANINES", {
                    name : "cat canines",
                    appearanceDesc : "You have a pair of cat-like canines in your mouth.",
                    bite : true
                });
        EnumValue.add(Types, CHESHIRE, "CHESHIRE", {
                    name : "cheshire cat",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        if (!creature.hasCoat())
                        {
                            desc += "You have a cat-like face, complete with a cute, moist nose and whiskers. The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face.";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "You have a cat-like face, complete with moist nose and whiskers. Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.";
                        }
                        else
                        {
                            desc += "Your facial structure blends humanoid features with those of a cat. A moist nose and whiskers are included, but overlaid with glittering patches of [skin coat].";
                        }
                        desc += " For some reason your facial expression is that of an everlasting yet unsettling grin.";
                        
                        return desc;
                    },
                    bite : true
                });
        EnumValue.add(Types, CHESHIRE_SMILE, "CHESHIRE_SMILE", {
                    name : "cheshire smile",
                    appearanceDesc : "You have a pair of cat-like canines in your mouth, and for some reason your facial expression is that of an everlasting yet unsettling grin.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, AVIAN, "AVIAN", {
                    name : "avian",
                    appearanceDesc : "Your visage has a bird-like appearance, complete with an avian beak. A couple of small holes on it makes up for your nostrils, while a long, nimble tongue is hidden inside.",
                    bite : true,
                    hasBeak : true
                });
        EnumValue.add(Types, WOLF_FANGS, "WOLF_FANGS", {
                    name : "wolf fangs",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        if (!creature.hasCoat())
                        {
                            desc += " Your face is human in shape and structure with [skin coat]. Your mouth is somewhat human save for your wolf-like canines.";
                        }
                        else if (creature.hasPartialCoat(Skin.FUR))
                        {
                            desc += " Your face looks human save for your wolf-like canines, but overlaid with glittering patches of [skin coat].";
                        }
                        else
                        {
                            desc += " Your face looks human save for your wolf-like canines. You've got [skin coat], hiding your [skin noadj] underneath your furry visage.";
                        }
                        
                        return desc;
                    },
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, ORC_FANGS, "ORC_FANGS", {
                    name : "orc fangs",
                    appearanceDesc : "Your two lower canines resemble boar tusks poking out of your mouth.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, ANIMAL_TOOTHS, "ANIMAL_TOOTHS", {
                    name : "animal teeth",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        if (!creature.hasCoat())
                        {
                            desc += "Your face looks human save for your sharp canines.";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "Your face looks human save for your sharp canines. Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.";
                        }
                        else
                        {
                            desc += "Your face looks human save for your sharp canines, but overlaid with glittering patches of [skin coat].";
                        }
                        if (creature.eyes.type == Eyes.CENTIPEDE)
                        {
                            desc += " You wear a constant expression of sadness, barely drawing attention away from your mouth.";
                        }
                        
                        return desc;
                    },
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, BEAR, "BEAR", {
                    name : "bear",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        desc += "Your face is that of a bear with an adorable wet nose and sharp teeth";
                        
                        if (!creature.hasCoat())
                        {
                            desc += ", though it looks rather strange without any coverage whatsoever";
                        }
                        
                        desc += ".";
                        
                        return desc;
                    },
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, PANDA, "PANDA", {
                    name : "panda",
                    appearanceDesc : "Your face is that of a panda with an adorable wet nose and sharp teeth. Your face fur, much like most of your body, is white with two black circles right around your eyes.",
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {
                    name : "fire snail",
                    appearanceDesc : "Your mouth is drooling from constant arousal.",
                    humanShaped : true
                });
        EnumValue.add(Types, GHOST, "GHOST", {
                    name : "ghost",
                    appearanceDesc : "You have a perpetual wide smile on your face, hiding your true feelings at all times.",
                    humanShaped : true
                });
        EnumValue.add(Types, JIANGSHI, "JIANGSHI", {
                    name : "jiangshi",
                    appearanceDesc : "Your expression is permanently dazed, as though you're in an eternal trance.",
                    humanShaped : true
                });
        EnumValue.add(Types, YUKI_ONNA, "YUKI_ONNA", {
                    name : "yuki onna",
                    appearanceDesc : "Your lips, as lacking in wamth as the rest of your body, are dyed blue by the cold.",
                    humanShaped : true
                });
        EnumValue.add(Types, KUDERE, "KUDERE", {
                    name : "kuudere",
                    appearanceDesc : "Your face shows no emotions whatsoever, hiding your true feelings at all times.",
                    humanShaped : true
                });
        EnumValue.add(Types, USHI_ONI, "USHI_ONI", {
                    name : "ushi-oni",
                    appearanceDesc : "You have strange black tattoos circling your eyes and small fangs in your mouth ready to inject its victims with a weak poison.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, FAIRY, "FAIRY", {
                    name : "fairy",
                    appearanceDesc : "Your fairy nature allows you to always display a pure, cheerful, innocent smile that warms the hearts of those around you.",
                    humanShaped : true
                });
        EnumValue.add(Types, CRAZY, "CRAZY", {
                    name : "crazy",
                    appearanceDesc : "Your mouth is human all right though your near constant crazy toothy smile isn't exactly helping to make you look sane.",
                    humanShaped : true
                });
        EnumValue.add(Types, SMUG, "SMUG", {
                    name : "smug",
                    appearanceDesc : "The length of your incisors gives your visage a hint of squirrel-like cuteness, and once in a while you can't help but smirk smuggly at your interlocutors.",
                    humanShaped : true
                });
        EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
                    name : "squirrel",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        if (!creature.hasCoat())
                        {
                            desc += "You have a squirrel-like face, complete with a twitching nose. The odd visage is hairless and covered with [skin base].";
                        }
                        else if (creature.hasFullCoatOfType(Skin.FUR))
                        {
                            desc += "You have a squirrel's face, complete with twitching nose and two incisors. You've got [skin coat], hiding your [skin base] underneath your furry visage.";
                        }
                        else
                        {
                            desc += "You have the facial structure of a squirrel, twitching nose incisors and all, but overlaid with glittering patches of [skin coat]";
                        }
                        
                        return desc;
                    },
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, ELF, "ELF", {
                    name : "elf",
                    appearanceDesc : "You have an enchanting smile and faultless pearlescent white teeth, so unnaturally perfect it makes you seem as though you came straight from a painting rather than real life.",
                    humanShaped : true
                });
        EnumValue.add(Types, ANT, "ANT", {
                    name : "ant",
                    appearanceDesc : "Your face looks largely human, except for the mandibles sticking out from your jawline.",
                    humanShaped : true,
                    bite : true
                });
        EnumValue.add(Types, INNOCENT, "INNOCENT", {
                    name : "innocent expression",
                    appearanceDesc : "Your face is human in shape and structure. You bear an innocent and almost angelic smile which soothes the soul of those who see you.",
                    humanShaped : true
                });
        EnumValue.add(Types, CERBERUS, "CERBERUS", {
                    name : "cerberus",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        desc += "You have a dog's face, complete with wet nose and panting tongue. You've got [skin coat], hiding your [skin base] underneath your furry visage. " +
                        "Flanking your main head are two more wich never truly fully agree with one another. You regularly need to put them back in their place and remind them who leads this body lest they start fighting each other.";
                        return desc;
                    },
                    bite : true,
                    hasMuzzle : true
                });
        EnumValue.add(Types, FOX_FANGS, "FOX_FANGS", {
                    name : "fox fangs",
                    appearanceDescFunc : function(creature : Dynamic) : String
                    {
                        var desc : String = "";
                        
                        if (!creature.hasCoat())
                        {
                            desc += " Your face is human in shape and structure with [skin coat]. Your mouth is somewhat human save for your fox-like canines.";
                        }
                        else if (creature.hasPartialCoat(Skin.FUR))
                        {
                            desc += " Your face looks human save for your fox-like canines, but overlaid with glittering patches of [skin coat].";
                        }
                        else
                        {
                            desc += " Your face looks human save for your fox-like canines. You've got [skin coat], hiding your [skin noadj] underneath your furry visage.";
                        }
                        
                        return desc;
                    },
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, ABYSSAL_SHARK, "ABYSSAL_SHARK", {
                    name : "abyss shark",
                    appearanceDesc : "Your face is of a hammer-head shark in both shape and structure. A razor-sharp set of retractable teeth fill your large mouth, giving your visage an angular silhouette.",
                    bite : true
                });
        EnumValue.add(Types, ARIGEAN, "ARIGEAN", {
                    name : "arigean",
                    appearanceDesc : "Your face is human in shape and structure except for the insides of your mouth which seem to be a light blue instead of the traditional pink, most likely caused by your blue blood.",
                    humanShaped : true
                });
        EnumValue.add(Types, DEMON, "DEMON", {
                    name : "demon",
                    appearanceDesc : "Your face is human in shape and structure albeith far too sexy to belong to one. With a face that hot, who would refuse you? Hidden behind your sensual lips is a pair of small fangs which betrays your fiendish nature.",
                    bite : true
                });
        EnumValue.add(Types, TROLL, "TROLL", {
                    name : "troll",
                    appearanceDesc : "Your have a face as that of a troll, covered in soft, green fur and a duo of tusks from your upper jaw that splits out from your mouth.",
                    bite : true,
                    humanShaped : true
                });
        EnumValue.add(Types, GLACIAL_TROLL, "GLACIAL_TROLL", {
                    name : "g.troll",
                    appearanceDesc : "Your have a face as that of a glacial troll, covered in soft, white fur and a duo of tusks from your upper jaw that splits out from your mouth.",
                    bite : true,
                    humanShaped : true
                });
        true;
    }

}


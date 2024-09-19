package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.Skin;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class SkinPatternMem extends BaseContent
{
    /**
	 * Entry properties:
	 * - id: the identificator of the Metamorph inside GeneticStorage
	 * - name: how the Metamorph is referred to in displayed texts
	 * - cost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - title: name displayed on the metamorph button
	 * - unlockText: additional text displayed when Metamorph is unlocked
	 * - transformation: TF object that refers to what the metamorph does
	 *
	 * Optional properties:
	 * - info: additional text to be shown underneath the Metamorph cost in the menu when hovering over a button
	 * - lockedInfo: additional text to be shown on *locked* Metamorphs when hovering over a button
	 * - permCost: how many Ascension Perk Points it costs to permanentize this Metamorph, defaults to 5 if not added
	 * - permReq: the ID of another Metamorph which must be permanentized first before the current one can be bought

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			id: [Name Saved in GeneticStorage],
			name: [Name Displayed in Texts],
			cost: [Cost Here],
			title: [Race Here],
			unlockText: [Text Displayed On Unlocking Metamorph Here],
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			}
		});

	 */
    
    public static var Memories : Array<Dynamic> = [];
    private static var _partid : Int = 0;
    
    public static var NONE : Int = _partid++;
    
    
    public static var MAGICAL : Int = _partid++;
    
    
    public static var PATTERN_VENOMOUS_MARKINGS : Int = _partid++;
    
    
    public static var BATTLE : Int = _partid++;
    
    
    public static var LIGHTNING_SHAPED : Int = _partid++;
    
    
    public static var SCAR_SHAPED : Int = _partid++;
    
    
    public static var OIL : Int = _partid++;
    
    
    public static var BEE_STRIPES : Int = _partid++;
    
    
    public static var SHARK_STRIPES : Int = _partid++;
    
    
    public static var ORCA_UNDERBODY : Int = _partid++;
    
    
    public static var SEA_DRAGON_UNDERBODY : Int = _partid++;
    
    
    public static var SCAR_WINDSWEPT : Int = _partid++;
    
    
    public static var BLACK_WHITE_VEINS : Int = _partid++;
    
    
    public static var GLYPH : Int = _partid++;
    
    
    public static var BIOLUMINESCENCE : Int = _partid++;
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var SkinPatternMem_static_initializer = {
        EnumValue.add(Memories, NONE, "NONE", {
                    id : "Unlocked Metamorph",
                    name : "No Skin Pattern",
                    cost : 500,
                    title : "None",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternNone;
                    }
                });
        EnumValue.add(Memories, MAGICAL, "MAGICAL", {
                    id : "Kitsune Skin Pattern",
                    name : "Runic Kitsune Tattoos",
                    cost : 100,
                    title : "Kitsune",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternKitsune;
                    }
                });
        EnumValue.add(Memories, PATTERN_VENOMOUS_MARKINGS, "PATTERN_VENOMOUS_MARKINGS", {
                    id : "VenomousMarkings Pattern",
                    name : "VenomousMarkings Pattern",
                    cost : 100,
                    title : "VenomousMarkings",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternVenomousMarkings;
                    }
                });
        EnumValue.add(Memories, BATTLE, "BATTLE", {
                    id : "Oni Skin Pattern",
                    name : "Oni Battle Tattoos",
                    cost : 100,
                    title : "Oni",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternOni;
                    }
                });
        EnumValue.add(Memories, LIGHTNING_SHAPED, "LIGHTNING_SHAPED", {
                    id : "Raiju Skin Pattern",
                    name : "Lightning-shaped Raiju Tattoos",
                    cost : 100,
                    title : "Raiju",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternRaiju;
                    }
                });
        EnumValue.add(Memories, SCAR_SHAPED, "SCAR_SHAPED", {
                    id : "Orc Skin Pattern",
                    name : "Scar-shaped Orc Tattoos",
                    cost : 100,
                    title : "Orc",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternOrc;
                    }
                });
        EnumValue.add(Memories, OIL, "OIL", {
                    id : "Gazer Skin Pattern",
                    name : "Drips black fluids",
                    cost : 100,
                    title : "Gazer",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternOil;
                    }
                });
        EnumValue.add(Memories, BEE_STRIPES, "BEE_STRIPES", {
                    id : "Bee Skin Pattern",
                    name : "Bee Stripes",
                    cost : 200,
                    title : "Bee Stripes",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternBeeStripes;
                    },
                    info : "Includes Chitin skin"
                });
        EnumValue.add(Memories, SHARK_STRIPES, "SHARK_STRIPES", {
                    id : "Tiger Shark Skin Pattern",
                    name : "Shark Stripes",
                    cost : 200,
                    title : "Shark Stripes",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternTigerSharkStripes;
                    },
                    info : "Includes Aqua Scales skin"
                });
        EnumValue.add(Memories, ORCA_UNDERBODY, "ORCA_UNDERBODY", {
                    id : "Orca Skin Pattern",
                    name : "Orca Underbody",
                    cost : 100,
                    title : "Orca",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternOrca;
                    }
                });
        EnumValue.add(Memories, SEA_DRAGON_UNDERBODY, "SEA_DRAGON_UNDERBODY", {
                    id : "Sea Dragon Skin Pattern",
                    name : "Sea Dragon Underbody",
                    cost : 100,
                    title : "Sea Dragon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternSeaDragon;
                    }
                });
        EnumValue.add(Memories, SCAR_WINDSWEPT, "SCAR_WINDSWEPT", {
                    id : "Windswept Scar",
                    name : "Windswept Scar",
                    cost : 100,
                    title : "Kamaitachi",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternScarWindswept;
                    }
                });
        EnumValue.add(Memories, BLACK_WHITE_VEINS, "BLACK_WHITE_VEINS", {
                    id : "Black & White Veins",
                    name : "Black & White Veins",
                    cost : 100,
                    title : "Black & White Veins",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternWhiteBlackVeins;
                    }
                });
        EnumValue.add(Memories, GLYPH, "GLYPH", {
                    id : "Anubis Glyph Pattern",
                    name : "Glyph Tattoos",
                    cost : 100,
                    title : "Anubis",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternAnubis;
                    }
                });
        EnumValue.add(Memories, BIOLUMINESCENCE, "BIOLUMINESCENCE", {
                    id : "Bioluminescent Patterns",
                    name : "Bioluminescent Patterns",
                    cost : 100,
                    title : "Bioluminescence",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPatternBioluminescence;
                    }
                });
        true;
    }

}


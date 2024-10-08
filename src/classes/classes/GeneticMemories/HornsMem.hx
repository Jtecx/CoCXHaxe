package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.Horns;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class HornsMem extends BaseContent
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
    
    
    public static var ANTLER : Int = _partid++;
    
    
    public static var BICORN : Int = _partid++;
    
    
    public static var COW_MINOTAUR : Int = _partid++;
    
    
    public static var DEMON : Int = _partid++;
    
    
    public static var DRACONIC_X2 : Int = _partid++;
    
    
    public static var DRACONIC_X4 : Int = _partid++;
    
    
    public static var FROSTWYRM : Int = _partid++;
    
    
    public static var GHOSTLY_WISP : Int = _partid++;
    
    
    public static var GOAT : Int = _partid++;
    
    
    public static var GOATQUAD : Int = _partid++;
    
    
    public static var JABBERWOCKY : Int = _partid++;
    
    
    public static var ONI : Int = _partid++;
    
    
    public static var ONI_X2 : Int = _partid++;
    
    
    public static var SEA_DRAGON : Int = _partid++;
    
    
    public static var UNICORN : Int = _partid++;
    
    
    public static var KIRIN : Int = _partid++;
    
    
    public static var OAK : Int = _partid++;
    
    
    public static var ORCHID : Int = _partid++;
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var HornsMem_static_initializer = {
        EnumValue.add(Memories, NONE, "NONE", {
                    id : "Unlocked Metamorph",
                    name : "No Horns",
                    cost : 500,
                    title : "No Horns",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsNone;
                    }
                });
        EnumValue.add(Memories, ANTLER, "ANTLER", {
                    id : "Antler Horns",
                    name : "Antler Horns",
                    cost : 100,
                    title : "Antlers",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsAntlers;
                    }
                });
        EnumValue.add(Memories, BICORN, "BICORN", {
                    id : "Bicorn Horns",
                    name : "Bicorn Horns",
                    cost : 100,
                    title : "Bicorn",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsBicorn;
                    }
                });
        EnumValue.add(Memories, COW_MINOTAUR, "COW_MINOTAUR", {
                    id : "Cow Minotaur Horns",
                    name : "Bovine Horns",
                    cost : 100,
                    title : "Bovine",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsCowMinotaur;
                    }
                });
        EnumValue.add(Memories, DEMON, "DEMON", {
                    id : "Demon Horns",
                    name : "Demon Horns",
                    cost : 100,
                    title : "Demon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsDemonic;
                    }
                });
        EnumValue.add(Memories, DRACONIC_X2, "DRACONIC_X2", {
                    id : "Draconic Dual Horns",
                    name : "Draconic Dual Horns",
                    cost : 100,
                    title : "Draconic x2",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsDraconicDual;
                    }
                });
        EnumValue.add(Memories, DRACONIC_X4, "DRACONIC_X4", {
                    id : "Draconic Quadruple Horns",
                    name : "Draconic Quadruple Horns",
                    cost : 200,
                    title : "Draconic x4",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsDraconicQuadruple;
                    }
                });
        EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
                    id : "Frostwyrm Horns",
                    name : "Frostwyrm Horns",
                    cost : 100,
                    title : "Frostwyrm",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsFrostwyrm;
                    }
                });
        EnumValue.add(Memories, GHOSTLY_WISP, "GHOSTLY_WISP", {
                    id : "Ghostly Whisps",
                    name : "Ghostly Whisps",
                    cost : 100,
                    title : "Ghostly Whisps",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsGhostlyWisps;
                    }
                });
        EnumValue.add(Memories, GOAT, "GOAT", {
                    id : "Goat Horns",
                    name : "Goat Horns",
                    cost : 100,
                    title : "Goat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsGoat;
                    }
                });
        EnumValue.add(Memories, GOATQUAD, "GOATQUAD", {
                    id : "Quad Goat Horns",
                    name : "Quad Goat Horns",
                    cost : 100,
                    title : "Quad Goat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsGoatQuadruple;
                    }
                });
        EnumValue.add(Memories, JABBERWOCKY, "JABBERWOCKY", {
                    id : "Jabberwocky Horns",
                    name : "Jabberwocky Horns",
                    cost : 100,
                    title : "Jabberwocky",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsJabberwocky;
                    }
                });
        EnumValue.add(Memories, ONI, "ONI", {
                    id : "Oni Horn",
                    name : "Oni Horn",
                    cost : 100,
                    title : "Oni",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsOni;
                    }
                });
        EnumValue.add(Memories, ONI_X2, "ONI_X2", {
                    id : "Oni Dual Horns",
                    name : "Oni Dual Horns",
                    cost : 100,
                    title : "Oni x2",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsOniDual;
                    }
                });
        EnumValue.add(Memories, SEA_DRAGON, "SEA_DRAGON", {
                    id : "Sea dragon Horns",
                    name : "Sea dragon Horns",
                    cost : 100,
                    title : "Sea dragon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsSeadragon;
                    }
                });
        EnumValue.add(Memories, UNICORN, "UNICORN", {
                    id : "Unicorn Horn",
                    name : "Unicorn Horn",
                    cost : 100,
                    title : "Unicorn",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsUnicorn;
                    }
                });
        EnumValue.add(Memories, KIRIN, "KIRIN", {
                    id : "Kirin Horn",
                    name : "Kirin Horn",
                    cost : 100,
                    title : "Kirin",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsKirin;
                    }
                });
        EnumValue.add(Memories, OAK, "OAK", {
                    id : "Oak Horns",
                    name : "Oak Horns",
                    cost : 100,
                    title : "Oak",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsOak;
                    }
                });
        EnumValue.add(Memories, ORCHID, "ORCHID", {
                    id : "Orchid Flowers",
                    name : "Orchid Flowers",
                    cost : 100,
                    title : "Orchid flowers",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HornsOrchid;
                    }
                });
        true;
    }

}


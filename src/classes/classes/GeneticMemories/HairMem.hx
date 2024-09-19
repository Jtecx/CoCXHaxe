package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.Hair;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class HairMem extends BaseContent
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
    
    public static var NORMAL : Int = _partid++;
    
    
    public static var BURNING : Int = _partid++;
    
    
    public static var ELF : Int = _partid++;
    
    
    public static var FEATHER : Int = _partid++;
    
    
    public static var GHOST : Int = _partid++;
    
    
    public static var GOO : Int = _partid++;
    
    
    public static var GORGON : Int = _partid++;
    
    
    public static var RATATOSKR : Int = _partid++;
    
    
    public static var STORM : Int = _partid++;
    
    
    public static var WIND : Int = _partid++;
    
    
    public static var LEAF : Int = _partid++;
    
    
    public static var GRASS : Int = _partid++;
    
    
    public static var SNOWY : Int = _partid++;
    
    
    public static var FLUFFY : Int = _partid++;
    
    
    public static var CRAZY : Int = _partid++;
    
    
    public static var PEAFOWL : Int = _partid++;
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var HairMem_static_initializer = {
        EnumValue.add(Memories, NORMAL, "NORMAL", {
                    id : "Unlocked Metamorph",
                    name : "Human Hair",
                    cost : 500,
                    title : "Human",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairHuman;
                    }
                });
        EnumValue.add(Memories, BURNING, "BURNING", {
                    id : "Burning Hair",
                    name : "Burning Hair",
                    cost : 100,
                    title : "Burning",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairBurning;
                    }
                });
        EnumValue.add(Memories, ELF, "ELF", {
                    id : "Silky Hair",
                    name : "Silky Hair",
                    cost : 100,
                    title : "Elf",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairSilky;
                    }
                });
        EnumValue.add(Memories, FEATHER, "FEATHER", {
                    id : "Feather Hair",
                    name : "Feather Hair",
                    cost : 100,
                    title : "Feather",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairFeather;
                    }
                });
        EnumValue.add(Memories, GHOST, "GHOST", {
                    id : "Ghost Hair",
                    name : "Ghost Hair",
                    cost : 100,
                    title : "Ghost",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairGhost;
                    }
                });
        EnumValue.add(Memories, GOO, "GOO", {
                    id : "Goo Hair",
                    name : "Goo Hair",
                    cost : 100,
                    title : "Goo",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairGoo;
                    }
                });
        EnumValue.add(Memories, GORGON, "GORGON", {
                    id : "Gorgon Hair",
                    name : "Gorgon \"Hair\" (Snakes)",
                    cost : 100,
                    title : "Gorgon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairGorgon;
                    }
                });
        EnumValue.add(Memories, RATATOSKR, "RATATOSKR", {
                    id : "Ratatoskr Hair",
                    name : "Ratatoskr Hair",
                    cost : 100,
                    title : "Ratatoskr",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairRatatoskr;
                    }
                });
        EnumValue.add(Memories, STORM, "STORM", {
                    id : "Storm Hair",
                    name : "Storm Hair",
                    cost : 100,
                    title : "Storm",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairStorm;
                    }
                });
        EnumValue.add(Memories, WIND, "WIND", {
                    id : "Windswept Hair",
                    name : "Windswept Hair",
                    cost : 100,
                    title : "Windswept",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairWindswept;
                    }
                });
        EnumValue.add(Memories, LEAF, "LEAF", {
                    id : "Leaf Hair",
                    name : "Leaf Hair",
                    cost : 100,
                    title : "Leaf",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairLeaf;
                    }
                });
        EnumValue.add(Memories, GRASS, "GRASS", {
                    id : "Grass Hair",
                    name : "Grass Hair",
                    cost : 100,
                    title : "Grass",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairGrass;
                    }
                });
        EnumValue.add(Memories, SNOWY, "SNOWY", {
                    id : "Snowy Hair",
                    name : "Snowy Hair",
                    cost : 100,
                    title : "Snowy",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairSnowy;
                    }
                });
        EnumValue.add(Memories, FLUFFY, "FLUFFY", {
                    id : "Fluffy Hair",
                    name : "Fluffy Hair",
                    cost : 100,
                    title : "Fluffy",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairFluffy;
                    }
                });
        EnumValue.add(Memories, CRAZY, "CRAZY", {
                    id : "Crazy Hair",
                    name : "Crazy Hair",
                    cost : 100,
                    title : "Crazy",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairCrazy;
                    }
                });
        EnumValue.add(Memories, PEAFOWL, "PEAFOWL", {
                    id : "Peafowl Hair",
                    name : "Peafowl Feather Hair",
                    cost : 100,
                    title : "Peafowl",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.HairPeafowlFeather;
                    }
                });
        true;
    }

}


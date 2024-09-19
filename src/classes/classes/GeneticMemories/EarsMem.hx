package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.Ears;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class EarsMem extends BaseContent
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
    
    public static var HUMAN : Int = _partid++;
    
    
    public static var AVIAN : Int = _partid++;
    
    
    public static var BAT : Int = _partid++;
    
    
    public static var BEAR : Int = _partid++;
    
    
    public static var BIG : Int = _partid++;
    
    
    public static var BUNNY : Int = _partid++;
    
    
    public static var CAT : Int = _partid++;
    
    
    public static var CAVE_WYRM : Int = _partid++;
    
    
    public static var COW : Int = _partid++;
    
    
    public static var DEER : Int = _partid++;
    
    
    public static var DISPLACER : Int = _partid++;
    
    
    public static var DOG : Int = _partid++;
    
    
    public static var DRACONIC : Int = _partid++;
    
    
    public static var ELFIN : Int = _partid++;
    
    
    public static var ELVEN : Int = _partid++;
    
    
    public static var FERRET : Int = _partid++;
    
    
    public static var FOX : Int = _partid++;
    
    
    public static var GOAT : Int = _partid++;
    
    
    public static var GREMLIN : Int = _partid++;
    
    
    public static var GRYPHON : Int = _partid++;
    
    
    public static var HORSE : Int = _partid++;
    
    
    public static var INSECT : Int = _partid++;
    
    
    public static var KANGAROO : Int = _partid++;
    
    
    public static var KIRIN : Int = _partid++;
    
    
    public static var LIZARD : Int = _partid++;
    
    
    public static var LION : Int = _partid++;
    
    
    public static var MELKIE : Int = _partid++;
    
    
    public static var MOUSE : Int = _partid++;
    
    
    public static var ONI : Int = _partid++;
    
    
    public static var ORCA : Int = _partid++;
    
    
    public static var ORCA2 : Int = _partid++;
    
    
    public static var PANDA : Int = _partid++;
    
    
    public static var PIG : Int = _partid++;
    
    
    public static var RACCOON : Int = _partid++;
    
    
    public static var RAIJU : Int = _partid++;
    
    
    public static var RED_PANDA : Int = _partid++;
    
    
    public static var SHARK : Int = _partid++;
    
    
    public static var SNAKE : Int = _partid++;
    
    
    public static var SQUIRREL : Int = _partid++;
    
    
    public static var VAMPIRE : Int = _partid++;
    
    
    public static var WEASEL : Int = _partid++;
    
    
    public static var WOLF : Int = _partid++;
    
    
    public static var YETI : Int = _partid++;
    
    
    public static var FENNEC_FOX : Int = _partid++;
    
    
    public static var JACKAL : Int = _partid++;
    
    
    public static var TROLL : Int = _partid++;
    
    
    public static var GLACIAL_TROLL : Int = _partid++;
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var EarsMem_static_initializer = {
        EnumValue.add(Memories, HUMAN, "HUMAN", {
                    id : "Unlocked Metamorph",
                    name : "Human Ears",
                    cost : 500,
                    title : "Human",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsHuman;
                    }
                });
        EnumValue.add(Memories, AVIAN, "AVIAN", {
                    id : "Avian Ears",
                    name : "Avian Ears",
                    cost : 100,
                    title : "Avian",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsAvian;
                    }
                });
        EnumValue.add(Memories, BAT, "BAT", {
                    id : "Bat Ears",
                    name : "Bat Ears",
                    cost : 100,
                    title : "Bat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsBat;
                    }
                });
        EnumValue.add(Memories, BEAR, "BEAR", {
                    id : "Bear Ears",
                    name : "Bear Ears",
                    cost : 100,
                    title : "Bear",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsBear;
                    }
                });
        EnumValue.add(Memories, BIG, "BIG", {
                    id : "Big Ears",
                    name : "Big Ears",
                    cost : 100,
                    title : "Big",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsBig;
                    }
                });
        EnumValue.add(Memories, BUNNY, "BUNNY", {
                    id : "Bunny Ears",
                    name : "Bunny Ears",
                    cost : 100,
                    title : "Bunny",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsBunny;
                    }
                });
        EnumValue.add(Memories, CAT, "CAT", {
                    id : "Cat Ears",
                    name : "Cat Ears",
                    cost : 100,
                    title : "Cat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsCat;
                    }
                });
        EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
                    id : "Cave Wyrm Ears",
                    name : "Cave Wyrm Ears",
                    cost : 100,
                    title : "Cave Wyrm",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsCaveWyrm;
                    }
                });
        EnumValue.add(Memories, COW, "COW", {
                    id : "Cow Ears",
                    name : "Bovine Ears",
                    cost : 100,
                    title : "Bovine",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsCow;
                    }
                });
        EnumValue.add(Memories, DEER, "DEER", {
                    id : "Deer Ears",
                    name : "Deer Ears",
                    cost : 100,
                    title : "Deer",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsDeer;
                    }
                });
        EnumValue.add(Memories, DISPLACER, "DISPLACER", {
                    id : "Displacer Ears",
                    name : "Displacer Ears",
                    cost : 100,
                    title : "Displacer",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsDisplacer;
                    }
                });
        EnumValue.add(Memories, DOG, "DOG", {
                    id : "Dog Ears",
                    name : "Dog Ears",
                    cost : 100,
                    title : "Dog",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsDog;
                    }
                });
        EnumValue.add(Memories, DRACONIC, "DRACONIC", {
                    id : "Draconic Ears",
                    name : "Draconic Ears",
                    cost : 100,
                    title : "Dragon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsDraconic;
                    }
                });
        EnumValue.add(Memories, ELFIN, "ELFIN", {
                    id : "Elfin Ears",
                    name : "Elfin Ears",
                    cost : 100,
                    title : "Elfin",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsElfin;
                    }
                });
        EnumValue.add(Memories, ELVEN, "ELVEN", {
                    id : "Elven Ears",
                    name : "Elven Ears",
                    cost : 100,
                    title : "Elven",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsElven;
                    }
                });
        EnumValue.add(Memories, FERRET, "FERRET", {
                    id : "Ferret Ears",
                    name : "Ferret Ears",
                    cost : 100,
                    title : "Ferret",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsFerret;
                    }
                });
        EnumValue.add(Memories, FOX, "FOX", {
                    id : "Fox Ears",
                    name : "Fox Ears",
                    cost : 100,
                    title : "Fox",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsFox;
                    }
                });
        EnumValue.add(Memories, GOAT, "GOAT", {
                    id : "Goat Ears",
                    name : "Goat Ears",
                    cost : 100,
                    title : "Goat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsGoat;
                    }
                });
        EnumValue.add(Memories, GREMLIN, "GREMLIN", {
                    id : "Gremlin Ears",
                    name : "Gremlin Ears",
                    cost : 100,
                    title : "Gremlin",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsGremlin;
                    }
                });
        EnumValue.add(Memories, GRYPHON, "GRYPHON", {
                    id : "Gryphon Ears",
                    name : "Gryphon Ears",
                    cost : 100,
                    title : "Gryphon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsGryphon;
                    }
                });
        EnumValue.add(Memories, HORSE, "HORSE", {
                    id : "Horse Ears",
                    name : "Horse Ears",
                    cost : 100,
                    title : "Horse",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsHorse;
                    }
                });
        EnumValue.add(Memories, INSECT, "INSECT", {
                    id : "Insect Ears",
                    name : "Insect Ears",
                    cost : 100,
                    title : "Insect",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsInsect;
                    }
                });
        EnumValue.add(Memories, KANGAROO, "KANGAROO", {
                    id : "Kangaroo Ears",
                    name : "Kangaroo Ears",
                    cost : 100,
                    title : "Kangaroo",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsKangaroo;
                    }
                });
        EnumValue.add(Memories, KIRIN, "KIRIN", {
                    id : "Kirin Ears",
                    name : "Kirin Ears",
                    cost : 100,
                    title : "Kirin",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsKirin;
                    }
                });
        EnumValue.add(Memories, LIZARD, "LIZARD", {
                    id : "Lizard Ears",
                    name : "Lizard Ears",
                    cost : 100,
                    title : "Lizard",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsLizard;
                    }
                });
        EnumValue.add(Memories, LION, "LION", {
                    id : "Lion Ears",
                    name : "Lion Ears",
                    cost : 100,
                    title : "Lion",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsLion;
                    }
                });
        EnumValue.add(Memories, MELKIE, "MELKIE", {
                    id : "Melkie Ears",
                    name : "Melkie Ears",
                    cost : 100,
                    title : "Melkie",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsMelkie;
                    }
                });
        EnumValue.add(Memories, MOUSE, "MOUSE", {
                    id : "Mouse Ears",
                    name : "Mouse Ears",
                    cost : 100,
                    title : "Mouse",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsMouse;
                    }
                });
        EnumValue.add(Memories, ONI, "ONI", {
                    id : "Oni Ears",
                    name : "Oni Ears",
                    cost : 100,
                    title : "Oni",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsOni;
                    }
                });
        EnumValue.add(Memories, ORCA, "ORCA", {
                    id : "Orca Ears",
                    name : "Orca Fin Ears",
                    cost : 100,
                    title : "Orca",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsOrca;
                    }
                });
        EnumValue.add(Memories, ORCA2, "ORCA2", {
                    id : "Orca Hole Ears",
                    name : "Orca Hole Ears",
                    cost : 100,
                    title : "Orca",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsOrca2;
                    }
                });
        EnumValue.add(Memories, PANDA, "PANDA", {
                    id : "Panda Ears",
                    name : "Panda Ears",
                    cost : 100,
                    title : "Panda",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsPanda;
                    }
                });
        EnumValue.add(Memories, PIG, "PIG", {
                    id : "Pig Ears",
                    name : "Pig Ears",
                    cost : 100,
                    title : "Pig",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsPig;
                    }
                });
        EnumValue.add(Memories, RACCOON, "RACCOON", {
                    id : "Raccoon Ears",
                    name : "Raccoon Ears",
                    cost : 100,
                    title : "Raccoon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsRaccoon;
                    }
                });
        EnumValue.add(Memories, RAIJU, "RAIJU", {
                    id : "Raiju Ears",
                    name : "Raiju Ears",
                    cost : 100,
                    title : "Raiju",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsRaiju;
                    }
                });
        EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
                    id : "Red Panda Ears",
                    name : "Red Panda Ears",
                    cost : 100,
                    title : "Red Panda",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsRedPanda;
                    }
                });
        EnumValue.add(Memories, SHARK, "SHARK", {
                    id : "Shark Ears",
                    name : "Shark Ears",
                    cost : 100,
                    title : "Shark",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsShark;
                    }
                });
        EnumValue.add(Memories, SNAKE, "SNAKE", {
                    id : "Snake Ears",
                    name : "Snake Ears",
                    cost : 100,
                    title : "Snake",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsSnake;
                    }
                });
        EnumValue.add(Memories, SQUIRREL, "SQUIRREL", {
                    id : "Squirrel Ears",
                    name : "Squirrel Ears",
                    cost : 100,
                    title : "Squirrel",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsSquirrel;
                    }
                });
        EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
                    id : "Vampire Ears",
                    name : "Vampire Ears",
                    cost : 100,
                    title : "Vampire",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsVampire;
                    }
                });
        EnumValue.add(Memories, WEASEL, "WEASEL", {
                    id : "Weasel Ears",
                    name : "Weasel Ears",
                    cost : 100,
                    title : "Weasel",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsWeasel;
                    }
                });
        EnumValue.add(Memories, WOLF, "WOLF", {
                    id : "Wolf Ears",
                    name : "Wolf Ears",
                    cost : 100,
                    title : "Wolf",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsWolf;
                    }
                });
        EnumValue.add(Memories, YETI, "YETI", {
                    id : "Yeti Ears",
                    name : "Yeti Ears",
                    cost : 100,
                    title : "Yeti",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsYeti;
                    }
                });
        EnumValue.add(Memories, FENNEC_FOX, "FENNEC_FOX", {
                    id : "Fennec Fox Ears",
                    name : "Fennec Fox Ears",
                    cost : 100,
                    title : "Fennec Fox",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsFennecFox;
                    }
                });
        EnumValue.add(Memories, JACKAL, "JACKAL", {
                    id : "Jackal Ears",
                    name : "Jackal Ears",
                    cost : 100,
                    title : "Jackal",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsJackal;
                    }
                });
        EnumValue.add(Memories, TROLL, "TROLL", {
                    id : "Troll Ears",
                    name : "Troll Ears",
                    cost : 100,
                    title : "Troll",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsTroll;
                    }
                });
        EnumValue.add(Memories, GLACIAL_TROLL, "GLACIAL_TROLL", {
                    id : "G.Troll Ears",
                    name : "G.Troll Ears",
                    cost : 100,
                    title : "G.Troll",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EarsGlacialTroll;
                    }
                });
        true;
    }

}


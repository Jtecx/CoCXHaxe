package classes.geneticMemories;

import classes.BaseContent;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class CockMem extends BaseContent
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
    
    
    public static var KNOT : Int = _partid++;
    
    
    public static var HUMAN : Int = _partid++;
    
    
    public static var HORSE : Int = _partid++;
    
    
    public static var DOG : Int = _partid++;
    
    
    public static var DEMON : Int = _partid++;
    
    
    public static var TENTACLE : Int = _partid++;
    
    
    public static var SCYLLATENTACLE : Int = _partid++;
    
    
    public static var CAT : Int = _partid++;
    
    
    public static var CANCER : Int = _partid++;
    
    
    public static var LIZARD : Int = _partid++;
    
    
    public static var CAVE_WYRM : Int = _partid++;
    
    
    public static var ANEMONE : Int = _partid++;
    
    
    public static var KANGAROO : Int = _partid++;
    
    
    public static var DRAGON : Int = _partid++;
    
    
    public static var DISPLACER : Int = _partid++;
    
    
    public static var FOX : Int = _partid++;
    
    
    public static var BEE : Int = _partid++;
    
    
    public static var PIG : Int = _partid++;
    
    
    public static var AVIAN : Int = _partid++;
    
    
    public static var RHINO : Int = _partid++;
    
    
    public static var ECHIDNA : Int = _partid++;
    
    
    public static var WOLF : Int = _partid++;
    
    
    public static var STAMEN : Int = _partid++;
    
    
    public static var RED_PANDA : Int = _partid++;
    
    
    public static var GRYPHON : Int = _partid++;
    
    
    public static var OOMUKADE : Int = _partid++;
    
    
    public static var RAIJU : Int = _partid++;
    
    
    public static var USHI_ONI : Int = _partid++;
    
    
    public static var INSECT : Int = _partid++;
    
    
    public static var KIRIN : Int = _partid++;
    
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var CockMem_static_initializer = {
        EnumValue.add(Memories, NONE, "NONE", {
                    id : "Unlocked Metamorph",
                    name : "No Cock",
                    cost : 500,
                    title : "None",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockNone(cockIndex);
                    }
                });
        EnumValue.add(Memories, KNOT, "KNOT", {
                    id : "Unlocked Metamorph",
                    name : "Increase Knot",
                    cost : 200,
                    title : "Knot",
                    hint : "You need a dog-like dick",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.GrowKnot(cockIndex, 3);
                    }
                });
        EnumValue.add(Memories, HUMAN, "HUMAN", {
                    id : "Unlocked Metamorph",
                    name : "Human cock",
                    cost : 200,
                    title : "Human",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockHuman(cockIndex);
                    }
                });
        EnumValue.add(Memories, HORSE, "HORSE", {
                    id : "Horse cock",
                    name : "Horse cock",
                    cost : 200,
                    title : "Horse",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockHorse(cockIndex);
                    }
                });
        EnumValue.add(Memories, DOG, "DOG", {
                    id : "Dog cock",
                    name : "Dog cock",
                    cost : 200,
                    title : "Dog",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockDog(cockIndex);
                    }
                });
        EnumValue.add(Memories, DEMON, "DEMON", {
                    id : "Demon cock",
                    name : "Demon cock",
                    cost : 200,
                    title : "Demon",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockDemon(cockIndex);
                    }
                });
        EnumValue.add(Memories, TENTACLE, "TENTACLE", {
                    id : "Tentacle cock",
                    name : "Tentacle cock",
                    cost : 200,
                    title : "Tentacle",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockTentacle(cockIndex);
                    }
                });
        EnumValue.add(Memories, SCYLLATENTACLE, "SCYLLATENTACLE", {
                    id : "Scylla tentacle cock",
                    name : "Scylla tentacle cock",
                    cost : 200,
                    title : "Scylla",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockScylla(cockIndex);
                    }
                });
        EnumValue.add(Memories, CAT, "CAT", {
                    id : "Cat cock",
                    name : "Cat cock",
                    cost : 200,
                    title : "Cat",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockCat(cockIndex);
                    }
                });
        EnumValue.add(Memories, CANCER, "CANCER", {
                    id : "Cancer cock",
                    name : "Cancer cock",
                    cost : 200,
                    title : "Cancer",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockCancer(cockIndex);
                    }
                });
        EnumValue.add(Memories, LIZARD, "LIZARD", {
                    id : "Lizard cock",
                    name : "Lizard cock",
                    cost : 200,
                    title : "Lizard",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockLizard(cockIndex);
                    }
                });
        EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
                    id : "Cave Wyrm cock",
                    name : "Cave Wyrm cock",
                    cost : 200,
                    title : "Cave Wyrm",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockCaveWyrm(cockIndex);
                    }
                });
        EnumValue.add(Memories, ANEMONE, "ANEMONE", {
                    id : "Anemone cock",
                    name : "Anemone cock",
                    cost : 200,
                    title : "Anemone",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockAnemone(cockIndex);
                    }
                });
        EnumValue.add(Memories, KANGAROO, "KANGAROO", {
                    id : "Kangaroo cock",
                    name : "Kangaroo cock",
                    cost : 200,
                    title : "Kangaroo",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockKangaroo(cockIndex);
                    }
                });
        EnumValue.add(Memories, DRAGON, "DRAGON", {
                    id : "Dragon cock",
                    name : "Dragon cock",
                    cost : 200,
                    title : "Dragon",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockDragon(cockIndex);
                    }
                });
        EnumValue.add(Memories, DISPLACER, "DISPLACER", {
                    id : "Displacer cock",
                    name : "Displacer cock",
                    cost : 200,
                    title : "Displacer",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockDisplacer(cockIndex);
                    }
                });
        EnumValue.add(Memories, FOX, "FOX", {
                    id : "Fox cock",
                    name : "Fox cock",
                    cost : 200,
                    title : "Fox",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockFox(cockIndex);
                    }
                });
        EnumValue.add(Memories, BEE, "BEE", {
                    id : "Bee cock",
                    name : "Bee cock",
                    cost : 200,
                    title : "Bee",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockBee(cockIndex);
                    }
                });
        EnumValue.add(Memories, PIG, "PIG", {
                    id : "Pig cock",
                    name : "Pig cock",
                    cost : 200,
                    title : "Pig",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockPig(cockIndex);
                    }
                });
        EnumValue.add(Memories, AVIAN, "AVIAN", {
                    id : "Avian cock",
                    name : "Avian cock",
                    cost : 200,
                    title : "Avian",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockAvian(cockIndex);
                    }
                });
        EnumValue.add(Memories, RHINO, "RHINO", {
                    id : "Rhino cock",
                    name : "Rhino cock",
                    cost : 200,
                    title : "Rhino",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockRhino(cockIndex);
                    }
                });
        EnumValue.add(Memories, ECHIDNA, "ECHIDNA", {
                    id : "Echidna cock",
                    name : "Echidna cock",
                    cost : 200,
                    title : "Echidna",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockEchidna(cockIndex);
                    }
                });
        EnumValue.add(Memories, WOLF, "WOLF", {
                    id : "Wolf cock",
                    name : "Wolf cock",
                    cost : 200,
                    title : "Wolf",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockWolf(cockIndex);
                    }
                });
        EnumValue.add(Memories, STAMEN, "STAMEN", {
                    id : "Stamen cock",
                    name : "Stamen cock",
                    cost : 200,
                    title : "Stamen",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockStamen(cockIndex);
                    }
                });
        EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
                    id : "Red Panda cock",
                    name : "Red Panda cock",
                    cost : 200,
                    title : "Red Panda",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockRedPanda(cockIndex);
                    }
                });
        EnumValue.add(Memories, GRYPHON, "GRYPHON", {
                    id : "Gryphon cock",
                    name : "Gryphon cock",
                    cost : 200,
                    title : "Gryphon",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockGryphon(cockIndex);
                    }
                });
        EnumValue.add(Memories, OOMUKADE, "OOMUKADE", {
                    id : "Ookamude cock",
                    name : "Ookamude cock",
                    cost : 200,
                    title : "Centipede",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockCentipede(cockIndex);
                    }
                });
        EnumValue.add(Memories, RAIJU, "RAIJU", {
                    id : "Raiju cock",
                    name : "Raiju cock",
                    cost : 200,
                    title : "Raiju",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockRaiju(cockIndex);
                    }
                });
        EnumValue.add(Memories, USHI_ONI, "USHI_ONI", {
                    id : "Ushi Oni cock",
                    name : "Ushi Oni cock",
                    cost : 200,
                    title : "Ushi Oni",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockUshiOni(cockIndex);
                    }
                });
        EnumValue.add(Memories, INSECT, "INSECT", {
                    id : "Insect cock",
                    name : "Insect cock",
                    cost : 500,
                    title : "Insect",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockInsect(cockIndex);
                    }
                });
        EnumValue.add(Memories, KIRIN, "KIRIN", {
                    id : "Kirin cock",
                    name : "Kirin cock",
                    cost : 200,
                    title : "Kirin",
                    transformation : function(cockIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.CockKirin(cockIndex);
                    }
                });
        true;
    }

}


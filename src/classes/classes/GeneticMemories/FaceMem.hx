package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.Face;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class FaceMem extends BaseContent
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
    
    
    public static var ANIMAL_TOOTHS : Int = _partid++;
    
    
    public static var ANT : Int = _partid++;
    
    
    public static var BEAR : Int = _partid++;
    
    
    public static var BOAR : Int = _partid++;
    
    
    public static var BUCKTEETH : Int = _partid++;
    
    
    public static var BUNNY : Int = _partid++;
    
    
    public static var CAT : Int = _partid++;
    
    
    public static var CAT_CANINES : Int = _partid++;
    
    
    public static var CHESHIRE : Int = _partid++;
    
    
    public static var CHESHIRE_SMILE : Int = _partid++;
    
    
    public static var COW_MINOTAUR : Int = _partid++;
    
    
    public static var DEVIL_FANGS : Int = _partid++;
    
    
    public static var DEER : Int = _partid++;
    
    
    public static var DOG : Int = _partid++;
    
    
    public static var DRAGON : Int = _partid++;
    
    
    public static var DRAGON_FANGS : Int = _partid++;
    
    
    public static var ELF_FACE : Int = _partid++;
    
    
    public static var ECHIDNA : Int = _partid++;
    
    
    public static var FERRET : Int = _partid++;
    
    
    public static var FERRET_MASK : Int = _partid++;
    
    
    public static var FIRE_SNAIL : Int = _partid++;
    
    
    public static var FOX : Int = _partid++;
    
    
    public static var GHOST : Int = _partid++;
    
    
    public static var HORSE : Int = _partid++;
    
    
    public static var INNOCENT : Int = _partid++;
    
    
    public static var KANGAROO : Int = _partid++;
    
    
    public static var LIZARD : Int = _partid++;
    
    
    public static var MANTICORE : Int = _partid++;
    
    
    public static var MOUSE : Int = _partid++;
    
    
    public static var ONI_TEETH : Int = _partid++;
    
    
    public static var ORCA : Int = _partid++;
    
    
    public static var ORC_FANGS : Int = _partid++;
    
    
    public static var PANDA : Int = _partid++;
    
    
    public static var PIG : Int = _partid++;
    
    
    public static var RACCOON : Int = _partid++;
    
    
    public static var RACCOONMASK : Int = _partid++;
    
    
    public static var RED_PANDA : Int = _partid++;
    
    
    public static var RHINO : Int = _partid++;
    
    
    public static var SALAMANDER_FANGS : Int = _partid++;
    
    
    public static var SHARK_TEETH : Int = _partid++;
    
    
    public static var SNAKE_FANGS : Int = _partid++;
    
    
    public static var SPIDER : Int = _partid++;
    
    
    public static var SQUIRREL : Int = _partid++;
    
    
    public static var VAMPIRE : Int = _partid++;
    
    
    public static var WEASEL : Int = _partid++;
    
    
    public static var WOLF_FACE : Int = _partid++;
    
    
    public static var YETI : Int = _partid++;
    
    
    public static var YUKI_ONNA : Int = _partid++;
    
    
    public static var PLANT_DRAGON : Int = _partid++;
    
    
    public static var CRAZY : Int = _partid++;
    
    
    public static var SMUG : Int = _partid++;
    
    
    public static var AVIAN : Int = _partid++;
    
    
    public static var FOX_FANGS : Int = _partid++;
    
    
    public static var WOLF_FANGS : Int = _partid++;
    
    
    public static var ABYSSAL_SHARK : Int = _partid++;
    
    
    public static var ARIGEAN : Int = _partid++;
    
    
    public static var DEMON : Int = _partid++;
    
    
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
    private static var FaceMem_static_initializer = {
        EnumValue.add(Memories, HUMAN, "HUMAN", {
                    id : "Unlocked Metamorph",
                    name : "Human Face",
                    cost : 500,
                    title : "Human",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceHuman;
                    }
                });
        EnumValue.add(Memories, ANIMAL_TOOTHS, "ANIMAL_TOOTHS", {
                    id : "Animal Teeth",
                    name : "Animal Teeth",
                    cost : 100,
                    title : "Animal Teeth",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceAnimalTeeth;
                    }
                });
        EnumValue.add(Memories, ANT, "ANT", {
                    id : "Ant mandibles Face",
                    name : "Ant mandibles",
                    cost : 100,
                    title : "Ant mandibles",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceAnt;
                    }
                });
        EnumValue.add(Memories, BEAR, "BEAR", {
                    id : "Bear Face",
                    name : "Bear Face",
                    cost : 100,
                    title : "Bear",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceBear;
                    }
                });
        EnumValue.add(Memories, BOAR, "BOAR", {
                    id : "Boar Face",
                    name : "Boar Face",
                    cost : 100,
                    title : "Boar",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceBoar;
                    }
                });
        EnumValue.add(Memories, BUCKTEETH, "BUCKTEETH", {
                    id : "Buck Teeth",
                    name : "Buck Teeth",
                    cost : 100,
                    title : "Buck Teeth",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceBuckteeth;
                    }
                });
        EnumValue.add(Memories, BUNNY, "BUNNY", {
                    id : "Buck Teeth",
                    name : "Buck Teeth",
                    cost : 100,
                    title : "Bunny Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceBunny;
                    }
                });
        EnumValue.add(Memories, CAT, "CAT", {
                    id : "Cat Face",
                    name : "Cat Face",
                    cost : 100,
                    title : "Cat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceCat;
                    }
                });
        EnumValue.add(Memories, CAT_CANINES, "CAT_CANINES", {
                    id : "Cat Canines Face",
                    name : "Cat Canines",
                    cost : 100,
                    title : "Cat Canines",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceCatCanines;
                    }
                });
        EnumValue.add(Memories, CHESHIRE, "CHESHIRE", {
                    id : "Cheshire Face",
                    name : "Cheshire Face",
                    cost : 200,
                    title : "Cheshire",
                    permReq : "Cat Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceCheshire;
                    }
                });
        EnumValue.add(Memories, CHESHIRE_SMILE, "CHESHIRE_SMILE", {
                    id : "Cheshire Smile Face",
                    name : "Cheshire Smile",
                    cost : 200,
                    title : "Cheshire Smile",
                    permReq : "Cat Canines Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceCheshireSmile;
                    }
                });
        EnumValue.add(Memories, COW_MINOTAUR, "COW_MINOTAUR", {
                    id : "Cow/Minotaur Face",
                    name : "Bovine Face",
                    cost : 100,
                    title : "Bovine",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceCowMinotaur;
                    }
                });
        EnumValue.add(Memories, DEVIL_FANGS, "DEVIL_FANGS", {
                    id : "Devil Fangs Face",
                    name : "Demonic Fangs",
                    cost : 200,
                    title : "Dem. Fangs",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceDevilFangs;
                    }
                });
        EnumValue.add(Memories, DEER, "DEER", {
                    id : "Deer Face",
                    name : "Deer Face",
                    cost : 100,
                    title : "Deer",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceDeer;
                    }
                });
        EnumValue.add(Memories, DOG, "DOG", {
                    id : "Dog Face",
                    name : "Dog Face",
                    cost : 100,
                    title : "Dog",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceDog;
                    }
                });
        EnumValue.add(Memories, DRAGON, "DRAGON", {
                    id : "Draconic Face",
                    name : "Draconic Face",
                    cost : 100,
                    title : "Dragon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceDragon;
                    }
                });
        EnumValue.add(Memories, DRAGON_FANGS, "DRAGON_FANGS", {
                    id : "Draconic Fangs Face",
                    name : "Draconic Fangs",
                    cost : 100,
                    title : "Dragon Fangs",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceDragonFangs;
                    }
                });
        EnumValue.add(Memories, ELF_FACE, "ELF_FACE", {
                    id : "Elf Face",
                    name : "Elf Face",
                    cost : 100,
                    title : "Elf Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceElf;
                    }
                });
        EnumValue.add(Memories, ECHIDNA, "ECHIDNA", {
                    id : "Echidna Face",
                    name : "Echidna Face",
                    cost : 100,
                    title : "Echidna Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceEchidna;
                    }
                });
        EnumValue.add(Memories, FERRET, "FERRET", {
                    id : "Ferret Face",
                    name : "Ferret Face",
                    cost : 100,
                    title : "Ferret Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceFerret;
                    }
                });
        EnumValue.add(Memories, FERRET_MASK, "FERRET_MASK", {
                    id : "Ferret mask Face",
                    name : "Ferret mask Face",
                    cost : 100,
                    title : "Ferret mask Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceFerretMask;
                    }
                });
        EnumValue.add(Memories, FIRE_SNAIL, "FIRE_SNAIL", {
                    id : "Fire Snail Face",
                    name : "Fire Snail",
                    cost : 100,
                    title : "Fire Snail",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceFireSnail;
                    }
                });
        EnumValue.add(Memories, FOX, "FOX", {
                    id : "Fox Face",
                    name : "Fox Face",
                    cost : 100,
                    title : "Fox",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceFox;
                    }
                });
        EnumValue.add(Memories, GHOST, "GHOST", {
                    id : "Ghost Face",
                    name : "Ghost",
                    cost : 100,
                    title : "Ghost",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceGhost;
                    }
                });
        EnumValue.add(Memories, HORSE, "HORSE", {
                    id : "Horse Face",
                    name : "Horse Face",
                    cost : 100,
                    title : "Horse",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceHorse;
                    }
                });
        EnumValue.add(Memories, INNOCENT, "INNOCENT", {
                    id : "Innocent Expression",
                    name : "Innocent Expression",
                    cost : 200,
                    title : "Innocent",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceInnocent;
                    }
                });
        EnumValue.add(Memories, KANGAROO, "KANGAROO", {
                    id : "Kangaroo Face",
                    name : "Kangaroo Face",
                    cost : 200,
                    title : "Kangaroo",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceKangaroo;
                    }
                });
        EnumValue.add(Memories, LIZARD, "LIZARD", {
                    id : "Lizard Face",
                    name : "Lizard Face",
                    cost : 100,
                    title : "Lizard",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceLizard;
                    }
                });
        EnumValue.add(Memories, MANTICORE, "MANTICORE", {
                    id : "Manticore Face",
                    name : "Manticore Fangs",
                    cost : 100,
                    title : "Manticore",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceManticore;
                    }
                });
        EnumValue.add(Memories, MOUSE, "MOUSE", {
                    id : "Mouse Teeth",
                    name : "Mouse Teeth",
                    cost : 100,
                    title : "Mouse Teeth",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceMouse;
                    }
                });
        EnumValue.add(Memories, ONI_TEETH, "ONI_TEETH", {
                    id : "Oni Teeth Face",
                    name : "Oni Teeth",
                    cost : 100,
                    title : "Oni Teeth",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceOniTeeth;
                    }
                });
        EnumValue.add(Memories, ORCA, "ORCA", {
                    id : "Orca Face",
                    name : "Orca Face",
                    cost : 100,
                    title : "Orca",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceOrca;
                    }
                });
        EnumValue.add(Memories, ORC_FANGS, "ORC_FANGS", {
                    id : "Orc Fangs Face",
                    name : "Orc Fangs",
                    cost : 200,
                    title : "Orc Fangs",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceOrcFangs;
                    }
                });
        EnumValue.add(Memories, PANDA, "PANDA", {
                    id : "Panda Face",
                    name : "Panda",
                    cost : 100,
                    title : "Panda",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FacePanda;
                    }
                });
        EnumValue.add(Memories, PIG, "PIG", {
                    id : "Pig Face",
                    name : "Pig Face",
                    cost : 100,
                    title : "Pig",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FacePig;
                    }
                });
        EnumValue.add(Memories, RACCOON, "RACCOON", {
                    id : "Raccoon Face",
                    name : "Raccoon Face",
                    cost : 100,
                    title : "Raccoon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceRaccoon;
                    }
                });
        EnumValue.add(Memories, RACCOONMASK, "RACCOONMASK", {
                    id : "Raccoon Mask Face",
                    name : "Raccoon Mask",
                    cost : 100,
                    title : "Raccoon Mask",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceRaccoonMask;
                    }
                });
        EnumValue.add(Memories, RED_PANDA, "RED_PANDA", {
                    id : "Red Panda Face",
                    name : "Red Panda Face",
                    cost : 100,
                    title : "Red Panda",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceRedPanda;
                    }
                });
        EnumValue.add(Memories, RHINO, "RHINO", {
                    id : "Rhino Face",
                    name : "Rhino Face",
                    cost : 100,
                    title : "Rhino",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceRhino;
                    }
                });
        EnumValue.add(Memories, SALAMANDER_FANGS, "SALAMANDER_FANGS", {
                    id : "Salamander Fangs Face",
                    name : "Salamander Fangs",
                    cost : 100,
                    title : "Salamander F.",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceSalamanderFangs;
                    }
                });
        EnumValue.add(Memories, SHARK_TEETH, "SHARK_TEETH", {
                    id : "Shark Teeth Face",
                    name : "Shark Teeth",
                    cost : 100,
                    title : "Shark",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceSharkTeeth;
                    }
                });
        EnumValue.add(Memories, SNAKE_FANGS, "SNAKE_FANGS", {
                    id : "Snake Fangs Face",
                    name : "Snake Fangs",
                    cost : 100,
                    title : "Snake",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceSnakeFangs;
                    }
                });
        EnumValue.add(Memories, SPIDER, "SPIDER", {
                    id : "Spider Fangs Face",
                    name : "Spider Fangs",
                    cost : 100,
                    title : "Spider Fangs",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceSpiderFangs;
                    }
                });
        EnumValue.add(Memories, SQUIRREL, "SQUIRREL", {
                    id : "Squirrel Face",
                    name : "Squirrel Face",
                    cost : 100,
                    title : "Squirrel Fangs",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceSquirrel;
                    }
                });
        EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
                    id : "Vampire Face",
                    name : "Vampire Fangs",
                    cost : 100,
                    title : "Vampire",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceVampire;
                    }
                });
        EnumValue.add(Memories, WEASEL, "WEASEL", {
                    id : "Weasel Face",
                    name : "Weasel Face",
                    cost : 100,
                    title : "Weasel",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceWeasel;
                    }
                });
        EnumValue.add(Memories, WOLF_FACE, "WOLF_FACE", {
                    id : "Wolf Face",
                    name : "Wolf Face",
                    cost : 100,
                    title : "Wolf Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceWolf;
                    }
                });
        EnumValue.add(Memories, YETI, "YETI", {
                    id : "Yeti Fangs",
                    name : "Yeti Fangs",
                    cost : 100,
                    title : "Yeti Fangs",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceYetiFangs;
                    }
                });
        EnumValue.add(Memories, YUKI_ONNA, "YUKI_ONNA", {
                    id : "Yuki Onna Face",
                    name : "Yuki Onna Face",
                    cost : 100,
                    title : "Yuki Onna Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceYukiOnna;
                    }
                });
        EnumValue.add(Memories, PLANT_DRAGON, "PLANT_DRAGON", {
                    id : "Plant Dragon Face",
                    name : "Plant Dragon Face",
                    cost : 100,
                    title : "Plant Dragon Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FacePlantDragon;
                    }
                });
        EnumValue.add(Memories, CRAZY, "CRAZY", {
                    id : "Gremlin Crazy Face",
                    name : "Gremlin Crazy Face",
                    cost : 100,
                    title : "Gremlin Crazy Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceCrazy;
                    }
                });
        EnumValue.add(Memories, SMUG, "SMUG", {
                    id : "Smug Face",
                    name : "Smugy Face",
                    cost : 100,
                    title : "Smug Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceSmug;
                    }
                });
        EnumValue.add(Memories, AVIAN, "AVIAN", {
                    id : "Avian Face",
                    name : "Avian Face",
                    cost : 100,
                    title : "Avian Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceAvian;
                    }
                });
        EnumValue.add(Memories, FOX_FANGS, "FOX_FANGS", {
                    id : "Fox Fangs Face",
                    name : "Fox Fangs",
                    cost : 100,
                    title : "Fox Fangs",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceFoxFangs;
                    }
                });
        EnumValue.add(Memories, WOLF_FANGS, "WOLF_FANGS", {
                    id : "Wolf Fangs Face",
                    name : "Wolf Fangs",
                    cost : 100,
                    title : "Wolf Fangs",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceWolfFangs;
                    }
                });
        EnumValue.add(Memories, ABYSSAL_SHARK, "ABYSSAL_SHARK", {
                    id : "Abyssal Shark Face",
                    name : "Abyssal Shark Face",
                    cost : 100,
                    title : "A. Shark Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceAbyssalShark;
                    }
                });
        EnumValue.add(Memories, ARIGEAN, "ARIGEAN", {
                    id : "Arigean Face",
                    name : "Arigean Face",
                    cost : 100,
                    title : "Arigean Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceArigean;
                    }
                });
        EnumValue.add(Memories, DEMON, "DEMON", {
                    id : "Demon Face",
                    name : "Demon Face",
                    cost : 200,
                    title : "Demon Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceDemon;
                    }
                });
        EnumValue.add(Memories, TROLL, "TROLL", {
                    id : "Troll Face",
                    name : "Troll Face",
                    cost : 100,
                    title : "Troll Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceTroll;
                    }
                });
        EnumValue.add(Memories, GLACIAL_TROLL, "GLACIAL_TROLL", {
                    id : "G.Troll Face",
                    name : "G.Troll Face",
                    cost : 100,
                    title : "G.Troll Face",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.FaceGlacialTroll;
                    }
                });
        true;
    }

}


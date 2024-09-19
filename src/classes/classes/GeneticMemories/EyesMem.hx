package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.Eyes;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class EyesMem extends BaseContent
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
    
    
    public static var SPIDER : Int = _partid++;
    
    
    public static var CAT : Int = _partid++;
    
    
    public static var INFERNAL : Int = _partid++;
    
    
    public static var MANTICORE : Int = _partid++;
    
    
    public static var FOX : Int = _partid++;
    
    
    public static var JIANGSHI : Int = _partid++;
    
    
    public static var LIZARD : Int = _partid++;
    
    
    public static var SNAKE : Int = _partid++;
    
    
    public static var SNAKEFIENDISH : Int = _partid++;
    
    
    public static var GORGON : Int = _partid++;
    
    
    public static var DRACONIC : Int = _partid++;
    
    
    public static var DEVIL : Int = _partid++;
    
    
    public static var ONI : Int = _partid++;
    
    
    public static var ELF : Int = _partid++;
    
    
    public static var FAIRY : Int = _partid++;
    
    
    public static var RAIJU : Int = _partid++;
    
    
    public static var WEASEL : Int = _partid++;
    
    
    public static var VAMPIRE : Int = _partid++;
    
    
    public static var ORC : Int = _partid++;
    
    
    public static var DISPLACER : Int = _partid++;
    
    
    public static var CAVE_WYRM : Int = _partid++;
    
    
    public static var FROSTWYRM : Int = _partid++;
    
    
    public static var HINEZUMI : Int = _partid++;
    
    
    public static var MONOEYE : Int = _partid++;
    
    
    public static var BLACK_EYES_SAND_TRAP : Int = _partid++;
    
    
    public static var BEAR : Int = _partid++;
    
    
    public static var CANCER : Int = _partid++;
    
    
    public static var CENTIPEDE : Int = _partid++;
    
    
    public static var RATATOSKR : Int = _partid++;
    
    
    public static var KRAKEN : Int = _partid++;
    
    
    public static var FIRE_SNAIL : Int = _partid++;
    
    
    public static var FENRIR : Int = _partid++;
    
    
    public static var FERAL : Int = _partid++;
    
    
    public static var DEAD : Int = _partid++;
    
    
    public static var GRYPHON : Int = _partid++;
    
    
    public static var GOAT : Int = _partid++;
    
    
    public static var GHOST : Int = _partid++;
    
    
    public static var FIENDISH : Int = _partid++;
    
    
    public static var DEMON : Int = _partid++;
    
    
    public static var GREMLIN : Int = _partid++;
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var EyesMem_static_initializer = {
        EnumValue.add(Memories, HUMAN, "HUMAN", {
                    id : "Unlocked Metamorph",
                    name : "Human Eyes",
                    cost : 500,
                    title : "Human",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesHuman;
                    }
                });
        EnumValue.add(Memories, SPIDER, "SPIDER", {
                    id : "Spider Eyes",
                    name : "Spider Eyes",
                    cost : 100,
                    title : "Spider",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesSpider;
                    }
                });
        EnumValue.add(Memories, CAT, "CAT", {
                    id : "Cat Eyes",
                    name : "Cat Eyes",
                    cost : 100,
                    title : "Cat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesCat;
                    }
                });
        EnumValue.add(Memories, INFERNAL, "INFERNAL", {
                    id : "Infernal Eyes",
                    name : "Infernal Eyes",
                    cost : 100,
                    title : "Infernal",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesInfernal;
                    }
                });
        EnumValue.add(Memories, MANTICORE, "MANTICORE", {
                    id : "Manticore Eyes",
                    name : "Manticore Eyes",
                    cost : 100,
                    title : "Manticore",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesManticore;
                    }
                });
        EnumValue.add(Memories, FOX, "FOX", {
                    id : "Fox Eyes",
                    name : "Fox Eyes",
                    cost : 100,
                    title : "Fox",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesFox;
                    }
                });
        EnumValue.add(Memories, JIANGSHI, "JIANGSHI", {
                    id : "Jiangshi Eyes",
                    name : "Jiangshi Eyes",
                    cost : 100,
                    title : "Jiangshi",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesJiangshi;
                    }
                });
        EnumValue.add(Memories, LIZARD, "LIZARD", {
                    id : "Lizard Eyes",
                    name : "Lizard Eyes",
                    cost : 100,
                    title : "Lizard",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesLizard;
                    }
                });
        EnumValue.add(Memories, SNAKE, "SNAKE", {
                    id : "Snake Eyes",
                    name : "Snake Eyes",
                    cost : 100,
                    title : "Snake",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesSnake;
                    }
                });
        EnumValue.add(Memories, SNAKEFIENDISH, "SNAKEFIENDISH", {
                    id : "Fiendish Snake Eyes",
                    name : "Fiendish Snake Eyes",
                    cost : 100,
                    title : "Fiendish",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesSnakeFiendish;
                    }
                });
        EnumValue.add(Memories, GORGON, "GORGON", {
                    id : "Gorgon Eyes",
                    name : "Gorgon Eyes",
                    cost : 100,
                    title : "Gorgon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesGorgon;
                    }
                });
        EnumValue.add(Memories, DRACONIC, "DRACONIC", {
                    id : "Draconic Eyes",
                    name : "Draconic Eyes",
                    cost : 100,
                    title : "Dragon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesDraconic;
                    }
                });
        EnumValue.add(Memories, DEVIL, "DEVIL", {
                    id : "Devil Eyes",
                    name : "Devil Eyes",
                    cost : 100,
                    title : "Devil",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesDevil;
                    }
                });
        EnumValue.add(Memories, ONI, "ONI", {
                    id : "Oni Eyes",
                    name : "Oni Eyes",
                    cost : 100,
                    title : "Oni",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesOni;
                    }
                });
        EnumValue.add(Memories, ELF, "ELF", {
                    id : "Elf Eyes",
                    name : "Elf Eyes",
                    cost : 100,
                    title : "Elf",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesElf;
                    }
                });
        EnumValue.add(Memories, FAIRY, "FAIRY", {
                    id : "Fairy Eyes",
                    name : "Fairy Eyes",
                    cost : 100,
                    title : "Fairy",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesFairy;
                    }
                });
        EnumValue.add(Memories, RAIJU, "RAIJU", {
                    id : "Raiju Eyes",
                    name : "Raiju Eyes",
                    cost : 100,
                    title : "Raiju",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesRaiju;
                    }
                });
        EnumValue.add(Memories, WEASEL, "WEASEL", {
                    id : "Weasel Eyes",
                    name : "Weasel Eyes",
                    cost : 100,
                    title : "Weasel",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesWeasel;
                    }
                });
        EnumValue.add(Memories, VAMPIRE, "VAMPIRE", {
                    id : "Vampire Eyes",
                    name : "Vampire Eyes",
                    cost : 100,
                    title : "Vampire",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesVampire;
                    }
                });
        EnumValue.add(Memories, ORC, "ORC", {
                    id : "Orc Eyes",
                    name : "Orc Eyes",
                    cost : 100,
                    title : "Orc",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesOrc;
                    }
                });
        EnumValue.add(Memories, DISPLACER, "DISPLACER", {
                    id : "Displacer Eyes",
                    name : "Displacer Eyes",
                    cost : 100,
                    title : "Displacer",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesDisplacer;
                    }
                });
        EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
                    id : "Cave Wyrm Eyes",
                    name : "Cave Wyrm Eyes",
                    cost : 100,
                    title : "Cave Wyrm",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesCaveWyrm;
                    }
                });
        EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
                    id : "Frost wyrm Eyes",
                    name : "Frost wyrm Eyes",
                    cost : 100,
                    title : "Frost wyrm Eyes",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesFrostwyrm;
                    }
                });
        EnumValue.add(Memories, HINEZUMI, "HINEZUMI", {
                    id : "Hinezumi Eyes",
                    name : "Hinezumi Eyes",
                    cost : 100,
                    title : "Hinezumi",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesHinezumi;
                    }
                });
        EnumValue.add(Memories, MONOEYE, "MONOEYE", {
                    id : "Monoeye",
                    name : "Monoeye",
                    cost : 100,
                    title : "Monoeye",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesMonoeye;
                    }
                });
        EnumValue.add(Memories, BLACK_EYES_SAND_TRAP, "BLACK_EYES_SAND_TRAP", {
                    id : "Black Eyes",
                    name : "Black Eyes",
                    cost : 100,
                    title : "Black Eyes",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesSandTrap;
                    }
                });
        EnumValue.add(Memories, BEAR, "BEAR", {
                    id : "Bear eyes",
                    name : "Bear eyes",
                    cost : 100,
                    title : "Bear",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesBear;
                    }
                });
        EnumValue.add(Memories, CANCER, "CANCER", {
                    id : "Cancer eyes",
                    name : "Cancer eyes",
                    cost : 100,
                    title : "Cancer",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesCancer;
                    }
                });
        EnumValue.add(Memories, CENTIPEDE, "CENTIPEDE", {
                    id : "Centipede eyes",
                    name : "Centipede eyes",
                    cost : 100,
                    title : "Centipede",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesCentipede;
                    }
                });
        EnumValue.add(Memories, RATATOSKR, "RATATOSKR", {
                    id : "Ratatoskr eyes",
                    name : "Ratatoskr eyes",
                    cost : 100,
                    title : "Ratatoskr",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesRatatoskr;
                    }
                });
        EnumValue.add(Memories, KRAKEN, "KRAKEN", {
                    id : "Kraken eyes",
                    name : "Kraken eyes",
                    cost : 100,
                    title : "Kraken",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesKraken;
                    }
                });
        EnumValue.add(Memories, FIRE_SNAIL, "FIRE_SNAIL", {
                    id : "FireSnail eyes",
                    name : "FireSnail eyes",
                    cost : 100,
                    title : "FireSnail",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesFireSnail;
                    }
                });
        EnumValue.add(Memories, FENRIR, "FENRIR", {
                    id : "Fenrir eyes",
                    name : "Fenrir eyes",
                    cost : 100,
                    title : "Fenrir",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesFenrir;
                    }
                });
        EnumValue.add(Memories, FERAL, "FERAL", {
                    id : "Feral eyes",
                    name : "Feral eyes",
                    cost : 100,
                    title : "Feral",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesFeral;
                    }
                });
        EnumValue.add(Memories, DEAD, "DEAD", {
                    id : "Dead eyes",
                    name : "Dead eyes",
                    cost : 100,
                    title : "Dead",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesDead;
                    }
                });
        EnumValue.add(Memories, GRYPHON, "GRYPHON", {
                    id : "Gryphon eyes",
                    name : "Gryphon eyes",
                    cost : 100,
                    title : "Gryphon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesGryphon;
                    }
                });
        EnumValue.add(Memories, GOAT, "GOAT", {
                    id : "Goat eyes",
                    name : "Goat eyes",
                    cost : 100,
                    title : "Goat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesGoat;
                    }
                });
        EnumValue.add(Memories, GHOST, "GHOST", {
                    id : "Ghost eyes",
                    name : "Ghost eyes",
                    cost : 100,
                    title : "Ghost",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesGhost;
                    }
                });
        EnumValue.add(Memories, FIENDISH, "FIENDISH", {
                    id : "Fiendish eyes",
                    name : "Fiendish eyes",
                    cost : 100,
                    title : "Fiendish",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesFiendish;
                    }
                });
        EnumValue.add(Memories, DEMON, "DEMON", {
                    id : "Demon Eyes",
                    name : "Demon Eyes",
                    cost : 100,
                    title : "Demon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesDemon;
                    }
                });
        EnumValue.add(Memories, GREMLIN, "GREMLIN", {
                    id : "Gremlin Eyes",
                    name : "Gremlin Eyes",
                    cost : 100,
                    title : "Gremlin",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.EyesGremlin;
                    }
                });
        true;
    }

}


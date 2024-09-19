package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.Tongue;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class TongueMem extends BaseContent
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
    
    
    public static var CAT : Int = _partid++;
    
    
    public static var CAVE_WYRM : Int = _partid++;
    
    
    public static var DEMONIC : Int = _partid++;
    
    
    public static var DOG : Int = _partid++;
    
    
    public static var DRACONIC : Int = _partid++;
    
    
    public static var ELF : Int = _partid++;
    
    
    public static var GHOST : Int = _partid++;
    
    
    public static var IMPISH : Int = _partid++;
    
    
    
    public static var MELKIE : Int = _partid++;
    
    
    public static var RATATOSKR : Int = _partid++;
    
    
    public static var RAVENOUS_TONGUE : Int = _partid++;
    
    
    public static var SNAKE : Int = _partid++;
    
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var TongueMem_static_initializer = {
        EnumValue.add(Memories, HUMAN, "HUMAN", {
                    id : "Unlocked Metamorph",
                    name : "Human Tongue",
                    cost : 500,
                    title : "Human",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueHuman;
                    }
                });
        EnumValue.add(Memories, CAT, "CAT", {
                    id : "Cat Tongue",
                    name : "Cat Tongue",
                    cost : 100,
                    title : "Cat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueCat;
                    }
                });
        EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
                    id : "Cave Wyrm Tongue",
                    name : "Cave Wyrm Tongue",
                    cost : 100,
                    title : "Cave Wyrm",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueCaveWyrm;
                    }
                });
        EnumValue.add(Memories, DEMONIC, "DEMONIC", {
                    id : "Demon Tongue",
                    name : "Demon Tongue",
                    cost : 100,
                    title : "Demon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueDemonic;
                    }
                });
        EnumValue.add(Memories, DOG, "DOG", {
                    id : "Dog Tongue",
                    name : "Dog Tongue",
                    cost : 100,
                    title : "Dog",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueDog;
                    }
                });
        EnumValue.add(Memories, DRACONIC, "DRACONIC", {
                    id : "Draconic Tongue",
                    name : "Draconic Tongue",
                    cost : 100,
                    title : "Dragon",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueDraconic;
                    }
                });
        EnumValue.add(Memories, ELF, "ELF", {
                    id : "Elf Tongue",
                    name : "Elf Tongue",
                    cost : 100,
                    title : "Elf",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueElf;
                    }
                });
        EnumValue.add(Memories, GHOST, "GHOST", {
                    id : "Ghost Tongue",
                    name : "Ghost Tongue",
                    cost : 100,
                    title : "Ghost",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueGhost;
                    }
                });
        EnumValue.add(Memories, IMPISH, "IMPISH", {
                    id : "Impish Voice",
                    name : "Impish Voice",
                    cost : 100,
                    title : "Impish",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueImp;
                    }
                });
        EnumValue.add(Memories, MELKIE, "MELKIE", {
                    id : "Melkie Tongue",
                    name : "Melkie Tongue",
                    cost : 100,
                    title : "Melkie",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueMelkie;
                    }
                });
        EnumValue.add(Memories, RATATOSKR, "RATATOSKR", {
                    id : "Ratatoskr Tongue",
                    name : "Ratatoskr Tongue",
                    cost : 100,
                    title : "Ratatoskr",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueRatatoskr;
                    }
                });
        EnumValue.add(Memories, RAVENOUS_TONGUE, "RAVENOUS_TONGUE", {
                    id : "Ravenous Tongue",
                    name : "Ravenous Tongue",
                    cost : 100,
                    title : "Ravenous",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueRavenous;
                    }
                });
        EnumValue.add(Memories, SNAKE, "SNAKE", {
                    id : "Snake Tongue",
                    name : "Snake Tongue",
                    cost : 100,
                    title : "Snake",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.TongueSnake;
                    }
                });
        true;
    }

}


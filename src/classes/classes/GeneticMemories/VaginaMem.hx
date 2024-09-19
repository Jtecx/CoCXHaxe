package classes.geneticMemories;

import classes.BaseContent;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class VaginaMem extends BaseContent
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
    
    
    public static var HUMAN : Int = _partid++;
    
    
    public static var EQUINE : Int = _partid++;
    
    
    public static var BLACK_SAND_TRAP : Int = _partid++;
    
    
    public static var CAVE_WYRM : Int = _partid++;
    
    
    public static var VENOM_DRIPPING : Int = _partid++;
    
    
    public static var MANTICORE : Int = _partid++;
    
    
    public static var CANCER : Int = _partid++;
    
    
    public static var DEMONIC : Int = _partid++;
    
    
    public static var SCYLLA : Int = _partid++;
    
    
    public static var NAGA : Int = _partid++;
    
    
    public static var SHARK : Int = _partid++;
    
    
    public static var RAIJU : Int = _partid++;
    
    
    public static var ALRAUNE : Int = _partid++;
    
    
    public static var KIRIN : Int = _partid++;
    
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var VaginaMem_static_initializer = {
        EnumValue.add(Memories, NONE, "NONE", {
                    id : "Unlocked Metamorph",
                    name : "No Vagina",
                    cost : 500,
                    title : "None",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaNone(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, HUMAN, "HUMAN", {
                    id : "Unlocked Metamorph",
                    name : "Human Vagina",
                    cost : 200,
                    title : "Human",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaHuman(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, EQUINE, "EQUINE", {
                    id : "Equine Vagina",
                    name : "Equine Vagina",
                    cost : 200,
                    title : "Equine",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaHorse(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, BLACK_SAND_TRAP, "BLACK_SAND_TRAP", {
                    id : "Black Sand Trap Vagina",
                    name : "Black Sand Trap Vagina",
                    cost : 200,
                    title : "Sand Trap",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaSandTrap(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, CAVE_WYRM, "CAVE_WYRM", {
                    id : "Cave Wyrm Vagina",
                    name : "Cave Wyrm Vagina",
                    cost : 200,
                    title : "Cave Wyrm",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaCaveWyrm(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, VENOM_DRIPPING, "VENOM_DRIPPING", {
                    id : "Centipede Vagina",
                    name : "Centipede Vagina",
                    cost : 200,
                    title : "Centipede",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaCentipede(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, MANTICORE, "MANTICORE", {
                    id : "Manticore Vagina",
                    name : "Manticore Vagina",
                    cost : 200,
                    title : "Manticore",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaManticore(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, CANCER, "CANCER", {
                    id : "Cancer Vagina",
                    name : "Cancer Vagina",
                    cost : 200,
                    title : "Cancer",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaCancer(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, DEMONIC, "DEMONIC", {
                    id : "Demon Vagina",
                    name : "Demon Vagina",
                    cost : 200,
                    title : "Demon",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaDemonic(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, SCYLLA, "SCYLLA", {
                    id : "Scylla Vagina",
                    name : "Scylla Vagina",
                    cost : 200,
                    title : "Scylla",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaScylla(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, NAGA, "NAGA", {
                    id : "Naga Vagina",
                    name : "Naga Vagina",
                    cost : 200,
                    title : "Naga",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaNaga(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, SHARK, "SHARK", {
                    id : "Shark Vagina",
                    name : "Shark Vagina",
                    cost : 200,
                    title : "Shark",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaShark(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, RAIJU, "RAIJU", {
                    id : "Raiju Vagina",
                    name : "Raiju Vagina",
                    cost : 200,
                    title : "Raiju",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaRaiju(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, ALRAUNE, "ALRAUNE", {
                    id : "Alraune Vagina",
                    name : "Alraune Vagina",
                    cost : 200,
                    title : "Alraune",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaAlraune(vaginaIndex);
                    }
                });
        EnumValue.add(Memories, KIRIN, "KIRIN", {
                    id : "Kirin Vagina",
                    name : "Kirin Vagina",
                    cost : 200,
                    title : "Kirin",
                    transformation : function(vaginaIndex : Int) : Transformation
                    {
                        return CoC.instance.transformations.VaginaKirin(vaginaIndex);
                    }
                });
        true;
    }

}


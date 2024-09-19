package classes.geneticMemories;

import classes.BaseContent;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class CockCountMem extends BaseContent
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
    
    public static var COCK1 : Int = _partid++;
    
    
    public static var COCK2 : Int = _partid++;
    
    
    public static var COCK3 : Int = _partid++;
    
    
    public static var COCK4 : Int = _partid++;
    
    
    public static var COCK5 : Int = _partid++;
    
    
    public static var COCK6 : Int = _partid++;
    
    
    public static var COCK7 : Int = _partid++;
    
    
    public static var COCK8 : Int = _partid++;
    
    
    public static var COCK9 : Int = _partid++;
    
    
    public static var COCK10 : Int = _partid++;
    
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var CockCountMem_static_initializer = {
        EnumValue.add(Memories, COCK1, "COCK1", {
                    id : "One Cock",
                    name : "One Cock",
                    title : "COCK1"
                });
        EnumValue.add(Memories, COCK2, "COCK2", {
                    id : "Two Cocks",
                    name : "Two Cocks",
                    title : "COCK2",
                    permReq : "One Cock"
                });
        EnumValue.add(Memories, COCK3, "COCK3", {
                    id : "Three Cocks",
                    name : "Three Cocks",
                    title : "COCK3",
                    permReq : "Two Cocks"
                });
        EnumValue.add(Memories, COCK4, "COCK4", {
                    id : "Four Cocks",
                    name : "Four Cocks",
                    title : "COCK4",
                    permReq : "Three Cocks"
                });
        EnumValue.add(Memories, COCK5, "COCK5", {
                    id : "Five Cocks",
                    name : "Five Cocks",
                    title : "COCK5",
                    permReq : "Four Cocks"
                });
        EnumValue.add(Memories, COCK6, "COCK6", {
                    id : "Six Cocks",
                    name : "Six Cocks",
                    title : "COCK6",
                    permReq : "Five Cocks"
                });
        EnumValue.add(Memories, COCK7, "COCK7", {
                    id : "Seven Cocks",
                    name : "Seven Cocks",
                    title : "COCK7",
                    permReq : "Six Cocks"
                });
        EnumValue.add(Memories, COCK8, "COCK8", {
                    id : "Eight Cocks",
                    name : "Eight Cocks",
                    title : "COCK8",
                    permReq : "Seven Cocks"
                });
        EnumValue.add(Memories, COCK9, "COCK9", {
                    id : "Nine Cocks",
                    name : "Nine Cocks",
                    title : "COCK9",
                    permReq : "Eight Cocks"
                });
        EnumValue.add(Memories, COCK10, "COCK10", {
                    id : "Ten Cocks",
                    name : "Ten Cocks",
                    title : "COCK10",
                    permReq : "Nine Cocks"
                });
        true;
    }

}


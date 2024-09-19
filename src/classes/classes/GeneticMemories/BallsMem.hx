package classes.geneticMemories;

import classes.BaseContent;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class BallsMem extends BaseContent
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
    
    
    public static var DUO : Int = _partid++;
    
    
    public static var QUAD : Int = _partid++;
    
    
    public static var TRAP : Int = _partid++;
    
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var BallsMem_static_initializer = {
        EnumValue.add(Memories, NONE, "NONE", {
                    id : "Unlocked Metamorph",
                    name : "No Balls",
                    cost : 500,
                    title : "None",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.BallsNone;
                    }
                });
        EnumValue.add(Memories, DUO, "DUO", {
                    id : "Duo balls",
                    name : "Duo balls",
                    cost : 100,
                    title : "Duo",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.BallsDuo;
                    }
                });
        EnumValue.add(Memories, QUAD, "QUAD", {
                    id : "Quad balls",
                    name : "Quad balls",
                    cost : 200,
                    title : "Quad",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.BallsQuad(1, true);
                    }
                });
        EnumValue.add(Memories, TRAP, "TRAP", {
                    id : "Trap balls",
                    name : "Trap balls",
                    cost : 200,
                    title : "Trap",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.BallsTrap;
                    }
                });
        true;
    }

}


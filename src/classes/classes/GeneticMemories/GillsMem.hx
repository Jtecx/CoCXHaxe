package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.Gills;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class GillsMem extends BaseContent
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
    
    
    public static var FISH : Int = _partid++;
    
    
    public static var ANEMONE : Int = _partid++;
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var GillsMem_static_initializer = {
        EnumValue.add(Memories, NONE, "NONE", {
                    id : "Unlocked Metamorph",
                    name : "No Gills",
                    cost : 500,
                    title : "None",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.GillsNone;
                    }
                });
        EnumValue.add(Memories, FISH, "FISH", {
                    id : "Fish Gills",
                    name : "Fish Gills",
                    cost : 100,
                    title : "Fish",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.GillsFish;
                    }
                });
        EnumValue.add(Memories, ANEMONE, "ANEMONE", {
                    id : "Anemone Gills",
                    name : "Anemone Gills",
                    cost : 100,
                    title : "Anemone",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.GillsAnemone;
                    }
                });
        true;
    }

}


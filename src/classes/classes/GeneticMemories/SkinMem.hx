package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.Skin;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class SkinMem extends BaseContent
{
    /**
	 * Entry properties:
	 * - id: the identificator of the Metamorph inside GeneticStorage
	 * - name: how the Metamorph is referred to in displayed texts
	 * - cost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - title: name displayed on the metamorph button
	 * - unlockText: additional text displayed when Metamorph is unlocked
	 * - availableCoverages: which levels of skin coverage are available for this skin Metamorph
	 * - transformation: TF object that refers to what the metamorph does
	 * - transformationCoverage: returns TF function that refers to what the metamorph does, overwrites transformation
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
			availableCoverages: [Skin.COVERAGES_HERE],
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			},
			transformationCoverage: function(function(player: *, coverage: int): Transformation {
				return CoC.instance.transformations.[TF Function from TransformationLib](Necessary Properties);
			}
		});

	 */
    
    public static var Memories : Array<Dynamic> = [];
    private static var _partid : Int = 0;
    
    public static var PLAIN : Int = _partid++;
    
    
    public static var FUR : Int = _partid++;
    
    
    public static var SCALES : Int = _partid++;
    
    
    public static var DRAGON_SCALES : Int = _partid++;
    
    
    public static var CHITIN : Int = _partid++;
    
    
    public static var AQUA_SCALES : Int = _partid++;
    
    
    public static var SLIME : Int = _partid++;
    
    
    public static var DARK_SLIME : Int = _partid++;
    
    
    public static var MAGMA_SLIME : Int = _partid++;
    
    
    public static var GHOST : Int = _partid++;
    
    
    public static var BARK : Int = _partid++;
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var SkinMem_static_initializer = {
        EnumValue.add(Memories, PLAIN, "PLAIN", {
                    id : "Unlocked Metamorph",
                    name : "Human Skin",
                    cost : 500,
                    title : "Human",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.SkinPlain;
                    }
                });
        EnumValue.add(Memories, FUR, "FUR", {
                    id : "Fur Skin",
                    name : "Fur",
                    cost : 100,
                    title : "Fur",
                    availableCoverages : [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinFur(coverage);
                    }
                });
        EnumValue.add(Memories, SCALES, "SCALES", {
                    id : "Scales Skin",
                    name : "Scales",
                    cost : 100,
                    title : "Scales",
                    availableCoverages : [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinScales(coverage);
                    }
                });
        EnumValue.add(Memories, DRAGON_SCALES, "DRAGON_SCALES", {
                    id : "Dragon Scales Skin",
                    name : "Dragon Scales",
                    cost : 150,
                    title : "D.Scales",
                    availableCoverages : [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinDragonScales(coverage);
                    }
                });
        EnumValue.add(Memories, CHITIN, "CHITIN", {
                    id : "Chitin Skin",
                    name : "Chitin",
                    cost : 100,
                    title : "Chitin",
                    availableCoverages : [Skin.COVERAGE_LOW, Skin.COVERAGE_COMPLETE],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinChitin(coverage);
                    }
                });
        EnumValue.add(Memories, AQUA_SCALES, "AQUA_SCALES", {
                    id : "Aqua Scales",
                    name : "Aqua Scales",
                    cost : 100,
                    title : "A.Scales",
                    availableCoverages : [Skin.COVERAGE_HIGH],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinAquaScales(coverage);
                    }
                });
        EnumValue.add(Memories, SLIME, "SLIME", {
                    id : "Slime Skin",
                    name : "Slime Skin",
                    cost : 100,
                    title : "Slime",
                    availableCoverages : [Skin.COVERAGE_COMPLETE],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinGoo(coverage, 0);
                    }
                });
        EnumValue.add(Memories, DARK_SLIME, "DARK_SLIME", {
                    id : "Dark Slime skin",
                    name : "Dark Slime skin",
                    cost : 100,
                    title : "Dark Slime",
                    availableCoverages : [Skin.COVERAGE_COMPLETE],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinGoo(coverage, 2);
                    }
                });
        EnumValue.add(Memories, MAGMA_SLIME, "MAGMA_SLIME", {
                    id : "Magma Slime Skin",
                    name : "Magma Slime skin",
                    cost : 100,
                    title : "Magma Slime",
                    availableCoverages : [Skin.COVERAGE_COMPLETE],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinGoo(coverage, 1);
                    }
                });
        EnumValue.add(Memories, GHOST, "GHOST", {
                    id : "Ghost Skin",
                    name : "Ghost skin",
                    cost : 100,
                    title : "Ghost",
                    availableCoverages : [Skin.COVERAGE_COMPLETE],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinTransparent;
                    }
                });
        EnumValue.add(Memories, BARK, "BARK", {
                    id : "Bark Skin",
                    name : "Bark skin",
                    cost : 100,
                    title : "Bark",
                    availableCoverages : [Skin.COVERAGE_COMPLETE],
                    transformationCoverage : function(coverage : Int) : Transformation
                    {
                        return CoC.instance.transformations.SkinBark(coverage);
                    }
                });
        true;
    }

}


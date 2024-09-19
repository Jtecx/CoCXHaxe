package classes.geneticMemories;

import classes.BaseContent;
import classes.StatusEffects;
import classes.bodyParts.*;
import classes.bodyParts.RearBody;
import classes.internals.EnumValue;
import classes.transformations.Transformation;
import classes.CoC;

class RearBodyMem extends BaseContent
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
    
    
    public static var LION_MANE : Int = _partid++;
    
    
    public static var SHARK_FIN : Int = _partid++;
    
    
    public static var ORCA_BLOWHOLE : Int = _partid++;
    
    
    public static var RAIJU_MANE : Int = _partid++;
    
    
    public static var BAT_COLLAR : Int = _partid++;
    
    
    public static var DISPLACER_TENTACLES : Int = _partid++;
    
    
    public static var TENTACLE_EYESTALKS : Int = _partid++;
    
    
    public static var FROSTWYRM : Int = _partid++;
    
    
    public static var YETI : Int = _partid++;
    
    
    public static var KRAKEN : Int = _partid++;
    
    
    public static var METAMORPHIC_GOO : Int = _partid++;
    
    
    public static var SNAIL_SHELL : Int = _partid++;
    
    
    public static var GLACIAL_AURA : Int = _partid++;
    
    
    public static var CENTIPEDE : Int = _partid++;
    
    
    public static var FENRIR_ICE_SPIKES : Int = _partid++;
    
    
    public static var WOLF_COLLAR : Int = _partid++;
    
    
    public static var FUR_COAT : Int = _partid++;
    
    
    public static var ATLACH_NACHA : Int = _partid++;
    
    
    public static var COBRA_HOOD : Int = _partid++;
    
    
    public static var GHOSTLY_AURA : Int = _partid++;
    
    
    public static var ABYSSAL_SHARK_FIN : Int = _partid++;
    
    
    public static function getMemory(memoryId : Float) : Dynamic
    {
        return Reflect.field(Memories, Std.string(memoryId)) || Memories[0];
    }

    public function new()
    {
        super();
    }
    private static var RearBodyMem_static_initializer = {
        EnumValue.add(Memories, NONE, "NONE", {
                    id : "Unlocked Metamorph",
                    name : "No Rear Body",
                    cost : 500,
                    title : "None",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyNone;
                    }
                });
        EnumValue.add(Memories, LION_MANE, "LION_MANE", {
                    id : "Lion Mane Rear Body",
                    name : "Lion Mane",
                    cost : 100,
                    title : "Lion",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyLionMane;
                    }
                });
        EnumValue.add(Memories, SHARK_FIN, "SHARK_FIN", {
                    id : "Shark Fin Rear Body",
                    name : "Shark Fin",
                    cost : 100,
                    title : "Shark",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodySharkFin;
                    }
                });
        EnumValue.add(Memories, ORCA_BLOWHOLE, "ORCA_BLOWHOLE", {
                    id : "Orca Blowhole Rear Body",
                    name : "Orca Blowhole",
                    cost : 100,
                    title : "Orca",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyOrcaBlowhole;
                    }
                });
        EnumValue.add(Memories, RAIJU_MANE, "RAIJU_MANE", {
                    id : "Raiju Mane Rear Body",
                    name : "Raiju Mane",
                    cost : 100,
                    title : "Raiju",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyRaijuMane;
                    }
                });
        EnumValue.add(Memories, BAT_COLLAR, "BAT_COLLAR", {
                    id : "Bat Collar Rear Body",
                    name : "Bat Collar",
                    cost : 100,
                    title : "Bat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyBatCollar;
                    }
                });
        EnumValue.add(Memories, DISPLACER_TENTACLES, "DISPLACER_TENTACLES", {
                    id : "Displacer Tentacles Rear Body",
                    name : "Displacer Tentacles",
                    cost : 100,
                    title : "Displacer",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyDisplacerTentacles;
                    }
                });
        EnumValue.add(Memories, TENTACLE_EYESTALKS, "TENTACLE_EYESTALKS", {
                    id : "Gazer Tentacle Eyestalks Rear Body",
                    name : "Gazer Tentacle Eyestalks",
                    cost : 100,
                    title : "Gazer",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyTentacleEyestalks;
                    }
                });
        EnumValue.add(Memories, FROSTWYRM, "FROSTWYRM", {
                    id : "Frostwyrm Rear Body",
                    name : "Frostwyrm Collar",
                    cost : 100,
                    title : "Frostwyrm",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyFrostwyrm;
                    }
                });
        EnumValue.add(Memories, YETI, "YETI", {
                    id : "Yeti Rear Body",
                    name : "Yeti Fur",
                    cost : 100,
                    title : "Yeti",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyYetiFur;
                    }
                });
        EnumValue.add(Memories, KRAKEN, "KRAKEN", {
                    id : "Kraken Body",
                    name : "Kraken",
                    cost : 100,
                    title : "Kraken",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyKraken;
                    }
                });
        EnumValue.add(Memories, METAMORPHIC_GOO, "METAMORPHIC_GOO", {
                    id : "Metamorphic Goo",
                    name : "Metamorphic Goo",
                    cost : 100,
                    title : "'Morphic Goo",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyMetamorphicGoo;
                    }
                });
        EnumValue.add(Memories, SNAIL_SHELL, "SNAIL_SHELL", {
                    id : "SnailShell",
                    name : "SnailShell",
                    cost : 100,
                    title : "SnailShell",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodySnailShell;
                    }
                });
        EnumValue.add(Memories, GLACIAL_AURA, "GLACIAL_AURA", {
                    id : "GlacialAura",
                    name : "GlacialAura",
                    cost : 100,
                    title : "GlacialAura",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyGlacialAura;
                    }
                });
        EnumValue.add(Memories, CENTIPEDE, "CENTIPEDE", {
                    id : "Centipede Rear Body",
                    name : "Centipede",
                    cost : 100,
                    title : "Centipede",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyCentipede;
                    }
                });
        EnumValue.add(Memories, FENRIR_ICE_SPIKES, "FENRIR_ICE_SPIKES", {
                    id : "FenrirIceSpikes Rear Body",
                    name : "FenrirIceSpikes",
                    cost : 100,
                    title : "FenrirIceSpikes",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyFenrirIceSpikes;
                    }
                });
        EnumValue.add(Memories, WOLF_COLLAR, "WOLF_COLLAR", {
                    id : "WolfCollar Rear Body",
                    name : "WolfCollar",
                    cost : 100,
                    title : "WolfCollar",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyWolfCollar;
                    }
                });
        EnumValue.add(Memories, FUR_COAT, "FUR_COAT", {
                    id : "FurCoat Rear Body",
                    name : "FurCoat",
                    cost : 100,
                    title : "FurCoat",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyFurCoat;
                    }
                });
        EnumValue.add(Memories, ATLACH_NACHA, "ATLACH_NACHA", {
                    id : "AtlachNacha Rear Body",
                    name : "AtlachNacha",
                    cost : 100,
                    title : "AtlachNacha",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyAtlachNacha;
                    }
                });
        EnumValue.add(Memories, COBRA_HOOD, "COBRA_HOOD", {
                    id : "Cobra Rear Body",
                    name : "Cobra Hood",
                    cost : 100,
                    title : "Cobra Hood",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyCobraHood;
                    }
                });
        EnumValue.add(Memories, GHOSTLY_AURA, "GHOSTLY_AURA", {
                    id : "GhostlyAura Body",
                    name : "GhostlyAura",
                    cost : 100,
                    title : "GhostlyAura",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyGhostlyAura;
                    }
                });
        EnumValue.add(Memories, ABYSSAL_SHARK_FIN, "ABYSSAL_SHARK_FIN", {
                    id : "Abyss Shark Fin Rear Body",
                    name : "Abyss Shark Fin",
                    cost : 200,
                    title : "Abyss Shark",
                    transformation : function() : Transformation
                    {
                        return CoC.instance.transformations.RearBodyAbyssalSharkFin;
                    }
                });
        true;
    }

}


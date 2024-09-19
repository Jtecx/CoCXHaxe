package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;

/**
 * Container class for the players skin
 *
 * * character has two layer of skin: base and ~~cover~~ coat
 * each layer has: `type`, `tone`, `adj` (optional adjective), and `desc` (overrides default noun for type)
 * a **coverage** parameter with the rance:
 * `(0) COVERAGE_NONE` : coat layer is non-existant
 * `(1) COVERAGE_LOW` : coat layer exists, but its descriptions appear only when explicitly called
 * `(2) COVERAGE_MEDIUM` : coat layer exists, descriptions use mixed "[base] and [skin coat]", can explicitly check either
 * `(3) COVERAGE_HIGH` : coat layer exists and is used as a default layer when describing skin; base description appear only when explicitly called
 * `(4) COVERAGE_COMPLETE` : same as COVERAGE_HIGH; intended to be used when even face is fully coverred
 * tattoos should be moved to body part-level as patterns
 *
 * @since December 27, 2016
 * @author Stadler76, aimozg
 */
class Skin extends SaveableBodyPart
{
    public var coverage(get, set) : Int;
    public var color(get, set) : String;
    public var color1(get, never) : String;
    public var color2(get, never) : String;
    public var desc(get, never) : String;
    public var adj(get, never) : String;
    public var pattern(get, never) : Int;
    public var fur(get, never) : SkinLayer;
    public var shortName(get, never) : String;

    
    
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1, 2)
	 * - id: name of the constant ("PLAIN", "FUR", "SCALES")
	 * - name: human-readable default name, ("skin", "fur", "scales")
	 */
    public static var CoverageTypes : Array<Dynamic> = [];
    public static inline var COVERAGE_NONE : Int = 0;
    
    public static inline var COVERAGE_LOW : Int = 1;
    
    public static inline var COVERAGE_MEDIUM : Int = 2;
    
    public static inline var COVERAGE_HIGH : Int = 3;
    
    public static inline var COVERAGE_COMPLETE : Int = 4;
    
    
    
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1, 2)
	 * - id: name of the constant ("PLAIN", "FUR", "SCALES")
	 * - name: human-readable default name, ("skin", "fur", "scales")
	 * - adj: default adjective
	 * - plural: is name a plural noun phrase (false, false, true)
	 * - base: is valid base layer type (true, false, false)
	 * - coat: is valid coat layer type (false, true, true)
	 * - material: BodyMaterial this is made of
	 */
    public static var SkinTypes : Array<Dynamic> = [];
    
    public static inline var PLAIN : Int = 0;
    
    public static inline var FUR : Int = 1;
    
    public static inline var SCALES : Int = 2;
    
    public static inline var GOO : Int = 3;
    
    public static inline var UNDEFINED : Int = 4;  //[Deprecated] Silently discarded upon loading save  
    public static inline var CHITIN : Int = 5;
    
    public static inline var BARK : Int = 6;
    
    public static inline var STONE : Int = 7;
    
    public static inline var TATTOED : Int = 8;  // [Deprecated] Replaced on load with PLAIN + pattern  
    public static inline var AQUA_SCALES : Int = 9;
    
    public static inline var PARTIAL_FUR : Int = 10;  // [Deprecated] Replaced on load with PLAIN + FUR  
    public static inline var PARTIAL_SCALES : Int = 11;  // [Deprecated] Replaced on load with PLAIN + SCALES  
    public static inline var PARTIAL_CHITIN : Int = 12;  // [Deprecated] Replaced on load with PLAIN + CHITIN  
    public static inline var PARTIAL_BARK : Int = 13;  // [Deprecated] Replaced on load with PLAIN + BARK  
    public static inline var DRAGON_SCALES : Int = 14;
    
    public static inline var MOSS : Int = 15;
    
    public static inline var PARTIAL_DRAGON_SCALES : Int = 16;  // [Deprecated] Replaced on load with PLAIN + DRAGON_SCALES  
    public static inline var PARTIAL_STONE : Int = 17;  // [Deprecated] Replaced on load with PLAIN + STONE  
    public static inline var PARTIAL_AQUA_SCALES : Int = 18;  // [Deprecated] Replaced on load with PLAIN + AQUA_SCALES  
    public static inline var AQUA_RUBBER_LIKE : Int = 19;
    
    public static inline var TATTOED_ONI : Int = 20;  // [Deprecated] Replaced on load with PLAIN + pattern  
    public static inline var FEATHER : Int = 21;
    
    public static inline var TRANSPARENT : Int = 22;
    
    
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "MAGICAL_TATTOO")
	 * - name: human-readable default name, ("none", "magical tattoo")
	 * - base: valid pattern for base layer
	 * - coat: valid pattern for coat layer
	 */
    public static var PatternTypes : Array<Dynamic> = [];
    
    public static inline var PATTERN_NONE : Int = 0;
    
    public static inline var PATTERN_MAGICAL_TATTOO : Int = 1;
    
    public static inline var PATTERN_ORCA_UNDERBODY : Int = 2;
    
    public static inline var PATTERN_BEE_STRIPES : Int = 3;
    
    public static inline var PATTERN_TIGER_STRIPES : Int = 4;
    
    public static inline var PATTERN_BATTLE_TATTOO : Int = 5;
    
    public static inline var PATTERN_SPOTTED : Int = 6;
    
    public static inline var PATTERN_LIGHTNING_SHAPED_TATTOO : Int = 7;
    
    public static inline var PATTERN_RED_PANDA_UNDERBODY : Int = 8;
    
    public static inline var PATTERN_SCAR_SHAPED_TATTOO : Int = 9;
    
    public static inline var PATTERN_WHITE_BLACK_VEINS : Int = 10;
    
    public static inline var PATTERN_VENOMOUS_MARKINGS : Int = 11;
    
    public static inline var PATTERN_USHI_ONI_TATTOO : Int = 12;
    
    public static inline var PATTERN_SCAR_WINDSWEPT : Int = 13;
    
    public static inline var PATTERN_OIL : Int = 14;
    
    public static inline var PATTERN_SEA_DRAGON_UNDERBODY : Int = 15;
    
    public static inline var PATTERN_ARCH_IMP_RUNIC_TATTOO : Int = 16;
    
    public static inline var PATTERN_GLYPH_TATTOO : Int = 17;
    
    public static inline var PATTERN_BIOLUMINESCENCE : Int = 18;
    
    //19
    public static inline var PATTERN_DEMONIC_PLEASURE_RUNE : Int = 20;
    
    public static inline var PATTERN_BLOOD_MAGIC_TATTOO : Int = 21;
    
    // Don't forget to add new types in DebugMenu.as lists SKIN_BASE_TYPES or SKIN_COAT_TYPES
    
    public var base : SkinLayer;
    public var coat : SkinLayer;
    private var _coverage : Int = COVERAGE_NONE;
    
    public function new(creature : Creature)
    {
        super(creature, "skin", ["coverage"]);
        base = new SkinLayer(this);
        coat = new SkinLayer(this);
        addPublicJsonables(["base", "coat"]);
    }
    
    @:meta(Deprecated(replacement="describe('coat')"))

    public function skinFurScales() : String
    {
        return describe("coat");
    }
    private function get_coverage() : Int
    {
        return _coverage;
    }
    private function set_coverage(value : Int) : Int
    {
        _coverage = boundInt(COVERAGE_NONE, value, COVERAGE_COMPLETE);
        return value;
    }
    private function get_color() : String
    {
        return skinValue(base.color, coat.color);
    }
    private function get_color1() : String
    {
        return skinValue(base.color1, coat.color1);
    }
    private function get_color2() : String
    {
        return skinValue(base.color2, coat.color2);
    }
    private function set_color(value : String) : String
    {
        if (_coverage <= COVERAGE_MEDIUM)
        {
            base.color = value;
        }
        if (_coverage >= COVERAGE_MEDIUM)
        {
            coat.color = value;
        }
        return value;
    }
    private function get_desc() : String
    {
        return skinValue(base.desc, coat.desc);
    }
    private function get_adj() : String
    {
        return skinValue(base.adj, coat.adj);
    }
    private function get_pattern() : Int
    {
        if (coverage >= COVERAGE_NONE && coat.pattern != PATTERN_NONE)
        {
            return coat.pattern;
        }
        return base.pattern;
    }
    /**
	 * Returns `s` (default "is") if the skin main layer noun is singular (skin,fur,chitin)
	 * and `p` (default "are") if plural (scales)
	 */
    public function isAre(s : String = "is", p : String = "are") : String
    {
        return skinValue(base.isAre(s, p), coat.isAre(s, p));
    }
    override private function get_type() : Int
    {
        if (coverage > COVERAGE_NONE)
        {
            return coat.type;
        }
        return base.type;
    }
    
    override public function hasMaterial(type : Int) : Bool
    {
        return base.hasMaterial(type) || coat.hasMaterial(type);
    }
    
    /**
	 * Checks both layers against property set
	 * @param p {color, type, adj, desc}
	 * @return this.base, this.coat, or null
	 */
    public function findLayer(p : Dynamic) : SkinLayer
    {
        if (coverage < COVERAGE_COMPLETE && base.checkProps(p))
        {
            return base;
        }
        if (coverage > COVERAGE_NONE && coat.checkProps(p))
        {
            return coat;
        }
        return null;
    }
    
    public function growCoat(type : Int, options : Dynamic = null, coverage : Int = COVERAGE_HIGH) : SkinLayer
    {
        this.coverage = coverage;
        this.coat.type = type;
        if (options != null)
        {
            this.coat.setProps(options);
        }
        return this.coat;
    }
    /**
	 * @param options = {color,adj,desc}
	 */
    public function growFur(options : Dynamic = null, coverage : Int = COVERAGE_HIGH) : SkinLayer
    {
        this.coverage = coverage;
        this.coat.type = FUR;
        if (options != null)
        {
            this.coat.setProps(options);
        }
        return this.coat;
    }
    /**
	 * @param baseOptions = {color,adj,desc,type}
	 */
    public function setBaseOnly(baseOptions : Dynamic = null) : Void
    //mainly workaround to fix *something* setting the skin desc forever. Fuck.
    {
        
        //clear coverage. Nobody needs its type, color
        this.coverage = Skin.COVERAGE_NONE;
        coat.restore(true);  //restore, keep color for parts  
        if (baseOptions != null)
        {
            this.base.setAllProps(baseOptions);
        }
    }
    /**
	 * @param layer 'base','coat','skin' (both layer if MEDIUM, else major),'full' (both layers if present)
	 * @return
	 */
    public function describe(layer : String = "skin", noAdj : Bool = false, noTone : Bool = false) : String
    {
        var s_base : String = base.describe(noAdj, noTone);
        var s_coat : String = coat.describe(noAdj, noTone);
        switch (coverage)
        {
            case COVERAGE_NONE:
                return s_base;
            case COVERAGE_LOW:
                switch (layer)
                {
                    case "coat":
                        return s_coat;
                    case "full":
                        return s_base + " with patches of " + s_coat;
                    case "skin", "base":
                        return s_base;
                    default:
                        return s_base;
                }
            case COVERAGE_MEDIUM:
                switch (layer)
                {
                    case "coat":
                        return s_coat;
                    case "full", "skin":
                        return s_base + " and " + s_coat;
                    case "base":
                        return s_base;
                    default:
                        return s_base;
                }
            case COVERAGE_HIGH:
                switch (layer)
                {
                    case "base":
                        return s_base;
                    case "full":
                        return s_base + " under " + s_coat;
                    case "skin", "coat":
                        return s_coat;
                    default:
                        return s_coat;
                }
            case COVERAGE_COMPLETE:
                switch (layer)
                {
                    case "base":
                        return s_base;
                    case "full":
                        return s_base + " under " + s_coat;
                    case "skin", "coat":
                        return s_coat;
                    default:
                        return s_coat;
                }
            default:
                return s_coat;
        }
    }
    override public function descriptionFull() : String
    {
        return describe("full");
    }
    public function hasAny(types : Array<Dynamic> = null) : Bool
    {
        if (types.length == 1 && Std.is(types[0], Array))
        {
            types = types[0];
        }
        return (coverage < COVERAGE_COMPLETE && base.isAny(types)) ||
        (coverage > COVERAGE_NONE && coat.isAny(types));
    }
    public function isCoverLowMid() : Bool
    {
        return coverage > COVERAGE_NONE && coverage < COVERAGE_HIGH;
    }
    public function coatType() : Int
    {
        return (hasCoat()) ? coat.type : -1;
    }
    public function baseType() : Int
    {
        return base.type;
    }
    public function hasCoat() : Bool
    {
        return coverage > COVERAGE_NONE && coverage <= COVERAGE_COMPLETE;
    }
    public function hasFullCoat() : Bool
    {
        return coverage >= COVERAGE_HIGH && coverage <= COVERAGE_COMPLETE;
    }
    public function hasFullCoatOfType(types : Array<Dynamic> = null) : Bool
    {
        return hasFullCoat() && coat.isAny(types);
    }
    public function hasCoatOfType(types : Array<Dynamic> = null) : Bool
    {
        return hasCoat() && coat.isAny(types);
    }
    public function hasPartialCoat() : Bool
    {
        return coverage == COVERAGE_LOW;
    }
    public function hasPartialCoatOfType(types : Array<Dynamic> = null) : Bool
    {
        return hasPartialCoat() && coat.isAny(types);
    }
    public function isFurCovered() : Bool
    {
        return hasCoatOfType(FUR);
    }
    private function get_fur() : SkinLayer
    {
        return (isFurCovered()) ? coat : null;
    }
    public function isChitinCovered() : Bool
    {
        return hasCoatOfType(CHITIN);
    }
    public function isScaleCovered() : Bool
    {
        return hasCoatOfType(SCALES, AQUA_SCALES, DRAGON_SCALES);
    }
    public function isReptileScaleCovered() : Bool
    {
        return hasCoatOfType(SCALES, DRAGON_SCALES);
    }
    public function isDragonScaleCovered() : Bool
    {
        return hasCoatOfType(DRAGON_SCALES);
    }
    public function isLizardScaleCovered() : Bool
    {
        return hasCoatOfType(SCALES);
    }
    public function isNonLizardScaleCovered() : Bool
    {
        return isScaleCovered() && !isLizardScaleCovered();
    }
    public function hasBark() : Bool
    {
        return base.isAny(BARK);
    }
    public function isGooSkin() : Bool
    {
        return base.isAny(GOO);
    }
    public function hasRubberSkin() : Bool
    {
        return base.isAny(AQUA_RUBBER_LIKE);
    }
    public function isGhostSkin() : Bool
    {
        return base.isAny(TRANSPARENT);
    }
    public function isFeatherCovered() : Bool
    {
        return coat.isAny(FEATHER);
    }
    public function hasMostlyPlainSkin() : Bool
    {
        return coverage <= COVERAGE_LOW && base.type == PLAIN;
    }
    public function hasPlainSkinOnly() : Bool
    {
        return coverage == COVERAGE_NONE && base.type == PLAIN;
    }
    public function hasBaseOnly(baseType : Int) : Bool
    {
        return coverage == COVERAGE_NONE && base.type == baseType;
    }
    public function hasPlainSkin() : Bool
    {
        return coverage < COVERAGE_COMPLETE && base.type == PLAIN;
    }
    public function hasNoPattern() : Bool
    {
        return base.pattern == PATTERN_NONE && coat.pattern == PATTERN_NONE;
    }
    public function hasMagicalTattoo() : Bool
    {
        return base.pattern == PATTERN_MAGICAL_TATTOO;
    }
    public function hasBattleTattoo() : Bool
    {
        return base.pattern == PATTERN_BATTLE_TATTOO;
    }
    public function hasLightningShapedTattoo() : Bool
    {
        return base.pattern == PATTERN_LIGHTNING_SHAPED_TATTOO;
    }
    public function hasWindSweptScars() : Bool
    {
        return base.pattern == PATTERN_SCAR_WINDSWEPT;
    }
    public function hasOilySkin() : Bool
    {
        return base.pattern == PATTERN_OIL;
    }
    public function hasScarShapedTattoo() : Bool
    {
        return base.pattern == PATTERN_SCAR_SHAPED_TATTOO;
    }
    public function hasVenomousMarking() : Bool
    {
        return base.pattern == PATTERN_VENOMOUS_MARKINGS;
    }
    public function hasWhiteBlackVeins() : Bool
    {
        return base.pattern == PATTERN_WHITE_BLACK_VEINS;
    }
    public function hasUshiOniTattoo() : Bool
    {
        return base.pattern == PATTERN_USHI_ONI_TATTOO;
    }
    public function hasGlyphTattoo() : Bool
    {
        return base.pattern == PATTERN_GLYPH_TATTOO;
    }
    public function hasBioluminescence() : Bool
    {
        return base.pattern == PATTERN_BIOLUMINESCENCE;
    }
    override public function restore(keepTone : Bool = true) : Void
    {
        coverage = COVERAGE_NONE;
        base.restore(keepTone);
        coat.restore(keepTone);
    }
    override public function setProps(p : Dynamic) : Void
    {
        super.setProps(p);
        if (Lambda.has(p, "base"))
        {
            base.setProps(p.base);
        }
        if (Lambda.has(p, "coat"))
        {
            base.setProps(p.coat);
        }
    }
    private function skinValue(inBase : String, inCoat : String) : String
    {
        switch (coverage)
        {
            case COVERAGE_NONE, COVERAGE_LOW:
                return inBase;
            case COVERAGE_MEDIUM, COVERAGE_HIGH, COVERAGE_COMPLETE:
                return inCoat;
            default:
                return inCoat;
        }
    }
    //noinspection JSDeprecatedSymbols
    private static var PARTIAL_TO_FULL : Dynamic = createMapFromPairs([
                [PARTIAL_CHITIN, CHITIN], 
                [PARTIAL_SCALES, SCALES], 
                [PARTIAL_FUR, FUR], 
                [PARTIAL_BARK, BARK], 
                [PARTIAL_AQUA_SCALES, AQUA_SCALES], 
                [PARTIAL_DRAGON_SCALES, DRAGON_SCALES], 
                [PARTIAL_STONE, PARTIAL_STONE]
        ]);
    private static var TYPE_TO_BASE_COVERAGE_COAT : Dynamic = multipleMapsFromPairs([
                [PLAIN, 
                PLAIN, COVERAGE_NONE, 0
        ], 
                [FUR, 
                PLAIN, COVERAGE_HIGH, FUR
        ], 
                [SCALES, 
                PLAIN, COVERAGE_HIGH, SCALES
        ], 
                [GOO, 
                GOO, COVERAGE_NONE, 0
        ], 
                [UNDEFINED, 
                PLAIN, COVERAGE_NONE, 0
        ], 
                [CHITIN, 
                PLAIN, COVERAGE_HIGH, CHITIN
        ], 
                [BARK, 
                PLAIN, COVERAGE_HIGH, BARK
        ], 
                [STONE, 
                STONE, COVERAGE_NONE, 0
        ], 
                [TATTOED, 
                PLAIN, COVERAGE_NONE, 0
        ], 
                [AQUA_SCALES, 
                PLAIN, COVERAGE_HIGH, AQUA_SCALES
        ], 
                [PARTIAL_FUR, 
                PLAIN, COVERAGE_LOW, FUR
        ], 
                [PARTIAL_SCALES, 
                PLAIN, COVERAGE_LOW, SCALES
        ], 
                [PARTIAL_CHITIN, 
                PLAIN, COVERAGE_LOW, CHITIN
        ], 
                [PARTIAL_BARK, 
                PLAIN, COVERAGE_LOW, BARK
        ], 
                [DRAGON_SCALES, 
                PLAIN, COVERAGE_HIGH, DRAGON_SCALES
        ], 
                [MOSS, 
                PLAIN, COVERAGE_HIGH, MOSS
        ], 
                [PARTIAL_DRAGON_SCALES, 
                PLAIN, COVERAGE_LOW, DRAGON_SCALES
        ], 
                [PARTIAL_STONE, 
                PLAIN, COVERAGE_LOW, STONE
        ], 
                [PARTIAL_AQUA_SCALES, 
                PLAIN, COVERAGE_LOW, AQUA_SCALES
        ], 
                [AQUA_RUBBER_LIKE, 
                PLAIN, COVERAGE_NONE, 0
        ], 
                [TATTOED_ONI, 
                PLAIN, COVERAGE_NONE, 0
        ], 
                [FEATHER, 
                PLAIN, COVERAGE_HIGH, FEATHER
        ], 
                [TRANSPARENT, 
                TRANSPARENT, COVERAGE_NONE, 0
        ]
        ]);
    private static var TYPE_TO_BASE : Dynamic = Reflect.field(TYPE_TO_BASE_COVERAGE_COAT, Std.string(0));
    private static var TYPE_TO_COVERAGE : Dynamic = Reflect.field(TYPE_TO_BASE_COVERAGE_COAT, Std.string(1));
    private static var TYPE_TO_COAT : Dynamic = Reflect.field(TYPE_TO_BASE_COVERAGE_COAT, Std.string(2));
    @:meta(Deprecated())

    override private function set_type(value : Int) : Int
    {
        coverage = Reflect.field(TYPE_TO_COVERAGE, Std.string(value));
        base.type = Reflect.field(TYPE_TO_BASE, Std.string(value));
        coat.type = Reflect.field(TYPE_TO_COAT, Std.string(value));
        if (value == TATTOED)
        {
            base.pattern = PATTERN_MAGICAL_TATTOO;
            base.adj = "tattooed";
        }
        else if (value == AQUA_RUBBER_LIKE)
        {
            base.adj = "slippery rubber-like";
        }
        else if (value == TATTOED_ONI)
        {
            base.pattern = PATTERN_BATTLE_TATTOO;
            base.adj = "battle tattooed";
        }
        return value;
    }
    override private function loadFromOldSave(savedata : Dynamic) : Void
    //Convert from old skinDesc to new skinAdj + skinDesc!
    {
        
        var type : Int = intOr(savedata.skinType, PLAIN);
        //noinspection JSDeprecatedSymbols
        if (type == UNDEFINED)
        {
            type = PLAIN;
        }
        var desc : String = stringOr(savedata.skinDesc, "");
        var adj : String = stringOr(savedata.skinAdj, "");
        for (legacyAdj in ["smooth", "thick", "rubber", "latex", "slimey"])
        {
            if (desc.indexOf(legacyAdj) != -1)
            {
                adj = legacyAdj;
                if (type == FUR)
                {
                    desc = "fur";
                }
                else if (type == GOO)
                {
                    desc = "goo";
                }
                else if (Lambda.indexOf([
                            SCALES, 
                            AQUA_SCALES, 
                            DRAGON_SCALES
                ], type) >= 0)
                {
                    desc = "scales";
                }
                else
                {
                    desc = "skin";
                }
            }
        }
        //noinspection JSDeprecatedSymbols
        if (InCollection(type, PLAIN, GOO, TATTOED, STONE, SCALES, AQUA_SCALES, PARTIAL_DRAGON_SCALES, AQUA_RUBBER_LIKE, TATTOED_ONI))
        {
            coverage = COVERAGE_NONE;
            base.type = type;
            base.adj = adj;
            base.desc = desc;
            coat.type = FUR;
        }
        else
        {
            coverage = COVERAGE_HIGH;
            if (Lambda.has(PARTIAL_TO_FULL, type))
            {
                coverage = COVERAGE_LOW;
                type = Reflect.field(PARTIAL_TO_FULL, Std.string(type));
            }
            coat.type = type;
            coat.adj = adj;
            coat.desc = desc;
        }
    }
    override private function saveToOldSave(savedata : Dynamic) : Void
    {
        savedata.skinType = type;
        savedata.skinDesc = desc;
        savedata.skinAdj = adj;
        savedata.skinTone = color;
        savedata.furColor = coat.color;
        savedata.scalesColor = coat.color;
        savedata.chitinColor = coat.color;
    }
    
    private function get_shortName() : String
    {
        return SkinTypes[type].name;
    }
    
    public static function getSkinAppearanceDescription(creature : Dynamic) : String
    {
        var id : Int = creature.skin.type;
        return formatDescription(((SkinTypes[id].appearanceDescFunc) ? SkinTypes[id].appearanceDescFunc(creature) : SkinTypes[id].appearanceDesc) || "", creature);
    }
    
    public static function getSkinPatternAppearanceDescription(creature : Dynamic) : String
    {
        var id : Int = creature.skin.pattern;
        
        return formatDescription(((PatternTypes[id].appearanceDescFunc) ? PatternTypes[id].appearanceDescFunc(creature) : PatternTypes[id].appearanceDesc) || "", creature);
    }
    
    private static function formatDescription(desc : String, creature : Dynamic) : String
    {
        var upperCasePattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('^.', "");
        var coveragePattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('{partiallyOrCompletely}', "g");
        
        return coveragePattern.replace(desc, (creature.skin.coverage > Skin.COVERAGE_MEDIUM) ? "completely" : "partially").replace(upperCasePattern, function(__DOLLAR__0 : Dynamic) : Dynamic
                {
                    return __DOLLAR__0.toUpperCase();
                });
    }
    private static var Skin_static_initializer = {
        EnumValue.add(CoverageTypes, COVERAGE_NONE, "NONE", {
                    name : "no"
                });
        EnumValue.add(CoverageTypes, COVERAGE_LOW, "LOW", {
                    name : "partial"
                });
        EnumValue.add(CoverageTypes, COVERAGE_MEDIUM, "MEDIUM", {
                    name : "medium"
                });
        EnumValue.add(CoverageTypes, COVERAGE_HIGH, "HIGH", {
                    name : "high"
                });
        EnumValue.add(CoverageTypes, COVERAGE_COMPLETE, "COMPLETE", {
                    name : "complete"
                });
        EnumValue.add(SkinTypes, PLAIN, "PLAIN", {
                    name : "skin",
                    appearanceDesc : "Your [skin base] has a completely normal texture, at least for your original world.",
                    plural : false,
                    base : true,
                    material : BodyMaterial.SKIN
                });
        EnumValue.add(SkinTypes, FUR, "FUR", {
                    name : "fur",
                    appearanceDesc : "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
                    plural : false,
                    coat : true,
                    material : BodyMaterial.FUR
                });
        EnumValue.add(SkinTypes, SCALES, "SCALES", {
                    name : "scales",
                    appearanceDesc : "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
                    plural : true,
                    material : BodyMaterial.SCALES
                });
        EnumValue.add(SkinTypes, GOO, "GOO", {
                    name : "skin",
                    adj : "goopey",
                    appearanceDesc : "Your [skin base] is {partiallyOrCompletely} made of [skin coat].",
                    plural : false,
                    base : true,
                    material : BodyMaterial.SKIN
                });
        EnumValue.add(SkinTypes, CHITIN, "CHITIN", {
                    name : "chitin",
                    appearanceDesc : "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
                    plural : false,
                    coat : true,
                    material : BodyMaterial.CHITIN
                });
        EnumValue.add(SkinTypes, BARK, "BARK", {
                    name : "bark",
                    appearanceDesc : "Your [skin base] has been replaced with a thick, sturdy layer of bark. The knotted wood is hard, and you can barely feel any pain through it, even when your skin is struck.",
                    plural : false,
                    base : true,
                    material : BodyMaterial.BARK
                });
        EnumValue.add(SkinTypes, STONE, "STONE", {
                    name : "stone",
                    appearanceDesc : "Your [skin base] is completely made of [gargoylematerial].",
                    plural : false,
                    base : true,
                    material : BodyMaterial.SKIN
                });
        EnumValue.add(SkinTypes, AQUA_SCALES, "AQUA_SCALES", {
                    name : "aqua scales",
                    appearanceDesc : "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
                    plural : true,
                    coat : true,
                    material : BodyMaterial.SCALES
                });
        EnumValue.add(SkinTypes, DRAGON_SCALES, "DRAGON_SCALES", {
                    name : "dragon scales",
                    appearanceDesc : "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
                    plural : false,
                    coat : true,
                    material : BodyMaterial.SCALES
                });
        EnumValue.add(SkinTypes, MOSS, "MOSS", {
                    name : "moss",
                    appearanceDesc : "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
                    plural : false,
                    coat : true,
                    material : BodyMaterial.SKIN
                });
        EnumValue.add(SkinTypes, AQUA_RUBBER_LIKE, "AQUA_RUBBER_LIKE", {
                    name : "slippery rubber-like skin",
                    appearanceDesc : "Your [skin base] has a rubber-like texture.",
                    plural : false,
                    base : true,
                    material : BodyMaterial.SKIN
                });
        EnumValue.add(SkinTypes, FEATHER, "FEATHER", {
                    name : "feather",
                    appearanceDesc : "Your [skin base] is {partiallyOrCompletely} covered by [skin coat].",
                    plural : false,
                    base : true,
                    material : BodyMaterial.FEATHERS
                });
        EnumValue.add(SkinTypes, TRANSPARENT, "TRANSPARENT", {
                    name : "transparent",
                    appearanceDesc : "Your [skin base] is completely transparent, like a ghost's.",
                    plural : false,
                    base : true,
                    material : BodyMaterial.SKIN
                });
        EnumValue.add(PatternTypes, PATTERN_NONE, "NONE", {
                    name : "none",
                    appearanceDesc : "",
                    base : true,
                    coat : true
                });
        EnumValue.add(PatternTypes, PATTERN_MAGICAL_TATTOO, "MAGICAL_TATTOO", {
                    name : "magical tattoo",
                    appearanceDesc : "Your body is covered with runic tattoos.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_ORCA_UNDERBODY, "ORCA_UNDERBODY", {
                    name : "orca underbody",
                    appearanceDesc : "A [skin base.color2] underbelly runs on the underside of your limbs bearing a glossy shine, similar to that of an orca.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_BEE_STRIPES, "BEE_STRIPES", {
                    name : "bee stripes",
                    appearanceDesc : "You have [skin coat.color1] [skin coat.nocolor] covered by a bee-like [skin coat.color2] stripe pattern.",
                    coat : true
                });
        EnumValue.add(PatternTypes, PATTERN_TIGER_STRIPES, "TIGER_STRIPES", {
                    name : "tiger stripes",
                    appearanceDesc : "You have [skin coat] covered by a tiger-like [skin coat.color2] stripe pattern.",
                    coat : true
                });
        EnumValue.add(PatternTypes, PATTERN_BATTLE_TATTOO, "BATTLE_TATTOO", {
                    name : "battle tattoo",
                    appearanceDesc : "Your body is covered with battle tattoos.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_SPOTTED, "SPOTTED", {
                    name : "spotted",
                    appearanceDesc : "You have many [fur color2] spots around your [fur color1] fur.",
                    coat : true
                });
        EnumValue.add(PatternTypes, PATTERN_LIGHTNING_SHAPED_TATTOO, "LIGHTNING_SHAPED_TATTOO", {
                    name : "lightning shaped tattoo",
                    appearanceDesc : "Your body is covered with glowing lightning tattoos.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_RED_PANDA_UNDERBODY, "RED_PANDA_UNDERBODY", {
                    name : "red panda underbody",
                    appearanceDesc : "You have an underbelly colored [skin coat.color2].",
                    coat : true
                });
        EnumValue.add(PatternTypes, PATTERN_SCAR_SHAPED_TATTOO, "SCAR_SHAPED_TATTOO", {
                    name : "scar shaped tattoo",
                    appearanceDesc : "Your body is covered with scar-shaped tattoos.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_WHITE_BLACK_VEINS, "WHITE_BLACK_VEINS", {
                    name : "white and black veins",
                    appearanceDesc : "Many [skin color2] veins are clearly visible on your [skin base] body.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_VENOMOUS_MARKINGS, "VENOMOUS_MARKINGS", {
                    name : "venomous markings",
                    appearanceDesc : "Your skin is covered in intricate purple designs which pump venom alongside their paths.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_USHI_ONI_TATTOO, "USHI_ONI_TATTOO", {
                    name : "ushi-oni tattoo",
                    appearanceDesc : "You have strange ushi-oni tattoos on your belly, chest, breasts, shoulders and even face; some are like a black sheen plate, while others are just fur.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_SCAR_WINDSWEPT, "SCAR_WINDSWEPT", {
                    name : "windswept scars",
                    appearanceDesc : "Your body is covered with scars as if your skin was cut in various place by a windstorm.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_OIL, "OIL", {
                    name : "oily skin",
                    appearanceDesc : "Your body is dripping with oily black fluids.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_SEA_DRAGON_UNDERBODY, "SEA_DRAGON_UNDERBODY", {
                    name : "sea dragon underbody",
                    appearanceDesc : "An underbelly colored [skin base.color2] runs on the underside of your limbs bearing a glossy shine, on top of being lined up with bioluminescent dots like those of a deep sea fish.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_ARCH_IMP_RUNIC_TATTOO, "ARCH_IMP_RUNIC_TATTOO", {
                    name : "arch imp runic tattoo",
                    appearanceDesc : "Your body is covered with glowing runic tattoos.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_GLYPH_TATTOO, "GLYPH_TATTOO", {
                    name : "glyph tattoo",
                    appearanceDesc : "Your body is covered with glyph tattoos.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_BIOLUMINESCENCE, "PATTERN_BIOLUMINESCENCE", {
                    name : "bioluminescence tattoo",
                    appearanceDesc : "You have strange ushi-oni tattoos on your belly, chest, breasts, shoulders and even face; some are like a black sheen plate, while others are just fur.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_DEMONIC_PLEASURE_RUNE, "PATTERN_DEMONIC_PLEASURE_RUNE", {
                    name : "demonic pleasure rune",
                    appearanceDesc : "Your body is covered with various demonic pleasure runes.",
                    base : true
                });
        EnumValue.add(PatternTypes, PATTERN_BLOOD_MAGIC_TATTOO, "PATTERN_BLOOD_MAGIC_TATTOO", {
                    name : "blood magic tattoo",
                    appearanceDesc : "Your body is covered with blood magic tattoos.",
                    base : true
                });
        true;
    }

}


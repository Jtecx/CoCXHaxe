package classes;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.bodyParts.*;
import classes.internals.EnumValue;
import classes.internals.Utils;
import classes.internals.race.RaceUtils;
import classes.lists.BreastCup;
import classes.lists.Gender;

/**
 * This class is an aggregate of most important player body properties, packed into an array.
 */
class BodyData
{
    public var antennaeType(get, never) : Int;
    public var bodyColors(get, never) : String;
    public var bodyColor1(get, never) : String;
    public var armType(get, never) : Int;
    public var earType(get, never) : Int;
    public var eyeType(get, never) : Int;
    public var eyeColor(get, never) : String;
    public var faceType(get, never) : Int;
    public var furColors(get, never) : String;
    public var furColor1(get, never) : String;
    public var furColor2(get, never) : String;
    public var gillsType(get, never) : Int;
    public var hairType(get, never) : Int;
    public var hairColors(get, never) : String;
    public var hairColor1(get, never) : String;
    public var hairColor2(get, never) : String;
    public var hornType(get, never) : Int;
    public var hornCount(get, never) : Int;
    public var legType(get, never) : Int;
    public var rearType(get, never) : Int;
    public var scaleColors(get, never) : String;
    public var scaleColor1(get, never) : String;
    public var scaleColor2(get, never) : String;
    public var featherColors(get, never) : String;
    public var featherColor1(get, never) : String;
    public var featherColor2(get, never) : String;
    public var skinColors(get, never) : String;
    public var skinColor1(get, never) : String;
    public var skinColor2(get, never) : String;
    public var skinCoverage(get, never) : Int;
    public var skinType(get, never) : Int;
    public var skinBaseType(get, never) : Int;
    public var skinBaseColors(get, never) : String;
    public var skinBasePattern(get, never) : Int;
    public var skinBaseAdj(get, never) : String;
    public var skinCoatType(get, never) : Int;
    public var skinCoatColors(get, never) : String;
    public var skinCoatColor1(get, never) : String;
    public var skinCoatPattern(get, never) : Int;
    public var tailType(get, never) : Int;
    public var tailCount(get, never) : Int;
    public var tongueType(get, never) : Int;
    public var vaginaType(get, never) : Int;
    public var wingType(get, never) : Int;
    public var gender(get, never) : Int;
    public var height(get, never) : Int;
    public var femininity(get, never) : Int;
    public var tone(get, never) : Int;
    public var thickness(get, never) : Int;
    public var ballSize(get, never) : Int;
    public var ballCount(get, never) : Int;
    public var biggestCockSize(get, never) : Int;
    public var cockCount(get, never) : Int;
    public var biggestTitSize(get, never) : Int;
    public var isTaur(get, never) : Bool;
    public var isNaga(get, never) : Bool;
    public var isDrider(get, never) : Bool;
    public var looksMale(get, never) : Bool;
    public var looksFemale(get, never) : Bool;
    public var hasCoat(get, never) : Bool;
    public var hasVagina(get, never) : Bool;
    public var hasCock(get, never) : Bool;
    public var hasBalls(get, never) : Bool;

    /**
	 * Entry properties:
	 * - value: numerical id
	 * - id: name of the constant ("FACE_TYPE")
	 * - name: human-readable name ("face")
	 * - suffix: suffix appended to phrase about this type
	 *
	 * - nameFn (optional): `function(value:*):String` converting values stored in this slot to readable name (minus name of the entry itself)
	 * - phraseFn (optional): `function(operator:String value:*):String` to create text definition of a requirement phrase
	 *
	 * phraseFn semantics
	 * ==================
	 *
	 * Equality (x == value)
	 * - call: phraseFn("eq", value).
	 * - default: nameFn(value) + " " + slot.suffix
	 * - example (face): phraseFn("eq", Face.HUMAN), default is "human face"
	 *
	 * Inequality (x != value)
	 * - call: phraseFn("ne", value)
	 * - default: "not " + nameFn(value) + " " + slot.suffix
	 * - example (face): phraseFn("eq", Face.HUMAN), default is "not human face"
	 *
	 * Other comparison operators: > "gt", < "lt", >= "ge", <= "le"
	 * - call: phraseFn("gt"|"lt"|"ge"|"le", value)
	 * - default: "more than/less than/at least/at most" + nameFn(value) + " " + slot.suffix
	 * - example (tail count): phraseFn("ge", 2), default "at least 2 tail(s)"
	 *
	 * Inclusion: values.indexOf(x) >= 0
	 * - call: phraseFn("any", values)
	 * - default: (values converted with nameFn joined with ", " and " or ") + " " + slot.suffix
	 * - example: phraseFn("any", [Ears.WOLF, Ears.FOX, Ears.CAT]),
	 *            default would be "wolf, fox or cat ears"
	 *
	 * Inclusion: values.indexOf(x) >= 0
	 * - call: phraseFn("any", values)
	 * - default: "neither " + (values converted with nameFn joined with ", " and " nor ") + " " + slot.suffix
	 * - example: phraseFn("none", [Ears.WOLF, Ears.FOX, Ears.CAT]),
	 *            default would be "neither wolf, fox nor cat ears"
	 */
    public static var Slots : Array<Dynamic> = [];
    
    public static function defaultPhrase(operator : String, value : Dynamic, nameFn : Function, suffix : String) : String
    {
        if (nameFn == null)
        {
            nameFn = function(value : Dynamic) : String
                    {
                        return "" + value;
                    };
        }
        switch (operator)
        {
            case "eq":
                return nameFn(value) + suffix;
            case "ne":
                return "not " + nameFn(value) + suffix;
            case "ge", "le", "gt", "lt":
                return {
                    gt : "more than ",
                    lt : "less than ",
                    ge : "at least ",
                    le : "at most "
                }[operator] + nameFn(value) + suffix;
            case "any", "none":
                var any : Bool = operator == "any";
                return ((any) ? "" : "neither ") +
                Utils.mergeSentences(
                        (try cast(value, Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null).map(Utils.varargify(nameFn)), 
                        ((any) ? " or " : " nor "), 
                        ", ", 
                        false
            ) + suffix;
        }
        throw new Error("Invalid operator " + operator);
    }
    public static function defaultPhraseFn(suffix : String, nameFn : Function) : Function
    {
        return function(operator : String, value : Dynamic) : String
        {
            return defaultPhrase(operator, value, nameFn, suffix);
        };
    }
    public static function slotPhraseFn(slotid : Int, suffix : Bool = true) : Function
    {
        var decl : Dynamic = Slots[slotid];
        if (decl.phraseFn)
        {
            return decl.phraseFn;
        }
        var slotName : String = ((Lambda.has(decl, "suffix"))) ? decl.suffix : decl.name;
        var nameFn : Function = decl.nameFn || function(value : Dynamic) : String
        {
            return "" + value;
        };
        return function(operator : String, value : Dynamic) : String
        {
            return defaultPhrase(operator, value, nameFn, (suffix) ? Utils.trimRight(" " + slotName) : "");
        };
    }
    
    // Numbers are never saved, so can be changed between game versions without any problems.
    // As long as they are proper 0..N sequence
    // Don't forget to add a corresponding entry in update() function!
    
    private static var _slotid : Int = 0;
    // Basic body parts - sorted by name
    public static var SLOT_ANTENNAE_TYPE : Int = _slotid++;
    
    private function get_antennaeType() : Int
    {
        return data[SLOT_ANTENNAE_TYPE];
    }
    
    public static var SLOT_BODY_COLORS : Int = _slotid++;
    
    private function get_bodyColors() : String
    {
        return data[SLOT_BODY_COLORS];
    }
    
    public static var SLOT_BODY_COLOR1 : Int = _slotid++;
    
    private function get_bodyColor1() : String
    {
        return data[SLOT_BODY_COLOR1];
    }
    
    public static var SLOT_ARM_TYPE : Int = _slotid++;
    
    private function get_armType() : Int
    {
        return data[SLOT_ARM_TYPE];
    }
    
    public static var SLOT_CHITIN_COLORS : Int = _slotid++;
    
    
    public static var SLOT_CHITIN_COLOR1 : Int = _slotid++;
    
    
    public static var SLOT_EAR_TYPE : Int = _slotid++;
    
    private function get_earType() : Int
    {
        return data[SLOT_EAR_TYPE];
    }
    public static var SLOT_EYE_TYPE : Int = _slotid++;
    
    private function get_eyeType() : Int
    {
        return data[SLOT_EYE_TYPE];
    }
    public static var SLOT_EYE_COLOR : Int = _slotid++;
    
    private function get_eyeColor() : String
    {
        return data[SLOT_EYE_COLOR];
    }
    
    public static var SLOT_FACE_TYPE : Int = _slotid++;
    
    private function get_faceType() : Int
    {
        return data[SLOT_FACE_TYPE];
    }
    
    public static var SLOT_FUR_COLORS : Int = _slotid++;
    
    private function get_furColors() : String
    {
        return data[SLOT_FUR_COLORS];
    }
    
    public static var SLOT_FUR_COLOR1 : Int = _slotid++;
    
    public static var SLOT_FUR_COLOR2 : Int = _slotid++;
    
    private function get_furColor1() : String
    {
        return data[SLOT_FUR_COLOR1];
    }
    private function get_furColor2() : String
    {
        return data[SLOT_FUR_COLOR2];
    }
    
    public static var SLOT_GILLS_TYPE : Int = _slotid++;
    
    private function get_gillsType() : Int
    {
        return data[SLOT_GILLS_TYPE];
    }
    
    public static var SLOT_HAIR_TYPE : Int = _slotid++;
    
    private function get_hairType() : Int
    {
        return data[SLOT_HAIR_TYPE];
    }
    
    public static var SLOT_HAIR_COLORS : Int = _slotid++;
    
    private function get_hairColors() : String
    {
        return data[SLOT_HAIR_COLORS];
    }
    
    public static var SLOT_HAIR_COLOR1 : Int = _slotid++;
    
    public static var SLOT_HAIR_COLOR2 : Int = _slotid++;
    
    private function get_hairColor1() : String
    {
        return data[SLOT_HAIR_COLOR1];
    }
    private function get_hairColor2() : String
    {
        return data[SLOT_HAIR_COLOR2];
    }
    
    
    public static var SLOT_HORN_TYPE : Int = _slotid++;
    
    private function get_hornType() : Int
    {
        return data[SLOT_HORN_TYPE];
    }
    
    public static var SLOT_HORN_COUNT : Int = _slotid++;
    
    private function get_hornCount() : Int
    {
        return data[SLOT_HORN_COUNT];
    }
    
    public static var SLOT_LEG_TYPE : Int = _slotid++;
    
    private function get_legType() : Int
    {
        return data[SLOT_LEG_TYPE];
    }
    
    public static var SLOT_REAR_TYPE : Int = _slotid++;
    
    private function get_rearType() : Int
    {
        return data[SLOT_REAR_TYPE];
    }
    
    public static var SLOT_SCALE_COLORS : Int = _slotid++;
    
    private function get_scaleColors() : String
    {
        return data[SLOT_SCALE_COLORS];
    }
    
    public static var SLOT_SCALE_COLOR1 : Int = _slotid++;
    
    private function get_scaleColor1() : String
    {
        return data[SLOT_SCALE_COLOR1];
    }
    
    public static var SLOT_SCALE_COLOR2 : Int = _slotid++;
    
    private function get_scaleColor2() : String
    {
        return data[SLOT_SCALE_COLOR2];
    }
    
    public static var SLOT_FEATHER_COLORS : Int = _slotid++;
    
    private function get_featherColors() : String
    {
        return data[SLOT_FEATHER_COLORS];
    }
    
    public static var SLOT_FEATHER_COLOR1 : Int = _slotid++;
    
    private function get_featherColor1() : String
    {
        return data[SLOT_FEATHER_COLOR1];
    }
    
    public static var SLOT_FEATHER_COLOR2 : Int = _slotid++;
    
    private function get_featherColor2() : String
    {
        return data[SLOT_FEATHER_COLOR2];
    }
    
    public static var SLOT_SKIN_COLORS : Int = _slotid++;
    
    private function get_skinColors() : String
    {
        return data[SLOT_SKIN_COLORS];
    }
    
    public static var SLOT_SKIN_COLOR1 : Int = _slotid++;
    
    private function get_skinColor1() : String
    {
        return data[SLOT_SKIN_COLOR1];
    }
    
    public static var SLOT_SKIN_COLOR2 : Int = _slotid++;
    
    private function get_skinColor2() : String
    {
        return data[SLOT_SKIN_COLOR2];
    }
    
    public static var SLOT_SKIN_COVERAGE : Int = _slotid++;
    
    
    private function get_skinCoverage() : Int
    {
        return data[SLOT_SKIN_COVERAGE];
    }
    
    public static var SLOT_SKIN_TYPE : Int = _slotid++;
    
    private function get_skinType() : Int
    {
        return data[SLOT_SKIN_TYPE];
    }
    
    public static var SLOT_SKIN_BASE_TYPE : Int = _slotid++;
    
    private function get_skinBaseType() : Int
    {
        return data[SLOT_SKIN_BASE_TYPE];
    }
    
    public static var SLOT_SKIN_BASE_COLORS : Int = _slotid++;
    
    private function get_skinBaseColors() : String
    {
        return data[SLOT_SKIN_BASE_COLORS];
    }
    
    public static var SLOT_SKIN_BASE_PATTERN : Int = _slotid++;
    
    private function get_skinBasePattern() : Int
    {
        return data[SLOT_SKIN_BASE_PATTERN];
    }
    
    public static var SLOT_SKIN_BASE_ADJ : Int = _slotid++;
    
    private function get_skinBaseAdj() : String
    {
        return data[SLOT_SKIN_BASE_ADJ];
    }
    
    public static var SLOT_SKIN_COAT_TYPE : Int = _slotid++;
    
    private function get_skinCoatType() : Int
    {
        return data[SLOT_SKIN_COAT_TYPE];
    }
    
    public static var SLOT_SKIN_COAT_COLORS : Int = _slotid++;
    
    private function get_skinCoatColors() : String
    {
        return data[SLOT_SKIN_COAT_COLORS];
    }
    
    public static var SLOT_SKIN_COAT_COLOR1 : Int = _slotid++;
    
    private function get_skinCoatColor1() : String
    {
        return data[SLOT_SKIN_COAT_COLOR1];
    }
    
    public static var SLOT_SKIN_COAT_PATTERN : Int = _slotid++;
    
    private function get_skinCoatPattern() : Int
    {
        return data[SLOT_SKIN_COAT_PATTERN];
    }
    
    public static var SLOT_TAIL_TYPE : Int = _slotid++;
    
    private function get_tailType() : Int
    {
        return data[SLOT_TAIL_TYPE];
    }
    public static var SLOT_TAIL_COUNT : Int = _slotid++;
    
    private function get_tailCount() : Int
    {
        return data[SLOT_TAIL_COUNT];
    }
    
    public static var SLOT_TONGUE_TYPE : Int = _slotid++;
    
    private function get_tongueType() : Int
    {
        return data[SLOT_TONGUE_TYPE];
    }
    
    public static var SLOT_VAGINA_TYPE : Int = _slotid++;
    
    private function get_vaginaType() : Int
    {
        return data[SLOT_VAGINA_TYPE];
    }
    
    public static var SLOT_WING_TYPE : Int = _slotid++;
    
    private function get_wingType() : Int
    {
        return data[SLOT_WING_TYPE];
    }
    
    // Other stats
    public static var SLOT_GENDER : Int = _slotid++;
    
    private function get_gender() : Int
    {
        return data[SLOT_GENDER];
    }
    
    public static var SLOT_HEIGHT : Int = _slotid++;
    
    private function get_height() : Int
    {
        return data[SLOT_HEIGHT];
    }
    
    public static var SLOT_FEMININITY : Int = _slotid++;
    
    private function get_femininity() : Int
    {
        return data[SLOT_FEMININITY];
    }
    
    public static var SLOT_TONE : Int = _slotid++;
    
    private function get_tone() : Int
    {
        return data[SLOT_TONE];
    }
    
    public static var SLOT_THICKNESS : Int = _slotid++;
    
    private function get_thickness() : Int
    {
        return data[SLOT_THICKNESS];
    }
    
    public static var SLOT_BALL_SIZE : Int = _slotid++;
    
    private function get_ballSize() : Int
    {
        return data[SLOT_BALL_SIZE];
    }
    
    public static var SLOT_BALL_COUNT : Int = _slotid++;
    
    private function get_ballCount() : Int
    {
        return data[SLOT_BALL_COUNT];
    }
    
    public static var SLOT_BIGGEST_COCK_LENGTH : Int = _slotid++;
    
    private function get_biggestCockSize() : Int
    {
        return data[SLOT_BIGGEST_COCK_LENGTH];
    }
    
    public static var SLOT_COCK_COUNT : Int = _slotid++;
    
    private function get_cockCount() : Int
    {
        return data[SLOT_COCK_COUNT];
    }
    
    public static var SLOT_BIGGEST_TIT_SIZE : Int = _slotid++;
    
    private function get_biggestTitSize() : Int
    {
        return data[SLOT_BIGGEST_TIT_SIZE];
    }
    
    public var player : Player;
    public var data : Array<Dynamic> = [];
    
    private function get_isTaur() : Bool
    {
        return player.isTaur();
    }
    private function get_isNaga() : Bool
    {
        return player.isNaga();
    }
    private function get_isDrider() : Bool
    {
        return player.isDrider();
    }
    private function get_looksMale() : Bool
    {
        return player.looksMale();
    }
    private function get_looksFemale() : Bool
    {
        return player.looksFemale();
    }
    public function mf(male : String, female : String) : String
    {
        return (looksMale) ? male : female;
    }
    private function get_hasCoat() : Bool
    {
        return skinCoverage > Skin.COVERAGE_NONE;
    }
    private function get_hasVagina() : Bool
    {
        return gender == Gender.GENDER_FEMALE || gender == Gender.GENDER_HERM;
    }
    private function get_hasCock() : Bool
    {
        return gender == Gender.GENDER_MALE || gender == Gender.GENDER_HERM;
    }
    private function get_hasBalls() : Bool
    {
        return player.hasBalls();
    }
    
    public function new(player : Player, update : Bool = true)
    {
        this.player = player;
        if (update)
        {
            this.update();
        }
    }
    
    public function update() : Void
    {
        var player : Player = this.player;
        //noinspection JSMismatchedCollectionQueryUpdate
        var data : Array<Dynamic> = this.data;
        
        data[SLOT_ANTENNAE_TYPE] = player.antennae.type;
        data[SLOT_ARM_TYPE] = player.arms.type;
        data[SLOT_BODY_COLORS] = player.skin.color;
        data[SLOT_BODY_COLOR1] = player.skin.color1;
        data[SLOT_CHITIN_COLORS] = player.chitinColor;
        data[SLOT_CHITIN_COLOR1] = player.chitinColor1;
        data[SLOT_EAR_TYPE] = player.ears.type;
        data[SLOT_EYE_TYPE] = player.eyes.type;
        data[SLOT_EYE_COLOR] = player.eyes.colour;
        data[SLOT_FACE_TYPE] = player.facePart.type;
        data[SLOT_FUR_COLORS] = player.furColor;
        data[SLOT_FUR_COLOR1] = player.furColor1;
        data[SLOT_FUR_COLOR2] = player.furColor2;
        data[SLOT_GILLS_TYPE] = player.gills.type;
        data[SLOT_HAIR_TYPE] = player.hairType;
        data[SLOT_HAIR_COLORS] = player.hairColor;
        data[SLOT_HAIR_COLOR1] = player.hairColor1;
        data[SLOT_HAIR_COLOR2] = player.hairColor2;
        data[SLOT_HORN_TYPE] = player.horns.type;
        data[SLOT_HORN_COUNT] = player.horns.count;
        data[SLOT_LEG_TYPE] = player.lowerBodyPart.type;
        data[SLOT_REAR_TYPE] = player.rearBody.type;
        data[SLOT_SCALE_COLORS] = player.scaleColor;
        data[SLOT_SCALE_COLOR1] = player.scaleColor1;
        data[SLOT_SCALE_COLOR2] = player.scaleColor2;
        data[SLOT_FEATHER_COLORS] = player.featherColor;
        data[SLOT_FEATHER_COLOR1] = player.featherColor1;
        data[SLOT_FEATHER_COLOR2] = player.featherColor2;
        data[SLOT_SKIN_COLORS] = player.skinColor;
        data[SLOT_SKIN_COLOR1] = player.skinColor1;
        data[SLOT_SKIN_COVERAGE] = player.skin.coverage;
        data[SLOT_SKIN_TYPE] = player.skin.type;
        data[SLOT_SKIN_BASE_TYPE] = player.skin.base.type;
        data[SLOT_SKIN_BASE_COLORS] = player.skin.base.color;
        data[SLOT_SKIN_BASE_PATTERN] = player.skin.base.pattern;
        data[SLOT_SKIN_BASE_ADJ] = player.skin.base.adj;
        if (player.skin.coverage > Skin.COVERAGE_NONE)
        {
            data[SLOT_SKIN_COAT_TYPE] = player.skin.coat.type;
            data[SLOT_SKIN_COAT_COLORS] = player.skin.coat.color;
            data[SLOT_SKIN_COAT_COLOR1] = player.skin.coat.color1;
            data[SLOT_SKIN_COAT_PATTERN] = player.skin.coat.pattern;
        }
        else
        {
            data[SLOT_SKIN_COAT_TYPE] = -1;
            data[SLOT_SKIN_COAT_COLORS] = "no";
            data[SLOT_SKIN_COAT_COLOR1] = "no";
            data[SLOT_SKIN_COAT_PATTERN] = Skin.PATTERN_NONE;
        }
        data[SLOT_TAIL_TYPE] = player.tail.type;
        data[SLOT_TAIL_COUNT] = player.tail.count;
        data[SLOT_TONGUE_TYPE] = player.tongue.type;
        data[SLOT_VAGINA_TYPE] = player.vaginaType();
        data[SLOT_WING_TYPE] = player.wings.type;
        
        data[SLOT_GENDER] = player.gender;
        data[SLOT_HEIGHT] = player.tallness;
        data[SLOT_FEMININITY] = player.femininity;
        data[SLOT_TONE] = player.tone;
        data[SLOT_THICKNESS] = player.thickness;
        data[SLOT_BALL_SIZE] = (player.balls) ? player.ballSize : 0;
        data[SLOT_BIGGEST_COCK_LENGTH] = player.biggestCockLength();
        data[SLOT_BIGGEST_TIT_SIZE] = player.biggestTitSize();
        data[SLOT_COCK_COUNT] = player.cocks.length;
        data[SLOT_BALL_COUNT] = player.balls;
    }
    
    public function equals(other : BodyData) : Bool
    {
        for (i in 0...data.length)
        {
            if (data[i] != other.data[i])
            {
                return false;
            }
        }
        return true;
    }
    
    public function clone() : BodyData
    {
        var bd : BodyData = new BodyData(player, false);
        bd.data = this.data.slice();
        return bd;
    }
    private static var BodyData_static_initializer = {
        EnumValue.add(Slots, SLOT_ANTENNAE_TYPE, "ANTENNAE_TYPE", {
                    name : "antennae",
                    nameFn : function(value : Int) : String
                    {
                        if (value == Antennae.NONE)
                        {
                            return "no";
                        }
                        return Antennae.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_BODY_COLORS, "BODY_COLORS", {
                    name : "body color",
                    suffix : "skin"
                });
        EnumValue.add(Slots, SLOT_BODY_COLOR1, "BODY_COLOR1", {
                    name : "body primary color",
                    suffix : "skin"
                });
        EnumValue.add(Slots, SLOT_ARM_TYPE, "ARM_TYPE", {
                    name : "arms",
                    nameFn : function(value : Int) : String
                    {
                        return Arms.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_CHITIN_COLORS, "CHITIN_COLOR", {
                    name : "chitin color",
                    suffix : "chitin"
                });
        EnumValue.add(Slots, SLOT_CHITIN_COLOR1, "CHITIN_COLOR1", {
                    name : "chitin primary color",
                    suffix : "chitin"
                });
        EnumValue.add(Slots, SLOT_EAR_TYPE, "EAR_TYPE", {
                    name : "ears",
                    nameFn : function(value : Int) : String
                    {
                        return Ears.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_EYE_TYPE, "EYE_TYPE", {
                    name : "eyes",
                    nameFn : function(value : Int) : String
                    {
                        return Eyes.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_EYE_COLOR, "EYE_COLOR", {
                    name : "eye color",
                    suffix : "eyes"
                });
        EnumValue.add(Slots, SLOT_FACE_TYPE, "FACE_TYPE", {
                    name : "face",
                    nameFn : function(value : Int) : String
                    {
                        return Face.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_FUR_COLORS, "FUR_COLOR", {
                    name : "fur color",
                    suffix : "fur"
                });
        EnumValue.add(Slots, SLOT_FUR_COLOR1, "FUR_COLOR1", {
                    name : "fur primary color",
                    suffix : "fur"
                });
        EnumValue.add(Slots, SLOT_FUR_COLOR2, "FUR_COLOR2", {
                    name : "fur secondary color",
                    suffix : "fur"
                });
        EnumValue.add(Slots, SLOT_GILLS_TYPE, "GILL_TYPE", {
                    name : "gills",
                    nameFn : function(value : Int) : String
                    {
                        if (value == Gills.NONE)
                        {
                            return "no";
                        }
                        return Gills.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_HAIR_TYPE, "HAIR_TYPE", {
                    name : "hair",
                    nameFn : function(value : Int) : String
                    {
                        return Hair.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_HAIR_COLORS, "HAIR_COLOR", {
                    name : "hair color",
                    suffix : "hair"
                });
        EnumValue.add(Slots, SLOT_HAIR_COLOR1, "HAIR_COLOR1", {
                    name : "hair primary color",
                    suffix : "hair"
                });
        EnumValue.add(Slots, SLOT_HAIR_COLOR2, "HAIR_COLOR2", {
                    name : "hair secondary color",
                    suffix : "hair"
                });
        EnumValue.add(Slots, SLOT_HORN_TYPE, "HORN_TYPE", {
                    name : "horns",
                    nameFn : function(value : Int) : String
                    {
                        if (value == Horns.NONE)
                        {
                            return "no ";
                        }
                        return Horns.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_HORN_COUNT, "HORN_COUNT", {
                    name : "horn count/size",
                    suffix : "horns",
                    nameFn : function(value : Int) : String
                    {
                        if (value == 0)
                        {
                            return "no";
                        }
                        return "" + value;
                    }
                });
        EnumValue.add(Slots, SLOT_LEG_TYPE, "LEG_TYPE", {
                    name : "legs",
                    nameFn : function(value : Int) : String
                    {
                        return LowerBody.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_REAR_TYPE, "REAR_TYPE", {
                    name : "rear",
                    suffix : "",
                    nameFn : function(value : Int) : String
                    {
                        if (value == RearBody.NONE)
                        {
                            return "ordinary rear";
                        }
                        return RearBody.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_SCALE_COLORS, "SCALE_COLOR", {
                    name : "scale color",
                    suffix : "scales"
                });
        EnumValue.add(Slots, SLOT_SCALE_COLOR1, "SCALE_COLOR1", {
                    name : "scale primary color",
                    suffix : "scales"
                });
        EnumValue.add(Slots, SLOT_SCALE_COLOR2, "SCALE_COLOR2", {
                    name : "scale secondary color",
                    suffix : "scales"
                });
        EnumValue.add(Slots, SLOT_FEATHER_COLORS, "FEATHER_COLOR", {
                    name : "feather color",
                    suffix : "feathers"
                });
        EnumValue.add(Slots, SLOT_FEATHER_COLOR1, "FEATHER_COLOR1", {
                    name : "feather primary color",
                    suffix : "feathers"
                });
        EnumValue.add(Slots, SLOT_FEATHER_COLOR2, "FEATHER_COLOR2", {
                    name : "feather secondary color",
                    suffix : "feathers"
                });
        EnumValue.add(Slots, SLOT_SKIN_COLORS, "SKIN_COLOR", {
                    name : "skin color",
                    suffix : "skin"
                });
        EnumValue.add(Slots, SLOT_SKIN_COLOR1, "SKIN_COLOR1", {
                    name : "skin primary color",
                    suffix : "skin"
                });
        EnumValue.add(Slots, SLOT_SKIN_COLOR2, "SKIN_COLOR2", {
                    name : "skin secondary color",
                    suffix : "skin"
                });
        EnumValue.add(Slots, SLOT_SKIN_COVERAGE, "SKIN_COVERATE", {
                    name : "skin coverage",
                    suffix : "covered skin",
                    nameFn : function(value : Int) : String
                    {
                        return [
                        "not", 
                        "partially", 
                        "medium", 
                        "mostly", 
                        "fully"
            ][value];
                    },
                    phraseFn : function(operator : String, value : Dynamic) : String
                    {
                        if (operator == "eq" && value == Skin.COVERAGE_NONE)
                        {
                            return "no coat";
                        }
                        return defaultPhrase(operator, value, this.nameFn, "covered skin");
                    }
                });
        EnumValue.add(Slots, SLOT_SKIN_TYPE, "SKIN_TYPE", {
                    name : "skin",
                    nameFn : function(value : Int) : String
                    {
                        if (value == Skin.PLAIN)
                        {
                            return "plain";
                        }
                        return Skin.SkinTypes[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_SKIN_BASE_TYPE, "SKIN_BASE_TYPE", {
                    name : "skin",
                    nameFn : function(value : Int) : String
                    {
                        if (value == Skin.PLAIN)
                        {
                            return "plain";
                        }
                        return ((Skin.SkinTypes[value].adj != null)) ? Skin.SkinTypes[value].adj : Skin.SkinTypes[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_SKIN_BASE_COLORS, "SKIN_BASE_COLOR", {
                    name : "skin color",
                    suffix : "skin"
                });
        EnumValue.add(Slots, SLOT_SKIN_BASE_PATTERN, "SKIN_BASE_PATTERN", {
                    name : "skin pattern",
                    suffix : "pattern",
                    nameFn : function(value : Int) : String
                    {
                        if (value == Skin.PATTERN_NONE)
                        {
                            return "no";
                        }
                        return Skin.PatternTypes[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_SKIN_BASE_ADJ, "SKIN_BASE_ADJ", {
                    name : "skin"
                });
        EnumValue.add(Slots, SLOT_SKIN_COAT_TYPE, "SKIN_COAT_TYPE", {
                    name : "coat",
                    suffix : "",
                    nameFn : function(value : Int) : String
                    {
                        return Skin.SkinTypes[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_SKIN_COAT_COLORS, "SKIN_COAT_COLOR", {
                    name : "coat color",
                    suffix : "coat"
                });
        EnumValue.add(Slots, SLOT_SKIN_COAT_COLOR1, "SKIN_COAT_COLOR1", {
                    name : "coat primary color",
                    suffix : "coat"
                });
        EnumValue.add(Slots, SLOT_SKIN_COAT_PATTERN, "SKIN_COAT_PATTERN", {
                    name : "coat pattern",
                    suffix : "pattern",
                    nameFn : function(value : Int) : String
                    {
                        if (value == Skin.PATTERN_NONE)
                        {
                            return "no";
                        }
                        return Skin.PatternTypes[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_TAIL_TYPE, "TAIL_TYPE", {
                    name : "tail",
                    nameFn : function(value : Int) : String
                    {
                        if (value == Tail.NONE)
                        {
                            return "no";
                        }
                        if (value == Tail.NEKOMATA_FORKED_1_3)
                        {
                            return "forked at 1/3 cat";
                        }
                        if (value == Tail.NEKOMATA_FORKED_2_3)
                        {
                            return "forked at 2/3 cat";
                        }
                        return Tail.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_TAIL_COUNT, "TAIL_COUNT", {
                    name : "tail count",
                    suffix : "tail(s)",
                    nameFn : function(value : Int) : String
                    {
                        if (value == 0)
                        {
                            return "no";
                        }
                        return Utils.num2Text(value);
                    }  /*,
		phraseFn: function (operator:String, value:*):String {
			if (value is Number) {
				if (value == 0 || value == 1) return defaultPhrase(operator, value, Slots[SLOT_TAIL_COUNT].nameFn, " tail");
			}
			return defaultPhrase(operator, value, Slots[SLOT_TAIL_COUNT].nameFn, " tails");
		}*/  
                });
        EnumValue.add(Slots, SLOT_TONGUE_TYPE, "TONGUE_TYPE", {
                    name : "tongue",
                    nameFn : function(value : Int) : String
                    {
                        return Tongue.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_VAGINA_TYPE, "VAGINA_TYPE", {
                    name : "vagina",
                    nameFn : function(value : Int) : String
                    {
                        return VaginaClass.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_WING_TYPE, "WING_TYPE", {
                    name : "wings",
                    nameFn : function(value : Int) : String
                    {
                        if (value == Wings.NONE)
                        {
                            return "no";
                        }
                        return Wings.Types[value].name;
                    }
                });
        EnumValue.add(Slots, SLOT_GENDER, "GENDER", {
                    name : "gender",
                    suffix : "",
                    nameFn : function(value : Int) : String
                    {
                        switch (value)
                        {
                            case Gender.GENDER_NONE:return "genderless";
                            case Gender.GENDER_MALE:return "male";
                            case Gender.GENDER_FEMALE:return "female";
                            case Gender.GENDER_HERM:return "hermaphrodite";
                        }
                        return "" + value;
                    }
                });
        EnumValue.add(Slots, SLOT_HEIGHT, "HEIGHT", {
                    name : "height",
                    nameFn : function(value : Float) : String
                    {
                        return Measurements.footInchOrMetres(value);
                    },
                    phraseFn : function(operator : String, value : Dynamic) : String
                    {
                        switch (operator)
                        {
                            case "ge":
                                return Measurements.footInchOrMetres(value) + " tall or more";
                            case "gt":
                                return "taller than " + Measurements.footInchOrMetres(value);
                            case "le":
                                return Measurements.footInchOrMetres(value) + " tall or less";
                            case "lt":
                                return "shorter than " + Measurements.footInchOrMetres(value);
                        }
                        return defaultPhrase(operator, value, Measurements.footInchOrMetres, "height");
                    }
                });
        EnumValue.add(Slots, SLOT_FEMININITY, "FEMININITY", {
                    name : "femininity",
                    nameFn : function(value : Float) : String
                    {
                        if (value == 100)
                        {
                            return "" + value + " (maximum feminine)";
                        }
                        if (value > 55)
                        {
                            return "" + value + " (feminine)";
                        }
                        if (value > 45)
                        {
                            return "" + value + " (androgynous)";
                        }
                        if (value == 0)
                        {
                            return "" + value + " (maximum masculine)";
                        }
                        return "" + value + " (masculine)";
                    },
                    phraseFn : function(operator : String, value : Dynamic) : String
                    {
                        return "femininity " + defaultPhrase(operator, value, Slots[SLOT_FEMININITY].nameFn, "");
                    }
                });
        EnumValue.add(Slots, SLOT_TONE, "TONE", {
                    name : "muscle tone",
                    nameFn : function(value : Float) : String
                    {
                        if (value > 75)
                        {
                            return "" + value + " (muscular)";
                        }
                        if (value > 25)
                        {
                            return "" + value + " (average)";
                        }
                        return "" + value + " (soft)";
                    }
                });
        EnumValue.add(Slots, SLOT_THICKNESS, "THICKESS", {
                    name : "thickness",
                    nameFn : function(value : Float) : String
                    {
                        if (value > 75)
                        {
                            return "" + value + " (thick)";
                        }
                        if (value > 25)
                        {
                            return "" + value + " (average)";
                        }
                        return "" + value + " (thin)";
                    }
                });
        EnumValue.add(Slots, SLOT_BALL_SIZE, "BALL_SIZE", {
                    name : "balls size",
                    nameFn : function(value : Float) : String
                    {
                        return Measurements.inchesOrCentimetres(value);
                    }
                });
        EnumValue.add(Slots, SLOT_BALL_COUNT, "BALL_COUNT", {
                    name : "balls count",
                    nameFn : function(value : Float) : String
                    {
                        return "" + value;
                    }
                });
        EnumValue.add(Slots, SLOT_BIGGEST_COCK_LENGTH, "BIGGEST_COCK_LENGTH", {
                    name : "cock length",
                    suffix : "long cock",
                    nameFn : function(value : Float) : String
                    {
                        return Measurements.inchesOrCentimetres(value);
                    }
                });
        EnumValue.add(Slots, SLOT_COCK_COUNT, "COCK_COUNT", {
                    name : "cock count",
                    suffix : "cocks",
                    nameFn : function(value : Float) : String
                    {
                        return "" + value;
                    }
                });
        EnumValue.add(Slots, SLOT_BIGGEST_TIT_SIZE, "BIGGEST_TIT_SIZE", {
                    name : "breast size",
                    suffix : "breasts",
                    nameFn : function(value : Int) : String
                    {
                        return Appearance.breastCup(value);
                    },
                    phraseFn : function(operator : String, value : Dynamic) : String
                    {
                        switch (operator)
                        {
                            case "gt":
                                return "bigger than " + Appearance.breastCup(value) + " breasts";
                            case "gte":
                                return "at least " + Appearance.breastCup(value) + " breasts";
                            case "lt":
                                return "smaller than " + Appearance.breastCup(value) + " breasts";
                            case "lte":
                                return "no bigger than " + Appearance.breastCup(value) + " breasts";
                        }
                        return defaultPhrase(operator, value, Appearance.breastCup, "breasts");
                    }
                });
        true;
    }

}


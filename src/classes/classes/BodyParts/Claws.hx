/**
 * Created by aimozg on 27.04.2017.
 */
package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;

class Claws extends SaveableBodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NORMAL", "LIZARD")
	 * - name: human-readable default name, ("normal", "lizard")
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var NORMAL : Int = 0;
    
    public static inline var LIZARD : Int = 1;
    
    public static inline var DRAGON : Int = 2;
    
    public static inline var SALAMANDER : Int = 3;
    
    public static inline var CAT : Int = 4;  // NYI! Placeholder for now!!  
    
    public static inline var DOG : Int = 5;  // NYI! Placeholder for now!!  
    
    public static inline var RAPTOR : Int = 6;  // NYI! Placeholder for now!!  
    
    public static inline var MANTIS : Int = 7;  // NYI! Placeholder for Xianxia mod  
    
    public static inline var IMP : Int = 8;  // NYI! Placeholder from Revamp  
    
    public static inline var COCKATRICE : Int = 9;  // NYI! Placeholder from Revamp  
    
    public static inline var RED_PANDA : Int = 10;  // NYI! Placeholder from Revamp  
    
    
    public var tone : String = "";
    
    public function new(creature : Creature)
    {
        super(creature, "clawsPart", ["tone"]);
    }
    
    override public function restore(keepColor : Bool = true) : Void
    {
        super.restore(keepColor);
        tone = "";
    }
    
    override public function descriptionFull() : String
    {
        var toneText : String = (tone == "") ? " " : (", " + tone + " ");
        switch (type)
        {
            case NORMAL:return "fingernails";
            case LIZARD:return "short curved" + toneText + "claws";
            case DRAGON:return "powerful, thick curved" + toneText + "claws";
        }
        return "fingernails";
    }
    
    public function descriptionFinger() : String
    {
        var toneText : String = (tone == "") ? " " : (", " + tone + " ");
        switch (type)
        {
            case NORMAL:return "fingernail";
            case LIZARD:return "short curved" + toneText + "claw";
            case DRAGON:return "powerful, thick curved" + toneText + "claw";
        }
        return "fingernail";
    }
    
    override private function loadFromOldSave(savedata : Dynamic) : Void
    {
        type = intOr(savedata.clawType, NORMAL);
        tone = stringOr(savedata.clawTone, "");
    }
    override private function saveToOldSave(savedata : Dynamic) : Void
    {
        savedata.clawType = type;
        savedata.clawTone = tone;
    }
    private static var Claws_static_initializer = {
        EnumValue.add(Types, NORMAL, "NORMAL", {
                    name : "normal"
                });
        EnumValue.add(Types, LIZARD, "LIZARD", {
                    name : "lizard"
                });
        EnumValue.add(Types, DRAGON, "DRAGON", {
                    name : "dragon"
                });
        EnumValue.add(Types, SALAMANDER, "SALAMANDER", {
                    name : "salamander"
                });
        EnumValue.add(Types, CAT, "CAT", {
                    name : "cat"
                });
        EnumValue.add(Types, DOG, "DOG", {
                    name : "dog"
                });
        EnumValue.add(Types, RAPTOR, "RAPTOR", {
                    name : "raptor"
                });
        EnumValue.add(Types, MANTIS, "MANTIS", {
                    name : "mantis"
                });
        EnumValue.add(Types, IMP, "IMP", {
                    name : "imp"
                });
        EnumValue.add(Types, COCKATRICE, "COCKATRICE", {
                    name : "cockatrice"
                });
        EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
                    name : "red panda"
                });
        true;
    }

}


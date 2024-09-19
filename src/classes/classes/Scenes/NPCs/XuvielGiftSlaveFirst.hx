/**
 * ...
 * @author Liadri
 */
package classes.scenes.nPCs;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.StatusEffects;
import classes.internals.SaveableState;

class XuvielGiftSlaveFirst extends NPCAwareContent implements SaveableState
{
    public static var SlaveGender : Float;
    public static var HairColor : String;
    public static var SkinColor : String;
    public static var EyesColor : String;
    public static var SlaveName : String;
    public static var Defiance : Float;
    public static var SlavePersonality : Float;
    public static var CockDesc : String;
    public static var BallsDesc : String;
    public static var PussyDesc : String;
    public static var CupSize : String;
    public static var IsHumanStill : Bool;
    public static var HalfRaceDesc : String;
    public static var HornsType : Float;
    public static var FaceType : Float;
    public static var LowerBodyType : Float;
    public static var TailType : Float;
    public static var WingsType : Float;
    
    public function stateObjectName() : String
    {
        return "XuvielGiftSlaveFirst";
    }
    
    public function resetState() : Void
    {
        SlaveGender = 0;
        HairColor = "";
        SkinColor = "";
        EyesColor = "";
        SlaveName = "";
        Defiance = 0;
        SlavePersonality = 0;
        CockDesc = "";
        BallsDesc = "";
        PussyDesc = "";
        CupSize = "";
        IsHumanStill = false;
        HalfRaceDesc = "";
        HornsType = 0;
        FaceType = 0;
        LowerBodyType = 0;
        TailType = 0;
        WingsType = 0;
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            SlaveGender : SlaveGender,
            HairColor : HairColor,
            SkinColor : SkinColor,
            EyesColor : EyesColor,
            SlaveName : SlaveName,
            Defiance : Defiance,
            SlavePersonality : SlavePersonality,
            CockDesc : CockDesc,
            BallsDesc : BallsDesc,
            PussyDesc : PussyDesc,
            CupSize : CupSize,
            IsHumanStill : IsHumanStill,
            HalfRaceDesc : HalfRaceDesc,
            HornsType : HornsType,
            FaceType : FaceType,
            LowerBodyType : LowerBodyType,
            TailType : TailType,
            WingsType : WingsType
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            SlaveGender = Reflect.field(o, "SlaveGender");
            HairColor = Reflect.field(o, "HairColor");
            SkinColor = Reflect.field(o, "SkinColor");
            EyesColor = Reflect.field(o, "EyesColor");
            SlaveName = Reflect.field(o, "SlaveName");
            Defiance = Reflect.field(o, "Defiance");
            SlavePersonality = Reflect.field(o, "SlavePersonality");
            CockDesc = Reflect.field(o, "CockDesc");
            BallsDesc = Reflect.field(o, "BallsDesc");
            PussyDesc = Reflect.field(o, "PussyDesc");
            CupSize = Reflect.field(o, "CupSize");
            IsHumanStill = Reflect.field(o, "IsHumanStill");
            HalfRaceDesc = Reflect.field(o, "HalfRaceDesc");
            HornsType = Reflect.field(o, "HornsType");
            FaceType = Reflect.field(o, "FaceType");
            LowerBodyType = Reflect.field(o, "LowerBodyType");
            TailType = Reflect.field(o, "TailType");
            WingsType = Reflect.field(o, "WingsType");
        }
        // loading from old save
        else
        {
            
            resetState();
        }
    }
    
    public function new()
    {
        super();
        Saves.registerSaveableState(this);
    }
}


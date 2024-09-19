package classes.scenes.camp;

import classes.BaseContent;
import classes.Saves;
import classes.internals.SaveableState;

class CampStatsAndResources extends BaseContent implements SaveableState
{
    //cabin stored resources
    public static var MetalPieces : Float;
    public static var MechanismResc : Float;
    public static var EnergyCoreResc : Float;
    public static var PlasmaCoreResc : Float;
    public static var ElementalEnergyResc : Float;
    public static var StonesResc : Float;
    public static var WoodResc : Float;
    public static var NailsResc : Float;
    public static var WaterResc : Float;
    public static var SandResc : Float;
    public static var CementResc : Float;
    
    public function new()
    {
        super();
        Saves.registerSaveableState(this);
    }
    
    public function stateObjectName() : String
    {
        return "CampStatsAndResources";
    }
    
    public function resetState() : Void
    {
        MetalPieces = 0;
        MechanismResc = 0;
        EnergyCoreResc = 0;
        PlasmaCoreResc = 0;
        ElementalEnergyResc = 0;
        StonesResc = 0;
        WoodResc = 0;
        NailsResc = 0;
        WaterResc = 0;
        SandResc = 0;
        CementResc = 0;
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            MetalPieces : MetalPieces,
            MechanismResc : MechanismResc,
            EnergyCoreResc : EnergyCoreResc,
            PlasmaCoreResc : PlasmaCoreResc,
            ElementalEnergyResc : ElementalEnergyResc,
            StonesResc : StonesResc,
            WoodResc : WoodResc,
            NailsResc : NailsResc,
            WaterResc : WaterResc,
            SandResc : SandResc,
            CementResc : CementResc
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            MetalPieces = Reflect.field(o, "MetalPieces");
            MechanismResc = Reflect.field(o, "MechanismResc");
            EnergyCoreResc = Reflect.field(o, "EnergyCoreResc");
            PlasmaCoreResc = Reflect.field(o, "PlasmaCoreResc");
            ElementalEnergyResc = Reflect.field(o, "ElementalEnergyResc");
            StonesResc = Reflect.field(o, "StonesResc");
            WoodResc = Reflect.field(o, "WoodResc");
            NailsResc = Reflect.field(o, "NailsResc");
            WaterResc = Reflect.field(o, "WaterResc");
            SandResc = Reflect.field(o, "SandResc");
            CementResc = Reflect.field(o, "CementResc");
        }
        else
        {
            resetState();
        }
    }
}


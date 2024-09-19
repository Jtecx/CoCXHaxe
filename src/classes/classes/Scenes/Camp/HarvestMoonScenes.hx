package classes.scenes.camp;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.CoC;
import classes.scenes.nPCs.*;
import classes.scenes.SceneLib;
import classes.internals.SaveableState;

class HarvestMoonScenes extends BaseContent implements SaveableState
{
    
    //This should be managed like a quest checking weekly for crops
    public static var harvestmoonstageHH : Int;
    public static inline var HARVESTMOONNOTSTARTEDHH : Int = 0;
    public static inline var HARVESTMOONPENDINGHH : Int = 1;
    public static inline var HARVESTMOONPENDINGHH2 : Int = 2;
    public static inline var HARVESTMOONPENDINGHH3 : Int = 3;
    public static inline var HARVESTMOONPENDINGHH4 : Int = 4;
    public static inline var HARVESTMOONPENDINGHH5 : Int = 5;
    public static inline var HARVESTMOONPENDINGHH6 : Int = 6;
    public static inline var HARVESTMOONREADYHH : Int = 7;
    
    public static var harvestmoonstageMG : Int;
    public static inline var HARVESTMOONNOTSTARTEDMG : Int = 0;
    public static inline var HARVESTMOONPENDINGMG : Int = 1;
    public static inline var HARVESTMOONPENDINGMG2 : Int = 2;
    public static inline var HARVESTMOONPENDINGMG3 : Int = 3;
    public static inline var HARVESTMOONPENDINGMG4 : Int = 4;
    public static inline var HARVESTMOONPENDINGMG5 : Int = 5;
    public static inline var HARVESTMOONPENDINGMG6 : Int = 6;
    public static inline var HARVESTMOONREADYMG : Int = 7;
    
    public static var harvestmoonstageSB : Int;
    public static inline var HARVESTMOONNOTSTARTEDSB : Int = 0;
    public static inline var HARVESTMOONPENDINGSB : Int = 1;
    public static inline var HARVESTMOONPENDINGSB2 : Int = 2;
    public static inline var HARVESTMOONPENDINGSB3 : Int = 3;
    public static inline var HARVESTMOONPENDINGSB4 : Int = 4;
    public static inline var HARVESTMOONPENDINGSB5 : Int = 5;
    public static inline var HARVESTMOONPENDINGSB6 : Int = 6;
    public static inline var HARVESTMOONREADYSB : Int = 7;
    
    public static var harvestmoonstageIW : Int;
    public static inline var HARVESTMOONNOTSTARTEDIW : Int = 0;
    public static inline var HARVESTMOONPENDINGIW : Int = 1;
    public static inline var HARVESTMOONPENDINGIW2 : Int = 2;
    public static inline var HARVESTMOONPENDINGIW3 : Int = 3;
    public static inline var HARVESTMOONPENDINGIW4 : Int = 4;
    public static inline var HARVESTMOONPENDINGIW5 : Int = 5;
    public static inline var HARVESTMOONPENDINGIW6 : Int = 6;
    public static inline var HARVESTMOONREADYIW : Int = 7;
    
    public static var harvestmoonstageBF : Int;
    public static inline var HARVESTMOONNOTSTARTEDBF : Int = 0;
    public static inline var HARVESTMOONPENDINGBF : Int = 1;
    public static inline var HARVESTMOONPENDINGBF2 : Int = 2;
    public static inline var HARVESTMOONPENDINGBF3 : Int = 3;
    public static inline var HARVESTMOONPENDINGBF4 : Int = 4;
    public static inline var HARVESTMOONPENDINGBF5 : Int = 5;
    public static inline var HARVESTMOONPENDINGBF6 : Int = 6;
    public static inline var HARVESTMOONREADYBF : Int = 7;
    
    public function stateObjectName() : String
    {
        return "CampScenes";
    }
    
    public function resetState() : Void
    {
        harvestmoonstageHH = HARVESTMOONNOTSTARTEDHH;
        harvestmoonstageMG = HARVESTMOONNOTSTARTEDMG;
        harvestmoonstageSB = HARVESTMOONNOTSTARTEDSB;
        harvestmoonstageIW = HARVESTMOONNOTSTARTEDIW;
        harvestmoonstageBF = HARVESTMOONNOTSTARTEDBF;
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            stageHH : harvestmoonstageHH,
            stageMG : harvestmoonstageMG,
            stageSB : harvestmoonstageSB,
            stageIW : harvestmoonstageIW,
            stageBF : harvestmoonstageBF
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            harvestmoonstageHH = Reflect.field(o, "stageHH");
            harvestmoonstageMG = Reflect.field(o, "stageMG");
            harvestmoonstageSB = Reflect.field(o, "stageSB");
            harvestmoonstageIW = Reflect.field(o, "stageIW");
            harvestmoonstageBF = Reflect.field(o, "stageBF");
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


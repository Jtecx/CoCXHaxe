/**
 * ...
 * @author Ormael & Liadri
 */
package classes.scenes.camp;

import classes.*;
import classes.BaseContent;
import classes.internals.SaveableState;
import classes.items.consumables.SimpleConsumable;
import classes.scenes.SceneLib;

class Garden extends BaseContent implements SaveableState
{
    public static var GardenSlot01 : String;
    public static var GardenSlot01Time : Float;
    public static var GardenSlot02 : String;
    public static var GardenSlot02Time : Float;
    public static var GardenSlot03 : String;
    public static var GardenSlot03Time : Float;
    public static var GardenSlot04 : String;
    public static var GardenSlot04Time : Float;
    public static var GardenSlot05 : String;
    public static var GardenSlot05Time : Float;
    public static var GardenSlot06 : String;
    public static var GardenSlot06Time : Float;
    public static var GardenSlot07 : String;
    public static var GardenSlot07Time : Float;
    public static var GardenSlot08 : String;
    public static var GardenSlot08Time : Float;
    public static var GardenSlot09 : String;
    public static var GardenSlot09Time : Float;
    public static var GardenSlot10 : String;
    public static var GardenSlot10Time : Float;
    public static var GardenSlot11 : String;
    public static var GardenSlot11Time : Float;
    public static var GardenSlot12 : String;
    public static var GardenSlot12Time : Float;
    public static var IngrediantBagSlot01 : Float;
    public static var IngrediantBagSlot01Cap : Float;  //healing herb  
    public static var IngrediantBagSlot02 : Float;
    public static var IngrediantBagSlot02Cap : Float;  //moon grass  
    public static var IngrediantBagSlot03 : Float;
    public static var IngrediantBagSlot03Cap : Float;  //snakebane flower  
    public static var IngrediantBagSlot04 : Float;
    public static var IngrediantBagSlot04Cap : Float;  //ironweed  
    public static var IngrediantBagSlot05 : Float;
    public static var IngrediantBagSlot05Cap : Float;  //blade ferns  
    public static var IngrediantBagSlot06 : Float;
    public static var IngrediantBagSlot06Cap : Float;  //alraune nectar  
    public static var IngrediantBagSlot07 : Float;
    public static var IngrediantBagSlot07Cap : Float;  //ginseng  
    public static var IngrediantBagSlot08 : Float;
    public static var IngrediantBagSlot08Cap : Float;  //	???  
    public static var IngrediantBagSlot09 : Float;
    public static var IngrediantBagSlot09Cap : Float;  //	???  
    public static var IngrediantBagSlot10 : Float;
    public static var IngrediantBagSlot10Cap : Float;  //	???  
    public static var PotionsBagSlot01 : Float;
    public static var PotionsBagSlot01Cap : Float;
    public static var PotionsBagSlot01Potion : String;
    public static var PotionsBagSlot02 : Float;
    public static var PotionsBagSlot02Cap : Float;
    public static var PotionsBagSlot02Potion : String;
    public static var PotionsBagSlot03 : Float;
    public static var PotionsBagSlot03Cap : Float;
    public static var PotionsBagSlot03Potion : String;
    public static var PotionsBagSlot04 : Float;
    public static var PotionsBagSlot04Cap : Float;
    public static var PotionsBagSlot04Potion : String;
    public static var PotionsBagSlot05 : Float;
    public static var PotionsBagSlot05Cap : Float;
    public static var PotionsBagSlot05Potion : String;
    public static var PotionsBagSlot06 : Float;
    public static var PotionsBagSlot06Cap : Float;
    public static var PotionsBagSlot06Potion : String;
    public static var PotionsBagSlot07 : Float;
    public static var PotionsBagSlot07Cap : Float;
    public static var PotionsBagSlot08 : Float;
    public static var PotionsBagSlot08Cap : Float;
    public static var PotionsBagSlot09 : Float;
    public static var PotionsBagSlot09Cap : Float;
    public static var PotionsBagSlot10 : Float;
    public static var PotionsBagSlot10Cap : Float;
    public static var PotionsBagSlot11 : Float;
    public static var PotionsBagSlot11Cap : Float;
    public static var PotionsBagSlot12 : Float;
    public static var PotionsBagSlot12Cap : Float;
    public static var PotionsBagSlot13 : Float;
    public static var PotionsBagSlot13Cap : Float;
    public static var PotionsBagSlot14 : Float;
    public static var PotionsBagSlot14Cap : Float;
    public static var PotionsBagSlot15 : Float;
    public static var PotionsBagSlot15Cap : Float;
    public static var PotionsBagSlot16 : Float;
    public static var PotionsBagSlot16Cap : Float;
    public static var PotionsBagSlot17 : Float;
    public static var PotionsBagSlot17Cap : Float;
    public static var PotionsBagSlot18 : Float;
    public static var PotionsBagSlot18Cap : Float;
    public static var PotionsBagSlot19 : Float;
    public static var PotionsBagSlot19Cap : Float;
    public static var PotionsBagSlot20 : Float;
    public static var PotionsBagSlot20Cap : Float;
    public static var PotionsBagSlot21 : Float;
    public static var PotionsBagSlot21Cap : Float;
    public static var PotionsBagSlot22 : Float;
    public static var PotionsBagSlot22Cap : Float;
    public static var PotionsBagSlot23 : Float;
    public static var PotionsBagSlot23Cap : Float;
    public static var PotionsBagSlot24 : Float;
    public static var PotionsBagSlot24Cap : Float;
    public static var PotionsBagSlot25 : Float;
    public static var PotionsBagSlot25Cap : Float;
    public static var PotionsBagSlot26 : Float;
    public static var PotionsBagSlot26Cap : Float;
    public static var PotionsBagSlot27 : Float;
    public static var PotionsBagSlot27Cap : Float;
    public static var PotionsBagSlot28 : Float;
    public static var PotionsBagSlot28Cap : Float;
    public static var PotionsBagSlot29 : Float;
    public static var PotionsBagSlot29Cap : Float;
    public static var PotionsBagSlot30 : Float;
    public static var PotionsBagSlot30Cap : Float;
    public static var PotionsBagSlot31 : Float;
    public static var PotionsBagSlot31Cap : Float;
    public static var PotionsBagSlot32 : Float;
    public static var PotionsBagSlot32Cap : Float;
    public static var PotionsBagSlot33 : Float;
    public static var PotionsBagSlot33Cap : Float;
    public static var PotionsBagSlot34 : Float;
    public static var PotionsBagSlot34Cap : Float;
    public static var PotionsBagSlot35 : Float;
    public static var PotionsBagSlot35Cap : Float;
    public static var PotionsBagSlot36 : Float;
    public static var PotionsBagSlot36Cap : Float;
    public static var PotionsBagSlot37 : Float;
    public static var PotionsBagSlot37Cap : Float;
    public static var PotionsBagSlot38 : Float;
    public static var PotionsBagSlot38Cap : Float;
    public static var PotionsBagSlot39 : Float;
    public static var PotionsBagSlot39Cap : Float;
    public static var PotionsBagSlot40 : Float;
    public static var PotionsBagSlot40Cap : Float;
    public static var PotionsBagSlot41 : Float;
    public static var PotionsBagSlot41Cap : Float;
    public static var PotionsBagSlot42 : Float;
    public static var PotionsBagSlot42Cap : Float;
    public static var PotionsBagSlot43 : Float;
    public static var PotionsBagSlot43Cap : Float;
    public static var PotionsBagSlot44 : Float;
    public static var PotionsBagSlot44Cap : Float;
    public static var PotionsBagSlot45 : Float;
    public static var PotionsBagSlot45Cap : Float;
    public static var PotionsBagSlot46 : Float;
    public static var PotionsBagSlot46Cap : Float;
    public static var PotionsBagSlot47 : Float;
    public static var PotionsBagSlot47Cap : Float;
    public static var PotionsBagSlot48 : Float;
    public static var PotionsBagSlot48Cap : Float;
    public static var PotionsBagSlot49 : Float;
    public static var PotionsBagSlot49Cap : Float;
    public static var PotionsBagSlot50 : Float;
    public static var PotionsBagSlot50Cap : Float;
    
    public function stateObjectName() : String
    {
        return "Gardening";
    }
    
    public function resetState() : Void
    {
        GardenSlot01 = "";
        GardenSlot01Time = 0;
        GardenSlot02 = "";
        GardenSlot02Time = 0;
        GardenSlot03 = "";
        GardenSlot03Time = 0;
        GardenSlot04 = "";
        GardenSlot04Time = 0;
        GardenSlot05 = "";
        GardenSlot05Time = 0;
        GardenSlot06 = "";
        GardenSlot06Time = 0;
        GardenSlot07 = "";
        GardenSlot07Time = 0;
        GardenSlot08 = "";
        GardenSlot08Time = 0;
        GardenSlot09 = "";
        GardenSlot09Time = 0;
        GardenSlot10 = "";
        GardenSlot10Time = 0;
        GardenSlot11 = "";
        GardenSlot11Time = 0;
        GardenSlot12 = "";
        GardenSlot12Time = 0;
        IngrediantBagSlot01 = 0;
        IngrediantBagSlot01Cap = 0;
        IngrediantBagSlot02 = 0;
        IngrediantBagSlot02Cap = 0;
        IngrediantBagSlot03 = 0;
        IngrediantBagSlot03Cap = 0;
        IngrediantBagSlot04 = 0;
        IngrediantBagSlot04Cap = 0;
        IngrediantBagSlot05 = 0;
        IngrediantBagSlot05Cap = 0;
        IngrediantBagSlot06 = 0;
        IngrediantBagSlot06Cap = 0;
        IngrediantBagSlot07 = 0;
        IngrediantBagSlot07Cap = 0;
        IngrediantBagSlot08 = 0;
        IngrediantBagSlot08Cap = 0;
        IngrediantBagSlot09 = 0;
        IngrediantBagSlot09Cap = 0;
        IngrediantBagSlot10 = 0;
        IngrediantBagSlot10Cap = 0;
        PotionsBagSlot01 = 0;
        PotionsBagSlot01Cap = 0;
        PotionsBagSlot01Potion = "";
        PotionsBagSlot02 = 0;
        PotionsBagSlot02Cap = 0;
        PotionsBagSlot02Potion = "";
        PotionsBagSlot03 = 0;
        PotionsBagSlot03Cap = 0;
        PotionsBagSlot03Potion = "";
        PotionsBagSlot04 = 0;
        PotionsBagSlot04Cap = 0;
        PotionsBagSlot04Potion = "";
        PotionsBagSlot05 = 0;
        PotionsBagSlot05Cap = 0;
        PotionsBagSlot05Potion = "";
        PotionsBagSlot06 = 0;
        PotionsBagSlot06Cap = 0;
        PotionsBagSlot06Potion = "";
        PotionsBagSlot07 = 0;
        PotionsBagSlot07Cap = 0;
        PotionsBagSlot08 = 0;
        PotionsBagSlot08Cap = 0;
        PotionsBagSlot09 = 0;
        PotionsBagSlot09Cap = 0;
        PotionsBagSlot10 = 0;
        PotionsBagSlot10Cap = 0;
        PotionsBagSlot11 = 0;
        PotionsBagSlot11Cap = 0;
        PotionsBagSlot12 = 0;
        PotionsBagSlot12Cap = 0;
        PotionsBagSlot13 = 0;
        PotionsBagSlot13Cap = 0;
        PotionsBagSlot14 = 0;
        PotionsBagSlot14Cap = 0;
        PotionsBagSlot15 = 0;
        PotionsBagSlot15Cap = 0;
        PotionsBagSlot16 = 0;
        PotionsBagSlot16Cap = 0;
        PotionsBagSlot17 = 0;
        PotionsBagSlot17Cap = 0;
        PotionsBagSlot18 = 0;
        PotionsBagSlot18Cap = 0;
        PotionsBagSlot19 = 0;
        PotionsBagSlot19Cap = 0;
        PotionsBagSlot20 = 0;
        PotionsBagSlot20Cap = 0;
        PotionsBagSlot21 = 0;
        PotionsBagSlot21Cap = 0;
        PotionsBagSlot22 = 0;
        PotionsBagSlot22Cap = 0;
        PotionsBagSlot23 = 0;
        PotionsBagSlot23Cap = 0;
        PotionsBagSlot24 = 0;
        PotionsBagSlot24Cap = 0;
        PotionsBagSlot25 = 0;
        PotionsBagSlot25Cap = 0;
        PotionsBagSlot26 = 0;
        PotionsBagSlot26Cap = 0;
        PotionsBagSlot27 = 0;
        PotionsBagSlot27Cap = 0;
        PotionsBagSlot28 = 0;
        PotionsBagSlot28Cap = 0;
        PotionsBagSlot29 = 0;
        PotionsBagSlot29Cap = 0;
        PotionsBagSlot30 = 0;
        PotionsBagSlot30Cap = 0;
        PotionsBagSlot31 = 0;
        PotionsBagSlot31Cap = 0;
        PotionsBagSlot32 = 0;
        PotionsBagSlot32Cap = 0;
        PotionsBagSlot33 = 0;
        PotionsBagSlot33Cap = 0;
        PotionsBagSlot34 = 0;
        PotionsBagSlot34Cap = 0;
        PotionsBagSlot35 = 0;
        PotionsBagSlot35Cap = 0;
        PotionsBagSlot36 = 0;
        PotionsBagSlot36Cap = 0;
        PotionsBagSlot37 = 0;
        PotionsBagSlot37Cap = 0;
        PotionsBagSlot38 = 0;
        PotionsBagSlot38Cap = 0;
        PotionsBagSlot39 = 0;
        PotionsBagSlot39Cap = 0;
        PotionsBagSlot40 = 0;
        PotionsBagSlot40Cap = 0;
        PotionsBagSlot41 = 0;
        PotionsBagSlot41Cap = 0;
        PotionsBagSlot42 = 0;
        PotionsBagSlot42Cap = 0;
        PotionsBagSlot43 = 0;
        PotionsBagSlot43Cap = 0;
        PotionsBagSlot44 = 0;
        PotionsBagSlot44Cap = 0;
        PotionsBagSlot45 = 0;
        PotionsBagSlot45Cap = 0;
        PotionsBagSlot46 = 0;
        PotionsBagSlot46Cap = 0;
        PotionsBagSlot47 = 0;
        PotionsBagSlot47Cap = 0;
        PotionsBagSlot48 = 0;
        PotionsBagSlot48Cap = 0;
        PotionsBagSlot49 = 0;
        PotionsBagSlot49Cap = 0;
        PotionsBagSlot50 = 0;
        PotionsBagSlot50Cap = 0;
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            GardenSlot01 : GardenSlot01,
            GardenSlot01Time : GardenSlot01Time,
            GardenSlot02 : GardenSlot02,
            GardenSlot02Time : GardenSlot02Time,
            GardenSlot03 : GardenSlot03,
            GardenSlot03Time : GardenSlot03Time,
            GardenSlot04 : GardenSlot04,
            GardenSlot04Time : GardenSlot04Time,
            GardenSlot05 : GardenSlot05,
            GardenSlot05Time : GardenSlot05Time,
            GardenSlot06 : GardenSlot06,
            GardenSlot06Time : GardenSlot06Time,
            GardenSlot07 : GardenSlot07,
            GardenSlot07Time : GardenSlot07Time,
            GardenSlot08 : GardenSlot08,
            GardenSlot08Time : GardenSlot08Time,
            GardenSlot09 : GardenSlot09,
            GardenSlot09Time : GardenSlot09Time,
            GardenSlot10 : GardenSlot10,
            GardenSlot10Time : GardenSlot10Time,
            GardenSlot11 : GardenSlot11,
            GardenSlot11Time : GardenSlot11Time,
            GardenSlot12 : GardenSlot12,
            GardenSlot12Time : GardenSlot12Time,
            IngrediantBagSlot01 : IngrediantBagSlot01,
            IngrediantBagSlot01Cap : IngrediantBagSlot01Cap,
            IngrediantBagSlot02 : IngrediantBagSlot02,
            IngrediantBagSlot02Cap : IngrediantBagSlot02Cap,
            IngrediantBagSlot03 : IngrediantBagSlot03,
            IngrediantBagSlot03Cap : IngrediantBagSlot03Cap,
            IngrediantBagSlot04 : IngrediantBagSlot04,
            IngrediantBagSlot04Cap : IngrediantBagSlot04Cap,
            IngrediantBagSlot05 : IngrediantBagSlot05,
            IngrediantBagSlot05Cap : IngrediantBagSlot05Cap,
            IngrediantBagSlot06 : IngrediantBagSlot06,
            IngrediantBagSlot06Cap : IngrediantBagSlot06Cap,
            IngrediantBagSlot07 : IngrediantBagSlot07,
            IngrediantBagSlot07Cap : IngrediantBagSlot07Cap,
            IngrediantBagSlot08 : IngrediantBagSlot08,
            IngrediantBagSlot08Cap : IngrediantBagSlot08Cap,
            IngrediantBagSlot09 : IngrediantBagSlot09,
            IngrediantBagSlot09Cap : IngrediantBagSlot09Cap,
            IngrediantBagSlot10 : IngrediantBagSlot10,
            IngrediantBagSlot10Cap : IngrediantBagSlot10Cap,
            PotionsBagSlot01 : PotionsBagSlot01,
            PotionsBagSlot01Cap : PotionsBagSlot01Cap,
            PotionsBagSlot01Potion : PotionsBagSlot01Potion,
            PotionsBagSlot02 : PotionsBagSlot02,
            PotionsBagSlot02Cap : PotionsBagSlot02Cap,
            PotionsBagSlot02Potion : PotionsBagSlot02Potion,
            PotionsBagSlot03 : PotionsBagSlot03,
            PotionsBagSlot03Cap : PotionsBagSlot03Cap,
            PotionsBagSlot03Potion : PotionsBagSlot03Potion,
            PotionsBagSlot04 : PotionsBagSlot04,
            PotionsBagSlot04Cap : PotionsBagSlot04Cap,
            PotionsBagSlot04Potion : PotionsBagSlot04Potion,
            PotionsBagSlot05 : PotionsBagSlot05,
            PotionsBagSlot05Cap : PotionsBagSlot05Cap,
            PotionsBagSlot05Potion : PotionsBagSlot05Potion,
            PotionsBagSlot06 : PotionsBagSlot06,
            PotionsBagSlot06Cap : PotionsBagSlot06Cap,
            PotionsBagSlot06Potion : PotionsBagSlot06Potion,
            PotionsBagSlot07 : PotionsBagSlot07,
            PotionsBagSlot07Cap : PotionsBagSlot07Cap,
            PotionsBagSlot08 : PotionsBagSlot08,
            PotionsBagSlot08Cap : PotionsBagSlot08Cap,
            PotionsBagSlot09 : PotionsBagSlot09,
            PotionsBagSlot09Cap : PotionsBagSlot09Cap,
            PotionsBagSlot10 : PotionsBagSlot10,
            PotionsBagSlot10Cap : PotionsBagSlot10Cap,
            PotionsBagSlot11 : PotionsBagSlot11,
            PotionsBagSlot11Cap : PotionsBagSlot11Cap,
            PotionsBagSlot12 : PotionsBagSlot12,
            PotionsBagSlot12Cap : PotionsBagSlot12Cap,
            PotionsBagSlot13 : PotionsBagSlot13,
            PotionsBagSlot13Cap : PotionsBagSlot13Cap,
            PotionsBagSlot14 : PotionsBagSlot14,
            PotionsBagSlot14Cap : PotionsBagSlot14Cap,
            PotionsBagSlot15 : PotionsBagSlot15,
            PotionsBagSlot15Cap : PotionsBagSlot15Cap,
            PotionsBagSlot16 : PotionsBagSlot16,
            PotionsBagSlot16Cap : PotionsBagSlot16Cap,
            PotionsBagSlot17 : PotionsBagSlot17,
            PotionsBagSlot17Cap : PotionsBagSlot17Cap,
            PotionsBagSlot18 : PotionsBagSlot18,
            PotionsBagSlot18Cap : PotionsBagSlot18Cap,
            PotionsBagSlot19 : PotionsBagSlot19,
            PotionsBagSlot19Cap : PotionsBagSlot19Cap,
            PotionsBagSlot20 : PotionsBagSlot20,
            PotionsBagSlot20Cap : PotionsBagSlot20Cap,
            PotionsBagSlot21 : PotionsBagSlot21,
            PotionsBagSlot21Cap : PotionsBagSlot21Cap,
            PotionsBagSlot22 : PotionsBagSlot22,
            PotionsBagSlot22Cap : PotionsBagSlot22Cap,
            PotionsBagSlot23 : PotionsBagSlot23,
            PotionsBagSlot23Cap : PotionsBagSlot23Cap,
            PotionsBagSlot24 : PotionsBagSlot24,
            PotionsBagSlot24Cap : PotionsBagSlot24Cap,
            PotionsBagSlot25 : PotionsBagSlot25,
            PotionsBagSlot25Cap : PotionsBagSlot25Cap,
            PotionsBagSlot26 : PotionsBagSlot26,
            PotionsBagSlot26Cap : PotionsBagSlot26Cap,
            PotionsBagSlot27 : PotionsBagSlot27,
            PotionsBagSlot27Cap : PotionsBagSlot27Cap,
            PotionsBagSlot28 : PotionsBagSlot28,
            PotionsBagSlot28Cap : PotionsBagSlot28Cap,
            PotionsBagSlot29 : PotionsBagSlot29,
            PotionsBagSlot29Cap : PotionsBagSlot29Cap,
            PotionsBagSlot30 : PotionsBagSlot30,
            PotionsBagSlot30Cap : PotionsBagSlot30Cap,
            PotionsBagSlot31 : PotionsBagSlot31,
            PotionsBagSlot31Cap : PotionsBagSlot31Cap,
            PotionsBagSlot32 : PotionsBagSlot32,
            PotionsBagSlot32Cap : PotionsBagSlot32Cap,
            PotionsBagSlot33 : PotionsBagSlot33,
            PotionsBagSlot33Cap : PotionsBagSlot33Cap,
            PotionsBagSlot34 : PotionsBagSlot34,
            PotionsBagSlot34Cap : PotionsBagSlot34Cap,
            PotionsBagSlot35 : PotionsBagSlot35,
            PotionsBagSlot35Cap : PotionsBagSlot35Cap,
            PotionsBagSlot36 : PotionsBagSlot36,
            PotionsBagSlot36Cap : PotionsBagSlot36Cap,
            PotionsBagSlot37 : PotionsBagSlot37,
            PotionsBagSlot37Cap : PotionsBagSlot37Cap,
            PotionsBagSlot38 : PotionsBagSlot38,
            PotionsBagSlot38Cap : PotionsBagSlot38Cap,
            PotionsBagSlot39 : PotionsBagSlot39,
            PotionsBagSlot39Cap : PotionsBagSlot39Cap,
            PotionsBagSlot40 : PotionsBagSlot40,
            PotionsBagSlot40Cap : PotionsBagSlot40Cap,
            PotionsBagSlot41 : PotionsBagSlot41,
            PotionsBagSlot41Cap : PotionsBagSlot41Cap,
            PotionsBagSlot42 : PotionsBagSlot42,
            PotionsBagSlot42Cap : PotionsBagSlot42Cap,
            PotionsBagSlot43 : PotionsBagSlot43,
            PotionsBagSlot43Cap : PotionsBagSlot43Cap,
            PotionsBagSlot44 : PotionsBagSlot44,
            PotionsBagSlot44Cap : PotionsBagSlot44Cap,
            PotionsBagSlot45 : PotionsBagSlot45,
            PotionsBagSlot45Cap : PotionsBagSlot45Cap,
            PotionsBagSlot46 : PotionsBagSlot46,
            PotionsBagSlot46Cap : PotionsBagSlot46Cap,
            PotionsBagSlot47 : PotionsBagSlot47,
            PotionsBagSlot47Cap : PotionsBagSlot47Cap,
            PotionsBagSlot48 : PotionsBagSlot48,
            PotionsBagSlot48Cap : PotionsBagSlot48Cap,
            PotionsBagSlot49 : PotionsBagSlot49,
            PotionsBagSlot49Cap : PotionsBagSlot49Cap,
            PotionsBagSlot50 : PotionsBagSlot50,
            PotionsBagSlot50Cap : PotionsBagSlot50Cap
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            GardenSlot01 = Reflect.field(o, "GardenSlot01");
            GardenSlot01Time = Reflect.field(o, "GardenSlot01Time");
            GardenSlot02 = Reflect.field(o, "GardenSlot02");
            GardenSlot02Time = Reflect.field(o, "GardenSlot02Time");
            GardenSlot03 = Reflect.field(o, "GardenSlot03");
            GardenSlot03Time = Reflect.field(o, "GardenSlot03Time");
            GardenSlot04 = Reflect.field(o, "GardenSlot04");
            GardenSlot04Time = Reflect.field(o, "GardenSlot04Time");
            GardenSlot05 = Reflect.field(o, "GardenSlot05");
            GardenSlot05Time = Reflect.field(o, "GardenSlot05Time");
            GardenSlot06 = Reflect.field(o, "GardenSlot06");
            GardenSlot06Time = Reflect.field(o, "GardenSlot06Time");
            GardenSlot07 = Reflect.field(o, "GardenSlot07");
            GardenSlot07Time = Reflect.field(o, "GardenSlot07Time");
            GardenSlot08 = Reflect.field(o, "GardenSlot08");
            GardenSlot08Time = Reflect.field(o, "GardenSlot08Time");
            GardenSlot09 = Reflect.field(o, "GardenSlot09");
            GardenSlot09Time = Reflect.field(o, "GardenSlot09Time");
            GardenSlot10 = Reflect.field(o, "GardenSlot10");
            GardenSlot10Time = Reflect.field(o, "GardenSlot10Time");
            GardenSlot11 = Reflect.field(o, "GardenSlot11");
            GardenSlot11Time = Reflect.field(o, "GardenSlot11Time");
            GardenSlot12 = Reflect.field(o, "GardenSlot12");
            GardenSlot12Time = Reflect.field(o, "GardenSlot12Time");
            IngrediantBagSlot01 = Reflect.field(o, "IngrediantBagSlot01");
            IngrediantBagSlot01Cap = Reflect.field(o, "IngrediantBagSlot01Cap");
            IngrediantBagSlot02 = Reflect.field(o, "IngrediantBagSlot02");
            IngrediantBagSlot02Cap = Reflect.field(o, "IngrediantBagSlot02Cap");
            IngrediantBagSlot03 = Reflect.field(o, "IngrediantBagSlot03");
            IngrediantBagSlot03Cap = Reflect.field(o, "IngrediantBagSlot03Cap");
            IngrediantBagSlot04 = Reflect.field(o, "IngrediantBagSlot04");
            IngrediantBagSlot04Cap = Reflect.field(o, "IngrediantBagSlot04Cap");
            IngrediantBagSlot05 = Reflect.field(o, "IngrediantBagSlot05");
            IngrediantBagSlot05Cap = Reflect.field(o, "IngrediantBagSlot05Cap");
            IngrediantBagSlot06 = Reflect.field(o, "IngrediantBagSlot06");
            IngrediantBagSlot06Cap = Reflect.field(o, "IngrediantBagSlot06Cap");
            IngrediantBagSlot07 = Reflect.field(o, "IngrediantBagSlot07");
            IngrediantBagSlot07Cap = Reflect.field(o, "IngrediantBagSlot07Cap");
            IngrediantBagSlot08 = Reflect.field(o, "IngrediantBagSlot08");
            IngrediantBagSlot08Cap = Reflect.field(o, "IngrediantBagSlot08Cap");
            IngrediantBagSlot09 = Reflect.field(o, "IngrediantBagSlot09");
            IngrediantBagSlot09Cap = Reflect.field(o, "IngrediantBagSlot09Cap");
            IngrediantBagSlot10 = Reflect.field(o, "IngrediantBagSlot10");
            IngrediantBagSlot10Cap = Reflect.field(o, "IngrediantBagSlot10Cap");
            PotionsBagSlot01 = Reflect.field(o, "PotionsBagSlot01");
            PotionsBagSlot01Cap = Reflect.field(o, "PotionsBagSlot01Cap");
            PotionsBagSlot01Potion = valueOr(Reflect.field(o, "PotionsBagSlot01Potion"), "");
            PotionsBagSlot02 = Reflect.field(o, "PotionsBagSlot02");
            PotionsBagSlot02Cap = Reflect.field(o, "PotionsBagSlot02Cap");
            PotionsBagSlot02Potion = valueOr(Reflect.field(o, "PotionsBagSlot02Potion"), "");
            PotionsBagSlot03 = Reflect.field(o, "PotionsBagSlot03");
            PotionsBagSlot03Cap = Reflect.field(o, "PotionsBagSlot03Cap");
            PotionsBagSlot03Potion = valueOr(Reflect.field(o, "PotionsBagSlot03Potion"), "");
            PotionsBagSlot04 = Reflect.field(o, "PotionsBagSlot04");
            PotionsBagSlot04Cap = Reflect.field(o, "PotionsBagSlot04Cap");
            PotionsBagSlot04Potion = valueOr(Reflect.field(o, "PotionsBagSlot04Potion"), "");
            PotionsBagSlot05 = Reflect.field(o, "PotionsBagSlot05");
            PotionsBagSlot05Cap = Reflect.field(o, "PotionsBagSlot05Cap");
            PotionsBagSlot05Potion = valueOr(Reflect.field(o, "PotionsBagSlot05Potion"), "");
            PotionsBagSlot06 = Reflect.field(o, "PotionsBagSlot06");
            PotionsBagSlot06Cap = Reflect.field(o, "PotionsBagSlot06Cap");
            PotionsBagSlot06Potion = valueOr(Reflect.field(o, "PotionsBagSlot06Potion"), "");
            PotionsBagSlot07 = Reflect.field(o, "PotionsBagSlot07");
            PotionsBagSlot07Cap = Reflect.field(o, "PotionsBagSlot07Cap");
            PotionsBagSlot08 = Reflect.field(o, "PotionsBagSlot08");
            PotionsBagSlot08Cap = Reflect.field(o, "PotionsBagSlot08Cap");
            PotionsBagSlot09 = Reflect.field(o, "PotionsBagSlot09");
            PotionsBagSlot09Cap = Reflect.field(o, "PotionsBagSlot09Cap");
            PotionsBagSlot10 = Reflect.field(o, "PotionsBagSlot10");
            PotionsBagSlot10Cap = Reflect.field(o, "PotionsBagSlot10Cap");
            PotionsBagSlot11 = Reflect.field(o, "PotionsBagSlot11");
            PotionsBagSlot11Cap = Reflect.field(o, "PotionsBagSlot11Cap");
            PotionsBagSlot12 = Reflect.field(o, "PotionsBagSlot12");
            PotionsBagSlot12Cap = Reflect.field(o, "PotionsBagSlot12Cap");
            PotionsBagSlot13 = Reflect.field(o, "PotionsBagSlot13");
            PotionsBagSlot13Cap = Reflect.field(o, "PotionsBagSlot13Cap");
            PotionsBagSlot14 = Reflect.field(o, "PotionsBagSlot14");
            PotionsBagSlot14Cap = Reflect.field(o, "PotionsBagSlot14Cap");
            PotionsBagSlot15 = Reflect.field(o, "PotionsBagSlot15");
            PotionsBagSlot15Cap = Reflect.field(o, "PotionsBagSlot15Cap");
            PotionsBagSlot16 = Reflect.field(o, "PotionsBagSlot16");
            PotionsBagSlot16Cap = Reflect.field(o, "PotionsBagSlot16Cap");
            PotionsBagSlot17 = Reflect.field(o, "PotionsBagSlot17");
            PotionsBagSlot17Cap = Reflect.field(o, "PotionsBagSlot17Cap");
            PotionsBagSlot18 = Reflect.field(o, "PotionsBagSlot18");
            PotionsBagSlot18Cap = Reflect.field(o, "PotionsBagSlot18Cap");
            PotionsBagSlot19 = Reflect.field(o, "PotionsBagSlot19");
            PotionsBagSlot19Cap = Reflect.field(o, "PotionsBagSlot19Cap");
            PotionsBagSlot20 = Reflect.field(o, "PotionsBagSlot20");
            PotionsBagSlot20Cap = Reflect.field(o, "PotionsBagSlot20Cap");
            PotionsBagSlot21 = Reflect.field(o, "PotionsBagSlot21");
            PotionsBagSlot21Cap = Reflect.field(o, "PotionsBagSlot21Cap");
            PotionsBagSlot22 = Reflect.field(o, "PotionsBagSlot22");
            PotionsBagSlot22Cap = Reflect.field(o, "PotionsBagSlot22Cap");
            PotionsBagSlot23 = Reflect.field(o, "PotionsBagSlot23");
            PotionsBagSlot23Cap = Reflect.field(o, "PotionsBagSlot23Cap");
            PotionsBagSlot24 = Reflect.field(o, "PotionsBagSlot24");
            PotionsBagSlot24Cap = Reflect.field(o, "PotionsBagSlot24Cap");
            PotionsBagSlot25 = Reflect.field(o, "PotionsBagSlot25");
            PotionsBagSlot25Cap = Reflect.field(o, "PotionsBagSlot25Cap");
            PotionsBagSlot26 = Reflect.field(o, "PotionsBagSlot26");
            PotionsBagSlot26Cap = Reflect.field(o, "PotionsBagSlot26Cap");
            PotionsBagSlot27 = Reflect.field(o, "PotionsBagSlot27");
            PotionsBagSlot27Cap = Reflect.field(o, "PotionsBagSlot27Cap");
            PotionsBagSlot28 = Reflect.field(o, "PotionsBagSlot28");
            PotionsBagSlot28Cap = Reflect.field(o, "PotionsBagSlot28Cap");
            PotionsBagSlot29 = Reflect.field(o, "PotionsBagSlot29");
            PotionsBagSlot29Cap = Reflect.field(o, "PotionsBagSlot29Cap");
            PotionsBagSlot30 = Reflect.field(o, "PotionsBagSlot30");
            PotionsBagSlot30Cap = Reflect.field(o, "PotionsBagSlot30Cap");
            PotionsBagSlot31 = Reflect.field(o, "PotionsBagSlot31");
            PotionsBagSlot31Cap = Reflect.field(o, "PotionsBagSlot31Cap");
            PotionsBagSlot32 = Reflect.field(o, "PotionsBagSlot32");
            PotionsBagSlot32Cap = Reflect.field(o, "PotionsBagSlot32Cap");
            PotionsBagSlot33 = Reflect.field(o, "PotionsBagSlot33");
            PotionsBagSlot33Cap = Reflect.field(o, "PotionsBagSlot33Cap");
            PotionsBagSlot34 = Reflect.field(o, "PotionsBagSlot34");
            PotionsBagSlot34Cap = Reflect.field(o, "PotionsBagSlot34Cap");
            PotionsBagSlot35 = Reflect.field(o, "PotionsBagSlot35");
            PotionsBagSlot35Cap = Reflect.field(o, "PotionsBagSlot35Cap");
            PotionsBagSlot36 = Reflect.field(o, "PotionsBagSlot36");
            PotionsBagSlot36Cap = Reflect.field(o, "PotionsBagSlot36Cap");
            PotionsBagSlot37 = Reflect.field(o, "PotionsBagSlot37");
            PotionsBagSlot37Cap = Reflect.field(o, "PotionsBagSlot37Cap");
            PotionsBagSlot38 = Reflect.field(o, "PotionsBagSlot38");
            PotionsBagSlot38Cap = Reflect.field(o, "PotionsBagSlot38Cap");
            PotionsBagSlot39 = Reflect.field(o, "PotionsBagSlot39");
            PotionsBagSlot39Cap = Reflect.field(o, "PotionsBagSlot39Cap");
            PotionsBagSlot40 = Reflect.field(o, "PotionsBagSlot40");
            PotionsBagSlot40Cap = Reflect.field(o, "PotionsBagSlot40Cap");
            PotionsBagSlot41 = Reflect.field(o, "PotionsBagSlot41");
            PotionsBagSlot41Cap = Reflect.field(o, "PotionsBagSlot41Cap");
            PotionsBagSlot42 = Reflect.field(o, "PotionsBagSlot42");
            PotionsBagSlot42Cap = Reflect.field(o, "PotionsBagSlot42Cap");
            PotionsBagSlot43 = Reflect.field(o, "PotionsBagSlot43");
            PotionsBagSlot43Cap = Reflect.field(o, "PotionsBagSlot43Cap");
            PotionsBagSlot44 = Reflect.field(o, "PotionsBagSlot44");
            PotionsBagSlot44Cap = Reflect.field(o, "PotionsBagSlot44Cap");
            PotionsBagSlot45 = Reflect.field(o, "PotionsBagSlot45");
            PotionsBagSlot45Cap = Reflect.field(o, "PotionsBagSlot45Cap");
            PotionsBagSlot46 = Reflect.field(o, "PotionsBagSlot46");
            PotionsBagSlot46Cap = Reflect.field(o, "PotionsBagSlot46Cap");
            PotionsBagSlot47 = Reflect.field(o, "PotionsBagSlot47");
            PotionsBagSlot47Cap = Reflect.field(o, "PotionsBagSlot47Cap");
            PotionsBagSlot48 = Reflect.field(o, "PotionsBagSlot48");
            PotionsBagSlot48Cap = Reflect.field(o, "PotionsBagSlot48Cap");
            PotionsBagSlot49 = Reflect.field(o, "PotionsBagSlot49");
            PotionsBagSlot49Cap = Reflect.field(o, "PotionsBagSlot49Cap");
            PotionsBagSlot50 = Reflect.field(o, "PotionsBagSlot50");
            PotionsBagSlot50Cap = Reflect.field(o, "PotionsBagSlot50Cap");
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
    
    public function canAccessGarden() : Bool
    {
        return IngrediantBagSlot01Cap > 0;
    }
    public function accessGarden() : Void
    {
        hideMenus();
        clearOutput();
        menu();
        outputText("You move over to your gardening fields. You can plant and grow herbs here.");
        outputText("\n\n");
        outputText("<b>Herbs Bag</b>\n");
        outputText("Healing herb: " + IngrediantBagSlot01 + "/" + IngrediantBagSlot01Cap + "\n");
        outputText("Moon grass: " + IngrediantBagSlot02 + "/" + IngrediantBagSlot02Cap + "\n");
        outputText("Snakebane flower: " + IngrediantBagSlot03 + "/" + IngrediantBagSlot03Cap + "\n");
        outputText("Ironweed: " + IngrediantBagSlot04 + "/" + IngrediantBagSlot04Cap + "\n");
        outputText("Blade fern: " + IngrediantBagSlot05 + "/" + IngrediantBagSlot05Cap + "\n");
        outputText("Alraune nectar: " + IngrediantBagSlot06 + "/" + IngrediantBagSlot06Cap + "\n");
        if (IngrediantBagSlot07Cap > 0)
        {
            outputText("Ginseng: " + IngrediantBagSlot07 + "/" + IngrediantBagSlot07Cap + "\n");
        }
        //if (IngrediantBagSlot08Cap > 0) outputText("???: "+IngrediantBagSlot08+"/"+IngrediantBagSlot08Cap+"\n");
        outputText("\n<b>Fields</b>\n");
        outputText("-01-: " + ((GardenSlot01 != "") ? "" + GardenSlot01 + " (Time until harvest: " + GardenSlot01Time + " hours)" : "empty") + "");
        outputText("\n-02-: " + ((GardenSlot02 != "") ? "" + GardenSlot02 + " (Time until harvest: " + GardenSlot02Time + " hours)" : "empty") + "");
        if (player.farmingLevel >= 5)
        {
            outputText("\n-03-: " + ((GardenSlot03 != "") ? "" + GardenSlot03 + " (Time until harvest: " + GardenSlot03Time + " hours)" : "empty") + "");
        }
        if (player.farmingLevel >= 10)
        {
            outputText("\n-04-: " + ((GardenSlot04 != "") ? "" + GardenSlot04 + " (Time until harvest: " + GardenSlot04Time + " hours)" : "empty") + "");
        }
        if (player.farmingLevel >= 15)
        {
            outputText("\n-05-: " + ((GardenSlot05 != "") ? "" + GardenSlot05 + " (Time until harvest: " + GardenSlot05Time + " hours)" : "empty") + "");
        }
        if (player.farmingLevel >= 20)
        {
            outputText("\n-06-: " + ((GardenSlot06 != "") ? "" + GardenSlot06 + " (Time until harvest: " + GardenSlot06Time + " hours)" : "empty") + "");
        }
        if (player.farmingLevel >= 25)
        {
            outputText("\n-07-: " + ((GardenSlot07 != "") ? "" + GardenSlot07 + " (Time until harvest: " + GardenSlot07Time + " hours)" : "empty") + "");
        }
        if (player.farmingLevel >= 30)
        {
            outputText("\n-08-: " + ((GardenSlot08 != "") ? "" + GardenSlot08 + " (Time until harvest: " + GardenSlot08Time + " hours)" : "empty") + "");
        }
        if (player.farmingLevel >= 35)
        {
            outputText("\n-09-: " + ((GardenSlot09 != "") ? "" + GardenSlot09 + " (Time until harvest: " + GardenSlot09Time + " hours)" : "empty") + "");
        }
        if (player.farmingLevel >= 40)
        {
            outputText("\n-10-: " + ((GardenSlot10 != "") ? "" + GardenSlot10 + " (Time until harvest: " + GardenSlot10Time + " hours)" : "empty") + "");
        }
        if (player.farmingLevel >= 45)
        {
            outputText("\n-11-: " + ((GardenSlot11 != "") ? "" + GardenSlot11 + " (Time until harvest: " + GardenSlot11Time + " hours)" : "empty") + "");
        }
        if (player.farmingLevel >= 50)
        {
            outputText("\n-12-: " + ((GardenSlot12 != "") ? "" + GardenSlot12 + " (Time until harvest: " + GardenSlot12Time + " hours)" : "empty") + "");
        }
        addButton(0, "Put Herb In", putInHerbIntoHerbBag0);
        addButton(1, "Put Herb Out", putOutHerbFromHerbBag0);
        addButton(3, "Seed", Seed).hint("Plant down some seeds sacrificing an ingredients.");
        addButton(4, "Harvest", Harvest).hint("Check your harvests.");
        addButton(14, "Back", camp.campActions);
    }
    
    private function putInHerbIntoHerbBag0() : Void
    {
        menu();
        if (player.hasItem(consumables.HEALHERB))
        {
            if (IngrediantBagSlot01 >= IngrediantBagSlot01Cap)
            {
                addButtonDisabled(0, "Healing herb", "You not have space to put in another healing herb.");
            }
            else
            {
                addButton(0, "Healing herb", putInHerbIntoHerbBag, CoC.instance.consumables.HEALHERB);
            }
        }
        if (player.hasItem(consumables.MOONGRASS))
        {
            if (IngrediantBagSlot02 >= IngrediantBagSlot02Cap)
            {
                addButtonDisabled(1, "Moon grass", "You not have space to put in another moon grass.");
            }
            else
            {
                addButton(1, "Moon grass", putInHerbIntoHerbBag, CoC.instance.consumables.MOONGRASS);
            }
        }
        if (player.hasItem(consumables.SNAKEBANE))
        {
            if (IngrediantBagSlot03 >= IngrediantBagSlot03Cap)
            {
                addButtonDisabled(2, "Snakebane", "You not have space to put in another snakebane flower.");
            }
            else
            {
                addButton(2, "Snakebane", putInHerbIntoHerbBag, CoC.instance.consumables.SNAKEBANE);
            }
        }
        if (player.hasItem(consumables.IRONWEED))
        {
            if (IngrediantBagSlot04 >= IngrediantBagSlot04Cap)
            {
                addButtonDisabled(3, "Ironweed", "You not have space to put in another ironweed.");
            }
            else
            {
                addButton(3, "Ironweed", putInHerbIntoHerbBag, CoC.instance.consumables.IRONWEED);
            }
        }
        if (player.hasItem(consumables.BLADEFERN))
        {
            if (IngrediantBagSlot05 >= IngrediantBagSlot05Cap)
            {
                addButtonDisabled(4, "Blade fern", "You not have space to put in another blade fern.");
            }
            else
            {
                addButton(4, "Blade fern", putInHerbIntoHerbBag, CoC.instance.consumables.BLADEFERN);
            }
        }
        if (player.hasItem(consumables.RAUNENECT))
        {
            if (IngrediantBagSlot06 >= IngrediantBagSlot06Cap)
            {
                addButtonDisabled(5, "Alraune nectar", "You not have space to put in another bottle of alraune nectar.");
            }
            else
            {
                addButton(5, "Alraune nectar", putInHerbIntoHerbBag, CoC.instance.consumables.RAUNENECT);
            }
        }
        if (player.hasItem(consumables.GINSENG) && IngrediantBagSlot07Cap > 0)
        {
            if (IngrediantBagSlot07 >= IngrediantBagSlot07Cap)
            {
                addButtonDisabled(6, "Ginseng", "You not have space to put in another ginseng.");
            }
            else
            {
                addButton(6, "Ginseng", putInHerbIntoHerbBag, CoC.instance.consumables.GINSENG);
            }
        }
        addButton(14, "Back", accessGarden);
    }
    private function putInHerbIntoHerbBag(ItemID : SimpleConsumable) : Void
    {
        clearOutput();
        outputText("In order to have some free space in your backpack you put one of the herbs into your bag.\n\n");
        player.destroyItems(ItemID, 1);
        if (ItemID == CoC.instance.consumables.HEALHERB)
        {
            IngrediantBagSlot01++;
        }
        if (ItemID == CoC.instance.consumables.MOONGRASS)
        {
            IngrediantBagSlot02++;
        }
        if (ItemID == CoC.instance.consumables.SNAKEBANE)
        {
            IngrediantBagSlot03++;
        }
        if (ItemID == CoC.instance.consumables.IRONWEED)
        {
            IngrediantBagSlot04++;
        }
        if (ItemID == CoC.instance.consumables.BLADEFERN)
        {
            IngrediantBagSlot05++;
        }
        if (ItemID == CoC.instance.consumables.RAUNENECT)
        {
            IngrediantBagSlot06++;
        }
        if (ItemID == CoC.instance.consumables.GINSENG)
        {
            IngrediantBagSlot07++;
        }
        doNext(putInHerbIntoHerbBag0);
    }
    
    private function putOutHerbFromHerbBag0() : Void
    {
        menu();
        if (IngrediantBagSlot01 > 0)
        {
            addButton(0, "Healing herb", putOutHerbFromHerbBag, CoC.instance.consumables.HEALHERB).hint("Make sure to have free space in backapck to put it in or it would be lost.");
        }
        else
        {
            addButtonDisabled(0, "Healing herb", "You not have any herb of this type in herb bag.");
        }
        if (IngrediantBagSlot02 > 0)
        {
            addButton(1, "Moon grass", putOutHerbFromHerbBag, CoC.instance.consumables.MOONGRASS).hint("Make sure to have free space in backapck to put it in or it would be lost.");
        }
        else
        {
            addButtonDisabled(1, "Moon grass", "You not have any herb of this type in herb bag.");
        }
        if (IngrediantBagSlot03 > 0)
        {
            addButton(2, "Snakebane", putOutHerbFromHerbBag, CoC.instance.consumables.SNAKEBANE).hint("Make sure to have free space in backapck to put it in or it would be lost.");
        }
        else
        {
            addButtonDisabled(2, "Snakebane", "You not have any herb of this type in herb bag.");
        }
        if (IngrediantBagSlot04 > 0)
        {
            addButton(3, "Ironweed", putOutHerbFromHerbBag, CoC.instance.consumables.IRONWEED).hint("Make sure to have free space in backapck to put it in or it would be lost.");
        }
        else
        {
            addButtonDisabled(3, "Ironweed", "You not have any herb of this type in herb bag.");
        }
        if (IngrediantBagSlot05 > 0)
        {
            addButton(4, "Blade fern", putOutHerbFromHerbBag, CoC.instance.consumables.BLADEFERN).hint("Make sure to have free space in backapck to put it in or it would be lost.");
        }
        else
        {
            addButtonDisabled(4, "Blade fern", "You not have any herb of this type in herb bag.");
        }
        if (IngrediantBagSlot06 > 0)
        {
            addButton(5, "Alraune nectar", putOutHerbFromHerbBag, CoC.instance.consumables.RAUNENECT).hint("Make sure to have free space in backapck to put it in or it would be lost.");
        }
        else
        {
            addButtonDisabled(5, "Alraune nectar", "You not have any herb of this type in herb bag.");
        }
        if (IngrediantBagSlot07Cap > 0)
        {
            if (IngrediantBagSlot07 > 0)
            {
                addButton(6, "Ginseng", putOutHerbFromHerbBag, CoC.instance.consumables.GINSENG).hint("Make sure to have free space in backapck to put it in or it would be lost.");
            }
            else
            {
                addButtonDisabled(6, "Ginseng", "You not have any herb of this type in herb bag.");
            }
        }
        addButton(14, "Back", accessGarden);
    }
    private function putOutHerbFromHerbBag(ItemID : SimpleConsumable) : Void
    {
        clearOutput();
        outputText("In order to have some free space in your bag you put one of the herbs into your backpack.\n\n");
        if (ItemID == CoC.instance.consumables.HEALHERB)
        {
            IngrediantBagSlot01--;
        }
        if (ItemID == CoC.instance.consumables.MOONGRASS)
        {
            IngrediantBagSlot02--;
        }
        if (ItemID == CoC.instance.consumables.SNAKEBANE)
        {
            IngrediantBagSlot03--;
        }
        if (ItemID == CoC.instance.consumables.IRONWEED)
        {
            IngrediantBagSlot04--;
        }
        if (ItemID == CoC.instance.consumables.BLADEFERN)
        {
            IngrediantBagSlot05--;
        }
        if (ItemID == CoC.instance.consumables.RAUNENECT)
        {
            IngrediantBagSlot06--;
        }
        if (ItemID == CoC.instance.consumables.GINSENG)
        {
            IngrediantBagSlot07--;
        }
        inventory.takeItem(ItemID, putOutHerbFromHerbBag0);
    }
    
    private function timeUntilHarvest() : Float
    {
        var tUH : Float = 168;
        if (player.farmingLevel >= 5)
        {
            tUH -= 12;
        }
        if (player.farmingLevel >= 10)
        {
            tUH -= 12;
        }
        if (player.farmingLevel >= 15)
        {
            tUH -= 12;
        }
        if (player.farmingLevel >= 20)
        {
            tUH -= 12;
        }
        if (player.farmingLevel >= 25)
        {
            tUH -= 12;
        }
        if (player.farmingLevel >= 30)
        {
            tUH -= 12;
        }
        if (player.farmingLevel >= 35)
        {
            tUH -= 12;
        }
        if (player.farmingLevel >= 40)
        {
            tUH -= 12;
        }
        if (player.farmingLevel >= 45)
        {
            tUH -= 12;
        }
        if (player.farmingLevel >= 50)
        {
            tUH -= 12;
        }
        return tUH;
    }
    
    private function Seed() : Void
    {
        hideMenus();
        clearOutput();
        menu();
        outputText("What kind of herb would you like to grow?");
        if (IngrediantBagSlot01 == 0)
        {
            addButtonDisabled(0, "Healing herb", "You lack a plant sample in ingredient bag to get seeds from.");
        }
        else
        {
            addButton(0, "Healing herb", Seed1, 1).hint("Plant new seeds.");
        }
        if (IngrediantBagSlot02 == 0)
        {
            addButtonDisabled(1, "Moon grass", "You lack a plant sample in ingredient bag to get seeds from.");
        }
        else
        {
            addButton(1, "Moon grass", Seed1, 2).hint("Plant new seeds.");
        }
        if (IngrediantBagSlot03 == 0)
        {
            addButtonDisabled(2, "Snakebane", "You lack a plant sample in ingredient bag to get seeds from.");
        }
        else
        {
            addButton(2, "Snakebane", Seed1, 3).hint("Plant new seeds.");
        }
        if (IngrediantBagSlot04 == 0)
        {
            addButtonDisabled(3, "Ironweed", "You lack a plant sample in ingredient bag to get seeds from.");
        }
        else
        {
            addButton(3, "Ironweed", Seed1, 4).hint("Plant new seeds.");
        }
        if (IngrediantBagSlot05 == 0)
        {
            addButtonDisabled(4, "Blade fern", "You lack a plant sample in ingredient bag to get seeds from.");
        }
        else
        {
            addButton(4, "Blade fern", Seed1, 5).hint("Plant new seeds.");
        }
        if (IngrediantBagSlot07Cap > 0)
        {
            if (IngrediantBagSlot07 == 0)
            {
                addButtonDisabled(5, "Ginseng", "You lack a plant sample in ingredient bag to get seeds from.");
            }
            else
            {
                addButton(5, "Ginseng", Seed1, 6).hint("Plant new seeds.");
            }
        }
        addButton(14, "Back", accessGarden).hint("Go back to garden menu.");
    }
    private function Seed1(Item : Float) : Void
    {
        hideMenus();
        clearOutput();
        menu();
        outputText("Which plot would you like to use?");
        if (GardenSlot01 != "")
        {
            addButtonDisabled(0, "-01-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
        }
        else
        {
            addButton(0, "-01-", curry(Seed2, Item, 1));
        }
        if (GardenSlot02 != "")
        {
            addButtonDisabled(1, "-02-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
        }
        else
        {
            addButton(1, "-02-", curry(Seed2, Item, 2));
        }
        if (player.farmingLevel >= 5)
        {
            if (GardenSlot03 != "")
            {
                addButtonDisabled(2, "-03-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(2, "-03-", curry(Seed2, Item, 3));
            }
        }
        if (player.farmingLevel >= 10)
        {
            if (GardenSlot04 != "")
            {
                addButtonDisabled(3, "-04-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(3, "-04-", curry(Seed2, Item, 4));
            }
        }
        if (player.farmingLevel >= 15)
        {
            if (GardenSlot05 != "")
            {
                addButtonDisabled(4, "-05-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(4, "-05-", curry(Seed2, Item, 5));
            }
        }
        if (player.farmingLevel >= 20)
        {
            if (GardenSlot06 != "")
            {
                addButtonDisabled(5, "-06-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(5, "-06-", curry(Seed2, Item, 6));
            }
        }
        if (player.farmingLevel >= 25)
        {
            if (GardenSlot07 != "")
            {
                addButtonDisabled(6, "-07-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(6, "-07-", curry(Seed2, Item, 7));
            }
        }
        if (player.farmingLevel >= 30)
        {
            if (GardenSlot08 != "")
            {
                addButtonDisabled(7, "-08-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(7, "-08-", curry(Seed2, Item, 8));
            }
        }
        if (player.farmingLevel >= 35)
        {
            if (GardenSlot09 != "")
            {
                addButtonDisabled(8, "-09-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(8, "-09-", curry(Seed2, Item, 9));
            }
        }
        if (player.farmingLevel >= 40)
        {
            if (GardenSlot10 != "")
            {
                addButtonDisabled(9, "-10-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(9, "-10-", curry(Seed2, Item, 10));
            }
        }
        if (player.farmingLevel >= 45)
        {
            if (GardenSlot11 != "")
            {
                addButtonDisabled(10, "-11-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(10, "-11-", curry(Seed2, Item, 11));
            }
        }
        if (player.farmingLevel >= 50)
        {
            if (GardenSlot12 != "")
            {
                addButtonDisabled(11, "-12-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
            }
            else
            {
                addButton(11, "-12-", curry(Seed2, Item, 12));
            }
        }
        addButton(14, "Back", Seed).hint("Go back to plot choice menu.");
    }
    private function Seed2(Item : Float, plot : Float) : Void
    {
        hideMenus();
        clearOutput();
        outputText("Planting a new herb will consume one of your herb items, proceed anyway?");
        doYesNo(curry(Seed3, Item, plot), Seed);
    }
    private function Seed3(Item : Float, plot : Float) : Void
    {
        var herb : String = "";
        if (Item == 1)
        {
            herb = "healing herb";
        }
        if (Item == 2)
        {
            herb = "moon grass";
        }
        if (Item == 3)
        {
            herb = "snakebane";
        }
        if (Item == 4)
        {
            herb = "ironweed";
        }
        if (Item == 5)
        {
            herb = "bladefern";
        }
        if (Item == 6)
        {
            herb = "ginseng";
        }
        switch (plot)
        {
            case 1:
                GardenSlot01 = herb;
                GardenSlot01Time = timeUntilHarvest();
            case 2:
                GardenSlot02 = herb;
                GardenSlot02Time = timeUntilHarvest();
            case 3:
                GardenSlot03 = herb;
                GardenSlot03Time = timeUntilHarvest();
            case 4:
                GardenSlot04 = herb;
                GardenSlot04Time = timeUntilHarvest();
            case 5:
                GardenSlot05 = herb;
                GardenSlot05Time = timeUntilHarvest();
            case 6:
                GardenSlot06 = herb;
                GardenSlot06Time = timeUntilHarvest();
            case 7:
                GardenSlot07 = herb;
                GardenSlot07Time = timeUntilHarvest();
            case 8:
                GardenSlot08 = herb;
                GardenSlot08Time = timeUntilHarvest();
            case 9:
                GardenSlot09 = herb;
                GardenSlot09Time = timeUntilHarvest();
            case 10:
                GardenSlot10 = herb;
                GardenSlot10Time = timeUntilHarvest();
            case 11:
                GardenSlot11 = herb;
                GardenSlot11Time = timeUntilHarvest();
            case 12:
                GardenSlot12 = herb;
                GardenSlot12Time = timeUntilHarvest();
            default:
                outputText("<b>This text should not appear. Please let Ormael/Aimozg know.</b>");
                doNext(playerMenu);
        }
        cast((Item), Seed4);
    }
    private function Seed4(Item : Float) : Void
    {
        clearOutput();
        outputText("You begin carefully planting the");
        if (Item == 1)
        {
            outputText("healing herb");
            IngrediantBagSlot01 -= 1;
        }
        if (Item == 2)
        {
            outputText("moon grass");
            IngrediantBagSlot02 -= 1;
        }
        if (Item == 3)
        {
            outputText("snakebane");
            IngrediantBagSlot03 -= 1;
        }
        if (Item == 4)
        {
            outputText("ironweed");
            IngrediantBagSlot04 -= 1;
        }
        if (Item == 5)
        {
            outputText("bladefern");
            IngrediantBagSlot05 -= 1;
        }
        if (Item == 6)
        {
            outputText("ginseng");
            IngrediantBagSlot07 -= 1;
        }
        outputText("into the fertile soil. It should grow back into several or more plants within a few days. Sometime you ponder if you shouldve just became a farmer back home you definitively have a knack for this.");
        var FE : Float = 20 + player.level;
        FE *= player.FarmingMulti();
        player.farmXP(FE);
        doNext(Seed);
    }
    
    private function Harvest() : Void
    {
        hideMenus();
        clearOutput();
        menu();
        outputText("You take a tour of your garden and survey your crops for readied harvests.");
        if (GardenSlot01 == "" && GardenSlot02 == "" && GardenSlot03 == "" && GardenSlot04 == "" && GardenSlot05 == "" && GardenSlot06 == "" && GardenSlot07 == "" && GardenSlot08 == "" && GardenSlot09 == "" && GardenSlot10 == "" && GardenSlot11 == "" && GardenSlot12 == "")
        {
            outputText("\n\n There is no crops left to harvest you will need to plan new seeds.");
        }
        if (GardenSlot01 != "")
        {
            addButton(0, "-01-", Harvest2, GardenSlot01, 1).hint("Harvest your ingredients.");
            if (GardenSlot01Time > 0)
            {
                addButtonDisabled(0, "-01-", "Your crops are still growing.");
            }
        }
        if (GardenSlot02 != "")
        {
            addButton(1, "-02-", Harvest2, GardenSlot02, 2).hint("Harvest your ingredients.");
            if (GardenSlot02Time > 0)
            {
                addButtonDisabled(1, "-02-", "Your crops are still growing.");
            }
        }
        if (GardenSlot03 != "")
        {
            addButton(2, "-03-", Harvest2, GardenSlot03, 3).hint("Harvest your ingredients.");
            if (GardenSlot03Time > 0)
            {
                addButtonDisabled(2, "-03-", "Your crops are still growing.");
            }
        }
        if (GardenSlot04 != "")
        {
            addButton(3, "-04-", Harvest2, GardenSlot04, 4).hint("Harvest your ingredients.");
            if (GardenSlot04Time > 0)
            {
                addButtonDisabled(3, "-04-", "Your crops are still growing.");
            }
        }
        if (GardenSlot05 != "")
        {
            addButton(4, "-05-", Harvest2, GardenSlot05, 5).hint("Harvest your ingredients.");
            if (GardenSlot05Time > 0)
            {
                addButtonDisabled(4, "-05-", "Your crops are still growing.");
            }
        }
        if (GardenSlot06 != "")
        {
            addButton(5, "-06-", Harvest2, GardenSlot06, 6).hint("Harvest your ingredients.");
            if (GardenSlot06Time > 0)
            {
                addButtonDisabled(5, "-06-", "Your crops are still growing.");
            }
        }
        if (GardenSlot07 != "")
        {
            addButton(6, "-07-", Harvest2, GardenSlot07, 7).hint("Harvest your ingredients.");
            if (GardenSlot07Time > 0)
            {
                addButtonDisabled(6, "-07-", "Your crops are still growing.");
            }
        }
        if (GardenSlot08 != "")
        {
            addButton(7, "-08-", Harvest2, GardenSlot08, 8).hint("Harvest your ingredients.");
            if (GardenSlot08Time > 0)
            {
                addButtonDisabled(7, "-08-", "Your crops are still growing.");
            }
        }
        if (GardenSlot09 != "")
        {
            addButton(8, "-09-", Harvest2, GardenSlot09, 9).hint("Harvest your ingredients.");
            if (GardenSlot09Time > 0)
            {
                addButtonDisabled(8, "-09-", "Your crops are still growing.");
            }
        }
        if (GardenSlot10 != "")
        {
            addButton(9, "-10-", Harvest2, GardenSlot10, 10).hint("Harvest your ingredients.");
            if (GardenSlot10Time > 0)
            {
                addButtonDisabled(9, "-10-", "Your crops are still growing.");
            }
        }
        if (GardenSlot11 != "")
        {
            addButton(10, "-11-", Harvest2, GardenSlot11, 11).hint("Harvest your ingredients.");
            if (GardenSlot11Time > 0)
            {
                addButtonDisabled(10, "-11-", "Your crops are still growing.");
            }
        }
        if (GardenSlot12 != "")
        {
            addButton(11, "-12-", Harvest2, GardenSlot12, 12).hint("Harvest your ingredients.");
            if (GardenSlot12Time > 0)
            {
                addButtonDisabled(11, "-12-", "Your crops are still growing.");
            }
        }
        addButton(14, "Back", accessGarden).hint("Go back to garden menu.");
    }
    public function Harvest2(IngredientName : String, plot : Float) : Void
    {
        hideMenus();
        clearOutput();
        if (IngredientName == "healing herb")
        {
            IngrediantBagSlot01 += 5;
            if (IngrediantBagSlot01 > IngrediantBagSlot01Cap)
            {
                IngrediantBagSlot01 -= 5;
                plot = 0;
            }
        }
        if (IngredientName == "moon grass")
        {
            IngrediantBagSlot02 += 5;
            if (IngrediantBagSlot02 > IngrediantBagSlot02Cap)
            {
                IngrediantBagSlot02 -= 5;
                plot = 0;
            }
        }
        if (IngredientName == "snakebane")
        {
            IngrediantBagSlot03 += 5;
            if (IngrediantBagSlot03 > IngrediantBagSlot03Cap)
            {
                IngrediantBagSlot03 -= 5;
                plot = 0;
            }
        }
        if (IngredientName == "ironweed")
        {
            IngrediantBagSlot04 += 5;
            if (IngrediantBagSlot04 > IngrediantBagSlot04Cap)
            {
                IngrediantBagSlot04 -= 5;
                plot = 0;
            }
        }
        if (IngredientName == "bladefern")
        {
            IngrediantBagSlot05 += 5;
            if (IngrediantBagSlot05 > IngrediantBagSlot05Cap)
            {
                IngrediantBagSlot05 -= 5;
                plot = 0;
            }
        }
        if (IngredientName == "ginseng")
        {
            IngrediantBagSlot07 += 5;
            if (IngrediantBagSlot07 > IngrediantBagSlot07Cap)
            {
                IngrediantBagSlot07 -= 5;
                plot = 0;
            }
        }
        switch (plot)
        {
            case 0:
                outputText("<b>You can't store all seeds in bag. Harvest this plot when you have enough space for storing this herb.</b>");
            case 1:
                GardenSlot01 = "";
            case 2:
                GardenSlot02 = "";
            case 3:
                GardenSlot03 = "";
            case 4:
                GardenSlot04 = "";
            case 5:
                GardenSlot05 = "";
            case 6:
                GardenSlot06 = "";
            case 7:
                GardenSlot07 = "";
            case 8:
                GardenSlot08 = "";
            case 9:
                GardenSlot09 = "";
            case 10:
                GardenSlot10 = "";
            case 11:
                GardenSlot11 = "";
            case 12:
                GardenSlot12 = "";
            default:
                outputText("<b>This text should not appear. Please let Ormael/Aimozg know.</b>");
                doNext(playerMenu);
        }
        if (plot > 0)
        {
            outputText("You've collected all of the ingredients.");
            var FE : Float = 20 + player.level;
            FE *= player.FarmingMulti();
            player.farmXP(FE);
        }
        doNext(Harvest);
    }
    
    public function herbalismMenu() : Void
    {
        hideMenus();
        clearOutput();
        menu();
        outputText("You move to Rathazul’s side alchemy equipment. Using these tools you can process raw natural materials into poultices and medicines.\n\nWhat would you like to craft?\n\n");
        outputText("<b><u>Available potions:</u></b>\n");
        if (PotionsBagSlot01Cap > 0)
        {
            outputText("Slot 1 - " + ((PotionsBagSlot01Potion == "") ? "EMPTY" : "" + PotionsBagSlot01Potion + " " + PotionsBagSlot01 + " / " + PotionsBagSlot01Cap + "") + "\n");
        }
        if (PotionsBagSlot02Cap > 0)
        {
            outputText("Slot 2 - " + ((PotionsBagSlot02Potion == "") ? "EMPTY" : "" + PotionsBagSlot02Potion + " " + PotionsBagSlot02 + " / " + PotionsBagSlot02Cap + "") + "\n");
        }
        if (PotionsBagSlot03Cap > 0)
        {
            outputText("Slot 3 - " + ((PotionsBagSlot03Potion == "") ? "EMPTY" : "" + PotionsBagSlot03Potion + " " + PotionsBagSlot03 + " / " + PotionsBagSlot03Cap + "") + "\n");
        }
        if (PotionsBagSlot04Cap > 0)
        {
            outputText("Slot 4 - " + ((PotionsBagSlot04Potion == "") ? "EMPTY" : "" + PotionsBagSlot04Potion + " " + PotionsBagSlot04 + " / " + PotionsBagSlot04Cap + "") + "\n");
        }
        if (PotionsBagSlot05Cap > 0)
        {
            outputText("Slot 5 - " + ((PotionsBagSlot05Potion == "") ? "EMPTY" : "" + PotionsBagSlot05Potion + " " + PotionsBagSlot05 + " / " + PotionsBagSlot05Cap + "") + "\n");
        }
        if (PotionsBagSlot06Cap > 0)
        {
            outputText("Slot 6 - " + ((PotionsBagSlot06Potion == "") ? "EMPTY" : "" + PotionsBagSlot06Potion + " " + PotionsBagSlot06 + " / " + PotionsBagSlot06Cap + "") + "\n");
        }
        //if (PotionsBagSlot07Cap > 0) outputText("Slot 7 - "+(PotionsBagSlot07Potion == "" ? "EMPTY":""+PotionsBagSlot07Potion+" "+PotionsBagSlot07+" / "+PotionsBagSlot07Cap+"")+"\n");
        //if (PotionsBagSlot08Cap > 0) outputText("Slot 8 - "+(PotionsBagSlot08Potion == "" ? "EMPTY":""+PotionsBagSlot08Potion+" "+PotionsBagSlot08+" / "+PotionsBagSlot08Cap+"")+"\n");
        //if (PotionsBagSlot09Cap > 0) outputText("Slot 9 - "+(PotionsBagSlot09Potion == "" ? "EMPTY":""+PotionsBagSlot09Potion+" "+PotionsBagSlot09+" / "+PotionsBagSlot09Cap+"")+"\n");
        //if (PotionsBagSlot10Cap > 0) outputText("Slot 10 - "+(PotionsBagSlot10Potion == "" ? "EMPTY":""+PotionsBagSlot10Potion+" "+PotionsBagSlot10+" / "+PotionsBagSlot10Cap+"")+"\n");
        //Poultice
        addButton(0, "Poultice", HerbalismCraftItem, 1, "healing herb", "Poultice").hint("Craft a Poultice using healing herb.\n\nHealing herbs currently in Ingredient Bag " + IngrediantBagSlot01 + "").disableIf(IngrediantBagSlot01 == 0, "You lack the ingrediants to craft this item.\n\nHealing herbs currently in Ingredient Bag " + IngrediantBagSlot01 + "");
        //Energy drink
        addButton(1, "Energy drink", HerbalismCraftItem, 2, "moon grass", "Energy drink").hint("Craft a Energy drink using moon grass.\n\nMoon grass currently in Ingredient Bag " + IngrediantBagSlot02 + "");
        if (player.herbalismLevel < 2)
        {
            button(1).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 2");
        }
        if (IngrediantBagSlot02 == 0)
        {
            button(1).disable("You lack the ingrediants to craft this item. \n\nMoon grass currently in Ingredient Bag " + IngrediantBagSlot02 + "");
        }
        //Cure
        addButton(2, "Cure", HerbalismCraftItem, 3, "snakebane flower", "Cure").hint("Craft a Cure using snakebane flower.\n\nSnakebane flower currently in Ingredient Bag " + IngrediantBagSlot03 + "");
        if (player.herbalismLevel < 4)
        {
            button(2).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 4");
        }
        if (IngrediantBagSlot03 == 0)
        {
            button(2).disable("You lack the ingrediants to craft this item. \n\nSnakebane flower currently in Ingredient Bag " + IngrediantBagSlot03 + "");
        }
        //Painkiller
        addButton(3, "Painkiller", HerbalismCraftItem, 4, "ironweed", "Painkiller").hint("Craft a Painkiller using ironweed.\n\nIronweed currently in Ingredient Bag " + IngrediantBagSlot04 + "");
        if (player.herbalismLevel < 6)
        {
            button(3).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 6");
        }
        if (IngrediantBagSlot04 == 0)
        {
            button(3).disable("You lack the ingrediants to craft this item. \n\nIronweed currently in Ingredient Bag " + IngrediantBagSlot04 + "");
        }
        //Stimulant
        addButton(4, "Stimulant", HerbalismCraftItem, 5, "blade ferns", "Stimulant").hint("Craft a Stimulant using a handfull of blade ferns.\n\nBlade ferns currently in Ingredient Bag " + IngrediantBagSlot05 + "");
        if (player.herbalismLevel < 8)
        {
            button(4).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 8");
        }
        if (IngrediantBagSlot05 == 0)
        {
            button(4).disable("You lack the ingrediants to craft this item. \n\nBlade ferns currently in Ingredient Bag " + IngrediantBagSlot05 + "");
        }
        //Perfume
        addButton(5, "Perfume", HerbalismCraftItem, 6, "alraune nectar", "Perfume").hint("Craft a Perfume using Alraune nectar.\n\nAlraune nectar currently in Ingredient Bag " + IngrediantBagSlot06 + "");
        if (player.herbalismLevel < 10)
        {
            button(5).disable("You lack the skill to craft this item.\n\nRequire Herbalism level 10");
        }
        if (IngrediantBagSlot06 == 0)
        {
            button(5).disable("You lack the ingrediants to craft this item. \n\nAlraune nectar currently in Ingredient Bag " + IngrediantBagSlot06 + "");
        }
        addButton(14, "Back", camp.campActions);
    }
    private function HerbalismCraftItem(Item : Float, IngrediantName : String, CraftingResult : String) : Void
    {
        clearOutput();
        menu();
        outputText("Refine " + IngrediantName + " into a " + CraftingResult + "?");
        addButton(0, "Craft (x1)", HerbalismCraftItem2, Item, IngrediantName, CraftingResult);
        addButton(1, "Craft (x5)", HerbalismCraftItem3, Item, IngrediantName, CraftingResult);
        addButton(2, "Cancel", herbalismMenu);
    }
    private function HerbalismCraftItem2(Item : Float, IngrediantName : String, CraftingResult : String) : Void
    {
        clearOutput();
        outputText("In which slot you want to store crafted potion?");
        menu();
        addButton(0, "-01-", HerbalismCraftItem2a, Item, 1, CraftingResult).hint("Put crafted potion in first slot of potions bag.").disableIf(PotionsBagSlot01Potion != CraftingResult && PotionsBagSlot01Potion != "", "You already keep different type of the potion in this slot.").disableIf(PotionsBagSlot01 + 1 > PotionsBagSlot01Cap, "You not have left any space to store crafted potion in this potions bag slot.");
        addButton(1, "-02-", HerbalismCraftItem2a, Item, 2, CraftingResult).hint("Put crafted potion in first slot of potions bag.").disableIf(PotionsBagSlot02Potion != CraftingResult && PotionsBagSlot02Potion != "", "You already keep different type of the potion in this slot.").disableIf(PotionsBagSlot02 + 1 > PotionsBagSlot02Cap, "You not have left any space to store crafted potion in this potions bag slot.");
        addButton(2, "-03-", HerbalismCraftItem2a, Item, 3, CraftingResult).hint("Put crafted potion in first slot of potions bag.").disableIf(PotionsBagSlot03Potion != CraftingResult && PotionsBagSlot03Potion != "", "You already keep different type of the potion in this slot.").disableIf(PotionsBagSlot03 + 1 > PotionsBagSlot03Cap, "You not have left any space to store crafted potion in this potions bag slot.");
        addButton(3, "-04-", HerbalismCraftItem2a, Item, 4, CraftingResult).hint("Put crafted potion in first slot of potions bag.").disableIf(PotionsBagSlot04Potion != CraftingResult && PotionsBagSlot04Potion != "", "You already keep different type of the potion in this slot.").disableIf(PotionsBagSlot04 + 1 > PotionsBagSlot04Cap, "You not have left any space to store crafted potion in this potions bag slot.");
        addButton(4, "-05-", HerbalismCraftItem2a, Item, 5, CraftingResult).hint("Put crafted potion in first slot of potions bag.").disableIf(PotionsBagSlot05Potion != CraftingResult && PotionsBagSlot05Potion != "", "You already keep different type of the potion in this slot.").disableIf(PotionsBagSlot05 + 1 > PotionsBagSlot05Cap, "You not have left any space to store crafted potion in this potions bag slot.");
        addButton(5, "-06-", HerbalismCraftItem2a, Item, 6, CraftingResult).hint("Put crafted potion in first slot of potions bag.").disableIf(PotionsBagSlot06Potion != CraftingResult && PotionsBagSlot06Potion != "", "You already keep different type of the potion in this slot.").disableIf(PotionsBagSlot06 + 1 > PotionsBagSlot06Cap, "You not have left any space to store crafted potion in this potions bag slot.");
        addButton(14, "Back", herbalismMenu);
    }
    private function HerbalismCraftItem2a(Item : Float, Item2 : Float, CraftingResult : String) : Void
    {
        var Ingredient : String = "";
        var count : Float = 1;
        switch (Item)
        {
            case 1:
                IngrediantBagSlot01 -= 1;
                Ingredient = "healing herb";
            case 2:
                IngrediantBagSlot02 -= 1;
                Ingredient = "moon grass";
            case 3:
                IngrediantBagSlot03 -= 1;
                Ingredient = "snakebane flower";
            case 4:
                IngrediantBagSlot04 -= 1;
                Ingredient = "ironweed";
            case 5:
                IngrediantBagSlot05 -= 1;
                Ingredient = "blade ferns";
            case 6:
                IngrediantBagSlot06 -= 1;
                Ingredient = "alraune nectar";
            default:
                outputText("<b>This text should not appear. Please let Ormael/Aimozg know.</b>");
                doNext(playerMenu);
        }
        clearOutput();
        outputText("You spend the better part of the next hour refining the " + Ingredient + " into a " + CraftingResult + " adding it to your potion bag.");
        if (player.hasPerk(PerkLib.NaturalHerbalism))
        {
            outputText("Your natural knowledge of herbalism allowed you to craft two additionnal " + CraftingResult + ".");
            count *= 3;
        }
        var HE : Float = 20 + player.level;
        HE *= player.HerbalismMulti();
        player.herbXP(HE);
        HerbalismCraftItem4(Item, Item2, count);
    }
    private function HerbalismCraftItem3(Item : Float, IngrediantName : String, CraftingResult : String) : Void
    {
        clearOutput();
        outputText("In which slot you want to store crafted potion?");
        var amount : Float = 0;
        switch (IngrediantName)
        {
            case "healing herb":
                amount = IngrediantBagSlot01;
            case "moon grass":
                amount = IngrediantBagSlot02;
            case "snakebane flower":
                amount = IngrediantBagSlot03;
            case "ironweed":
                amount = IngrediantBagSlot04;
            case "blade ferns":
                amount = IngrediantBagSlot05;
            case "alraune nectar":
                amount = IngrediantBagSlot06;
            default:
                outputText("<b>This text should not appear. Please let Ormael/Aimozg know.</b>");
                doNext(playerMenu);
        }
        menu();
        if (amount >= 5)
        {
            addButton(0, "-01-", HerbalismCraftItem3a, Item, 1, CraftingResult).hint("Put crafted potions in first slot of potions bag.").disableIf(PotionsBagSlot01Potion != CraftingResult && PotionsBagSlot01Potion != "", "You already keep different type of the potions in this slot.").disableIf(PotionsBagSlot01 + 5 > PotionsBagSlot01Cap, "You not have left any space to store crafted potions in this potions bag slot.");
            addButton(1, "-02-", HerbalismCraftItem3a, Item, 2, CraftingResult).hint("Put crafted potions in second slot of potions bag.").disableIf(PotionsBagSlot02Potion != CraftingResult && PotionsBagSlot02Potion != "", "You already keep different type of the potions in this slot.").disableIf(PotionsBagSlot02 + 5 > PotionsBagSlot02Cap, "You not have left any space to store crafted potions in this potions bag slot.");
            addButton(2, "-03-", HerbalismCraftItem3a, Item, 3, CraftingResult).hint("Put crafted potions in third slot of potions bag.").disableIf(PotionsBagSlot03Potion != CraftingResult && PotionsBagSlot03Potion != "", "You already keep different type of the potions in this slot.").disableIf(PotionsBagSlot03 + 5 > PotionsBagSlot03Cap, "You not have left any space to store crafted potions in this potions bag slot.");
            addButton(3, "-04-", HerbalismCraftItem3a, Item, 4, CraftingResult).hint("Put crafted potions in fourth slot of potions bag.").disableIf(PotionsBagSlot04Potion != CraftingResult && PotionsBagSlot04Potion != "", "You already keep different type of the potions in this slot.").disableIf(PotionsBagSlot04 + 5 > PotionsBagSlot04Cap, "You not have left any space to store crafted potions in this potions bag slot.");
            addButton(4, "-05-", HerbalismCraftItem3a, Item, 5, CraftingResult).hint("Put crafted potions in fifth slot of potions bag.").disableIf(PotionsBagSlot05Potion != CraftingResult && PotionsBagSlot05Potion != "", "You already keep different type of the potions in this slot.").disableIf(PotionsBagSlot05 + 5 > PotionsBagSlot05Cap, "You not have left any space to store crafted potions in this potions bag slot.");
            addButton(5, "-06-", HerbalismCraftItem3a, Item, 6, CraftingResult).hint("Put crafted potions in sixth slot of potions bag.").disableIf(PotionsBagSlot06Potion != CraftingResult && PotionsBagSlot06Potion != "", "You already keep different type of the potions in this slot.").disableIf(PotionsBagSlot06 + 5 > PotionsBagSlot06Cap, "You not have left any space to store crafted potions in this potions bag slot.");
        }
        else
        {
            outputText("\n\n<b>You not have enough ingrediants to make this potions!!!</b>");
        }
        addButton(14, "Back", herbalismMenu);
    }
    private function HerbalismCraftItem3a(Item : Float, Item2 : Float, CraftingResult : String) : Void
    {
        var Ingredient : String = "";
        var count : Float = 5;
        switch (Item)
        {
            case 1:
                IngrediantBagSlot01 -= 5;
                Ingredient = "healing herb";
            case 2:
                IngrediantBagSlot02 -= 5;
                Ingredient = "moon grass";
            case 3:
                IngrediantBagSlot03 -= 5;
                Ingredient = "snakebane flower";
            case 4:
                IngrediantBagSlot04 -= 5;
                Ingredient = "ironweed";
            case 5:
                IngrediantBagSlot05 -= 5;
                Ingredient = "blade ferns";
            case 6:
                IngrediantBagSlot06 -= 5;
                Ingredient = "alraune nectar";
            default:
                outputText("<b>This text should not appear. Please let Ormael/Aimozg know.</b>");
                doNext(playerMenu);
        }
        clearOutput();
        outputText("You spend the better part of the next hour refining the " + Ingredient + " into multiple " + CraftingResult + " adding them to your bag.");
        if (player.hasPerk(PerkLib.NaturalHerbalism))
        {
            outputText("Your natural knowledge of herbalism allowed you to craft thrice as many " + CraftingResult + ".");
            count *= 3;
        }
        var HE : Float = (20 + player.level) * 5;
        HE *= player.HerbalismMulti();
        player.herbXP(HE);
        HerbalismCraftItem4(Item, Item2, count);
    }
    private function HerbalismCraftItem4(Item : Float, Item2 : Float, count : Float) : Void
    {
        var resultName : String = "";
        switch (Item)
        {
            case 1:
                resultName = "Poultice";
            case 2:
                resultName = "Energy drink";
            case 3:
                resultName = "Cure";
            case 4:
                resultName = "Painkiller";
            case 5:
                resultName = "Stimulant";
            case 6:
                resultName = "Perfume";
            default:
                outputText("<b>This text should not appear. Please let Ormael/Aimozg know.</b>");
                doNext(playerMenu);
        }
        if (player.hasPerk(PerkLib.NaturalHerbalism))
        {
            count *= 3;
        }
        switch (Item2)
        {
            case 1:
                PotionsBagSlot01 += count;
                if (PotionsBagSlot01Potion == "")
                {
                    PotionsBagSlot01Potion = resultName;
                }
            case 2:
                PotionsBagSlot02 += count;
                if (PotionsBagSlot02Potion == "")
                {
                    PotionsBagSlot02Potion = resultName;
                }
            case 3:
                PotionsBagSlot03 += count;
                if (PotionsBagSlot03Potion == "")
                {
                    PotionsBagSlot03Potion = resultName;
                }
            case 4:
                PotionsBagSlot04 += count;
                if (PotionsBagSlot04Potion == "")
                {
                    PotionsBagSlot04Potion = resultName;
                }
            case 5:
                PotionsBagSlot05 += count;
                if (PotionsBagSlot05Potion == "")
                {
                    PotionsBagSlot05Potion = resultName;
                }
            case 6:
                PotionsBagSlot06 += count;
                if (PotionsBagSlot06Potion == "")
                {
                    PotionsBagSlot06Potion = resultName;
                }
            default:
                outputText("<b>This text should not appear. Please let Ormael/Aimozg know.</b>");
                doNext(playerMenu);
        }
        doNext(herbalismMenu);
    }
    
    public function justForTestBuildsAdjustingBagsCapacityCuzINotWannaWasteSaveUpdateForThat() : Void
    {
        if ((IngrediantBagSlot01Cap == 3 || PotionsBagSlot01Cap == 3) && player.gems >= 150)
        {
            clearOutput();
            if (IngrediantBagSlot01Cap == 3 && player.gems >= 150)
            {
                outputText("Ingredients Bag Expansion COMPLETED!!!\n\n");
                player.gems -= 150;
                IngrediantBagSlot01Cap = 5;
                IngrediantBagSlot02Cap = 5;
                IngrediantBagSlot03Cap = 5;
                IngrediantBagSlot04Cap = 5;
                IngrediantBagSlot05Cap = 5;
                IngrediantBagSlot06Cap = 5;
            }
            if (PotionsBagSlot01Cap == 3 && player.gems >= 150)
            {
                outputText("Potions Bag Expansion COMPLETED!!!");
                player.gems -= 150;
                PotionsBagSlot01Cap = 5;
                PotionsBagSlot02Cap = 5;
                PotionsBagSlot03Cap = 5;
                PotionsBagSlot04Cap = 5;
                PotionsBagSlot05Cap = 5;
                PotionsBagSlot06Cap = 5;
            }
        }
        doNext(camp.campActions);
    }
    
    public function PotionMenu(page : Int = 1) : Void
    {
        hideMenus();
        hideUpDown();
        clearOutput();
        EngineCore.displayHeader("Potions");
        outputText("<b><u>Available potions:</u></b>\n");
        if (PotionsBagSlot01Cap > 0)
        {
            outputText("Slot 1 - " + ((PotionsBagSlot01Potion == "") ? "EMPTY" : "" + PotionsBagSlot01Potion + " " + PotionsBagSlot01 + " / " + PotionsBagSlot01Cap + "") + "\n");
        }
        if (PotionsBagSlot02Cap > 0)
        {
            outputText("Slot 2 - " + ((PotionsBagSlot02Potion == "") ? "EMPTY" : "" + PotionsBagSlot02Potion + " " + PotionsBagSlot02 + " / " + PotionsBagSlot02Cap + "") + "\n");
        }
        if (PotionsBagSlot03Cap > 0)
        {
            outputText("Slot 3 - " + ((PotionsBagSlot03Potion == "") ? "EMPTY" : "" + PotionsBagSlot03Potion + " " + PotionsBagSlot03 + " / " + PotionsBagSlot03Cap + "") + "\n");
        }
        if (PotionsBagSlot04Cap > 0)
        {
            outputText("Slot 4 - " + ((PotionsBagSlot04Potion == "") ? "EMPTY" : "" + PotionsBagSlot04Potion + " " + PotionsBagSlot04 + " / " + PotionsBagSlot04Cap + "") + "\n");
        }
        if (PotionsBagSlot05Cap > 0)
        {
            outputText("Slot 5 - " + ((PotionsBagSlot05Potion == "") ? "EMPTY" : "" + PotionsBagSlot05Potion + " " + PotionsBagSlot05 + " / " + PotionsBagSlot05Cap + "") + "\n");
        }
        if (PotionsBagSlot06Cap > 0)
        {
            outputText("Slot 6 - " + ((PotionsBagSlot06Potion == "") ? "EMPTY" : "" + PotionsBagSlot06Potion + " " + PotionsBagSlot06 + " / " + PotionsBagSlot06Cap + "") + "\n");
        }
        outputText("\n\nPotion Effects:");
        outputText("\nPoultice - Apply a healing salve to your wounds in order to recover health");
        outputText("\nEnergy drink - Use an energy drink to recover your resources");
        outputText("\nCure - Negate status ailments");
        outputText("\nPainkiller - Greatly reduce damage taken");
        outputText("\nStimulant - Increase physical attack power");
        outputText("\nPerfume - Empower teases through scent components");
        outputText("\n\nWhich item will you use?");
        menu();
        if (PotionsBagSlot01 > 0)
        {
            addButton(0, "" + PotionsBagSlot01Potion + "", PotionMenuUse, PotionsBagSlot01Potion, 1);
        }
        if (PotionsBagSlot02 > 0)
        {
            addButton(1, "" + PotionsBagSlot02Potion + "", PotionMenuUse, PotionsBagSlot02Potion, 2);
        }
        if (PotionsBagSlot03 > 0)
        {
            addButton(2, "" + PotionsBagSlot03Potion + "", PotionMenuUse, PotionsBagSlot03Potion, 3);
        }
        if (PotionsBagSlot04 > 0)
        {
            addButton(3, "" + PotionsBagSlot04Potion + "", PotionMenuUse, PotionsBagSlot04Potion, 4);
        }
        if (PotionsBagSlot05 > 0)
        {
            addButton(4, "" + PotionsBagSlot05Potion + "", PotionMenuUse, PotionsBagSlot05Potion, 5);
        }
        if (PotionsBagSlot06 > 0)
        {
            addButton(5, "" + PotionsBagSlot06Potion + "", PotionMenuUse, PotionsBagSlot06Potion, 6);
        }
        addButton(14, "Back", SceneLib.combat.combatMenu, false);
    }
    
    private function PotionMenuUse(potion : String, slot : Float) : Void
    {
        switch (slot)
        {
            case 1:
                PotionsBagSlot01 -= 1;
                if (PotionsBagSlot01 == 0)
                {
                    PotionsBagSlot01Potion = "";
                }
            case 2:
                PotionsBagSlot02 -= 1;
                if (PotionsBagSlot02 == 0)
                {
                    PotionsBagSlot02Potion = "";
                }
            case 3:
                PotionsBagSlot03 -= 1;
                if (PotionsBagSlot03 == 0)
                {
                    PotionsBagSlot03Potion = "";
                }
            case 4:
                PotionsBagSlot04 -= 1;
                if (PotionsBagSlot04 == 0)
                {
                    PotionsBagSlot04Potion = "";
                }
            case 5:
                PotionsBagSlot05 -= 1;
                if (PotionsBagSlot05 == 0)
                {
                    PotionsBagSlot05Potion = "";
                }
            case 6:
                PotionsBagSlot06 -= 1;
                if (PotionsBagSlot06 == 0)
                {
                    PotionsBagSlot06Potion = "";
                }
            default:
                outputText("<b>This text should not appear. Please let Ormael/Aimozg know.</b>");
        }
        switch (potion)
        {
            case "Poultice":
                SceneLib.combat.Poultice();
            case "Energy drink":
                SceneLib.combat.EnergyDrink();
            case "Cure":
                SceneLib.combat.Cure();
            case "Painkiller":
                SceneLib.combat.Painkiller();
            case "Stimulant":
                SceneLib.combat.Stimulant();
            case "Perfume":
                SceneLib.combat.Perfume();
            default:
                outputText("<b>This text should not appear. Please let Ormael/Aimozg know.</b>");
        }
        doNext(playerMenu);
    }
}

package classes;

import classes.internals.Utils;
import classes.lists.BreastCup;

class BreastStore extends Utils implements SaveAwareInterface
{
    public var cupSize(get, set) : Int;
    public var lactationLevel(get, set) : Int;
    public var nippleLength(get, set) : Float;
    public var rows(get, set) : Int;

    private static inline var MAX_FLAG_VALUE : Int = 2999;
    private static inline var BREAST_STORE_VERSION_1 : String = "1";
    private static var LACTATION_BOOST : Array<Dynamic> = [0, 0, 2, 3, 6, 9, 17];  //Disabled, None, Light, Moderate, Strong, Heavy, Epic  
    
    public static inline var LACTATION_DISABLED : Int = 0;
    public static inline var LACTATION_NONE : Int = 1;  //Full == (>= 50), Overfull == (>= 60 + 5 * _lactationLevel), Overload == (>= 60 + 20 * _lactationLevel)  
    public static inline var LACTATION_LIGHT : Int = 2;  //Full after 25 hours, overfull after 35 hours, overloaded after 50 hours  
    public static inline var LACTATION_MODERATE : Int = 3;  //Full after 17 hours, overfull after 25 hours, overloaded after 40 hours  
    public static inline var LACTATION_STRONG : Int = 4;  //Full after  9 hours, overfull after 15 hours, overloaded after 30 hours  
    public static inline var LACTATION_HEAVY : Int = 5;  //Full after  6 hours, overfull after 12 hours, overloaded after 27 hours  
    public static inline var LACTATION_EPIC : Int = 6;  //Full after  3 hours, overfull after  9 hours, overloaded after 24 hours  
    
    private var _breastFlag : Int;
    private var _cupSize : Int = 0;
    private var _fullness : Int = 0;  //How much milk the breasts currently hold - use milkQuantity to decide how much milk is produced in a scene  
    //The milkIsFull and milkIsOverflowing functions let you know how much the NPC wants to be milked
    private var _lactation : Int = 0;  //How fast the breasts refill with milk  
    private var _nippleLength : Float = 0;
    private var _timesMilked : Int = 0;  //How many times has this NPC been milked - only used internally  
    private var _rows : Int = 0;  //Number of rows of breasts. All assumed to be the same size  
    
    public var preventLactationIncrease : Int = 0;  //Control the points at which the lactation stops increasing or decreasing  
    public var preventLactationDecrease : Int = 0;
    
    public function new(breastFlag : Int)
    {
        super();
        _breastFlag = breastFlag;
        if (_breastFlag < 1 || _breastFlag > MAX_FLAG_VALUE)
        {
            CoC_Settings.error("BreastStore created with invalid flag value. BreastStore(" + breastFlag + ")");
        }
    }
    
    //Implementation of SaveAwareInterface
    public function updateAfterLoad(game : CoC) : Void
    {
        if (_breastFlag < 1 || _breastFlag > MAX_FLAG_VALUE)
        {
            return;
        }
        var flagData : Array<Dynamic> = Std.string(game.flags[_breastFlag]).split("^");
        if (flagData.length < 9)
        
        //Loading from a file that doesn't contain appropriate save data.{
            
            //Values will either have to be assigned in Saves.unFuckSave() or by the first encounter with this NPC
            return;
        }
        //For now there's no need to check the version. If this class is ever updated to save more the version will become useful.
        rows = as3hx.Compat.parseInt(flagData[1]);
        cupSize = as3hx.Compat.parseInt(flagData[2]);
        lactationLevel = as3hx.Compat.parseInt(flagData[3]);
        nippleLength = as3hx.Compat.parseFloat(flagData[4]);
        _fullness = as3hx.Compat.parseInt(flagData[5]);
        _timesMilked = as3hx.Compat.parseInt(flagData[6]);
        preventLactationIncrease = as3hx.Compat.parseInt(flagData[7]);
        preventLactationDecrease = as3hx.Compat.parseInt(flagData[8]);
    }
    
    public function updateBeforeSave(game : CoC) : Void
    {
        if (_breastFlag < 1 || _breastFlag > MAX_FLAG_VALUE)
        {
            return;
        }
        game.flags[_breastFlag] = BREAST_STORE_VERSION_1 + "^" + rows + "^" + cupSize + "^" + lactationLevel + "^" + nippleLength + "^" + _fullness + "^" + _timesMilked + "^" + preventLactationIncrease + "^" + preventLactationDecrease;
    }
    //End of Interface Implementation
    
    public static function breastDescript(size : Int, lactation : Float = 0) : String
    {
        if (size < 1)
        {
            return "flat breasts";
        }
        var descript : String = ((rand(2) == 0) ? Appearance.breastSize(size) : "");  //Add a description of the breast size 50% of the time  
        switch (rand(10))
        {
            case 1:
                if (lactation > 2)
                {
                    return descript + "milk-udders";
                }
            case 2:
                if (lactation > 1.5)
                {
                    descript += "milky ";
                }
                if (size > 4)
                {
                    return descript + "tits";
                }
            case 4, 5, 6:
                return descript + "tits";
            case 7:
                if (lactation >= 2.5)
                {
                    return descript + "udders";
                }
                if (lactation >= 1)
                {
                    descript += "milk ";
                }
                return descript + "jugs";
            case 8:
                if (size > 6)
                {
                    return descript + "love-pillows";
                }
                return descript + "boobs";
            case 9:
                if (size > 6)
                {
                    return descript + "tits";
                }
        }
        return descript + "breasts";
    }
    
    private function get_cupSize() : Int
    {
        return _cupSize;
    }
    
    private function set_cupSize(value : Int) : Int
    {
        if (value < BreastCup.FLAT)
        {
            value = BreastCup.FLAT;
        }
        if (value > BreastCup.ZZZ_LARGE)
        {
            value = BreastCup.ZZZ_LARGE;
        }
        _cupSize = value;
        return value;
    }
    
    private function get_lactationLevel() : Int
    {
        return _lactation;
    }
    
    private function set_lactationLevel(value : Int) : Int
    {
        if (value < LACTATION_DISABLED)
        {
            value = LACTATION_DISABLED;
        }
        if (value > LACTATION_EPIC)
        {
            value = LACTATION_EPIC;
        }
        if (_lactation <= LACTATION_NONE && value >= LACTATION_LIGHT)
        
        //Lactation is just starting - zero the other vars involved{
            
            _fullness = 0;
            _timesMilked = 0;
        }
        _lactation = value;
        return value;
    }
    
    public function advanceTime() : Void
    {
        if (_lactation <= LACTATION_NONE)
        {
            return;
        }
        //Add to breastFullness and possibly adjust lactationLevel. Even when lactationLevel == LACTATION_NONE this is still doing something useful, adjusting _breastTimesMilked
        _fullness += LACTATION_BOOST[_lactation];  //Higher lactation means faster refill  
        if (_fullness > 60 + 20 * LACTATION_BOOST[_lactation])
        
        //100 at LACTATION_LIGHT, 180 at LACTATION_EPIC - fullness over this value is overloaded, lactation may be reduced{
            
            _fullness = 50;  //This way fullness won't immediately hit the limit again  
            if (_timesMilked >= 5)
            {
                _timesMilked -= 5;
            }
            else if (preventLactationDecrease != _lactation)
            {
                _lactation--;
            }
        }
    }
    
    public function adj() : String
    {
        switch (_cupSize)
        {
            case BreastCup.FLAT:return "non-existent";
            case BreastCup.A:return "small";
            case BreastCup.B, BreastCup.C:return "palmable";
            case BreastCup.D, BreastCup.DD, BreastCup.DD_BIG:return "sizeable";
            case BreastCup.E, BreastCup.E_BIG, BreastCup.EE, BreastCup.EE_BIG, BreastCup.F, BreastCup.F_BIG, BreastCup.FF, BreastCup.FF_BIG:return "huge";
            case BreastCup.G, BreastCup.G_BIG, BreastCup.GG, BreastCup.GG_BIG, BreastCup.H, BreastCup.H_BIG, BreastCup.HH, BreastCup.HH_BIG, BreastCup.I, BreastCup.I_BIG, BreastCup.II, BreastCup.II_BIG:return "gigantic";
            case BreastCup.J, BreastCup.J_BIG, BreastCup.JJ, BreastCup.JJ_BIG, BreastCup.K, BreastCup.K_BIG, BreastCup.KK, BreastCup.KK_BIG, BreastCup.L, BreastCup.L_BIG, BreastCup.LL, BreastCup.LL_BIG, BreastCup.M, BreastCup.M_BIG, BreastCup.MM, BreastCup.MM_BIG, BreastCup.MMM, BreastCup.MMM_LARGE:return "mammoth";
            default:
        }
        return ("titanic");
    }
    
    public function canTitFuck() : Bool
    {
        return _cupSize >= BreastCup.C;
    }
    
    public function cup() : String
    {
        return Appearance.breastCup(_cupSize);
    }  //The cup size alone  
    
    public function description(useAdj : Bool = false, isMale : Bool = false) : String
    {
        if (_cupSize == BreastCup.FLAT)
        {
            return "flat" + ((isMale) ? " manly," : "") + " chest";
        }
        return ((useAdj) ? adj() + " " : "") + cup() + " breasts";
    }
    
    public function breastDesc() : String
    {
        return breastDescript(cupSize, 0.5 * lactationLevel);
    }
    
    public function hasBreasts() : Bool
    {
        return _cupSize != BreastCup.FLAT;
    }
    
    public function lactating() : Bool
    {
        return _lactation >= LACTATION_LIGHT;
    }
    
    public function milked() : Bool
    //Returns true if this milking increased the NPC's lactationLevel
    {
        
        _fullness = 0;
        _timesMilked++;
        if (preventLactationIncrease == _lactation)
        {
            return false;
        }
        switch (_lactation)
        {  //With enough milking the lactation level increases  
            case LACTATION_NONE:  //If you suckle enough times the NPC will eventually start producing milk if they're set to LACTATION_NONE  
            if (_timesMilked < 12)
            {
                return false;
            }
            case LACTATION_LIGHT:
                if (_timesMilked < 10)
                {
                    return false;
                }
            case LACTATION_MODERATE:
                if (_timesMilked < 12)
                {
                    return false;
                }
            case LACTATION_HEAVY:
                if (_timesMilked < 15)
                {
                    return false;
                }
            case LACTATION_STRONG:
                if (_timesMilked < 20)
                {
                    return false;
                }
            default:  //No amount of suckling will increase lactation levels for this NPC  
                return false;
        }
        //Only reach this point if the NPC has been milked enough times to justify increasing their milk production
        _timesMilked = 5;
        lactationLevel++;
        return true;
    }
    
    public function milkIsFull() : Bool
    {
        return ((_lactation <= LACTATION_NONE) ? 0 : _fullness >= 50);
    }
    
    public function milkIsOverflowing() : Bool
    {
        return ((_lactation <= LACTATION_NONE) ? 0 : _fullness >= 60 + 5 * LACTATION_BOOST[_lactation]);
    }
    
    //At fullness == 50 the maximum amount of milk is produced. When overfull, lactation level is reduced and fullness drops to 50.
    //So a higher lactationLevel means more milk is produced and the breasts can stay full without drying up for longer. Will always return 0 if not lactating
    public function milkQuantity() : Float
    {
        if (_lactation <= LACTATION_NONE)
        {
            return 0;
        }
        return 0.01 * Math.max(100, 2 * _fullness) * as3hx.Compat.parseFloat(20 * _rows * _cupSize * (_lactation - 1));
    }
    
    public function nippleDescript(tiny : String = "tiny", small : String = "prominent", large : String = "large", huge : String = "elongated", massive : String = "massive") : String
    {
        if (_nippleLength < 3)
        {
            return tiny;
        }
        if (_nippleLength < 10)
        {
            return small;
        }
        if (_nippleLength < 20)
        {
            return large;
        }
        if (_nippleLength < 32)
        {
            return huge;
        }
        return massive;
    }
    
    private function get_nippleLength() : Float
    {
        return _nippleLength;
    }
    
    private function set_nippleLength(value : Float) : Float
    {
        if (value < 0)
        {
            value = 0;
        }
        _nippleLength = 0.1 * Math.round(10 * value);
        return value;
    }
    
    private function get_rows() : Int
    {
        return _rows;
    }
    
    private function set_rows(value : Int) : Int
    {
        if (value < 1)
        {
            value = 1;
        }
        _rows = value;
        return value;
    }
}

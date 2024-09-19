package classes;

import classes.bodyParts.IPhallic;
import classes.CockTypesEnum;
import classes.globalFlags.KFLAGS;
import classes.internals.Utils;

class Cock implements IPhallic
{
    public var host(get, set) : Creature;
    public var cockLength(get, set) : Float;
    public var cockThickness(get, set) : Float;
    public var cockType(get, set) : CockTypesEnum;
    public var knotMultiplier(get, set) : Float;
    public var isPierced(get, set) : Bool;
    public var pShortDesc(get, set) : String;
    public var pLongDesc(get, set) : String;
    public var sock(get, set) : String;
    public var pierced(get, set) : Float;

    private var _cockLength : Float;
    private var _cockThickness : Float;
    private var _cockType : CockTypesEnum;  //See CockTypesEnum.as for all cock types  
    
    //Used to determine thickness of knot relative to normal thickness
    private var _knotMultiplier : Float;
    
    //Piercing info
    private var _isPierced : Bool;
    private var _pierced : Float;
    //Not yet, sweet prince. PiercedType current has no uses. But it will, one day.
    // private var _pierceType:PiercingTypesEnum;
    private var _pShortDesc : String;
    private var _pLongDesc : String;
    
    //Sock
    private var _sock : String;
    private var _host : Creature = null;
    private function get_host() : Creature
    {
        return _host;
    }
    private function set_host(value : Creature) : Creature
    {
        _host = value;
        return value;
    }
    
    /**
		 * @return string description of errors
		 */
    public function validate() : String
    {
        var error : String = "";
        error += Utils.validateNonNegativeNumberFields(this, "Cock.validate", ["cockLength", "cockThickness", "knotMultiplier", "pierced"]);
        if (!_isPierced)
        {
            if (_pShortDesc.length > 0)
            {
                error += "Not pierced but _pShortDesc = " + _pShortDesc + ". ";
            }
            if (_pLongDesc.length > 0)
            {
                error += "Not pierced but pLong = " + _pLongDesc + ". ";
            }
        }
        else
        {
            if (_pShortDesc.length == 0)
            {
                error += "Pierced but no _pShortDesc. ";
            }
            if (_pLongDesc.length == 0)
            {
                error += "Pierced but no pLong. ";
            }
        }
        return error;
    }
    
    //constructor. Default type is HUMAN
    public function new(i_cockLength : Float = 5.5, i_cockThickness : Float = 1, i_cockType : CockTypesEnum = null)
    {
        if (i_cockType == null)
        {
            i_cockType = CockTypesEnum.HUMAN;
        }
        _cockLength = i_cockLength;
        _cockThickness = i_cockThickness;
        _cockType = i_cockType;
        _pierced = 0;
        _knotMultiplier = 1;
        _isPierced = false;
        //_pierceType = PiercingTypesEnum.NONE;
        _pShortDesc = "";
        _pLongDesc = "";
        _sock = "";
    }
    
    //MEMBER FUNCTIONS
    public function cArea() : Float
    {
        return cockThickness * cockLength;
    }
    
    private function cockDR(curLength : Float, lengthDelta : Float, threshold : Float, bigCock : Bool) : Float
    {
        if (lengthDelta > 0)
        
        // growing{
            
            threshold = 24;
            // BigCock Perk increases incoming change by 50% and adds 12 to the length before diminishing returns set in
            if (bigCock)
            {
                lengthDelta *= 1.5;
                threshold *= 1.5;
            }
            // Not a human cock? Multiple the length before dimishing returns set in
            if (cockType != CockTypesEnum.HUMAN)
            {
                threshold *= 2;
            }
            // Modify growth for cock socks
            if (sock == "scarlet")
            {
                lengthDelta *= 1.5;
            }
            else if (sock == "cobalt")
            {
                lengthDelta *= .5;
            }
            // Do diminishing returns
            if (CoC.instance.flags[kFLAGS.HYPER_HAPPY] == null)
            {
                if (curLength > threshold)
                {
                    lengthDelta /= 4;
                }
                else if (curLength > threshold / 2)
                {
                    lengthDelta /= 2;
                }
            }
        }
        else
        {
            if (bigCock)
            {
                lengthDelta *= 0.5;
            }
            // Modify growth for cock socks
            if (sock == "scarlet")
            {
                lengthDelta *= 0.5;
            }
            else if (sock == "cobalt")
            {
                lengthDelta *= 1.5;
            }
        }
        return lengthDelta;
    }
    
    public function growCock(lengthDelta : Float, bigCock : Bool) : Float
    {
        var increase : Float;
        var increaseTotal : Float = 0;
        if (lengthDelta == 0)
        {
            trace("Whoops! growCock called with 0, aborting...");
            return lengthDelta;
        }
        while (lengthDelta != 0)
        {
            increase = (lengthDelta > 0) ? ((lengthDelta < 1) ? lengthDelta : 1) : (lengthDelta > -(1) ? lengthDelta : -1);
            lengthDelta -= increase;
            //apply an inch
            increase = cockDR(cockLength, increase, 24, bigCock);
            cockLength += increase;
            increaseTotal += increase;
        }
        if (cockLength < 2)
        {
            cockLength = 2;
        }
        return increaseTotal;
    }
    
    public function thickenCock(thickDelta : Float, bigCock : Bool) : Float
    {
        var increase : Float;
        var increaseTotal : Float = 0;
        if (thickDelta == 0)
        {
            trace("Whoops! thickenCock called with 0, aborting...");
            return thickDelta;
        }
        while (thickDelta != 0)
        {
            increase = (thickDelta > 0.1) ? ((thickDelta < 0.1) ? thickDelta : 0.1) : (thickDelta > -(0.1) ? thickDelta : -0.1);
            thickDelta -= increase;
            //apply an inch
            increase = cockDR(cockLength, increase, 6, bigCock);
            if (increase > 0)
            {
                if (cockThickness > cockLength * .25)
                {
                    increase /= 2;
                }
                if (cockThickness > cockLength * .33)
                {
                    increase /= 2;
                }
                if (cockThickness > cockLength * .50)
                {
                    increase /= 4;
                }
            }
            else
            {
                if (cockThickness < cockLength * .15)
                {
                    increase /= 2;
                }
                if (cockThickness < cockLength * .1)
                {
                    increase /= 2;
                }
                if (cockThickness < cockLength * .05)
                {
                    increase /= 4;
                }
            }
            cockThickness += increase;
            increaseTotal += increase;
        }
        if (cockThickness < 0.5)
        {
            cockLength = 0.5;
        }
        return increaseTotal;
    }
    
    private function get_cockLength() : Float
    {
        return _cockLength;
    }
    
    private function set_cockLength(value : Float) : Float
    {
        _cockLength = value;
        return value;
    }
    
    private function get_cockThickness() : Float
    {
        return _cockThickness;
    }
    
    private function set_cockThickness(value : Float) : Float
    {
        _cockThickness = value;
        return value;
    }
    
    private function get_cockType() : CockTypesEnum
    {
        return _cockType;
    }
    
    private function set_cockType(value : CockTypesEnum) : CockTypesEnum
    {
        _cockType = value;
        return value;
    }
    
    public function hasKnot() : Bool
    {
        return knotMultiplier > 1;
    }
    
    private function get_knotMultiplier() : Float
    {
        return _knotMultiplier;
    }
    
    private function set_knotMultiplier(value : Float) : Float
    {
        _knotMultiplier = value;
        return value;
    }
    
    private function get_isPierced() : Bool
    {
        return _isPierced;
    }
    
    private function set_isPierced(value : Bool) : Bool
    {
        _isPierced = value;
        return value;
    }
    
    /*
		public function get pierceType():PiercingTypesEnum 
		{
			return _pierceType;
		}
		
		public function set pierceType(value:PiercingTypesEnum):void 
		{
			_pierceType = value;
		}
		*/
    
    //{ region Getter/Setters
    private function get_pShortDesc() : String
    {
        return _pShortDesc;
    }
    
    private function set_pShortDesc(value : String) : String
    {
        _pShortDesc = value;
        return value;
    }
    
    private function get_pLongDesc() : String
    {
        return _pLongDesc;
    }
    
    private function set_pLongDesc(value : String) : String
    {
        _pLongDesc = value;
        return value;
    }
    
    private function get_sock() : String
    {
        return _sock;
    }
    
    private function set_sock(value : String) : String
    {
        _sock = value;
        return value;
    }
    
    private function get_pierced() : Float
    {
        return _pierced;
    }
    
    private function set_pierced(value : Float) : Float
    {
        _pierced = value;
        return value;
    }
}

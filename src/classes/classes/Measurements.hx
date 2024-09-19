package classes;

import classes.globalFlags.KFLAGS;
import classes.internals.Utils;

/**
	 * Class to make the measurement methods taken from PlayerAppearance globally accessible
	 * @since  19.08.2016
	 * @author Stadler76
	 */
class Measurements
{
    public static function footInchOrMetres(inches : Float, precision : Int = 2) : String
    {
        var pHeight : String = "";
        if (CoC.instance.flags[kFLAGS.USE_METRICS] == 1)
        {
            pHeight = (Math.round(inches * 2.54) / Math.pow(10, precision)).toFixed(precision) + " metres";
        }
        else if (CoC.instance.flags[kFLAGS.USE_METRICS] == 0)
        {
            pHeight = Math.floor(inches / 12) + " foot";
            if (inches % 12 > 0)
            {
                pHeight = pHeight + " " + inches % 12 + " inch";
            }
        }
        else
        {
            pHeight = Math.floor(inches / 12) + "\'";
            if (inches % 12 > 0)
            {
                pHeight = pHeight + " " + inches % 12 + "\"";
            }
        }
        return pHeight;
    }
    public static function numInchesOrCentimetres(inches : Float) : String
    {
        if (inches < 1)
        {
            return inchesOrCentimetres(inches);
        }
        var value : Int = Math.round(inches);
        if (CoC.instance.flags[kFLAGS.USE_METRICS] == 1)
        {
            value = Math.round(inches * 2.54);
            return Utils.num2Text(value) + ((value == 1) ? " centimetre" : " centimetres");
        }
        if (inches % 12 == 0)
        {
            return ((inches == 12) ? "a foot" : Utils.num2Text(inches / 12) + " feet");
        }
        return Utils.num2Text(value) + ((value == 1) ? " inch" : " inches");
    }
    public static function inchesOrCentimetres(inches : Float, precision : Int = 1) : String
    {
        var value : Float = Math.round(inchToCm(inches) * Math.pow(10, precision)) / Math.pow(10, precision);
        var text : String = Std.string(value) + ((CoC.instance.flags[kFLAGS.USE_METRICS] == 1) ? " centimetre" : " inch");
        if (value == 1)
        {
            return text;
        }
        return text + ((CoC.instance.flags[kFLAGS.USE_METRICS] == 1) ? "s" : "es");
    }
    public static function shortSuffix(inches : Float, precision : Int = 1) : String
    {
        var value : Float = Math.round(inchToCm(inches) * Math.pow(10, precision)) / Math.pow(10, precision);
        return Std.string(value) + ((CoC.instance.flags[kFLAGS.USE_METRICS] == 1) ? "-cm" : "-inch");
    }
    public static function inchToCm(inches : Float) : Float
    {
        return (CoC.instance.flags[kFLAGS.USE_METRICS] == 1) ? inches * 2.54 : inches;
    }

    public function new()
    {
    }
}


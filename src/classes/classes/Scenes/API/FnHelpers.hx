/**
 * Created by aimozg on 28.03.2017.
 */
package classes.scenes.aPI;

import haxe.Constraints.Function;
import classes.BaseContent;
import classes.CoC;
import classes.globalFlags.KFLAGS;

class FnHelpers extends BaseContent
{
    public static var FN : FnHelpers = new FnHelpers();
    /**
	 * @param chances An array of chances or chance functions
	 * @return A function returning product of chances. If encountered, 0 beats INFINITY
	 */
    public function product(chances : Array<Dynamic>) : Function
    {
        var saved : Array<Dynamic> = chances.concat([]);
        return function() : Float
        {
            var rslt : Float = 1;
            for (i in 0...saved.length)
            {
                var o : Dynamic = Encounters.convertChance(saved[i]);
                if (o <= 0)
                {
                    return 0;
                }
                rslt *= o;
            }
            return rslt;
        };
    }
    
    /**
	 * @param chance Number | Boolean | Function():Number|Boolean
	 * @return Function returning 0 if `chance` is not 0, 1 otherwise
	 */
    public function not(chance : Dynamic) : Function
    {
        return function() : Float
        {
            var c : Dynamic = ((Std.is(chance, Function))) ? chance() : chance;
            return (Encounters.convertChance(c)) ? 0 : 1;
        };
    }
    /**
	 * @param chances Array of [Number | Boolean | Function():Number|Boolean]
	 * @return Function returning 1 iff all chances are not 0, 0 if any is 0
	 */
    public function all(chances : Array<Dynamic> = null) : Function
    {
        return function() : Float
        {
            for (chance in chances)
            {
                var c : Dynamic = chance;
                if (Std.is(c, Function))
                {
                    c = c();
                }
                if (!Encounters.convertChance(c))
                {
                    return 0;
                }
            }
            return 1;
        };
    }
    /**
	 * @param chances Array of [Number | Boolean | Function():Number|Boolean]
	 * @return Function returning 1 iff all chances are 0, 0 if any is 1
	 */
    public function none(chances : Array<Dynamic> = null) : Function
    {
        return function() : Float
        {
            for (chance in chances)
            {
                var c : Dynamic = chance;
                if (Std.is(c, Function))
                {
                    c = c();
                }
                if (Encounters.convertChance(c))
                {
                    return 0;
                }
            }
            return 1;
        };
    }
    /**
	 * @param chances Array of [Number | Boolean | Function():Number|Boolean]
	 * @return Function returning 0 iff all chances are 0, 1 if any is not 0
	 */
    public function any(chances : Array<Dynamic> = null) : Function
    {
        return function() : Float
        {
            for (chance in chances)
            {
                var c : Dynamic = chance;
                if (Std.is(c, Function))
                {
                    c = c();
                }
                if (Encounters.convertChance(c))
                {
                    return 1;
                }
            }
            return 0;
        };
    }
    /**
	 * @return Function returning `iftrue` if player is at least `level` or at least `daysPerLevel`*`level` days have passed, `iffalse` otherwise
	 */
    public function ifLevelMin(level : Int, daysPerLevel : Int = 6, iftrue : Dynamic = 1, iffalse : Dynamic = 0) : Function
    {
        return function() : Dynamic
        {
            return (isLevelMin(level, daysPerLevel)) ? iftrue : iffalse;
        };
    }
    /**
	 * @return Function returning `true` if player is at least `minLevel` or at least `daysPerLevel`*`minLevel` days have passed
	 */
    public static function isLevelMin(minLevel : Int, daysPerLevel : Int = 6) : Bool
    {
        return (CoC.instance.player.level >= minLevel || daysPerLevel > 0 && CoC.instance.time.days >= minLevel * daysPerLevel);
    }
    /**
	 * @return Function returning Number, linearly dependent on player level:
	 * - at levleA: valueA
	 * - at levelB: valueB
	 * - in levelA..levelB: linearly interpolated value
	 * - if bound==true (default), for levels < levelA returns valueA, for levels > levelB returns valueB
	 * - if bound==false, continues the interpolation outside the levelA..levelB interval,
	 * optionally capped between min and max
	 */
    public function lineByLevel(levelA : Int,
            levelB : Int,
            valueA : Float,
            valueB : Float,
            bound : Bool = true,
            min : Float = Math.NEGATIVE_INFINITY,
            max : Float = Math.POSITIVE_INFINITY) : Function
    {
        return function() : Float
        {
            return lerpEx(player.level, levelA, levelB, valueA, valueB, bound, min, max);
        };
    }
    
    /**
	 * A linear interpolation of values xA..xB to yA..yB
	 * - if bound==true (default), for x < xA returns xA, for x > xB returns xB
	 * - if bound==false, continues the interpolation outside the xA..xB interval,
	 * optionally capped between min and max
	 */
    public static function lerpEx(x : Float, xA : Int, xB : Int, yA : Float, yB : Float,
            bound : Bool = true, min : Float = Math.NEGATIVE_INFINITY, max : Float = Math.POSITIVE_INFINITY) : Float
    {
        if (bound)
        {
            if (x <= xA)
            {
                return yA;
            }
            if (x >= xB)
            {
                return yB;
            }
        }
        if (xA == xB)
        {
            return (yA + yB) / 2;
        }
        var y : Float = yA + (x - xA) * (yB - yA) / (xB - xA);
        return Math.min(max, Math.max(min, y));
    }
    
    /**
	 * Solves
	 *   a * ln(x1 - c) + b = y1
	 *   a * ln(x2 - c) + b = y2 = (y3 + y1) / 2
	 *   a * ln(x3 - c) + b = y3
	 * for a,b,c
	 * @return Object{a:Number,b:Number,c:Number}
	 */
    public function buildLogScaleABC(x1 : Float, x2 : Float, x3 : Float, y1 : Float, y3 : Float) : Dynamic
    {
        var dy : Float = (y3 - y1) / 2;
        /*
		 * subtract one equation from another
		 * y3 - y2 = a * ln[(x3 - c) / (x2 - c)]
		 * y2 - y1 = a * ln[(x2 - c) / (x1 - c)]
		 * (x2 - c) / (x1 - c) = (x3 - c) / (x2 - c) = exp(dy / a)
		 * x & c part reduces into c*(2*x2 - x1 - x3) = x2*x2 - x1*x3
		 */
        var c : Float = (x2 * x2 - x1 * x3) / (2 * x2 - x1 - x3);
        var a : Float = dy / Math.log((x2 - c) / (x1 - c));
        var b : Float = y1 - a * Math.log(x1 - c);
        return {
            a : a,
            b : b,
            c : c
        };
    }
    
    /**
	 * @param abc Object{a:Number,b:Number,c:Number}
	 * @return a * ln(x - c) + b, clamped into [min..max]
	 */
    public function logScale(x : Float, abc : Dynamic, min : Float = Math.NEGATIVE_INFINITY, max : Float = Math.POSITIVE_INFINITY) : Float
    {
        var y : Float = abc.a * Math.log(x - abc.c) + abc.b;
        return Math.min(max, Math.max(min, y));
    }
    
    /**
	 * @return Function returning `iftrue` if current time (in hours) is between `minimum` (0-23, INCLUSIVELY) and `maximum` (0-24, EXCLUSIVELY)
	 */
    public function ifTimeOfDay(minimum : Int, maximum : Int, iftrue : Dynamic = 1, iffalse : Dynamic = 0) : Function
    {
        return function() : Dynamic
        {
            var hours : Float = time.hours;
            return ((hours >= minimum && hours < maximum)) ? iftrue : iffalse;
        };
    }
    
    /**
	 * @return Function returning `iftrue` if NG+ level is at least `minimum`, `iffalse` otherwise
	 */
    public function ifNGplusMin(minimum : Int, iftrue : Dynamic = 1, iffalse : Dynamic = 0) : Function
    {
        return function() : Dynamic
        {
            return (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0) ? iftrue : iffalse;
        };
    }
    
    public function new()
    {
        super();
    }
    
    public function ifPregnantWith(pregnancyType : Int, iftrue : Dynamic = 1, iffalse : Dynamic = 0) : Function
    {
        return function() : Dynamic
        {
            return (((player.pregnancyIncubation > 1 && player.pregnancyType == pregnancyType) || (player.pregnancy2Incubation > 1 && player.pregnancy2Type == pregnancyType))) ? iftrue : iffalse;
        };
    }
}


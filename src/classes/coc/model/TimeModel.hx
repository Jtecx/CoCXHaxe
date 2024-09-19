package coc.model;

import classes.CoC;
import classes.DefaultDict;
import classes.globalFlags.KFLAGS;
import classes.StatusEffects;

class TimeModel
{
    public var days(get, set) : Float;
    public var hours(get, set) : Float;
    public var minutes(get, set) : Float;
    public var totalTime(get, never) : Float;
    private static var flags(get, never) : DefaultDict;
    private static var dateReal(get, never) : Date;
    public var date(get, never) : Date;

    private var _days : Float;
    private var _hours : Float;
    private var _minutes : Float;
    
    private function get_days() : Float
    {
        return _days;
    }
    
    private function set_days(value : Float) : Float
    {
        _days = value;
        return value;
    }
    
    private function get_hours() : Float
    {
        return _hours;
    }
    
    private function set_hours(value : Float) : Float
    {
        _hours = value;
        return value;
    }
    
    private function get_minutes() : Float
    {
        return _minutes;
    }
    
    private function set_minutes(value : Float) : Float
    {
        _minutes = value;
        return value;
    }
    
    private function get_totalTime() : Float
    {
        return (this._days * 24 + this._hours);
    }
    
    //===================================================================
    //Date tools
    //IMPORTANT: Date class counts month from 0 to 11.
    private static function get_flags() : DefaultDict
    {
        return CoC.instance.flags;
    }
    
    public static function formatDate(d : Date) : String
    {
        var monthDayYear : Array<Dynamic> = d.toDateString().split(" ").slice(1);
        if (flags[kFLAGS.USE_METRICS] != null)
        {
            return monthDayYear[1] + " " + monthDayYear[0] + " " + monthDayYear[2];
        }
        else
        {
            return monthDayYear[1] + " " + monthDayYear[0] + " " + monthDayYear[2];
        }
    }
    
    private static function get_dateReal() : Date
    {
        return Date.now();
    }
    
    public function useRealDate() : Bool
    {
        return flags[kFLAGS.DAYS_PER_YEAR] <= 0;
    }
    
    //days are counted from 0, date from {1,1,1}
    public static function dateFromDays(gameDays : Int, daysPerYear : Int) : Date
    {
        var day : Int = 1;
        var month : Int = 5;  //starting from June to avoid most events  
        var year : Int = 2010;  //CoC origins!  
        if (daysPerYear != 365)
        
        //easy case{
            
            year += as3hx.Compat.parseInt(gameDays / daysPerYear);
            gameDays %= daysPerYear;
            month += as3hx.Compat.parseInt(gameDays / as3hx.Compat.parseInt(daysPerYear / 12));
            gameDays %= as3hx.Compat.parseInt(daysPerYear / 12);
        }
        //reality fuckery
        else
        {
            
            year += as3hx.Compat.parseInt(as3hx.Compat.parseInt(gameDays / 1461) * 4);  //365*3+366  
            gameDays %= 1461;
            var dpyReal : Array<Dynamic> = [365, 366, 365, 365];  //days per year from the middle of 2010  
            for (i in 0...dpyReal[i])
            {
                gameDays -= dpyReal[i];
                ++year;
            }
            year += as3hx.Compat.parseInt(gameDays / 365);  //leap year will be the last  
            gameDays %= 365;
            var daysPerMonth : Array<Dynamic> = [30, 31, 31, 30, 31, 30, 31,   /*OVERFLOW - next year*/  31, ((year + 1) % 4 == 0) ? 29 : 28, 31, 30, 31];
            while (gameDays >= daysPerMonth[month - 5])
            {
                gameDays -= daysPerMonth[month++ - 5];
            }
        }
        if (month >= 12)
        
        //fix overflow{
            
            ++year;
            month -= 12;
        }
        day += gameDays;
        return new Date(year, month, day);
    }
    
    public static function daysFromDate(dateObj : Date, daysPerYear : Int) : Int
    {
        var gameDays : Int = 0;
        var day : Int = dateObj.date;
        var dayOffset : Int = as3hx.Compat.parseInt(day - 1);
        var month : Int = (dateObj.month < 5) ? dateObj.month + 12 : dateObj.month;
        var monthOffset : Int = as3hx.Compat.parseInt(month - 5);
        var year : Int = (dateObj.month < 5) ? dateObj.fullYear - 1 : dateObj.fullYear;
        var yearOffset : Int = as3hx.Compat.parseInt(year - 2010);
        if (daysPerYear != 365)
        
        //easy case{
            
            gameDays += as3hx.Compat.parseInt(yearOffset * daysPerYear);
            gameDays += as3hx.Compat.parseInt(monthOffset * as3hx.Compat.parseInt(daysPerYear / 12));
        }
        //reality fuckery
        else
        {
            
            gameDays += as3hx.Compat.parseInt(as3hx.Compat.parseInt(yearOffset / 4) * 1461);
            var dpyReal : Array<Dynamic> = [365, 366, 365, 365];  //days per year from the middle of 2010  
            for (i in 0...yearOffset % 4)
            {
                gameDays += dpyReal[i];
            }
            var daysPerMonth : Array<Dynamic> = [30, 31, 31, 30, 31, 30, 31,   /*OVERFLOW - next year*/  31, (year % 4 == 0) ? 29 : 28, 31, 30, 31];
            while (monthOffset > 0)
            {
                gameDays += daysPerMonth[--monthOffset];
            }
        }
        gameDays += dayOffset;
        return gameDays;
    }
    
    private function get_date() : Date
    {
        return (useRealDate()) ? dateReal : 
        dateFromDays(CoC.instance.model.time.days + flags[kFLAGS.DATE_OFFSET], flags[kFLAGS.DAYS_PER_YEAR]);
    }
    
    //Change daysPerYear - and recalculate offset to keep the date as close as possible to original one.
    public function changeDPY(newDPY : Int) : Void
    {
        if (flags[kFLAGS.DAYS_PER_YEAR] == newDPY)
        {
            return;
        }
        var curDate : Date = date;  //calculate the date using the current DPY and offset  
        if (newDPY <= 0)
        
        //real date - reset the offset and fix stored year values{
            
            var yearOffset : Int = as3hx.Compat.parseInt(dateReal.fullYear - curDate.fullYear);
            var flagsToFix : Array<Dynamic> = [
            kFLAGS.CANDY_CANE_YEAR_MET, 
            kFLAGS.FERAS_GLADE_EXPLORED_YEAR, 
            kFLAGS.FERAS_TRAP_SPRUNG_YEAR, 
            kFLAGS.JACK_FROST_YEAR, 
            kFLAGS.LAST_EASTER_YEAR, 
            kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE, 
            kFLAGS.POLAR_PETE_YEAR_MET, 
            kFLAGS.PUMPKIN_FUCK_YEAR_DONE, 
            kFLAGS.TREACLE_MINE_YEAR_DONE, 
            kFLAGS.TURKEY_FUCK_YEAR_DONE, 
            kFLAGS.VALENTINES_EVENT_YEAR, 
            kFLAGS.XMAS_CHICKEN_YEAR, 
            kFLAGS.HELIA_BIRTHDAY_LAST_YEAR
        ];
            for (flagID in flagsToFix)
            {
                if (Reflect.field(flags, Std.string(flagID)) != 0)
                {
                    Reflect.field(flags, Std.string(flagID)) += yearOffset;
                }
            }
            //Rathazul status too!
            if (CoC.instance.player.hasStatusEffect(StatusEffects.RathazulAprilFool))
            {
                CoC.instance.player.changeStatusValue(StatusEffects.RathazulAprilFool, 1, 
                        CoC.instance.player.statusEffectv1(StatusEffects.RathazulAprilFool) + yearOffset
            );
            }
            flags[kFLAGS.DATE_OFFSET] = 0;
        }
        else
        {
            var gameDays : Int = CoC.instance.model.time.days;  //current days counter  
            var dpm365 : Array<Dynamic> = [31, (curDate.fullYear % 4 == 0) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            var dpmOld : Int = ((flags[kFLAGS.DAYS_PER_YEAR] == 0 || flags[kFLAGS.DAYS_PER_YEAR] == 365)) ? dpm365[date.month] : flags[kFLAGS.DAYS_PER_YEAR] / 12;
            var dpmNew : Int = ((newDPY == 365)) ? dpm365[date.month] : newDPY / 12;
            curDate.setDate(as3hx.Compat.parseInt(curDate.date * dpmNew / dpmOld));  //correct the day of month to the new scale  
            var newDays : Int = daysFromDate(curDate, newDPY);  //calculate the 'new' days value for this date.  
            flags[kFLAGS.DATE_OFFSET] = newDays - gameDays;
        }
        flags[kFLAGS.DAYS_PER_YEAR] = newDPY;
    }

    public function new()
    {
    }
}

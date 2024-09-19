package classes.statusEffects;

import classes.StatusEffectClass;
import classes.StatusEffectType;
import classes.internals.LoggerFactory;
import mx.logging.ILogger;

/**
 * Common superclass for temporary stat [de]buffs with complete recovery after time.
 *
 * Implementation details:
 * 1. Subclass. Pass affected stat names (dynStat keys like 'str','spe','tou','int','lib','sen') as superclass
 *    constructor args.
 * 2. Override apply() with a call to buffHost to buff host and remember effect
 * 3. To apply buff, add it to host; call increase() on already existing buff to increase it effect
 *
 * Using host.dynStats instead of buffHost makes the effect permanent
 */
class TemporaryBuff extends StatusEffectClass
{
    public var stat1(get, never) : String;
    public var stat2(get, never) : String;
    public var stat3(get, never) : String;
    public var stat4(get, never) : String;

    private static var LOGGER : ILogger = LoggerFactory.getLogger(TemporaryBuff);
    private var _stat1 : String;
    private var _stat2 : String;
    private var _stat3 : String;
    private var _stat4 : String;
    public function new(stype : StatusEffectType, stat1 : String, stat2 : String = "", stat3 : String = "", stat4 : String = "")
    {
        super(stype);
        this._stat1 = stat1;
        this._stat2 = stat2;
        this._stat3 = stat3;
        this._stat4 = stat4;
    }
    
    private function get_stat1() : String
    {
        return _stat1;
    }
    private function get_stat2() : String
    {
        return _stat2;
    }
    private function get_stat3() : String
    {
        return _stat3;
    }
    private function get_stat4() : String
    {
        return _stat4;
    }
    /**
	 * This function does a host.dynStats(...args) and stores the buff in status effect values
	 */
    private function buffHost(args : Array<Dynamic> = null) : Dynamic
    {
        var buff : Dynamic = host.dynStats.apply(host, args);
        if (_stat1 != null)
        {
            value1 += Reflect.field(buff, _stat1);
        }
        if (_stat2 != null)
        {
            value2 += Reflect.field(buff, _stat2);
        }
        if (_stat3 != null)
        {
            value3 += Reflect.field(buff, _stat3);
        }
        if (_stat4 != null)
        {
            value4 += Reflect.field(buff, _stat4);
        }
        LOGGER.debug("buffHost(" + args.join(",") + "): " +
                _stat1 + ((_stat1 != null) ? Reflect.field(buff, _stat1) : "") +
                _stat2 + ((_stat2 != null) ? Reflect.field(buff, _stat2) : "") +
                _stat3 + ((_stat3 != null) ? Reflect.field(buff, _stat3) : "") +
                _stat4 + ((_stat4 != null) ? Reflect.field(buff, _stat4) : "") +
                "->(" + value1 + ", " + value2 + ", " + value3 + ", " + value4 + ")");
        return buff;
    }
    private function restore() : Void
    {
        var dsargs : Array<Dynamic> = ["scale", false];
        if (_stat1 != null)
        {
            dsargs.push(_stat1);
            dsargs.push(-value1);
            
        }
        if (_stat2 != null)
        {
            dsargs.push(_stat2);
            dsargs.push(-value2);
            
        }
        if (_stat3 != null)
        {
            dsargs.push(_stat3);
            dsargs.push(-value3);
            
        }
        if (_stat4 != null)
        {
            dsargs.push(_stat4);
            dsargs.push(-value4);
            
        }
        var debuff : Dynamic = host.dynStats.apply(host, dsargs);
        if (_stat1 != null)
        {
            value1 += Reflect.field(debuff, _stat1);
        }
        if (_stat2 != null)
        {
            value2 += Reflect.field(debuff, _stat2);
        }
        if (_stat3 != null)
        {
            value3 += Reflect.field(debuff, _stat3);
        }
        if (_stat4 != null)
        {
            value4 += Reflect.field(debuff, _stat4);
        }
        LOGGER.debug("restore(" + dsargs.join(",") + "): " +
                _stat1 + " " + ((_stat1 != null) ? Reflect.field(debuff, _stat1) : "") + " " +
                _stat2 + " " + ((_stat2 != null) ? Reflect.field(debuff, _stat2) : "") + " " +
                _stat3 + " " + ((_stat3 != null) ? Reflect.field(debuff, _stat3) : "") + " " +
                _stat4 + " " + ((_stat4 != null) ? Reflect.field(debuff, _stat4) : "") + " " +
                "->(" + value1 + ", " + value2 + ", " + value3 + ", " + value4 + ")");
    }
    public function buffValue(stat : String) : Float
    {
        switch (stat)
        {
            case _stat1:return value1;
            case _stat2:return value2;
            case _stat3:return value3;
            case _stat4:return value4;
            default:return 0;
        }
    }
    override public function onRemove() : Void
    {
        super.onRemove();
        restore();
    }
}


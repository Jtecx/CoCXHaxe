package coc.view;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.internals.Utils;
import flash.display.DisplayObject;
import flash.sampler.StopSampling;
import mx.effects.Tween;
import mx.effects.easing.Exponential;

class SimpleTween
{
    public var startVal(get, never) : Dynamic;
    public var endVal(get, never) : Dynamic;

    public static var KnownEasings : Dynamic = {
            in : Exponential.easeIn,
            easeIn : Exponential.easeIn,
            out : Exponential.easeOut,
            easeOut : Exponential.easeOut,
            in-out : Exponential.easeInOut,
            easeInOut : Exponential.easeInOut,
            none : easingLinear,
            linear : easingLinear
        }  /**
         * Animate a property `prop` of sprite `spr` from its current value to `endVal`.
         * @param spr
         * @param prop
         * @param endVal
         * @param ms Animation duration in milliseconds
         * @param {Object} [options] Extra options
         * @param {int} [options.ms] Animation time, milliseconds (default 300)
         * @param {Function} [options.onEnd] Function to call on animation end
         * @param {Function} [options.easing] Easing function, default mx.effects.easing.Expontential.easeInOut
         * @param {Boolean} [options.color] The values are colors
         */  ;
    
    
    
    public function new(spr : DisplayObject, prop : String, endVal : Dynamic, ms : Int = 300, options : Dynamic = null)
    {
        this._spr = spr;
        this._prop = prop;
        this._startVal = _spr[_prop];
        this._endVal = endVal;
        this._duration = ms;
        this._onEnd = Utils.valueOr(options && options.onEnd, null);
        this._color = Utils.valueOr(options && options.color, false);
        var easingSpec : Dynamic = options && options.easing;
        if (easingSpec != null && Std.is(easingSpec, String))
        {
            easingSpec = Reflect.field(KnownEasings, Std.string(easingSpec));
        }
        this._easingFn = Utils.valueOr(easingSpec, Exponential.easeInOut);
        //        trace("SimpleTween",spr.name,prop,'from',_startVal,"to",_endVal,"/",_duration)
        
        _active = true;
        _tween = new Tween(this, _startVal, endVal, ms);
        if (_color)
        {
            _startVal = Color.getFloatComponents(Color.convertColor32(_startVal));
            _endVal = Color.getFloatComponents(Color.convertColor32(_endVal));
            _tween.easingFunction = colorEasingFn;
        }
        else
        {
            _tween.easingFunction = numberEasingFn;
        }
    }
    private function numberEasingFn(time : Float, start : Float, delta : Float, duration : Float) : Dynamic
    {
        return _easingFn(time, _startVal, _endVal - _startVal, duration);
    }
    private function colorEasingFn(time : Float, start : Dynamic, delta : Dynamic, duration : Float) : Dynamic
    {
        return Color.toHex(Color.interpolate(_startVal, _endVal, _easingFn(time, 0, 1, duration)));
    }
    public static function easingLinear(time : Float, start : Float, delta : Float, duration : Float) : Float
    {
        return Utils.lerp(start, start + delta, time / duration);
    }
    
    private var _spr : DisplayObject;
    private var _prop : String;
    private var _startVal : Dynamic;
    private var _endVal : Dynamic;
    private var _duration : Int;
    private var _easingFn : Function;
    private var _onEnd : Function;
    private var _tween : Tween;
    private var _active : Bool;
    private var _color : Bool;
    
    
    private function get_startVal() : Dynamic
    {
        return _startVal;
    }
    private function get_endVal() : Dynamic
    {
        return _endVal;
    }
    /**
     * Stop this tween and start a new one, to a new end value
     */
    public function retarget(newEndVal : Dynamic) : SimpleTween
    {
        dispose();
        return new SimpleTween(_spr, _prop, newEndVal, _duration, {
            onEnd : _onEnd,
            color : _color,
            easing : _easingFn
        });
    }
    
    // This function is called by the tween every tick
    public function onTweenUpdate(val : Dynamic) : Void
    {
        this._spr[_prop] = val;
    }
    
    // This function is called by the tween after it ends
    public function onTweenEnd(val : Dynamic) : Void
    {
        try
        {
            onTweenUpdate(val);
            _active = false;
            
            if (_onEnd != null)
            {
                _onEnd();
            }
        }
        catch (e : Error)
        {
            trace(e.getStackTrace());
        }
    }
    
    public function then(callback : Function) : Void
    {
        if (!_active)
        {
            callback();
            return;
        }
        if (_onEnd != null)
        {
            var oldOnEnd : Function = _onEnd;
            _onEnd = function() : Void
                    {
                        oldOnEnd();
                        callback();
                    };
        }
        else
        {
            _onEnd = callback;
        }
    }
    
    public function dispose() : Void
    {
        if (_active && _tween != null)
        {
            _tween.stop();
        }
        _active = false;
        _tween = null;
    }
    public function fastForward() : Void
    {
        if (_active && _tween != null)
        {
            _tween.endTween();
        }
        _tween = null;
    }
}



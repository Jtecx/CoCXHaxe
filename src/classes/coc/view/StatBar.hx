/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view;

import classes.internals.Utils;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextLineMetrics;

class StatBar extends Block
{
    private var arrowSz(get, never) : Float;
    public var minValue(get, set) : Float;
    public var maxValue(get, set) : Float;
    public var rawValue(get, set) : Float;
    public var value(get, set) : Float;
    public var animate(get, set) : Bool;
    public var valueText(get, set) : String;
    public var showMax(get, set) : Bool;
    public var isUp(get, set) : Bool;
    public var isDown(get, set) : Bool;
    public var statName(get, set) : String;
    public var nameColor(never, set) : Dynamic;
    public var bar(get, never) : BitmapDataSprite;
    public var minBar(get, never) : BitmapDataSprite;
    public var nameLabel(get, never) : TextField;
    public var valueLabel(get, never) : TextField;
    public var arrowUp(get, never) : BitmapDataSprite;
    public var arrowDown(get, never) : BitmapDataSprite;
    public var percentage(get, set) : Bool;

    @:meta(Embed(source="../../../res/ui/StatsBarBottom.png"))

    public static var StatsBarBottom : Class<Dynamic>;
    @:meta(Embed(source="../../../res/ui/arrow-up.png"))

    public static var ArrowUp : Class<Dynamic>;
    @:meta(Embed(source="../../../res/ui/arrow-down.png"))

    public static var ArrowDown : Class<Dynamic>;
    
    private static function factoryReset() : Dynamic
    {
        return {
            width : 200,
            height : 28,
            minValue : 0,
            maxValue : 100,
            rawValue : 0,
            animate : true,
            statName : "",
            showMax : false,
            isUp : false,
            isDown : false,
            hasGauge : true,
            hasBar : true,
            hasMinBar : false,
            barAlpha : 0.4,
            barHeight : 1.0,
            barColor : "#0000ff",
            minBarColor : "#8080ff",
            bgColor : null,
            percentage : false
        };
    }
    private static var DEFAULT_OPTIONS : Dynamic = factoryReset();
    public static function setDefaultOptions(options : Dynamic) : Void
    {
        Utils.extend(DEFAULT_OPTIONS, options);
    }
    public static function resetDefaultOptions() : Void
    {
        DEFAULT_OPTIONS = factoryReset();
    }
    
    private var _bar : BitmapDataSprite;
    private var _minBar : BitmapDataSprite;
    private var _bgBar : BitmapDataSprite;
    private var _arrowUp : BitmapDataSprite;
    private var _arrowDown : BitmapDataSprite;
    private var _nameLabel : TextField;
    private var _valueLabel : TextField;
    private var _minValue : Float;
    private var _maxValue : Float;
    private var _value : Float;
    private var _showMax : Bool;
    private var _tween : SimpleTween;
    private var _animate : Bool;
    private var _percentage : Bool;
    
    private function get_arrowSz() : Float
    {
        return this.height - 2;
    }
    
    public function new(options : Dynamic)
    {
        super();
        options = Utils.extend({ }, DEFAULT_OPTIONS, options);
        var myWidth : Float = options.width;
        var myHeight : Float = options.height;
        var arrowSz : Float = myHeight - 2;
        var barWidth : Float = myWidth - arrowSz - 2;
        if (options.hasBar)
        {
            var barX : Float = 1;
            var barHeight : Float = myHeight * options.barHeight;
            var barY : Float = myHeight - barHeight;
            if (options.bgColor != null)
            {
                _bgBar = addBitmapDataSprite({
                                    x : barX,
                                    y : barY,
                                    alpha : options.barAlpha,
                                    fillColor : options.bgColor,
                                    width : barWidth,
                                    height : barHeight
                                });
            }
            _bar = addBitmapDataSprite({
                                x : barX,
                                y : barY,
                                alpha : options.barAlpha,
                                fillColor : options.barColor,
                                width : 0,
                                height : barHeight
                            });
            if (options.hasMinBar)
            {
                _minBar = addBitmapDataSprite({
                                    x : barX,
                                    y : barY,
                                    alpha : options.barAlpha,
                                    fillColor : options.minBarColor,
                                    width : 0,
                                    height : barHeight
                                });
            }
            if (options.hasGauge)
            
            /*gauge=*/{
                
                addBitmapDataSprite({
                            x : 0,
                            y : myHeight - 10,
                            width : barWidth + 2,
                            height : 10,
                            stretch : true,
                            bitmapClass : StatsBarBottom
                        });
            }
        }
        _nameLabel = addTextField({
                            x : 6,
                            y : 4,
                            width : barWidth,
                            height : myHeight - 4,
                            defaultTextFormat : {
                                font : "Georgia",
                                size : 15
                            }
                        });
        _valueLabel = addTextField({
                            x : 0,
                            y : myHeight - 30,
                            width : barWidth,
                            height : 30,
                            defaultTextFormat : {
                                font : "Georgia",
                                size : 20,
                                align : "right"
                            }
                        });
        _arrowUp = addBitmapDataSprite({
                            bitmapClass : ArrowUp,
                            width : arrowSz,
                            height : arrowSz,
                            stretch : true,
                            x : myWidth - arrowSz - 1,
                            y : 1,
                            visible : false
                        });
        _arrowDown = addBitmapDataSprite({
                            bitmapClass : ArrowDown,
                            width : arrowSz,
                            height : arrowSz,
                            stretch : true,
                            x : myWidth - arrowSz - 1,
                            y : 1,
                            visible : false
                        });
        UIUtils.setProperties(this, options);
        update();
    }
    
    private function get_minValue() : Float
    {
        return _minValue;
    }
    private function set_minValue(value : Float) : Float
    {
        _minValue = value;
        update();
        return value;
    }
    private function get_maxValue() : Float
    {
        return _maxValue;
    }
    private function set_maxValue(value : Float) : Float
    {
        _maxValue = value;
        if (showMax)
        {
            renderValue();
        }
        update();
        return value;
    }
    private function renderValue() : Void
    {
        if (percentage)
        {
            var pValue : Float = (value / maxValue) * 100;
            var valueStr : String = as3hx.Compat.toFixed(pValue, 1);
            valueText = "" + valueStr + "%";
        }
        else
        {
            var bValue : String = Std.string(Math.floor(value));
            var mValue : String = Std.string(Math.floor(maxValue));
            if (value > 1000000)
            {
                bValue = value.toPrecision(3);
            }
            if (maxValue > 1000000)
            {
                mValue = maxValue.toPrecision(3);
            }
            valueText = "" + bValue + ((showMax) ? "/" + mValue : "");
        }
    }
    private function get_rawValue() : Float
    {
        return _value;
    }
    private function set_rawValue(value : Float) : Float
    {
        _value = value;
        renderValue();
        update();
        return value;
    }
    private function get_value() : Float
    {
        return _value;
    }
    private function set_value(value : Float) : Float
    {
        if (_animate)
        {
            if (_tween != null && _tween.endVal != value)
            
            // animating{
                
                _tween = _tween.retarget(value);
            }
            else if (_value != value)
            
            // not animating{
                
                _tween = new SimpleTween(this, "rawValue", value, 300, {
                            easing : "linear"
                        });
            }
        }
        else
        {
            rawValue = value;
        }
        return value;
    }
    private function get_animate() : Bool
    {
        return _animate;
    }
    private function set_animate(value : Bool) : Bool
    {
        _animate = value;
        if (!value && _tween != null)
        {
            _tween.fastForward();
            _tween = null;
        }
        return value;
    }
    private function get_valueText() : String
    {
        return (_valueLabel != null) ? _valueLabel.text : value + "";
    }
    private function set_valueText(value : String) : String
    {
        if (_valueLabel != null)
        {
            _valueLabel.text = value;
        }
        return value;
    }
    public function update() : Void
    {
        if (_bar != null)
        {
            _bar.width = (maxValue > 0) ? 
                    Utils.boundFloat(0, value, maxValue) * (width - arrowSz - 2) / maxValue : 0;
        }
        if (_minBar != null)
        {
            _minBar.width = (maxValue > 0) ? 
                    Utils.boundFloat(0, minValue, maxValue) * (width - arrowSz - 2) / maxValue : 0;
        }
    }
    private function get_showMax() : Bool
    {
        return _showMax;
    }
    private function set_showMax(value : Bool) : Bool
    {
        _showMax = value;
        renderValue();
        return value;
    }
    private function get_isUp() : Bool
    {
        return _arrowUp.visible;
    }
    private function set_isUp(value : Bool) : Bool
    {
        _arrowUp.visible = value;
        if (value)
        {
            _arrowDown.visible = false;
        }
        return value;
    }
    private function get_isDown() : Bool
    {
        return _arrowDown.visible;
    }
    private function set_isDown(value : Bool) : Bool
    {
        _arrowDown.visible = value;
        if (value)
        {
            _arrowUp.visible = false;
        }
        return value;
    }
    private function get_statName() : String
    {
        return _nameLabel.text;
    }
    private function set_statName(value : String) : String
    {
        _nameLabel.text = value;
        return value;
    }
    private function set_nameColor(value : Dynamic) : Dynamic
    {
        var tf : TextFormat = _nameLabel.defaultTextFormat;
        tf.color = Color.convertColor(value);
        _nameLabel.defaultTextFormat = tf;
        _nameLabel.setTextFormat(tf);
        return value;
    }
    
    private function get_bar() : BitmapDataSprite
    {
        return _bar;
    }
    private function get_minBar() : BitmapDataSprite
    {
        return _minBar;
    }
    private function get_nameLabel() : TextField
    {
        return _nameLabel;
    }
    private function get_valueLabel() : TextField
    {
        return _valueLabel;
    }
    private function get_arrowUp() : BitmapDataSprite
    {
        return _arrowUp;
    }
    private function get_arrowDown() : BitmapDataSprite
    {
        return _arrowDown;
    }
    
    private function get_percentage() : Bool
    {
        return _percentage;
    }
    
    private function set_percentage(value : Bool) : Bool
    {
        _percentage = value;
        renderValue();
        return value;
    }
}


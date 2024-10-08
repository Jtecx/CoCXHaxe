/**
 * Slider.as
 * Keith Peters
 * version 0.9.10
 * 
 * Abstract base slider class for HSlider and VSlider.
 * 
 * Copyright (c) 2011 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.bit101.components;

import haxe.Constraints.Function;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

@:meta(Event(name="change",type="flash.events.Event"))

class Slider extends Component
{
    public var backClick(get, set) : Bool;
    public var value(get, set) : Float;
    public var rawValue(get, never) : Float;
    public var maximum(get, set) : Float;
    public var minimum(get, set) : Float;
    public var tick(get, set) : Float;

    private var _handle : Sprite;
    private var _back : Sprite;
    private var _backClick : Bool = true;
    private var _value : Float = 0;
    private var _max : Float = 100;
    private var _min : Float = 0;
    private var _orientation : String;
    private var _tick : Float = 0.01;
    
    public static inline var HORIZONTAL : String = "horizontal";
    public static inline var VERTICAL : String = "vertical";
    
    /**
		 * Constructor
		 * @param orientation Whether the slider will be horizontal or vertical.
		 * @param parent The parent DisplayObjectContainer on which to add this Slider.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
    public function new(orientation : String = Slider.HORIZONTAL, parent : DisplayObjectContainer = null, xpos : Float = 0, ypos : Float = 0, defaultHandler : Function = null)
    {
        _orientation = orientation;
        super(parent, xpos, ypos);
        if (defaultHandler != null)
        {
            addEventListener(Event.CHANGE, defaultHandler);
        }
    }
    
    /**
		 * Initializes the component.
		 */
    override private function init() : Void
    {
        super.init();
        
        if (_orientation == HORIZONTAL)
        {
            setSize(100, 10);
        }
        else
        {
            setSize(10, 100);
        }
    }
    
    /**
		 * Creates and adds the child display objects of this component.
		 */
    override private function addChildren() : Void
    {
        _back = new Sprite();
        _back.filters = [getShadow(2, true)];
        addChild(_back);
        
        _handle = new Sprite();
        _handle.filters = [getShadow(1)];
        _handle.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
        _handle.buttonMode = true;
        _handle.useHandCursor = true;
        addChild(_handle);
    }
    
    /**
		 * Draws the back of the slider.
		 */
    private function drawBack() : Void
    {
        _back.graphics.clear();
        _back.graphics.beginFill(Style.BACKGROUND);
        _back.graphics.drawRect(0, 0, _width, _height);
        _back.graphics.endFill();
        
        if (_backClick)
        {
            _back.addEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
        }
        else
        {
            _back.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
        }
    }
    
    /**
		 * Draws the handle of the slider.
		 */
    private function drawHandle() : Void
    {
        _handle.graphics.clear();
        _handle.graphics.beginFill(Style.BUTTON_FACE);
        if (_orientation == HORIZONTAL)
        {
            _handle.graphics.drawRect(1, 1, _height - 2, _height - 2);
        }
        else
        {
            _handle.graphics.drawRect(1, 1, _width - 2, _width - 2);
        }
        _handle.graphics.endFill();
        positionHandle();
    }
    
    /**
		 * Adjusts value to be within minimum and maximum.
		 */
    private function correctValue() : Void
    {
        if (_max > _min)
        {
            _value = Math.min(_value, _max);
            _value = Math.max(_value, _min);
        }
        else
        {
            _value = Math.max(_value, _max);
            _value = Math.min(_value, _min);
        }
    }
    
    /**
		 * Adjusts position of handle when value, maximum or minimum have changed.
		 * TODO: Should also be called when slider is resized.
		 */
    private function positionHandle() : Void
    {
        var range : Float;
        if (_orientation == HORIZONTAL)
        {
            range = _width - _height;
            _handle.x = (_value - _min) / (_max - _min) * range;
        }
        else
        {
            range = _height - _width;
            _handle.y = _height - _width - (_value - _min) / (_max - _min) * range;
        }
    }
    
    
    
    
    ///////////////////////////////////
    // public methods
    ///////////////////////////////////
    
    /**
		 * Draws the visual ui of the component.
		 */
    override public function draw() : Void
    {
        super.draw();
        drawBack();
        drawHandle();
    }
    
    /**
		 * Convenience method to set the three main parameters in one shot.
		 * @param min The minimum value of the slider.
		 * @param max The maximum value of the slider.
		 * @param value The value of the slider.
		 */
    public function setSliderParams(min : Float, max : Float, value : Float) : Void
    {
        this.minimum = min;
        this.maximum = max;
        this.value = value;
    }
    
    
    
    
    ///////////////////////////////////
    // event handlers
    ///////////////////////////////////
    
    /**
		 * Handler called when user clicks the background of the slider, causing the handle to move to that point. Only active if backClick is true.
		 * @param event The MouseEvent passed by the system.
		 */
    private function onBackClick(event : MouseEvent) : Void
    {
        if (_orientation == HORIZONTAL)
        {
            _handle.x = mouseX - _height / 2;
            _handle.x = Math.max(_handle.x, 0);
            _handle.x = Math.min(_handle.x, _width - _height);
            _value = _handle.x / (width - _height) * (_max - _min) + _min;
        }
        else
        {
            _handle.y = mouseY - _width / 2;
            _handle.y = Math.max(_handle.y, 0);
            _handle.y = Math.min(_handle.y, _height - _width);
            _value = (_height - _width - _handle.y) / (height - _width) * (_max - _min) + _min;
        }
        dispatchEvent(new Event(Event.CHANGE));
    }
    
    /**
		 * Internal mouseDown handler. Starts dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
    private function onDrag(event : MouseEvent) : Void
    {
        stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
        if (_orientation == HORIZONTAL)
        {
            _handle.startDrag(false, new Rectangle(0, 0, _width - _height, 0));
        }
        else
        {
            _handle.startDrag(false, new Rectangle(0, 0, 0, _height - _width));
        }
    }
    
    /**
		 * Internal mouseUp handler. Stops dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
    private function onDrop(event : MouseEvent) : Void
    {
        stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
        stopDrag();
    }
    
    /**
		 * Internal mouseMove handler for when the handle is being moved.
		 * @param event The MouseEvent passed by the system.
		 */
    private function onSlide(event : MouseEvent) : Void
    {
        var oldValue : Float = _value;
        if (_orientation == HORIZONTAL)
        {
            _value = _handle.x / (width - _height) * (_max - _min) + _min;
        }
        else
        {
            _value = (_height - _width - _handle.y) / (height - _width) * (_max - _min) + _min;
        }
        if (_value != oldValue)
        {
            dispatchEvent(new Event(Event.CHANGE));
        }
    }
    
    
    
    
    ///////////////////////////////////
    // getter/setters
    ///////////////////////////////////
    
    /**
		 * Sets / gets whether or not a click on the background of the slider will move the handler to that position.
		 */
    private function set_backClick(b : Bool) : Bool
    {
        _backClick = b;
        invalidate();
        return b;
    }
    private function get_backClick() : Bool
    {
        return _backClick;
    }
    
    /**
		 * Sets / gets the current value of this slider.
		 */
    private function set_value(v : Float) : Float
    {
        _value = v;
        correctValue();
        positionHandle();
        return v;
    }
    private function get_value() : Float
    {
        return Math.round(_value / _tick) * _tick;
    }
    
    /**
     * Gets the value of the slider without rounding it per the tick value.
     */
    private function get_rawValue() : Float
    {
        return _value;
    }
    
    /**
		 * Gets / sets the maximum value of this slider.
		 */
    private function set_maximum(m : Float) : Float
    {
        _max = m;
        correctValue();
        positionHandle();
        return m;
    }
    private function get_maximum() : Float
    {
        return _max;
    }
    
    /**
		 * Gets / sets the minimum value of this slider.
		 */
    private function set_minimum(m : Float) : Float
    {
        _min = m;
        correctValue();
        positionHandle();
        return m;
    }
    private function get_minimum() : Float
    {
        return _min;
    }
    
    /**
		 * Gets / sets the tick value of this slider. This round the value to the nearest multiple of this number. 
		 */
    private function set_tick(t : Float) : Float
    {
        _tick = t;
        return t;
    }
    private function get_tick() : Float
    {
        return _tick;
    }
}


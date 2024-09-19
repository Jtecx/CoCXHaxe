/**
 * Component.as
 * Keith Peters
 * version 0.9.10
 * 
 * Base class for all components
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
 * 
 * 
 * 
 * Components with text make use of the font PF Ronda Seven by Yuusuke Kamiyamane
 * This is a free font obtained from http://www.dafont.com/pf-ronda-seven.font
 */

package com.bit101.components;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.filters.DropShadowFilter;

@:meta(Event(name="resize",type="flash.events.Event"))

@:meta(Event(name="draw",type="flash.events.Event"))

class Component extends Sprite
{
    public var tag(get, set) : Int;
    public var enabled(get, set) : Bool;

    @:meta(Embed(source="../../../../res/ui/Shrewsbury-Titling_Bold.ttf",embedAsCFF="false",fontName="PF Ronda Seven",mimeType="application/x-font"))

    private var Ronda : Class<Dynamic>;
    
    private var _width : Float = 0;
    private var _height : Float = 0;
    private var _tag : Int = -1;
    private var _enabled : Bool = true;
    
    public static inline var DRAW : String = "draw";
    
    /**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this component.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
    public function new(parent : DisplayObjectContainer = null, xpos : Float = 0, ypos : Float = 0)
    {
        super();
        move(xpos, ypos);
        init();
        if (parent != null)
        {
            parent.addChild(this);
        }
    }
    
    /**
		 * Initilizes the component.
		 */
    private function init() : Void
    {
        addChildren();
        invalidate();
    }
    
    /**
		 * Overriden in subclasses to create child display objects.
		 */
    private function addChildren() : Void
    {
    }
    
    /**
		 * DropShadowFilter factory method, used in many of the components.
		 * @param dist The distance of the shadow.
		 * @param knockout Whether or not to create a knocked out shadow.
		 */
    private function getShadow(dist : Float, knockout : Bool = false) : DropShadowFilter
    {
        return new DropShadowFilter(dist, 45, Style.DROPSHADOW, 1, dist, dist, .3, 1, knockout);
    }
    
    /**
		 * Marks the component to be redrawn on the next frame.
		 */
    private function invalidate() : Void
    //			draw();
    {
        
        addEventListener(Event.ENTER_FRAME, onInvalidate);
    }
    
    
    
    
    ///////////////////////////////////
    // public methods
    ///////////////////////////////////
    
    /**
		 * Utility method to set up usual stage align and scaling.
		 */
    public static function initStage(stage : Stage) : Void
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
    }
    
    /**
		 * Moves the component to the specified position.
		 * @param xpos the x position to move the component
		 * @param ypos the y position to move the component
		 */
    public function move(xpos : Float, ypos : Float) : Void
    {
        x = Math.round(xpos);
        y = Math.round(ypos);
    }
    
    /**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
    public function setSize(w : Float, h : Float) : Void
    {
        _width = w;
        _height = h;
        dispatchEvent(new Event(Event.RESIZE));
        invalidate();
    }
    
    /**
		 * Abstract draw function.
		 */
    public function draw() : Void
    {
        dispatchEvent(new Event(Component.DRAW));
    }
    
    
    
    
    ///////////////////////////////////
    // event handlers
    ///////////////////////////////////
    
    /**
		 * Called one frame after invalidate is called.
		 */
    private function onInvalidate(event : Event) : Void
    {
        removeEventListener(Event.ENTER_FRAME, onInvalidate);
        draw();
    }
    
    
    
    
    ///////////////////////////////////
    // getter/setters
    ///////////////////////////////////
    
    /**
		 * Sets/gets the width of the component.
		 */
    override private function set_width(w : Float) : Float
    {
        _width = w;
        invalidate();
        dispatchEvent(new Event(Event.RESIZE));
        return w;
    }
    override private function get_width() : Float
    {
        return _width;
    }
    
    /**
		 * Sets/gets the height of the component.
		 */
    override private function set_height(h : Float) : Float
    {
        _height = h;
        invalidate();
        dispatchEvent(new Event(Event.RESIZE));
        return h;
    }
    override private function get_height() : Float
    {
        return _height;
    }
    
    /**
		 * Sets/gets in integer that can identify the component.
		 */
    private function set_tag(value : Int) : Int
    {
        _tag = value;
        return value;
    }
    private function get_tag() : Int
    {
        return _tag;
    }
    
    /**
		 * Overrides the setter for x to always place the component on a whole pixel.
		 */
    override private function set_x(value : Float) : Float
    {
        super.x = Math.round(value);
        return value;
    }
    
    /**
		 * Overrides the setter for y to always place the component on a whole pixel.
		 */
    override private function set_y(value : Float) : Float
    {
        super.y = Math.round(value);
        return value;
    }
    
    /**
		 * Sets/gets whether this component is enabled or not.
		 */
    private function set_enabled(value : Bool) : Bool
    {
        _enabled = value;
        mouseEnabled = mouseChildren = _enabled;
        tabEnabled = value;
        alpha = (_enabled) ? 1.0 : 0.5;
        return value;
    }
    private function get_enabled() : Bool
    {
        return _enabled;
    }
}

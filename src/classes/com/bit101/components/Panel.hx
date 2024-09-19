/**
 * Panel.as
 * Keith Peters
 * version 0.9.10
 * 
 * A rectangular panel. Can be used as a container for other components.
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

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

class Panel extends Component
{
    public var border(get, set) : Bool;
    public var shadow(get, set) : Bool;
    public var color(get, set) : Int;
    public var PanelAlpha(get, set) : Int;
    public var gridSize(get, set) : Int;
    public var showGrid(get, set) : Bool;
    public var gridColor(get, set) : Int;

    private var _mask : Sprite;
    private var _background : Sprite;
    private var _border : Bool = true;
    private var _color : Int = -1;
    private var _alpha : Int = 100;
    private var _shadow : Bool = true;
    private var _gridSize : Int = 10;
    private var _showGrid : Bool = false;
    private var _gridColor : Int = 0xd0d0d0;
    
    
    /**
		 * Container for content added to this panel. This is masked, so best to add children to content, rather than directly to the panel.
		 */
    public var content : Sprite;
    
    
    /**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this Panel.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
    public function new(parent : DisplayObjectContainer = null, xpos : Float = 0, ypos : Float = 0)
    {
        super(parent, xpos, ypos);
    }
    
    
    /**
		 * Initializes the component.
		 */
    override private function init() : Void
    {
        super.init();
        setSize(100, 100);
    }
    
    /**
		 * Creates and adds the child display objects of this component.
		 */
    override private function addChildren() : Void
    {
        _background = new Sprite();
        super.addChild(_background);
        
        _mask = new Sprite();
        _mask.mouseEnabled = false;
        super.addChild(_mask);
        
        content = new Sprite();
        super.addChild(content);
        content.mask = _mask;
        
        filters = [getShadow(2, true)];
    }
    
    
    
    
    ///////////////////////////////////
    // public methods
    ///////////////////////////////////
    
    /**
		 * Overridden to add new child to content.
		 */
    override public function addChild(child : DisplayObject) : DisplayObject
    {
        content.addChild(child);
        return child;
    }
    
    /**
		 * Access to super.addChild
		 */
    public function addRawChild(child : DisplayObject) : DisplayObject
    {
        super.addChild(child);
        return child;
    }
    
    /**
		 * Draws the visual ui of the component.
		 */
    override public function draw() : Void
    {
        super.draw();
        _background.graphics.clear();
        if (_border)
        {
            _background.graphics.lineStyle(1, 0, 0.1);
        }
        if (_color == -1)
        {
            _background.graphics.beginFill(Style.PANEL);
        }
        else if (_alpha == 100)
        {
            _background.graphics.beginFill(_color);
        }
        else
        {
            _background.graphics.beginFill(_color, _alpha);
        }
        _background.graphics.drawRect(0, 0, _width, _height);
        _background.graphics.endFill();
        
        drawGrid();
        
        _mask.graphics.clear();
        _mask.graphics.beginFill(0xff0000);
        _mask.graphics.drawRect(0, 0, _width, _height);
        _mask.graphics.endFill();
    }
    
    private function drawGrid() : Void
    {
        if (!_showGrid)
        {
            return;
        }
        
        _background.graphics.lineStyle(0, _gridColor);
        var i : Int = 0;
        while (i < _width)
        {
            _background.graphics.moveTo(i, 0);
            _background.graphics.lineTo(i, _height);
            i += _gridSize;
        }
        i = 0;
        while (i < _height)
        {
            _background.graphics.moveTo(0, i);
            _background.graphics.lineTo(_width, i);
            i += _gridSize;
        }
    }
    
    
    
    ///////////////////////////////////
    // event handlers
    ///////////////////////////////////
    
    ///////////////////////////////////
    // getter/setters
    ///////////////////////////////////
    
    private function set_border(b : Bool) : Bool
    {
        _border = b;
        invalidate();
        return b;
    }
    private function get_border() : Bool
    {
        return _border;
    }
    
    /**
		 * Gets / sets whether or not this Panel will have an inner shadow.
		 */
    private function set_shadow(b : Bool) : Bool
    {
        _shadow = b;
        if (_shadow)
        {
            filters = [getShadow(2, true)];
        }
        else
        {
            filters = [];
        }
        return b;
    }
    private function get_shadow() : Bool
    {
        return _shadow;
    }
    
    /**
		 * Gets / sets the backgrond color of this panel.
		 */
    private function set_color(c : Int) : Int
    {
        _color = c;
        invalidate();
        return c;
    }
    private function get_color() : Int
    {
        return _color;
    }
    private function set_PanelAlpha(c : Int) : Int
    {
        _alpha = c;
        invalidate();
        return c;
    }
    private function get_PanelAlpha() : Int
    {
        return _alpha;
    }
    /**
		 * Sets / gets the size of the grid.
		 */
    private function set_gridSize(value : Int) : Int
    {
        _gridSize = value;
        invalidate();
        return value;
    }
    private function get_gridSize() : Int
    {
        return _gridSize;
    }
    
    /**
		 * Sets / gets whether or not the grid will be shown.
		 */
    private function set_showGrid(value : Bool) : Bool
    {
        _showGrid = value;
        invalidate();
        return value;
    }
    private function get_showGrid() : Bool
    {
        return _showGrid;
    }
    
    /**
		 * Sets / gets the color of the grid lines.
		 */
    private function set_gridColor(value : Int) : Int
    {
        _gridColor = value;
        invalidate();
        return value;
    }
    private function get_gridColor() : Int
    {
        return _gridColor;
    }
}

/**
 * InputText.as
 * Keith Peters
 * version 0.9.10
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
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;

class InputText extends Component
{
    public var text(get, set) : String;
    public var textField(get, never) : TextField;
    public var restrict(get, set) : String;
    public var maxChars(get, set) : Int;
    public var password(get, set) : Bool;

    private var _back : Sprite;
    private var _password : Bool = false;
    private var _text : String = "";
    private var _tf : TextField;
    
    /**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this InputText.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param text The string containing the initial text of this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
    public function new(parent : DisplayObjectContainer = null, xpos : Float = 0, ypos : Float = 0, text : String = "", defaultHandler : Function = null)
    {
        this.text = text;
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
        setSize(100, 16);
    }
    
    /**
		 * Creates and adds child display objects.
		 */
    override private function addChildren() : Void
    {
        _back = new Sprite();
        _back.filters = [getShadow(2, true)];
        addChild(_back);
        
        _tf = new TextField();
        _tf.embedFonts = Style.embedFonts;
        _tf.selectable = true;
        _tf.type = TextFieldType.INPUT;
        _tf.defaultTextFormat = new TextFormat(Style.fontName, Style.fontSize, Style.INPUT_TEXT);
        addChild(_tf);
        _tf.addEventListener(Event.CHANGE, onChange);
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
        _back.graphics.clear();
        _back.graphics.beginFill(Style.BACKGROUND);
        _back.graphics.drawRect(0, 0, _width, _height);
        _back.graphics.endFill();
        
        _tf.displayAsPassword = _password;
        
        if (_text != null)
        {
            _tf.text = _text;
        }
        else
        {
            _tf.text = "";
        }
        _tf.width = _width - 4;
        if (_tf.text == "")
        {
            _tf.text = "X";
            _tf.height = Math.min(_tf.textHeight + 4, _height);
            _tf.text = "";
        }
        else
        {
            _tf.height = Math.min(_tf.textHeight + 4, _height);
        }
        _tf.x = 2;
        _tf.y = Math.round(_height / 2 - _tf.height / 2);
    }
    
    
    
    
    ///////////////////////////////////
    // event handlers
    ///////////////////////////////////
    
    /**
		 * Internal change handler.
		 * @param event The Event passed by the system.
		 */
    private function onChange(event : Event) : Void
    {
        _text = _tf.text;
        event.stopImmediatePropagation();
        dispatchEvent(event);
    }
    
    
    
    
    ///////////////////////////////////
    // getter/setters
    ///////////////////////////////////
    
    /**
		 * Gets / sets the text shown in this InputText.
		 */
    private function set_text(t : String) : String
    {
        _text = t;
        if (_text == null)
        {
            _text = "";
        }
        invalidate();
        return t;
    }
    private function get_text() : String
    {
        return _text;
    }
    
    /**
		 * Returns a reference to the internal text field in the component.
		 */
    private function get_textField() : TextField
    {
        return _tf;
    }
    
    /**
		 * Gets / sets the list of characters that are allowed in this TextInput.
		 */
    private function set_restrict(str : String) : String
    {
        _tf.restrict = str;
        return str;
    }
    private function get_restrict() : String
    {
        return _tf.restrict;
    }
    
    /**
		 * Gets / sets the maximum number of characters that can be shown in this InputText.
		 */
    private function set_maxChars(max : Int) : Int
    {
        _tf.maxChars = max;
        return max;
    }
    private function get_maxChars() : Int
    {
        return _tf.maxChars;
    }
    
    /**
		 * Gets / sets whether or not this input text will show up as password (asterisks).
		 */
    private function set_password(b : Bool) : Bool
    {
        _password = b;
        invalidate();
        return b;
    }
    private function get_password() : Bool
    {
        return _password;
    }
    
    /**
     * Sets/gets whether this component is enabled or not.
     */
    override private function set_enabled(value : Bool) : Bool
    {
        super.enabled = value;
        _tf.tabEnabled = value;
        return value;
    }
}

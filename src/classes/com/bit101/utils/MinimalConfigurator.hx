/**
 * MinimalConfigurator.as
 * Keith Peters
 * version 0.9.10
 * 
 * A class for parsing xml layout code to create minimal components declaratively.
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

package com.bit101.utils;

import flash.errors.Error;
import com.bit101.components.*;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

// usually don't use * but we really are importing everything here.
/**
	 * Creates and lays out minimal components based on a simple xml format.
	 */
class MinimalConfigurator extends EventDispatcher
{
    private var loader : URLLoader;
    private var parent : DisplayObjectContainer;
    private var idMap : Dynamic;
    
    /**
		 * Constructor.
		 * @param parent The display object container on which to create components and look for ids and event handlers.
		 */
    public function new(parent : DisplayObjectContainer)
    {
        super();
        this.parent = parent;
        idMap = {};
    }
    
    /**
		 * Loads an xml file from the specified url and attempts to parse it as a layout format for this class.
		 * @param url The location of the xml file.
		 */
    public function loadXML(url : String) : Void
    {
        loader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, onLoadComplete);
        loader.load(new URLRequest(url));
    }
    
    /**
		 * Called when the xml has loaded. Will attempt to parse the loaded data as xml.
		 */
    private function onLoadComplete(event : Event) : Void
    {
        parseXMLString(Std.string(loader.data));
    }
    
    /**
		 * Parses a string as xml.
		 * @param string The xml string to parse.
		 */
    public function parseXMLString(string : String) : Void
    {
        try
        {
            var xml : FastXML = new FastXML(string);
            parseXML(xml);
        }
        catch (e : Error)
        {
        }
        dispatchEvent(new Event(Event.COMPLETE));
    }
    
    /**
		 * Parses xml and creates componetns based on it.
		 * @param xml The xml to parse.
		 */
    public function parseXML(xml : FastXML) : Void
    // root tag should contain one or more component tags
    {
        
        // each tag's name should be the base name of a component, i.e. "PushButton"
        // package is assumed "com.bit101.components"
        for (i in 0...xml.node.children.innerData().length())
        {
            var comp : FastXML = xml.nodes.children()[i];
            var compInst : Component = parseComp(comp);
            if (compInst != null)
            {
                parent.addChild(compInst);
            }
        }
    }
    
    /**
		 * Parses a single component's xml.
		 * @param xml The xml definition for this component.
		 * @return A component instance.
		 */
    private function parseComp(xml : FastXML) : Component
    {
        var compInst : Dynamic;
        var specialProps : Dynamic = { };
        try
        {
            var classRef : Class<Dynamic> = Type.getClass(Type.resolveClass("com.bit101.components." + xml.node.name.innerData()));
            compInst = Type.createInstance(classRef, []);
            
            // id is special case, maps to name as well.
            var id : String = trim(Std.string(xml.att.id));
            if (id != "")
            {
                compInst.name = id;
                Reflect.setField(idMap, id, compInst);
                
                // if id exists on parent as a public property, assign this component to it.
                if (parent.exists(id))
                {
                    Reflect.setField(parent, id, compInst);
                }
            }
            
            // event is another special case
            if (Std.string(xml.att.event) != "")
            
            // events are in the format: event="eventName:eventHandler"{
                
                // i.e. event="click:onClick"
                var parts : Array<Dynamic> = xml.att.event.split(":");
                var eventName : String = trim(parts[0]);
                var handler : String = trim(parts[1]);
                if (parent.exists(handler))
                
                // if event handler exists on parent as a public method, assign it as a handler for the event.{
                    
                    compInst.addEventListener(eventName, Reflect.field(parent, handler));
                }
            }
            
            // every other attribute handled essentially the same
            for (attrib/* AS3HX WARNING could not determine type for var: attrib exp: ECall(EField(EIdent(xml),attributes),[]) type: null */ in xml.nodes.attributes())
            {
                var prop : String = Std.string(attrib.name());
                // if the property exists on the component, assign it.
                if (compInst.exists(prop))
                
                // special handling to correctly parse booleans{
                    
                    if (Std.is(Reflect.field(compInst, prop), Bool))
                    {
                        Reflect.setField(compInst, prop, attrib == "true");
                    }
                    // special handling - these values should be set last.
                    else if (prop == "value" || prop == "lowValue" || prop == "highValue" || prop == "choice")
                    {
                        Reflect.setField(specialProps, prop, attrib);
                    }
                    else
                    {
                        Reflect.setField(compInst, prop, attrib);
                    }
                }
            }
            
            // now handle special props
            for (prop in Reflect.fields(specialProps))
            {
                Reflect.setField(compInst, Std.string(prop), Reflect.field(specialProps, Std.string(prop)));
            }
            
            // child nodes will be added as children to the instance just created.
            for (j in 0...xml.node.children.innerData().length())
            {
                var child : Component = parseComp(xml.nodes.children()[j]);
                if (child != null)
                {
                    compInst.addChild(child);
                }
            }
        }
        catch (e : Error)
        {
        }
        return try cast(compInst, Component) catch(e:Dynamic) null;
    }
    
    /**
		 * Returns the componet with the given id, if it exists.
		 * @param id The id of the component you want.
		 * @return The component with that id, if it exists.
		 */
    public function getCompById(id : String) : Component
    {
        return Reflect.field(idMap, id);
    }
    
    /**
		 * Trims a string.
		 * @param s The string to trim.
		 * @return The trimmed string.
		 */
    private function trim(s : String) : String
    // http://jeffchannell.com/ActionScript-3/as3-trim.html
    {
        
        return new as3hx.Compat.Regex('^\\s+|\\s+$', "gs").replace(s, "");
    }  /**
		 * We need to include all component classes in the swf.
		 */  
    private static var MinimalConfigurator_static_initializer = {
        Accordion;
        Calendar;
        CheckBox;
        ColorChooser;
        ComboBox;
        FPSMeter;
        HBox;
        HRangeSlider;
        HScrollBar;
        HSlider;
        HUISlider;
        IndicatorLight;
        InputText;
        Knob;
        Label;
        List;
        ListItem;
        Meter;
        NumericStepper;
        Panel;
        ProgressBar;
        PushButton;
        RadioButton;
        RangeSlider;
        RotarySelector;
        ScrollBar;
        ScrollPane;
        Slider;
        Style;
        Text;
        TextArea;
        UISlider;
        VBox;
        VRangeSlider;
        VScrollBar;
        VSlider;
        VUISlider;
        WheelMenu;
        Window;
        true;
    }

}

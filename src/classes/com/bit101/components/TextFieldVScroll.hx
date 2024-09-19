package com.bit101.components;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

class TextFieldVScroll extends VScrollBar
{
    private var scrollTarget : TextField;
    
    public function new(_scrollTarget : TextField = null, parent : DisplayObjectContainer = null, xpos : Float = 0, ypos : Float = 0)
    {
        scrollTarget = _scrollTarget;
        super(parent, xpos, ypos, onScrollbarScroll);
        this.autoHide = true;
    }
    
    
    /**
     * Initilizes the component.
     */
    override private function init() : Void
    {
        super.init();
        addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
        scrollTarget.width = scrollTarget.width - this.width;
    }
    
    /**
     * Creates and adds the child display objects of this component.
     */
    override private function addChildren() : Void
    {
        super.addChildren();
        scrollTarget.addEventListener(Event.SCROLL, onTextScroll);
    }
    
    /**
     * Changes the thumb percent of the scrollbar based on how much text is shown in the text area.
     */
    private function updateScrollbar() : Void
    {
        var visibleLines : Int = as3hx.Compat.parseInt(scrollTarget.numLines - scrollTarget.maxScrollV + 1);
        var percent : Float = visibleLines / scrollTarget.numLines;
        this.setSliderParams(1, scrollTarget.maxScrollV, scrollTarget.scrollV);
        this.setThumbPercent(percent);
        this.pageSize = visibleLines;
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
        this.x = (scrollTarget.x + scrollTarget.width) + 10;
        this.height = scrollTarget.height;
        addEventListener(Event.ENTER_FRAME, onTextScrollDelay);
    }
    
    
    ///////////////////////////////////
    // event handlers
    ///////////////////////////////////
    
    /**
     * Waits one more frame before updating scroll bar.
     * It seems that numLines and maxScrollV are not valid immediately after changing a TextField's size.
     */
    private function onTextScrollDelay(event : Event) : Void
    {
        removeEventListener(Event.ENTER_FRAME, onTextScrollDelay);
        updateScrollbar();
    }
    
    /**
     * Called when the scroll bar is moved. Scrolls text accordingly.
     */
    private function onScrollbarScroll(event : Event) : Void
    {
        scrollTarget.scrollV = Math.round(this.value);
    }
    
    /**
     * Called when the text is scrolled manually. Updates the position of the scroll bar.
     */
    private function onTextScroll(event : Event) : Void
    {
        this.value = scrollTarget.scrollV;
        updateScrollbar();
    }
    
    /**
     * Called when the mouse wheel is scrolled over the component.
     */
    private function onMouseWheel(event : MouseEvent) : Void
    {
        this.value -= event.delta;
        scrollTarget.scrollV = Math.round(this.value);
    }
    
    /**
     * Sets/gets whether this component is enabled or not.
     */
    override private function set_enabled(value : Bool) : Bool
    {
        super.enabled = value;
        scrollTarget.tabEnabled = value;
        return value;
    }
}


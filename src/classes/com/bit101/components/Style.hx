/**
 * Style.as
 * Keith Peters
 * version 0.9.10
 * 
 * A collection of style variables used by the components.
 * If you want to customize the colors of your components, change these values BEFORE instantiating any components.
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


class Style
{
    public static var TEXT_BACKGROUND : Int = 0xFFFFFF;
    public static var BACKGROUND : Int = 0xCCCCCC;
    public static var BUTTON_FACE : Int = 0xFFFFFF;
    public static var BUTTON_DOWN : Int = 0xEEEEEE;
    public static var INPUT_TEXT : Int = 0x333333;
    public static var LABEL_TEXT : Int = 0x000000;
    public static var DROPSHADOW : Int = 0x000000;
    public static var PANEL : Int = 0xF3F3F3;
    public static var PROGRESS_BAR : Int = 0xFFFFFF;
    public static var LIST_DEFAULT : Int = 0xFFFFFF;
    public static var LIST_ALTERNATE : Int = 0xF3F3F3;
    public static var LIST_SELECTED : Int = 0xCCCCCC;
    public static var LIST_ROLLOVER : Int = 0;
    
    public static var embedFonts : Bool = false;
    public static var fontName : String = "Arial";
    public static var fontSize : Float = 10;
    
    public static inline var DARK : String = "dark";
    public static inline var LIGHT : String = "light";
    
    /**
		 * Applies a preset style as a list of color values. Should be called before creating any components.
		 */
    public static function setStyle(style : String) : Void
    {
        switch (style)
        {
            case DARK:
                Style.BACKGROUND = 0x444444;
                Style.BUTTON_FACE = 0x666666;
                Style.BUTTON_DOWN = 0x222222;
                Style.INPUT_TEXT = 0xBBBBBB;
                Style.LABEL_TEXT = 0xCCCCCC;
                Style.PANEL = 0x666666;
                Style.PROGRESS_BAR = 0x666666;
                Style.TEXT_BACKGROUND = 0x555555;
                Style.LIST_DEFAULT = 0x444444;
                Style.LIST_ALTERNATE = 0x393939;
                Style.LIST_SELECTED = 0x666666;
                Style.LIST_ROLLOVER = 0x777777;
            case LIGHT:
                Style.BACKGROUND = 0xCCCCCC;
                Style.BUTTON_FACE = 0xFFFFFF;
                Style.BUTTON_DOWN = 0xEEEEEE;
                Style.INPUT_TEXT = 0x333333;
                Style.LABEL_TEXT = 0x666666;
                Style.PANEL = 0xF3F3F3;
                Style.PROGRESS_BAR = 0xFFFFFF;
                Style.TEXT_BACKGROUND = 0xFFFFFF;
                Style.LIST_DEFAULT = 0xFFFFFF;
                Style.LIST_ALTERNATE = 0xF3F3F3;
                Style.LIST_SELECTED = 0xCCCCCC;
                Style.LIST_ROLLOVER = 0xDDDDDD;
            default:
                Style.BACKGROUND = 0xCCCCCC;
                Style.BUTTON_FACE = 0xFFFFFF;
                Style.BUTTON_DOWN = 0xEEEEEE;
                Style.INPUT_TEXT = 0x333333;
                Style.LABEL_TEXT = 0x666666;
                Style.PANEL = 0xF3F3F3;
                Style.PROGRESS_BAR = 0xFFFFFF;
                Style.TEXT_BACKGROUND = 0xFFFFFF;
                Style.LIST_DEFAULT = 0xFFFFFF;
                Style.LIST_ALTERNATE = 0xF3F3F3;
                Style.LIST_SELECTED = 0xCCCCCC;
                Style.LIST_ROLLOVER = 0xDDDDDD;
        }
    }

    public function new()
    {
    }
    private static var Style_static_initializer = {
        XDDDDDD;
        true;
    }

}

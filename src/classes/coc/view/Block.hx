/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view;

import flash.errors.ArgumentError;
import classes.internals.Utils;
import com.bit101.components.ComboBox;
import com.bit101.components.InputText;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.utils.Dictionary;

class Block extends Sprite
{
    private var xmin(get, never) : Float;
    private var ymin(get, never) : Float;
    public var layoutConfig(get, set) : Dynamic;
    public var innerWidth(get, never) : Float;
    public var innerHeight(get, never) : Float;
    public var numElements(get, never) : Int;
    public var paddingTop(get, never) : Float;
    public var paddingRight(get, never) : Float;
    public var paddingBottom(get, never) : Float;
    public var paddingLeft(get, never) : Float;

    public static inline var ON_LAYOUT : String = "coc$layout";
    /**
	 * Null layout. All elements' positions and sizes are NOT adjusted
	 */
    public static inline var LAYOUT_NONE : String = "none";
    /**
	 * Common layout parameters:
	 * * padding{s,Horiz,Vert,Top,Right,Bottom,Left} - a distance from borders of this block to its elements
	 * * `ignoreHidden` - ignore all hidden (visible=false) elements. Default layout-dependent
	 * Common element hints:
	 * * `ignore` - ignore element
	 */
    /**
	 * Grid layout. Aligns elements in a grid of fixed cell size, fixed cell count
	 * Config:
	 * * `rows` - number of rows. Default 0 (indefinite number, keep adding more rows)
	 * * `cols` - number of columns. Default 1 (or `columns` size)
	 * * `columns` - column widths. -1: autosize, 0..1: fraction, >1: pixels. Defaults to cellWidth or (1.0 / rows) if cellWidth not set.
	 * * `setWidth`, `setHeight - should set width/height of elements. Default false
	 * * `gap` - gap between cells, -1 to auto (works only if all columns are fixed width, or cellWidth is set)
	 * * `cellWidth` - default cell width.
	 *
	 * Hints:
	 * * `row`, `col` - 2D position in grid. Defaults to "next cell"
	 * * `setWidth`, `setHeight - should set width/height of this element. Default to layout config
	 */
    public static inline var LAYOUT_GRID : String = "grid";
    private function applyGridLayout() : Void
    {
        var config : Dynamic = _layoutConfig;
        var ignoreHidden : Bool = (Lambda.has(config, "ignoreHidden")) ? Reflect.field(config, "ignoreHidden") : false;
        var rows : Float = Utils.intOr(Reflect.field(config, "rows"), 0);
        var cols : Float = Utils.intOr(Reflect.field(config, "cols"), 1);
        var gap : Float = Utils.numberOr(Reflect.field(config, "gap"), 0);
        var innerw : Float = innerWidth;
        var columns : Array<Dynamic> = Reflect.field(config, "columns");
        var setcw : Bool = Reflect.field(config, "setWidth");
        var setch : Bool = Reflect.field(config, "setHeight");
        var debug : Bool = Reflect.field(config, "debug");
        var cellWidth : Float = Utils.intOr(Reflect.field(config, "cellWidth"), 0);
        if (!(Lambda.has(config, "cols")) && columns != null)
        {
            cols = columns.length;
        }
        if (gap > 0)
        {
            innerw -= gap * cols;
        }
        if (columns == null || columns.length != cols)
        {
            columns = [];
            for (i in 0...cols)
            {
                Reflect.setField(columns, i, -1);
            }
        }
        else
        {
            columns = columns.copy();
        }
        // calculate column size
        var autocols : Int = 0;
        var freespace : Float = innerw;
        // count autocols and convert fraction widths to pixels
        for (i in 0...cols)
        {
            if (Reflect.field(columns, i) < 0)
            {
                autocols += -Reflect.field(columns, i);
                continue;
            }
            else if (Reflect.field(columns, i) <= 1)
            
            // fraction{
                
                Reflect.field(columns, i) *= innerw;
            }  // else size in pixels  
            freespace -= Reflect.field(columns, i);
        }
        // calculate autocol sizes
        if (autocols > 0)
        {
            if (cellWidth <= 0)
            {
                cellWidth = freespace / autocols;
            }
            for (i in 0...cols)
            {
                if (Reflect.field(columns, i) < 0)
                {
                    Reflect.setField(columns, i, cellWidth * (-Reflect.field(columns, i)));
                }
            }
        }
        if (gap < 0)
        {
            var tw : Float = 0;
            for (i in 0...cols)
            {
                tw += Reflect.field(columns, i);
            }
            gap = (innerw - tw) / cols;
        }
        
        var row : Int = 0;
        var col : Int = 0;
        var grid : Array<Dynamic> = [];
        var innerh : Float = innerHeight - ((rows > 1) ? gap * (rows - 1) : 0);
        var cellh : Float = (rows > 0) ? innerh / rows : 0;
        var ci : Int = 0;
        var cn : Int = _container.numChildren;
        while (ci < cn)
        {
            var child : DisplayObject = _container.getChildAt(ci);
            var hint : Dynamic = Reflect.field(_layoutHints, Std.string(child)) || { };
            if (Reflect.field(hint, "ignore") != null || !child.visible && ignoreHidden)
            {
                {ci++;continue;
                }
            }
            if (Lambda.has(hint, "row") && Lambda.has(hint, "col"))
            {
                row = Reflect.field(hint, "row");
                col = Reflect.field(hint, "col");
            }
            if (grid[row] == null)
            {
                grid[row] = [];
            }
            grid[row][col] = child;
            col += ((Lambda.has(hint, "colspan"))) ? Reflect.field(hint, "colspan") : 1;
            if (col >= cols)
            {
                col = 0;
                row++;
            }
            ci++;
        }
        var y : Float = paddingTop + gap / 2;
        for (row in 0...grid.length)
        {
            if (grid[row] == null)
            {
                continue;
            }
            var h : Float = 0;
            var x : Float = paddingLeft;
            col = 0;
            while (col < columns.length)
            {
                var colspan : Int = 1;
                child = grid[row][col];
                if (child)
                {
                    if (debug)
                    {
                        trace("[" + row + "][" + col + "] x=" + (x | 0) + " y=" + (y | 0) + " w=" + (columns[col] | 0) + " h=" + (cellh | 0) + " " + child);
                    }
                    hint = _layoutHints[child] || { };
                    var setw : Bool = (Lambda.has(hint, "setWidth")) ? Reflect.field(hint, "setWidth") : setcw;
                    var seth : Bool = (Lambda.has(hint, "setHeight")) ? Reflect.field(hint, "setHeight") : setch;
                    colspan = (Lambda.has(hint, "colspan")) ? Reflect.field(hint, "colspan") : 1;
                    child.x = x + gap / 2;
                    child.y = y;
                    if (setw)
                    {
                        var cw : Float = columns[col];
                        i = 1;
                        while (i < colspan && col + i < cols)
                        {
                            cw += gap + columns[col + i];
                            i++;
                        }
                        child.width = cw;
                    }
                    if (seth)
                    {
                        child.height = cellh;
                    }
                    if (debug)
                    {
                        trace("" + child.x + " " + child.y + " " + child.width + " " + child.height);
                    }
                    h = Math.max(h, child.height);
                }
                while (colspan-- > 0 && col < columns.length)
                {
                    x += columns[col] + gap;
                    col++;
                }
            }
            y += h + gap;
        }
    }
    /**
	 * Flow layout. Aligns size-providing elements in a row or column
	 * Config:
	 * `direction` - 'row'|'column'. Defaults to 'row'
	 * `gap` - Gap between neighbouring elements. Defaults to 2.
	 * `ignoreHidden` defaults to true
	 * `stretch` - Stretch children horizontally (column mode) or vertically (row mode). Default false
	 * Hints:
	 * `before`, `after` - Additional gap before/after that element. May be negative
	 */
    public static inline var LAYOUT_FLOW : String = "flow";
    private function applyFlowLayout() : Void
    {
        var config : Dynamic = _layoutConfig;
        var ignoreHidden : Bool = (Lambda.has(config, "ignoreHidden")) ? Reflect.field(config, "ignoreHidden") : true;
        var dir : String = Reflect.field(config, "direction") || "row";
        var stretch : Bool = Reflect.field(config, "stretch");
        var gap : Float = (Lambda.has(config, "gap")) ? Reflect.field(config, "gap") : 2;
        var x : Float = paddingLeft;
        var y : Float = paddingTop;
        var column : Bool = dir == "column";
        var ci : Int = 0;
        var cn : Int = _container.numChildren;
        while (ci < cn)
        {
            var child : DisplayObject = _container.getChildAt(ci);
            var hint : Dynamic = Reflect.field(_layoutHints, Std.string(child)) || { };
            if (Reflect.field(hint, "ignore") != null || !child.visible && ignoreHidden)
            {
                {ci++;continue;
                }
            }
            var stretchChild : Bool = Utils.valueOr(Reflect.field(hint, "stretch"), stretch);
            var before : Float = (Lambda.has(hint, "before")) ? Reflect.field(hint, "before") : 0;
            if (column)
            {
                y += before;
            }
            else
            {
                x += before;
            }
            child.x = x;
            child.y = y;
            if (stretchChild)
            {
                if (column)
                {
                    child.width = innerWidth;
                }
                else
                {
                    child.height = innerHeight;
                }
            }
            var after : Float = (Lambda.has(hint, "after")) ? Reflect.field(hint, "after") : 0;
            if (column)
            {
                y += child.height + after + gap;
            }
            else
            {
                x += child.width + after + gap;
            }
            ci++;
        }
    }
    
    private var _container : Sprite;
    private var _layoutHints : Dictionary = new Dictionary();
    private var _dirty : Bool = false;
    private var _layoutConfig : Dynamic;
    private var explicitWidth : Float = 0;
    private var explicitHeight : Float = 0;
    public var dataset : Dynamic = { };
    private var _xminCached : Float = -1;
    private var _yminCached : Float = -1;
    
    public function new(options : Dynamic = null)
    {
        super();
        _layoutConfig = {
                    type : LAYOUT_NONE
                };
        UIUtils.setProperties(this, options || { });
        _container = new Sprite();
        addChild(_container);
        addEventListener(Event.ADDED_TO_STAGE, addedToStage);
        invalidateLayout();
    }
    
    private function get_xmin() : Float
    {
        if (_xminCached != -1)
        {
            return _xminCached;
        }
        var xmin : Float = 0;
        if (_container != null)
        {
            var i : Int = 0;
            var n : Int = numElements;
            while (i < n)
            {
                xmin = Math.min(xmin, getElementAt(i).x);
                i++;
            }
        }
        //		_xminCached = xmin;
        return xmin;
    }
    private function get_ymin() : Float
    {
        if (_yminCached != -1)
        {
            return _yminCached;
        }
        var ymin : Float = 0;
        if (_container != null)
        {
            var i : Int = 0;
            var n : Int = numElements;
            while (i < n)
            {
                ymin = Math.min(ymin, getElementAt(i).y);
                i++;
            }
        }
        //		_yminCached = ymin;
        return ymin;
    }
    override private function get_width() : Float
    {
        if (explicitWidth != 0 && !Math.isNaN(explicitWidth))
        {
            return explicitWidth;
        }
        return super.width - xmin;
    }
    override private function get_height() : Float
    {
        if (explicitHeight != 0 && !Math.isNaN(explicitHeight))
        {
            return explicitHeight;
        }
        return super.height - ymin;
    }
    override private function set_width(value : Float) : Float
    {
        if (width != value)
        {
            explicitWidth = value;
            resize();
        }
        return value;
    }
    override private function set_height(value : Float) : Float
    {
        if (height != value)
        {
            explicitHeight = value;
            resize();
        }
        return value;
    }
    private function resize() : Void
    {
        invalidateLayout();
        if (width > 0 || height > 0)
        {
            graphics.clear();
            graphics.beginFill(0, 0);
            graphics.drawRect(0, 0, width, height);
            graphics.endFill();
        }
        if ((width != 0 && !Math.isNaN(width)) && (height != 0 && !Math.isNaN(height)))
        {
            super.width = width + Math.max(0, -xmin);
            super.height = height + Math.max(0, -ymin);
        }
    }
    private function get_layoutConfig() : Dynamic
    {
        return _layoutConfig;
    }
    
    private function set_layoutConfig(value : Dynamic) : Dynamic
    {
        _layoutConfig = value;
        invalidateLayout();
        return value;
    }
    private function get_innerWidth() : Float
    {
        return Math.max(0, (width || explicitWidth) - paddingLeft - paddingRight);
    }
    private function get_innerHeight() : Float
    {
        return Math.max(0, (height || explicitHeight) - paddingTop - paddingBottom);
    }
    private function addedToStage(e : Event) : Void
    {
    }
    
    public function addElement(e : DisplayObject, hint : Dynamic = null) : DisplayObject
    {
        _container.addChild(e);
        layElement(e, hint);
        return e;
    }
    
    public function hasElement(e : DisplayObject) : Bool
    {
        return getElementIndex(e) >= 0;
    }
    
    public function addElementAt(e : DisplayObject, index : Int, hint : Dynamic = null) : DisplayObject
    {
        _container.addChildAt(e, index);
        layElement(e, hint);
        return e;
    }
    public function addElementAbove(e : DisplayObject, reference : DisplayObject, hint : Dynamic = null) : DisplayObject
    {
        var i : Int = getElementIndex(reference);
        if (i < 0)
        {
            i = 0;
        }
        // above none = below all
        else
        {
            i = as3hx.Compat.parseInt(i + 1);
        }
        var j : Int = getElementIndex(e);
        if (j != i + 1)
        {
            addElementAt(e, i, hint);
        }
        return e;
    }
    public function addElementBelow(e : DisplayObject, reference : DisplayObject, hint : Dynamic = null) : DisplayObject
    {
        var i : Int = getElementIndex(reference);
        if (i < 0)
        {
            i = numElements;
        }  // below none = above all  
        var j : Int = getElementIndex(e);
        if (j != i - 1)
        {
            addElementAt(e, i, hint);
        }
        return e;
    }
    
    public function layElement(e : DisplayObject, hint : Dynamic) : Block
    {
        Reflect.setField(_layoutHints, Std.string(e), hint);
        invalidateLayout();
        return this;
    }
    
    public function getElementIndex(e : DisplayObject) : Int
    {
        if (e == null)
        {
            return -1;
        }
        var i : Int = -1;
        try
        {
            i = _container.getChildIndex(e);
        }
        catch (e : ArgumentError)
        {
        }
        return i;
    }
    
    public function getElementByName(name : String) : DisplayObject
    {
        return _container.getChildByName(name);
    }
    public function getElementAt(index : Int) : DisplayObject
    {
        return _container.getChildAt(index);
    }
    private function get_numElements() : Int
    {
        return _container.numChildren;
    }
    
    public function removeElement(e : DisplayObject) : Void
    {
        try
        {
            _container.removeChild(e);
        }
        catch (error : ArgumentError)
        {
        }
        This is an intentional compilation error. See the README for handling the delete keyword
        delete _layoutHints[e];
        invalidateLayout();
    }
    public function removeAllElements() : Void
    {
        _container.removeChildren();
        _layoutHints = new Dictionary();
        invalidateLayout();
    }
    
    public function invalidateLayout() : Void
    {
        _xminCached = -1;
        _yminCached = -1;
        if (!_dirty)
        {
            _dirty = true;
            as3hx.Compat.setTimeout(maybeDoLayout, 0);
        }
    }
    
    private function get_paddingTop() : Float
    {
        var config : Dynamic = _layoutConfig;
        if (Lambda.has(config, "paddingTop"))
        {
            return Reflect.field(config, "paddingTop");
        }
        if (Lambda.has(config, "paddingVert"))
        {
            return Reflect.field(config, "paddingVert");
        }
        if (Lambda.has(config, "padding"))
        {
            return Reflect.field(config, "padding");
        }
        return 0;
    }
    private function get_paddingRight() : Float
    {
        var config : Dynamic = _layoutConfig;
        if (Lambda.has(config, "paddingRight"))
        {
            return Reflect.field(config, "paddingRight");
        }
        if (Lambda.has(config, "paddingHoriz"))
        {
            return Reflect.field(config, "paddingHoriz");
        }
        if (Lambda.has(config, "padding"))
        {
            return Reflect.field(config, "padding");
        }
        return 0;
    }
    private function get_paddingBottom() : Float
    {
        var config : Dynamic = _layoutConfig;
        if (Lambda.has(config, "paddingBottom"))
        {
            return Reflect.field(config, "paddingBottom");
        }
        if (Lambda.has(config, "paddingVert"))
        {
            return Reflect.field(config, "paddingVert");
        }
        if (Lambda.has(config, "padding"))
        {
            return Reflect.field(config, "padding");
        }
        return 0;
    }
    private function get_paddingLeft() : Float
    {
        var config : Dynamic = _layoutConfig;
        if (Lambda.has(config, "paddingLeft"))
        {
            return Reflect.field(config, "paddingLeft");
        }
        if (Lambda.has(config, "paddingHoriz"))
        {
            return Reflect.field(config, "paddingHoriz");
        }
        if (Lambda.has(config, "padding"))
        {
            return Reflect.field(config, "padding");
        }
        return 0;
    }
    public function doLayout() : Void
    {
        _dirty = false;
        var type : String = Reflect.field(_layoutConfig, "type");
        Utils.Begin("Block", "doLayout", type);
        //if (type !== "none") trace("doLayout "+this+" ["+x+", "+y+" "+width+"x"+height+"]");
        switch (type)
        {
            case "grid":
                applyGridLayout();
            case "flow":
                applyFlowLayout();
            case "none":
            default:
                trace("Unknown layout config type ", type);
        }
        Utils.End("Block", "doLayout");
        dispatchEvent(new Event(ON_LAYOUT, true, true));
    }
    
    private function maybeDoLayout() : Void
    {
        if (_dirty)
        {
            doLayout();
        }
    }
    
    /////////////////
    // Helper methods
    /////////////////
    
    public function addBitmapDataSprite(options : Dynamic, hint : Dynamic = null) : BitmapDataSprite
    {
        var e : BitmapDataSprite = new BitmapDataSprite(options);
        addElement(e, hint);
        return e;
    }
    public function addTextField(options : Dynamic, hint : Dynamic = null) : TextField
    {
        var e : TextField = UIUtils.newTextField(options);
        addElement(e, hint);
        return e;
    }
    
    /**
	 * Create text input
	 * @param options TextInput properties
	 * @param options.bindText [object, keyName]. On change set object[keyName]=value
	 * @param options.bindNumber [object, keyName]. On change set object[keyName]=parseFloat(value) if not NaN
	 * @param hint Layout hint
	 */
    public function addTextInput(options : Dynamic, hint : Dynamic = null) : InputText
    {
        var e : InputText = new InputText();
        UIUtils.setProperties(e, options);
        if (Lambda.has(options, "bindText"))
        {
            var obj : Dynamic = options.bindText[0];
            var key : String = options.bindText[1];
            e.text = Reflect.field(obj, key);
            e.addEventListener(Event.CHANGE, function(event : Event) : Void
                    {
                        Reflect.setField(obj, key, e.text);
                    });
        }
        else if (Lambda.has(options, "bindNumber"))
        {
            obj = options.bindNumber[0];
            key = options.bindNumber[1];
            e.text = obj[key];
            e.addEventListener(Event.CHANGE, function(event : Event) : Void
                    {
                        var value : Float = as3hx.Compat.parseFloat(e.text);
                        if (!Math.isNaN(value))
                        {
                            obj[key] = value;
                        }
                    });
        }
        addElement(e, hint);
        return e;
    }
    
    /**
	 * Create dropdown list
	 * @param options ComboBox properties
	 * @param options.items Array of objects or primitives to select from
	 * @param options.labelKey Item property name to use as label, default "label"
	 * @param options.valueKey Item property name to use as value, default "data"
	 * @param options.bindValue [object, propname]. On change set object[propname] to selected item
	 * @param hint Layout hint
	 */
    public function addComboBox(options : Dynamic, hint : Dynamic = null) : ComboBox
    {
        var e : ComboBox = new ComboBox();
        UIUtils.setProperties(e, options, {
                    value : null
                });
        var labelKey : String = Utils.valueOr(Reflect.field(options, "labelKey"), "label");
        var valueKey : String = Utils.valueOr(Reflect.field(options, "valueKey"), "data");
        var selectedIndex : Int = 0;
        var selectedValue : Dynamic;
        var bindObject : Dynamic;
        var bindProp : String;
        if (Lambda.has(options, "bindValue"))
        {
            bindObject = options.bindValue[0];
            bindProp = options.bindValue[1];
            selectedValue = Reflect.field(bindObject, bindProp);
        }
        else if (Lambda.has(options, "value"))
        {
            selectedValue = options.value;
        }
        var i : Int = 0;
        var items : Array<Dynamic> = [];
        for (item/* AS3HX WARNING could not determine type for var: item exp: EField(EIdent(options),items) type: null */ in options.items)
        {
            var entry : Dynamic;
            if (Std.is(item, Dynamic) && !(Std.is(item, String)) && item != null)
            {
                entry = {
                            label : Reflect.field(item, labelKey),
                            data : Reflect.field(item, valueKey)
                        };
            }
            else
            {
                entry = {
                            label : "" + item,
                            data : item
                        };
            }
            if (entry.data == selectedValue)
            {
                selectedIndex = i;
            }
            items.push(entry);
            i++;
        }
        e.items = items;
        if (bindObject != null)
        {
            e.addEventListener(Event.SELECT, function(event : Event) : Void
                    {
                        event.preventDefault();
                        Reflect.setField(bindObject, bindProp, e.selectedItem.data);
                    });
        }
        addElement(e, hint);
        return e;
    }
}


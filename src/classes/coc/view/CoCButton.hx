package coc.view;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.CoC;
import classes.GameSettings;
import classes.ItemSlotClass;
import classes.ItemType;
import classes.parser.Parser;
import classes.internals.Utils;
import flash.display.Bitmap;
import flash.events.MouseEvent;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

/****
 coc.view.CoCButton

 note that although this stores its current tool tip text,
 it does not display the text.  That is taken care of
 by whoever owns this.

 The mouse event handlers are public to facilitate reaction to
 keyboard events.
 ****/
class CoCButton extends Block
{
    public var enabled(get, set) : Bool;
    public var iconId(get, set) : String;
    public var iconQty(get, set) : String;
    public var cornerLabelText(get, set) : String;
    public var labelText(get, set) : String;
    public var key1text(get, set) : String;
    public var key2text(get, set) : String;
    public var callback(get, set) : Function;
    public var preCallback(get, set) : Function;
    public var labelColor(get, set) : String;

    
    @:meta(Embed(source="../../../res/ui/Shrewsbury-Titling_Bold.ttf",advancedAntiAliasing="true",fontName="ShrewsburyTitlingBold",embedAsCFF="false"))

    private static var ButtonLabelFont : Class<Dynamic>;
    
    @:meta(Embed(source="../../../res/ui/buttonBackground.png"))

    private static var ButtonBackgroundImage : Class<Dynamic>;
    
    @:meta(Embed(source="../../../res/ui/buttonBorder.png"))

    private static var ButtonBorderImage : Class<Dynamic>;
    
    private static inline var BACKGROUND_SIZE : Int = 256;
    public static var ButtonBorder : BorderImage = new BorderImage((try cast(Type.createInstance(ButtonBorderImage, []), Bitmap) catch(e:Dynamic) null).bitmapData, 8, 8, 8, 8);
    
    public static var ButtonLabelFontName : String = (try cast(Type.createInstance(ButtonLabelFont, []), Font) catch(e:Dynamic) null).fontName;
    public static inline var ButtonKeyFontName : String = "Arial";
    public static inline var ButtonKeyFontColor : Dynamic = "#ffffff";
    public static inline var ButtonKeyShadowColor : Dynamic = "#000000";
    public static inline var ButtonKeyFontSize : Int = 10;
    public static var IconQuantityFormat : Dynamic = {
            font : "Arial",
            size : 10,
            bold : true,
            align : "right"
        };
    public static inline var IconQuantityColor : String = "#ffff00";
    public static inline var IconQuantityShadow : String = "#000000";
    
    /**
	 * function(error:Error, button:CoCButton):void
	 */
    public static var clickErrorHandler : Function;
    public static inline var DEFAULT_COLOR : String = "#000000";
    public static inline var MAX_FONT_SIZE : Int = 18;
    public static inline var MIN_FONT_SIZE : Int = 12;
    
    public static inline var ICON_WIDTH : Int = 32;
    public static inline var ICON_HEIGHT : Int = 32;
    private static var BTN_W : Int = MainView.BTN_W;
    private static var BTN_H : Int = MainView.BTN_H;
    private static inline var ICON_Y : Int = 4;
    private static inline var ICON_X : Int = 4;
    private static inline var LABEL_NOICON_X : Int = 0;
    private static var LABEL_ICON_X : Int = ICON_X + ICON_WIDTH;
    private static inline var LABEL_RIGHT : Int = 2;
    private static inline var LABEL_Y : Int = 8;  // works for default font size  
    
    
    private var _labelField : TextField;private var _key1label : TextField;private var _key2label : TextField;private var _iconQuantityLabel : TextField;private var _cornerLabel : TextField;private var _iconGraphic : BitmapDataSprite;private var _backgroundGraphic : BitmapDataSprite;private var _enabled : Bool = true;private var _callback : Function = null;private var _preCallback : Function = null;private var _iconId : String = null;
    
    public var toolTipHeader : String;public var toolTipText : String;
    
    /**
		 * @param options  enabled, labelText, bitmapClass, callback
		 */
    public function new(options : Dynamic = null)
    {
        super();
        var width : Float = 
        ((options != null && Lambda.has(options, "square"))) ? BTN_H : 
        ((options != null && Lambda.has(options, "width"))) ? Reflect.field(options, "width") : BTN_W;
        var height : Float = BTN_H;
        this.width = width;
        this.height = height;
        _backgroundGraphic = addBitmapDataSprite({
                            width : width,
                            height : BTN_H,
                            bitmapX : Math.max(0, Math.random() * (BACKGROUND_SIZE - width)) | 0,
                            bitmapY : Math.max(0, Math.random() * (BACKGROUND_SIZE - height)) | 0,
                            bitmapClass : ButtonBackgroundImage,
                            stretch : false,
                            crop : true,
                            repeat : true,
                            borderImage : ButtonBorder
                        });
        _labelField = addTextField({
                            width : width - LABEL_RIGHT - LABEL_NOICON_X,
                            embedFonts : true,
                            x : LABEL_NOICON_X,
                            y : LABEL_Y,
                            height : BTN_H - LABEL_Y,
                            defaultTextFormat : {
                                font : ButtonLabelFontName,
                                size : MAX_FONT_SIZE,
                                align : "center"
                            }
                        });
        
        this.mouseChildren = true;
        this.buttonMode = true;
        this.visible = true;
        UIUtils.setProperties(this, options);
        
        this.addEventListener(MouseEvent.ROLL_OVER, this.hover);
        this.addEventListener(MouseEvent.ROLL_OUT, this.dim);
        this.addEventListener(MouseEvent.CLICK, this.click);
        this.resize();
    }
    private function iconElement() : BitmapDataSprite
    {
        if (_iconGraphic != null)
        {
            return _iconGraphic;
        }
        _iconGraphic = try cast(addElementBelow(new BitmapDataSprite({
                            stretch : true,
                            smooth : false,
                            visible : false,
                            x : ICON_X,
                            y : ICON_Y,
                            width : ICON_WIDTH,
                            height : ICON_HEIGHT
                        }), _labelField), BitmapDataSprite) catch(e:Dynamic) null;
        return _iconGraphic;
    }
    private function iconQuantityElement() : TextField
    {
        if (_iconQuantityLabel != null)
        {
            return _iconQuantityLabel;
        }
        _iconQuantityLabel = try cast(addElementAbove(UIUtils.newTextField({
                                    x : ICON_X,
                                    y : ICON_Y + (ICON_HEIGHT / 2),
                                    width : ICON_WIDTH,
                                    height : ICON_HEIGHT / 2,
                                    textColor : IconQuantityColor,
                                    defaultTextFormat : IconQuantityFormat
                                }), iconElement()), TextField) catch(e:Dynamic) null;
        _iconQuantityLabel.filters = [UIUtils.outlineFilter(IconQuantityShadow)];
        return _iconQuantityLabel;
    }
    private function cornerLabelElement() : TextField
    {
        if (_cornerLabel != null)
        {
            return _cornerLabel;
        }
        _cornerLabel = try cast(addElementAbove(UIUtils.newTextField({
                                    x : ICON_X,
                                    width : width - ICON_X * 2,
                                    y : ICON_Y,
                                    height : ICON_HEIGHT / 2,
                                    textColor : IconQuantityColor,
                                    defaultTextFormat : IconQuantityFormat
                                }), _labelField), TextField) catch(e:Dynamic) null;
        _cornerLabel.filters = [UIUtils.outlineFilter(IconQuantityShadow)];
        return _cornerLabel;
    }
    private function key1labelElement() : TextField
    {
        if (_key1label != null)
        {
            return _key1label;
        }
        _key1label = try cast(addElementAbove(UIUtils.newTextField({
                                    alpha : 0.5,
                                    x : 8,
                                    width : width - 12,
                                    y : 2,
                                    height : (MainView.BTN_H - 4) / 2,
                                    textColor : ButtonKeyFontColor,
                                    defaultTextFormat : {
                                        font : ButtonKeyFontName,
                                        size : ButtonKeyFontSize,
                                        bold : true,
                                        align : "right"
                                    }
                                }), _labelField), TextField) catch(e:Dynamic) null;
        _key1label.filters = [UIUtils.outlineFilter(ButtonKeyShadowColor)];
        return _key1label;
    }
    private function key2labelElement() : TextField
    {
        if (_key2label != null)
        {
            return _key2label;
        }
        _key2label = try cast(addElementAbove(UIUtils.newTextField({
                                    alpha : 0.5,
                                    x : 8,
                                    width : width - 12,
                                    y : 2 + (MainView.BTN_H - 4) / 2,
                                    height : (MainView.BTN_H - 4) / 2,
                                    textColor : ButtonKeyFontColor,
                                    defaultTextFormat : {
                                        font : ButtonKeyFontName,
                                        size : ButtonKeyFontSize,
                                        bold : true,
                                        align : "right"
                                    }
                                }), _labelField), TextField) catch(e:Dynamic) null;
        _key2label.filters = [UIUtils.outlineFilter(ButtonKeyShadowColor)];
        return _key2label;
    }
    
    override private function resize() : Void
    {
        if (_backgroundGraphic != null)
        {
            _backgroundGraphic.width = innerWidth;
            if (_key1label != null)
            {
                _key1label.width = innerWidth - 12;
            }
            if (_key2label != null)
            {
                _key2label.width = innerWidth - 12;
            }
            iconId = iconId;
        }
        if (_cornerLabel != null)
        {
            _cornerLabel.width = width - ICON_X * 2;
        }
        super.resize();
    }
    
    //////// Mouse Events... ////////
    
    public function hover(event : MouseEvent = null) : Void
    {
        if (this._backgroundGraphic)
        {
            this._backgroundGraphic.alpha = (enabled) ? 0.5 : 0.4;
        }
        if (visible && toolTipText != null)
        {
            CoC.instance.mainView.toolTipView.showForElement(this, toolTipHeader, toolTipText);
        }
    }
    
    public function dim(event : MouseEvent = null) : Void
    {
        if (this._backgroundGraphic)
        {
            this._backgroundGraphic.alpha = (enabled) ? 1 : 0.4;
        }
        CoC.instance.mainView.toolTipView.hide();
    }
    
    public function click(event : MouseEvent = null) : Void
    {
        if (!this.enabled)
        {
            return;
        }
        CoC.instance.mainView.toolTipView.hide();
        try
        {
            if (this._preCallback != null)
            {
                this._preCallback(this);
            }
            if (this._callback != null)
            {
                this._callback();
            }
        }
        catch (e : Error)
        {
            if (clickErrorHandler != null)
            {
                clickErrorHandler(e, this);
            }
            else
            {
                throw e;
            }
        }
    }
    
    
    
    //////// Getters and Setters ////////
    
    private function get_enabled() : Bool
    {
        return _enabled;
    }
    private function set_enabled(value : Bool) : Bool
    {
        _enabled = value;
        var alpha : Float = (value) ? 1 : 0.4;
        this._labelField.alpha = alpha;
        this._backgroundGraphic.alpha = alpha;
        if (_iconGraphic != null)
        {
            this._iconGraphic.alpha = alpha;
        }
        return value;
    }
    
    private function get_iconId() : String
    {
        return _iconId;
    }
    
    private function set_iconId(iconId : String) : String
    {
        if (!GameSettings.buttonIconsEnabled)
        {
            return iconId;
        }
        _iconId = iconId;
        var bitmap : Bitmap = (iconId != null) ? IconLib.getBitmap(iconId) : null;
        if (bitmap != null)
        {
            iconElement();
            _iconGraphic.bitmap = IconLib.getBitmap(iconId);
            _iconGraphic.visible = true;
            this._labelField.x = LABEL_ICON_X;
        }
        else
        {
            if (_iconGraphic != null)
            {
                _iconGraphic.visible = false;
            }
            this._labelField.x = LABEL_NOICON_X;
        }
        this._labelField.width = width - LABEL_RIGHT - this._labelField.x;
        if (_iconQuantityLabel != null && _iconGraphic != null)
        {
            _iconQuantityLabel.visible = _iconGraphic.visible;
        }
        if (labelText != null)
        {
            labelText = labelText;
        }
        return iconId;
    }
    private function get_iconQty() : String
    {
        return (_iconQuantityLabel != null && _iconQuantityLabel.visible) ? _iconQuantityLabel.text : "";
    }
    private function set_iconQty(value : String) : String
    {
        if (value != null && _iconQuantityLabel == null)
        {
            iconQuantityElement();
        }
        if (_iconQuantityLabel != null)
        {
            _iconQuantityLabel.text = value;
            _iconQuantityLabel.visible = _iconGraphic && _iconGraphic.visible;
        }
        return value;
    }
    public function cornerLabel(value : String) : CoCButton
    {
        cornerLabelText = value;
        return this;
    }
    private function get_cornerLabelText() : String
    {
        return (_cornerLabel != null) ? _cornerLabel.text : "";
    }
    private function set_cornerLabelText(value : String) : String
    {
        if (value != null && _cornerLabel == null)
        {
            cornerLabelElement();
        }
        if (_cornerLabel != null)
        {
            _cornerLabel.text = value;
        }
        return value;
    }
    public function icon(iconId : String, iconQty : String = "") : CoCButton
    {
        this.iconId = iconId;
        this.iconQty = iconQty;
        return this;
    }
    private function get_labelText() : String
    {
        return this._labelField.text;
    }
    
    private function set_labelText(value : String) : String
    {
        var fontSize : Int = MAX_FONT_SIZE;
        var tf : TextFormat = this._labelField.defaultTextFormat;
        tf.size = fontSize;
        this._labelField.defaultTextFormat = tf;
        this._labelField.text = value;
        this._labelField.y = LABEL_Y;
        this._labelField.height = BTN_H - this._labelField.y;
        while (this._labelField.textWidth + 2 > this._labelField.width && fontSize > MIN_FONT_SIZE)
        {
            fontSize--;
            tf.size = fontSize;
            this._labelField.defaultTextFormat = tf;
            this._labelField.text = value;
            this._labelField.y = (BTN_H - this._labelField.textHeight) / 2;
            this._labelField.height = BTN_H - this._labelField.y;
        }
        return value;
    }
    private function get_key1text() : String
    {
        return (_key1label != null) ? this._key1label.text : "";
    }
    
    private function set_key1text(value : String) : String
    {
        key1labelElement();
        this._key1label.text = value;
        return value;
    }
    
    private function get_key2text() : String
    {
        return (_key2label != null) ? this._key2label.text : "";
    }
    
    private function set_key2text(value : String) : String
    {
        key2labelElement();
        this._key2label.text = value;
        return value;
    }
    
    private function get_callback() : Function
    {
        return this._callback;
    }
    
    private function set_callback(value : Function) : Function
    {
        this._callback = value;
        return value;
    }
    
    /**
	 * In case of needing to execute multiple callback when button press
	 * e.g. during combat need to end player turn
	 * use this instead of hardcoding everything
	 * @param postCallback
	 * @return
	 */
    public function and(postCallback : Function) : Void
    {
        var oldCb : Function = this.callback;
        this.callback = function() : Void
                {
                    oldCb();
                    postCallback();
                };
    }
    
    private function get_preCallback() : Function
    {
        return _preCallback;
    }
    private function set_preCallback(value : Function) : Function
    {
        _preCallback = value;
        return value;
    }
    //////////// Builder functions
    /**
	 * Setup (text, callback, tooltip) and show enabled button. Removes all previously set options
	 * @return this
	 */
    public function show(text : String, callback : Function, toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        this.reset();
        this.labelText = text;
        this.callback = callback;
        this.toolTipText = toolTipText;
        this.toolTipHeader = toolTipHeader || text;
        if (this.labelText)
        {
            this.labelText = Parser.recursiveParser(this.labelText);
        }
        if (this.toolTipText)
        {
            this.toolTipText = Parser.recursiveParser(this.toolTipText);
        }
        if (this.toolTipHeader)
        {
            this.toolTipHeader = Parser.recursiveParser(this.toolTipHeader);
        }
        this.visible = true;
        this.enabled = (this.callback != null);
        return this;
    }
    
    public function color(rgb : Dynamic) : CoCButton
    {
        labelColor = rgb;
        return this;
    }
    private function get_labelColor() : String
    {
        return Color.toHex(this._labelField.textColor);
    }
    private function set_labelColor(value : Dynamic) : Dynamic
    {
        this._labelField.textColor = Color.convertColor(value);
        return value;
    }
    /**
	 * Set color, text, and hint from the item
	 */
    public function itemTexts(item : ItemType) : CoCButton
    {
        text(item.shortName, item.description, Utils.capitalizeFirstLetter(item.longName));
        color(item.buttonColor);
        return this;
    }
    /**
	 * Set hint from the item
	 */
    public function itemHints(item : ItemType) : CoCButton
    {
        text(labelText, item.description, Utils.capitalizeFirstLetter(item.longName));
        return this;
    }
    /**
	 * Set color, text, and hint from the item slot
	 */
    public function itemSlotTexts(slot : ItemSlotClass) : CoCButton
    {
        itemIcon(slot.itype);
        itemTexts(slot.itype);
        iconQty = "";
        if (slot.quantity > 1 || slot.itype.stackSize > 1)
        {
            toolTipHeader = "" + slot.quantity + " x " + toolTipHeader;
            if (_iconGraphic != null && _iconGraphic.visible)
            {
                iconQty = Std.string(slot.quantity);
            }
            else
            {
                labelText += " x" + slot.quantity;
            }
        }
        return this;
    }
    public function itemIcon(item : ItemType) : CoCButton
    {
        iconId = item.iconId;
        return this;
    }
    public function showForItem(item : ItemType, callback : Function) : CoCButton
    {
        show(item.shortName, callback);
        itemIcon(item);
        itemTexts(item);
        return this;
    }
    public function showForItemSlot(slot : ItemSlotClass, callback : Function) : CoCButton
    {
        if (slot.isEmpty())
        {
            showDisabled("Empty");
            hint("");
            color(DEFAULT_COLOR);
            iconId = null;
            iconQty = "";
            return this;
        }
        showForItem(slot.itype, callback);
        if (slot.itype.stackSize > 1 || slot.quantity > 1)
        {
            iconQty = Std.string(slot.quantity);
        }
        else
        {
            iconQty = "";
        }
        itemSlotTexts(slot);
        return this;
    }
    /**
	 * Setup (text, tooltip, and show) disabled button. Removes all previously set options
	 * @return this
	 */
    public function showDisabled(text : String, toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        return show(text, null, toolTipText, toolTipHeader);
    }
    /**
	 * Set text and tooltip. Don't change callback, enabled, visibility
	 * @return this
	 */
    public function text(text : String, toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        this.labelText = text;
        this.toolTipText = toolTipText || labelText;
        this.toolTipHeader = toolTipHeader;
        if (this.toolTipText)
        {
            this.toolTipText = Parser.recursiveParser(this.toolTipText);
        }
        if (this.toolTipHeader)
        {
            this.toolTipHeader = Parser.recursiveParser(this.toolTipHeader);
        }
        return this;
    }
    /**
	 * Set tooltip only. Don't change text, callback, enabled, visibility
	 * @return this
	 */
    public function hint(toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        this.toolTipText = toolTipText;
        this.toolTipHeader = toolTipHeader || labelText;
        if (this.toolTipText)
        {
            this.toolTipText = Parser.recursiveParser(this.toolTipText);
        }
        if (this.toolTipHeader)
        {
            this.toolTipHeader = Parser.recursiveParser(this.toolTipHeader);
        }
        return this;
    }
    /**
	 * Disable if condition is true, optionally change tooltip and/or label. Does not un-hide button.
	 * If tooltipText starts with '++', the text after '++' will be appended to existing hint.
	 * @return this
	 */
    public function disableIf(condition : Bool, toolTipText : String = null, labelText : String = null) : CoCButton
    {
        if (condition)
        {
            enabled = false;
            if (toolTipText != null)
            {
                if (toolTipText.indexOf("++") == 0)
                {
                    this.toolTipText += Parser.recursiveParser(toolTipText).slice(2);
                }
                else
                {
                    this.toolTipText = Parser.recursiveParser(toolTipText);
                }
            }
            if (labelText != null)
            {
                this.labelText = labelText;
            }
        }
        return this;
    }
    /**
	 * Disable, optionally change tooltip. Does not un-hide button.
	 * @return this
	 */
    public function disable(toolTipText : String = null) : CoCButton
    {
        enabled = false;
        if (toolTipText != null)
        {
            this.toolTipText = Parser.recursiveParser(toolTipText);
        }
        return this;
    }
    
    /**
	 * Enable, optionally change tooltip. Does not un-hide button.
	 * @return this
	 */
    public function enable(toolTipText : String = null) : CoCButton
    {
        enabled = true;
        if (toolTipText != null)
        {
            this.toolTipText = Parser.recursiveParser(toolTipText);
        }
        return this;
    }
    
    /**
	 * Set callback to fn(...args)
	 * @return this
	 */
    public function call(fn : Function, args : Array<Dynamic> = null) : CoCButton
    {
        this.callback = Utils.curry.apply(null, [fn].concat(args));
        return this;
    }
    
    public function reset() : CoCButton
    {
        color(DEFAULT_COLOR);
        visible = false;
        labelText = "";
        toolTipHeader = "";
        toolTipText = "";
        alpha = 1;
        enabled = false;
        callback = null;
        iconId = null;
        iconQty = "";
        cornerLabelText = "";
        return this;
    }
    /**
	 * Hide the button
	 * @return this
	 */
    public function hide() : CoCButton
    {
        visible = false;
        return this;
    }
    /**
	 * Show the button with all properties from previous configuration
	 * @return this
	 */
    public function unhide() : CoCButton
    {
        visible = true;
        return this;
    }
}


package classes.scenes.aPI;

import classes.ItemType;
import classes.internals.Utils;
import coc.view.CoCButton;

class MerchantItem extends Utils
{
    @:allow(classes.scenes.aPI)
    private var _menu : MerchantMenu;
    @:allow(classes.scenes.aPI)
    private var _item : ItemType;
    @:allow(classes.scenes.aPI)
    private var _amount : Int;
    @:allow(classes.scenes.aPI)
    private var _price : Int;
    @:allow(classes.scenes.aPI)
    private var _hint : String = "";
    @:allow(classes.scenes.aPI)
    private var _disabled : Bool = false;
    @:allow(classes.scenes.aPI)
    private var _disabledHint : String = null;
    @:allow(classes.scenes.aPI)
    private var _hide : Bool = false;
    
    public function new(
            menu : MerchantMenu,
            item : ItemType,
            price : Int,
            amount : Int = -1)
    {
        super();
        this._menu = menu;
        this._item = item;
        this._price = price;
        this._amount = amount;
        this._hint = item.description;
        if (_hint.match(new as3hx.Compat.Regex('Base value: \\d+', "")))
        {
            _hint = new as3hx.Compat.Regex('Base value: \\d+', "").replace(_hint, "Price: " + _price);
        }
        else
        {
            _hint = _hint += "\nPrice: " + _price;
        }
    }
    
    public function hint(toolTipText : String) : MerchantItem
    {
        this._hint = toolTipText;
        return this;
    }
    
    public function applyToButton(button : CoCButton) : Void
    {
        if (_item.isNothing)
        {
            button.hide();
            return;
        }
        if (_hide)
        {
            button.showDisabled("???", _disabledHint);
            return;
        }
        
        button.showForItem(_item, curry(_menu.merchantItemClick, this));
        
        if (_amount >= 0)
        {
            button.iconQty = Std.string(_amount);
        }
        button.toolTipText = _hint;
        if (_disabled)
        {
            button.disable((_disabledHint != null) ? _disabledHint + "\n" + button.toolTipText : null);
        }
        else if (_amount == 0)
        {
            button.disable("<b>Out of stock!</b>\n\n" + button.toolTipText);
        }
        else if (_menu.getCurrencyFn() < _price)
        {
            button.disable("<b>Can't afford!</b>\n\n" + button.toolTipText);
        }
    }
    
    public function disableIf(condition : Bool, tooltipHint : String = null, hide : Bool = false) : MerchantItem
    {
        if (!_disabled && condition)
        {
            _disabled = true;
            if (tooltipHint != null)
            {
                _disabledHint = tooltipHint;
            }
            _hide = true;
        }
        return this;
    }
}


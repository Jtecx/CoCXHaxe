package classes.display;

import haxe.Constraints.Function;
import coc.view.Block;
import coc.view.CoCButton;
import flash.text.TextField;

/**
	 * Defines a composite display object of all the seperate components required to display a
	 * single BoundControlMethod, its associated primary and secondary bindings with the buttons
	 * used to bind methods to new keys.
	 * @author Gedan
	 */
class BindDisplay extends Block
{
    public var text(get, set) : String;
    public var htmlText(get, set) : String;
    public var button1Text(get, set) : String;
    public var button2Text(get, set) : String;
    public var button1Callback(never, set) : Function;
    public var button2Callback(never, set) : Function;

    // Object components and settings
    private var _nameLabel : TextField;
    private var _button1 : CoCButton;
    private var _button2 : CoCButton;
    
    /**
		 * Create a new composite object, initilizing the label to be used for display, as well as the two
		 * buttons used for user interface.
		 *
		 * @param	maxWidth	Defines the maximum available width that the control can consume for positining math
		 */
    public function new(maxWidth : Int)
    {
        super();
        layoutConfig = {
                    type : Block.LAYOUT_GRID,
                    cols : 3,
                    setWidth : true
                };
        width = maxWidth;
        _nameLabel = addTextField({
                            text : "THIS IS SOME KINDA CRAZY LABEL",
                            defaultTextFormat : {
                                font : "Times New Roman",
                                size : 20,
                                align : "right"
                            }
                        });
        addElement(_button1 = new CoCButton({
                            labelText : "Unbound"
                        }));
        addElement(_button2 = new CoCButton({
                            labelText : "Unbound"
                        }));
    }
    
    private function get_text() : String
    {
        return _nameLabel.text;
    }
    
    private function set_text(value : String) : String
    {
        _nameLabel.text = value;
        return value;
    }
    
    private function get_htmlText() : String
    {
        return _nameLabel.htmlText;
    }
    
    private function set_htmlText(value : String) : String
    {
        _nameLabel.htmlText = value;
        return value;
    }
    
    private function get_button1Text() : String
    {
        return _button1.labelText;
    }
    
    private function get_button2Text() : String
    {
        return _button2.labelText;
    }
    
    private function set_button1Text(value : String) : String
    {
        _button1.labelText = value;
        return value;
    }
    
    private function set_button2Text(value : String) : String
    {
        _button2.labelText = value;
        return value;
    }
    
    private function set_button1Callback(callback : Function) : Function
    {
        _button1.callback = callback;
        return callback;
    }
    
    private function set_button2Callback(callback : Function) : Function
    {
        _button2.callback = callback;
        return callback;
    }
}



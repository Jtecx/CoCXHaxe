package classes;

import haxe.Constraints.Function;
import classes.display.BindingPane;
import coc.view.CoCButton;

/**
 * Defines a container to wrap a closure around a game function, associating the callable object
 * with a string name representation of the action undertaken, a description, and the associated
 * keyCodes that the action is triggered by.
 * The keyCodes are stored here primarily for ease of display, as we have a handy refernece for
 * a displayable function name AND the actual keyCodes the function uses. The actual interface used
 * for incoming key code -> do action is internal to the InputManager instance.
 * @author Gedan
 */
class BoundControlMethod
{
    public var Name(get, never) : String;
    public var Description(get, never) : String;
    public var Func(get, never) : Function;
    public var PrimaryKey(get, set) : Int;
    public var SecondaryKey(get, set) : Int;
    public var Index(get, never) : Int;
    public var button(get, set) : CoCButton;
    public var showHotkeys(get, set) : Bool;

    private var _funcToCall : Function;
    private var _shortName : String;
    private var _descript : String;
    
    private var _primaryKey : Int;
    private var _secondaryKey : Int;
    
    private var _index : Int;
    private var _button : CoCButton;
    private var _showHotkeys : Bool = true;
    
    /**
	 * Define a new bindable control method with "Unbound" keys.
	 *
	 * @param	func			The function closure used by this BoundControlMethod
	 * @param	name			The friendly name used for this BoundControlMethod
	 * @param	desc			A Description of what the BoundControlMethod does
	 * @param 	primaryKey		The primary bound key code
	 * @param	secondarykey 	The secondary bound key code
	 */
    public function new(func : Function, name : String, desc : String, index : Int, primaryKey : Int = -1, secondaryKey : Int = -1)
    {
        _funcToCall = func;
        _shortName = name;
        _descript = desc;
        _index = index;
        
        _primaryKey = primaryKey;
        _secondaryKey = secondaryKey;
    }
    
    /**
	 * Execute the wrapped BoundControlMethod. Uses an apply() call, so that arguments
	 * can be passed to the wrapped function.
	 * @param	... args	Args to pass to the wrapped function.
	 */
    public function ExecFunc(args : Array<Dynamic> = null) : Void
    {
        Reflect.callMethod(null, _funcToCall, args);
    }
    
    private function get_Name() : String
    {
        return _shortName;
    }
    
    private function get_Description() : String
    {
        return _descript;
    }
    
    private function get_Func() : Function
    {
        return _funcToCall;
    }
    
    private function get_PrimaryKey() : Int
    {
        return _primaryKey;
    }
    
    private function set_PrimaryKey(keyCode : Int) : Int
    {
        _primaryKey = keyCode;
        updateHotkeys();
        return keyCode;
    }
    
    private function get_SecondaryKey() : Int
    {
        return _secondaryKey;
    }
    
    private function set_SecondaryKey(keyCode : Int) : Int
    {
        _secondaryKey = keyCode;
        updateHotkeys();
        return keyCode;
    }
    
    private function get_Index() : Int
    {
        return _index;
    }
    
    
    private function get_button() : CoCButton
    {
        return _button;
    }
    private function set_button(value : CoCButton) : CoCButton
    {
        if (_button != null)
        {
            _button.key1text = "";
            _button.key2text = "";
        }
        _button = value;
        updateHotkeys();
        return value;
    }
    
    private function get_showHotkeys() : Bool
    {
        return _showHotkeys;
    }
    private function set_showHotkeys(value : Bool) : Bool
    {
        _showHotkeys = value;
        updateHotkeys();
        return value;
    }
    private function updateHotkeys() : Void
    {
        if (_button != null)
        {
            _button.key1text = _showHotkeys && _primaryKey != -(1) ? BindingPane.keyName(_primaryKey, "") : "";
            _button.key2text = _showHotkeys && _secondaryKey != -(1) ? BindingPane.keyName(_secondaryKey, "") : "";
        }
    }
}



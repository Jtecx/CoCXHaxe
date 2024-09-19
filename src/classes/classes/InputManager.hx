package classes;

import haxe.Constraints.Function;
import classes.display.BindingPane;
import coc.view.CoCButton;
import coc.view.MainView;
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.text.TextField;

/**
	 * Generic input manager
	 * I feel sick writing some of these control functors; rather than having some form of queryable game state
	 * we're checking for the presence (and sometimes, the label contents) of UI elements to determine what state
	 * the game is currently in.
	 * @author Gedan
	 */
class InputManager
{
    public var showHotkeys(get, set) : Bool;

    // Declaring some consts for clarity when using some of the InputManager methods
    public static var PRIMARYKEY : Bool = true;
    public static var SECONDARYKEY : Bool = false;
    public static var NORMALCONTROL : Bool = false;
    public static var CHEATCONTROL : Bool = true;
    public static var UNBOUNDKEY : Int = -1;
    
    private var _stage : Stage;
    private var _debug : Bool;
    
    private var _defaultControlMethods : Dynamic = {};
    private var _defaultAvailableControlMethods : Int = 0;
    private var _defaultKeysToControlMethods : Dynamic = {};
    
    // Basically, an associative list of Names -> Control Methods
    private var _controlMethods : Dynamic = {};
    private var _availableControlMethods : Int = 0;
    
    // A list of cheat control methods that we can throw incoming keycodes against at will
    private var _cheatControlMethods : Array<Dynamic> = new Array<Dynamic>();
    private var _availableCheatControlMethods : Int = 0;
    
    // The primary lookup method for finding what method an incoming keycode should belong too
    // Sparse array of keyCode -> BoundControlMethod.Name, used to look into _controlMethods
    private var _keysToControlMethods : Dynamic = {};
    
    // Visual shit
    private var _mainView : MainView;
    private var _mainText : TextField;
    
    // A new UI element that we can embed buttons into to facilitate key rebinding
    private var _bindingPane : BindingPane;
    
    // A flag to determine if we're listening for keyCodes to execute, or keyCodes to bind a method against
    private var _bindingMode : Bool;
    private var _bindingFunc : String;
    private var _bindingSlot : Bool;
    
    /**
		 * Init the InputManager. Attach the keyboard event listener to the stage and prepare the subobjects for usage.
		 * @param	stage	Reference to core stage on which to add display objects
		 * @param	_mainView
		 * @param	debug	Emit debugging trace statements
		 */
    public function new(stage : Stage,
            _mainView : MainView,
            debug : Bool = true)
    {
        _bindingMode = false;
        _debug = debug;
        
        _stage = stage;
        this._mainView = _mainView;
        _availableControlMethods = 0;
        _availableCheatControlMethods = 0;
        
        _stage.addEventListener(KeyboardEvent.KEY_DOWN, this.KeyHandler);
        
        _mainText = try cast(_mainView.mainText, TextField) catch(e:Dynamic) null;
        
        _bindingPane = new BindingPane(this, _mainText.x + 2, _mainText.y + 2, _mainText.width + 2, _mainText.height + 3);
    }
    
    /**
		 * Mode toggle - keyboard events recieved by the input manager will be used to associated the incoming keycode
		 * with a new bound control method, removing the keycode from *other* bindings and updating data as appropriate.
		 * Displays a message indicating the player should do the needful.
		 * @param	funcName	BoundControlMethod name that they key is going to be associated with. Set by a button
		 * 						callback function generated in BindingPane
		 * @param	isPrimary	Specifies if the incoming bind will replace/set the primary or secondary bind for a control.
		 */
    public function ListenForNewBind(funcName : String, isPrimary : Bool = true) : Void
    {
        if (_debug)
        {
            var slot : String = "";
            
            if (isPrimary)
            {
                slot = "Primary";
            }
            else
            {
                slot = "Secondary";
            }
            
            trace("Listening for a new " + slot + " bind for " + funcName);
        }
        
        _bindingMode = true;
        _bindingFunc = funcName;
        _bindingSlot = isPrimary;
        
        _mainText.htmlText = "<b>Hit the key that you want to bind " + funcName + " to!</b>";
        
        // hide some buttons that will fuck shit up
        _mainView.hideCurrentBottomButtons();
        
        HideBindingPane();
    }
    
    /**
		 * Mode toggle - return to normal keyboard event listening mechanics. Shows the binding display again.
		 */
    public function StopListenForNewBind() : Void
    {
        _bindingMode = false;
        _mainView.showCurrentBottomButtons();
        DisplayBindingPane();
    }
    
    /**
		 * Add a new action that can be associated with incoming key codes.
		 * This will mostly be static after first being initialized, this pattern was just easier to capture references
		 * to the required game functions without having to make the InputManager truely global or doing any namespacing
		 * shenanigans.
		 * The closure can be declared with the rest of the game code, in the namespace where the functions are available,
		 * and still work inside this object.
		 * @param	name		Name to associate the BoundControlMethod with
		 * @param	desc		A description of the activity that the BoundControlMethod does. (Unused, but implemented)
		 * @param	func		A function object that defines the BoundControlMethods action
		 * @param	isCheat		Differentiates between a cheat method (not displayed in the UI) and normal controls.
		 */
    public function AddBindableControl(name : String, desc : String, func : Function, button : CoCButton = null, isCheat : Bool = false) : Void
    {
        var bcm : BoundControlMethod;
        if (isCheat)
        {
            bcm = new BoundControlMethod(func, name, desc, _availableCheatControlMethods++);
            _cheatControlMethods.push(bcm);
        }
        else
        {
            bcm = new BoundControlMethod(func, name, desc, _availableControlMethods++);
            Reflect.setField(_controlMethods, name, bcm);
        }
        if (button != null)
        {
            bcm.button = button;
        }
    }
    
    /**
		 * Set either the primary or secondary binding for a target control method to a given keycode.
		 * @param	keyCode		The keycode to bind the method to.
		 * @param	funcName	The name of the associated BoundControlMethod
		 * @param	isPrimary	Specifies the primary or secondary binding slot
		 */
    public function BindKeyToControl(keyCode : Int, funcName : String, isPrimary : Bool = true) : Void
    {
        for (key in Reflect.fields(_controlMethods))
        
        // Find the method we want to bind the incoming key to{
            
            if (funcName == key)
            
            // Check if the incoming key is already bound to *something* and if it is, remove the bind.{
                
                this.RemoveExistingKeyBind(keyCode);
                
                // If we're binding the primary key of the method...
                if (isPrimary)
                
                // If the primary key of the method is already bound, removing the existing bind{
                    
                    if (Reflect.field(_controlMethods, key).PrimaryKey != InputManager.UNBOUNDKEY)
                    {
                        Reflect.deleteField(_keysToControlMethods, Reflect.field(_controlMethods, key).PrimaryKey);
                    }
                    
                    // Add the new bind
                    Reflect.setField(_keysToControlMethods, Std.string(keyCode), key);
                    Reflect.setField(_controlMethods, key, keyCode).PrimaryKey;
                    return;
                }
                // We're doing the secondary key of the method
                else
                {
                    
                    {
                        // If the secondary key is already bound, remove the existing bind
                        if (Reflect.field(_controlMethods, key).SecondaryKey != InputManager.UNBOUNDKEY)
                        {
                            Reflect.deleteField(_keysToControlMethods, Reflect.field(_controlMethods, key).SecondaryKey);
                        }
                        
                        // Add the new bind
                        Reflect.setField(_keysToControlMethods, Std.string(keyCode), key);
                        Reflect.setField(_controlMethods, key, keyCode).SecondaryKey;
                        return;
                    }
                }
            }
        }
        
        if (_debug)
        {
            trace("Failed to bind control method [" + funcName + "] to keyCode [" + keyCode + "]");
        }
    }
    
    /**
		 * Remove an existing key from a BoundControlMethod, if present, and shuffle the remaining key as appropriate
		 * @param	keyCode		The keycode to remove.
		 */
    public function RemoveExistingKeyBind(keyCode : Int) : Void
    // If the key is already bound to a method, remove it from that method
    {
        
        if (Reflect.field(_keysToControlMethods, Std.string(keyCode)) != null)
        {
            if (Reflect.field(_controlMethods, Std.string(Reflect.field(_keysToControlMethods, Std.string(keyCode)))).PrimaryKey == keyCode)
            {
                Reflect.setField(_controlMethods, Std.string(Reflect.field(_keysToControlMethods, Std.string(keyCode))), Reflect.field(_controlMethods, Std.string(Reflect.field(_keysToControlMethods, Std.string(keyCode)))).SecondaryKey).PrimaryKey;
                Reflect.setField(_controlMethods, Std.string(Reflect.field(_keysToControlMethods, Std.string(keyCode))), InputManager.UNBOUNDKEY).SecondaryKey;
            }
            else if (Reflect.field(_controlMethods, Std.string(Reflect.field(_keysToControlMethods, Std.string(keyCode)))).SecondaryKey == keyCode)
            {
                Reflect.setField(_controlMethods, Std.string(Reflect.field(_keysToControlMethods, Std.string(keyCode))), InputManager.UNBOUNDKEY).SecondaryKey;
            }
        }
    }
    
    /**
		 * The core event handler we attach to the stage to capture incoming keyboard events.
		 * @param	e		KeyboardEvent data
		 */
    public function KeyHandler(e : KeyboardEvent) : Void
    {
        if (_debug)
        {
            trace("Got key input " + e.keyCode);
        }
        
        // Ignore key input during certain phases of gamestate
        if (_mainView.eventTestInput.x == 207.5 || _mainView.hotkeysDisabled)
        {
            return;
        }
        
        if (_mainView.nameBox.visible && _stage.focus == _mainView.nameBox)
        {
            return;
        }
        
        // If we're not in binding mode, listen for key inputs to act on
        if (_bindingMode == false)
        
        // Made it this far, process the key and call the relevant (if any) function{
            
            this.ExecuteKeyCode(e.keyCode);
        }
        // Otherwise, we're listening for a new keycode from the player
        else
        {
            
            {
                BindKeyToControl(e.keyCode, _bindingFunc, _bindingSlot);
                StopListenForNewBind();
            }
        }
    }
    
    /**
		 * Execute the BoundControlMethod's wrapped function associated with the given KeyCode
		 * @param	keyCode		The KeyCode for which we wish to execute the BoundControlMethod for.
		 */
    private function ExecuteKeyCode(keyCode : Int) : Void
    {
        if (Reflect.field(_keysToControlMethods, Std.string(keyCode)) != null)
        {
            if (_debug)
            {
                trace("Attempting to exec func [" + Reflect.field(_controlMethods, Std.string(Reflect.field(_keysToControlMethods, Std.string(keyCode)))).Name + "]");
            }
            
            Reflect.field(_controlMethods, Std.string(Reflect.field(_keysToControlMethods, Std.string(keyCode)))).ExecFunc();
        }
        
        for (i in 0..._cheatControlMethods.length)
        {
            _cheatControlMethods[i].ExecFunc(keyCode);
        }
    }
    
    /**
		 * Hide the mainText object and scrollbar, ensure the binding ScrollPane is up to date with the latest
		 * data and then show the binding scrollpane.
		 */
    public function DisplayBindingPane() : Void
    {
        _mainText.visible = false;
        
        _bindingPane.functions = this.GetAvailableFunctions();
        _bindingPane.ListBindingOptions();
        
        _mainText.parent.addChild(_bindingPane);
        _bindingPane.update();
    }
    
    /**
		 * Hide the binding ScrollPane, and re-display the mainText object + Scrollbar.
		 */
    public function HideBindingPane() : Void
    {
        _mainText.visible = true;
        _bindingPane.parent.removeChild(_bindingPane);
    }
    
    /**
		 * Register the current methods, and their associated bindings, as the defaults.
		 */
    public function RegisterDefaults() : Void
    {
        for (key in Reflect.fields(_controlMethods))
        {
            Reflect.setField(_defaultControlMethods, key, new BoundControlMethod(
            Reflect.field(_controlMethods, key).Func, 
            Reflect.field(_controlMethods, key).Name, 
            Reflect.field(_controlMethods, key).Description, 
            Reflect.field(_controlMethods, key).Index, 
            Reflect.field(_controlMethods, key).PrimaryKey, 
            Reflect.field(_controlMethods, key).SecondaryKey));
        }
        
        // Elbullshito mode -- 126 is the maximum keycode in as3 we're likely to see
        for (i in 0...126)
        {
            if (Reflect.field(_keysToControlMethods, Std.string(i)) != null)
            {
                Reflect.setField(_defaultKeysToControlMethods, Std.string(i), Reflect.field(_keysToControlMethods, Std.string(i)));
            }
        }
    }
    
    /**
		 * Reset the bound keys to the defaults previously registered.
		 */
    public function ResetToDefaults() : Void
    {
        for (key in Reflect.fields(_controlMethods))
        {
            Reflect.setField(_controlMethods, key, new BoundControlMethod(
            Reflect.field(_defaultControlMethods, key).Func, 
            Reflect.field(_defaultControlMethods, key).Name, 
            Reflect.field(_defaultControlMethods, key).Description, 
            Reflect.field(_defaultControlMethods, key).Index, 
            Reflect.field(_defaultControlMethods, key).PrimaryKey, 
            Reflect.field(_defaultControlMethods, key).SecondaryKey));
        }
        
        // Elbullshito mode -- 126 is the maximum keycode in as3 we're likely to see
        for (i in 0...126)
        {
            if (Reflect.field(_defaultKeysToControlMethods, Std.string(i)) != null)
            {
                Reflect.setField(_keysToControlMethods, Std.string(i), Reflect.field(_defaultKeysToControlMethods, Std.string(i)));
            }
        }
    }
    
    /**
		 * Get an array of the available functions.
		 * @return	Array of available BoundControlMethods.
		 */
    public function GetAvailableFunctions() : Array<Dynamic>
    {
        var funcs : Array<Dynamic> = new Array<Dynamic>();
        
        for (key in Reflect.fields(_controlMethods))
        {
            if (_debug)
            {
                trace(key);
            }
            funcs.push(Reflect.field(_controlMethods, key));
        }
        funcs.sortOn(["Index"], [Array.NUMERIC]);
        
        return funcs;
    }
    
    
    /**
		 * Get an array of the currently active keyCodes.
		 * @return	Array of active keycodes.
		 */
    public function GetControlMethods() : Array<Dynamic>
    {
        var buttons : Array<Dynamic> = [];
        for (key in Reflect.fields(_keysToControlMethods))
        {
            buttons.push(key);
        }
        
        return buttons;
    }
    
    /**
		 * Clear all currently bound keys.
		 */
    public function ClearAllBinds() : Void
    {
        for (key in Reflect.fields(_controlMethods))
        {
            Reflect.setField(_controlMethods, key, InputManager.UNBOUNDKEY).PrimaryKey;
            Reflect.setField(_controlMethods, key, InputManager.UNBOUNDKEY).SecondaryKey;
        }
        
        _keysToControlMethods = {};
    }
    
    /**
		 * Load bindings from a source "Object" retrieved from a game save file.
		 * @param	source	Source object to enumerate for binding data.
		 */
    public function LoadBindsFromObj(source : Dynamic) : Void
    {
        this.ClearAllBinds();
        
        for (key in Reflect.fields(source))
        {
            var pKeyCode : Int = Reflect.field(source, key).PrimaryKey;
            var sKeyCode : Int = Reflect.field(source, key).SecondaryKey;
            
            if (pKeyCode != InputManager.UNBOUNDKEY)
            {
                this.BindKeyToControl(pKeyCode, key, InputManager.PRIMARYKEY);
            }
            
            if (sKeyCode != InputManager.UNBOUNDKEY)
            {
                this.BindKeyToControl(sKeyCode, key, InputManager.SECONDARYKEY);
            }
        }
    }
    
    /**
		 * Create an associative object that can serialise the bindings to the users save file.
		 * @return	Dynamic object of control bindings.
		 */
    public function SaveBindsToObj() : Dynamic
    {
        var controls : Dynamic = {};
        
        for (key in Reflect.fields(_controlMethods))
        {
            if (_debug)
            {
                trace(key);
            }
            var ctrlObj : Dynamic = {};
            ctrlObj.PrimaryKey = Reflect.field(_controlMethods, key).PrimaryKey;
            ctrlObj.SecondaryKey = Reflect.field(_controlMethods, key).SecondaryKey;
            
            Reflect.setField(controls, key, ctrlObj);
        }
        
        return controls;
    }
    
    private function set_showHotkeys(display : Bool) : Bool
    {
        for (key in Reflect.fields(_controlMethods))
        {
            (try cast(Reflect.setField(_controlMethods, key, display), BoundControlMethod) catch(e:Dynamic) null).showHotkeys;
        }
        return display;
    }
    
    private function get_showHotkeys() : Bool
    //noinspection LoopStatementThatDoesntLoopJS
    {
        
        for (key in Reflect.fields(_controlMethods))
        {
            return (try cast(Reflect.field(_controlMethods, key), BoundControlMethod) catch(e:Dynamic) null).showHotkeys;
        }
        return false;
    }
}

/**
	 * List of known bound keyboard methods
	 *
	 * Some of the methods use an undefined "Event" parameter to pass into the actual UI components...
	 * ... strip this out and instead modify the handlers on the execution end to have a default null parameter?
	 *
	 * ** Bypass handler if mainView.eventTestInput.x == 270.5
	 * ** Bypass handler if mainView.nameBox.visible && stage.focus == mainView.nameBox
	 *
	 * 38	-- UpArrow			-- Cheat code for Humus stage 1
	 * 40	-- DownArrow		-- Cheat code for Humus stage 2
	 * 37 	-- LeftArrow		-- Cheat code for Humus stage 3
	 * 39	-- RightArrow		-- Cheat code for Humus stage 4 IF str > 0, not gameover, give humus
	 *
	 * 83	-- s				-- Display stats if main menu button displayed
	 * 76	-- l				-- Level up if level up button displayed
	 * 112	-- F1				-- Quicksave to slot 1 if menu_data displayed
	 * 113	-- F2				-- Quicksave slot 2
	 * 114	-- F3				-- Quicksave slot 3
	 * 115	-- F4				-- Quicksave slot 4
	 * 116	-- F5				-- Quicksave slot 5
	 *
	 * 117	-- F6				-- Quickload slot 1
	 * 118	-- F7				-- Quickload slot 2
	 * 119	-- F8				-- Quickload slot 3
	 * 120	-- F9				-- Quickload slot 4
	 * 121	-- F10				-- Quickload slot 5
	 *
	 * 8	-- Backspace		-- Go to "Main" menu if in game
	 * 68	-- d				-- Open saveload if in game
	 * 65	-- a				-- Open Appearance if in game
	 * 78	-- n				-- "no" if button index 1 displays no		<--
	 * 89	-- y				-- "yes" if button index 0 displays yes		<-- These two seem akward
	 * 80	-- p				-- display perks if in game
	 *
	 * 13/32 -- Enter/Space		-- if button index 0,4,5,9 or 14 has text of (never mind, abandon, next, return, back, leave, resume) execute it
	 *
	 * 36	-- Home				-- Cycle the background of the maintext area
	 *
	 * 49	-- 1				-- Execute button index 0 if visisble
	 * 50	-- 2				-- ^ index 1
	 * 51	-- 3				-- ^ index 2
	 * 52	-- 4				-- ^ index 3
	 * 53	-- 5				-- ^ index 4
	 * 54/81-- 6/q				-- ^ index 5
	 * 55/87-- 7/w				-- ^ index 6
	 * 56/69-- 8/e				-- ^ index 7
	 * 57/82-- 9/r				-- ^ index 8
	 * 48/84-- 0/t				-- ^ index 9
	 *
	 * 68	-- ???				-- ??? Unknown, theres a conditional check for the button, but no code is ever executed
	 */


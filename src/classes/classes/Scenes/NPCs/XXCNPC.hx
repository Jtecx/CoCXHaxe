package classes.scenes.nPCs;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.BaseContent;
import classes.CoC;
import coc.view.ButtonDataList;
import coc.xxc.BoundStory;

/**
	 * ...
	 * @author Oxdeception
	 */
class XXCNPC extends BaseContent
{
    public static var SavedNPCs(get, never) : Array<XXCNPC>;
    private var story(get, never) : BoundStory;
    public var Name(get, never) : String;

    public static var COMPANION : Int = -1;
    public static inline var FOLLOWER : Int = 0;
    public static inline var LOVER : Int = 1;
    public static inline var SLAVE : Int = 2;
    
    private static var _savedNPCs : Array<XXCNPC> = new Array<XXCNPC>();
    
    /**
		 * The classes added to this list require a static getter for instance
     * @param toAdd
     */
    private static function addSavedNPC(toAdd : XXCNPC) : Void
    {
        _savedNPCs.push(toAdd);
    }
    private static function get_SavedNPCs() : Array<XXCNPC>
    {
        return _savedNPCs;
    }
    public static function unloadSavedNPCs() : Void
    {
        for (npc in _savedNPCs)
        {
            npc.unload();
        }
        _savedNPCs = new Array<XXCNPC>();
    }
    private var _story : BoundStory;
    private var _storyName : String;
    private function get_story() : BoundStory
    {
        if (_story == null)
        {
            _story = CoC.instance.rootStory.locate(_storyName).bind(CoC.instance.context);
        }
        return _story;
    }
    
    public function new(storyName : String)
    {
        super();
        _storyName = storyName;
    }
    public function display(toDisplay : String, locals : Dynamic = null) : Void
    {
        story.display(toDisplay, locals);
    }
    public function save(saveto : Dynamic) : Void
    {
    }
    public function load(loadfrom : Dynamic) : Void
    {
    }
    public function campInteraction() : Void
    {
    }
    public function campDescription(buttons : ButtonDataList, menuType : Int = -1) : Void
    {
    }
    public function checkCampEvent() : Bool
    {
        return false;
    }
    public function isCompanion(type : Int = -1) : Bool
    {
        return false;
    }
    private function get_Name() : String
    {
        return _storyName;
    }
    
    /**
		 * Unloads the instance of an XXCNPC
		 * This needs to be overriden by child classes clear their
		 * _instanace variables from any lists they've been addded to
     */
    public function unload() : Void
    {
        throw new Error("Must be overloaded by child class");
    }
    public function scene(ref : String, locals : Dynamic = null, next : Function = null) : Void
    {
        clearOutput();
        display(ref, locals);
        doNext((next != null) ? next : camp.returnToCampUseOneHour);
    }
}

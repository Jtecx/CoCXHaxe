package classes.scenes.aPI;

import classes.BaseContent;
import classes.internals.EnumValue;
import flash.utils.Dictionary;

class AbstractQuest extends BaseContent
{
    public var id(get, never) : String;
    public var title(get, never) : String;
    public var group(get, never) : String;
    public var description(get, never) : String;
    public var status(get, never) : Int;
    public var isKnown(get, never) : Bool;
    public var hintToUnlock(get, never) : String;
    public var isStarted(get, never) : Bool;
    public var isEnded(get, never) : Bool;
    public var isCompleted(get, never) : Bool;
    public var isFailed(get, never) : Bool;

    public static var ALL_QUESTS_MAP : Dictionary = new Dictionary();
    public static var ALL_QUESTS_LIST : Array<Dynamic> = [];
    
    /**
	 * EnumValue properties:
	 * - id: var name ("COMPLETED")
	 * - value: code (3)
	 * - name: display name ("Completed")
	 * - color: text color, optional
	 */
    public static var AllStatuses : Array<Dynamic> = [];
    /**
	 * Player does not know about this quest
	 */
    public static inline var STATUS_UNKNOWN : Int = 0;
    
    /**
	 * Player knows about this quest, but haven't started it
	 */
    public static inline var STATUS_NOT_STARTED : Int = 1;
    
    /**
	 * Player started the quest, but not completed it yet.
	 * It can also mean that player completed the quest but didn't take the rewards yet.
	 */
    public static inline var STATUS_IN_PROGRESS : Int = 2;
    
    /**
	 * Player successfully completed the quests and took the rewards.
	 */
    public static inline var STATUS_COMPLETED : Int = 3;
    
    /**
	 * Player failed the quest.
	 */
    public static inline var STATUS_FAILED : Int = 4;
    
    /**
	 * Return value to indicate invalid quest id
	 */
    public static var STATUS_INVALID : Int = -1;
    
    
    private var _id : String;
    private var _group : String;
    private var _title : String;
    
    public function new(
            id : String,
            group : String,
            title : String)
    {
        super();
        this._id = id;
        this._group = group;
        this._title = title;
        Reflect.setField(ALL_QUESTS_MAP, _id, this);
        ALL_QUESTS_LIST.push(this);
    }
    
    private function get_id() : String
    {
        return _id;
    }
    private function get_title() : String
    {
        return _title;
    }
    private function get_group() : String
    {
        return _group;
    }
    
    private function get_description() : String
    // Implement in subclass (optional)
    {
        
        return "";
    }
    /**
	 * Quest objectives, as viewed by player.
	 * Array of parts [status, test]
	 */
    public function objectives() : Array<Dynamic>
    // Implement in subclass
    {
        
        return [
        [STATUS_UNKNOWN, "ERROR: Quest '" + id + "' is missing objectives"]
    ];
    }
    public function formattedObjectives(colored : Bool) : Array<Dynamic>
    {
        var result : Array<Dynamic> = [];
        for (obj/* AS3HX WARNING could not determine type for var: obj exp: ECall(EIdent(objectives),[]) type: null */ in objectives())
        {
            var ev : EnumValue = AllStatuses[obj[0]];
            var s : String;
            if (obj[0] == STATUS_UNKNOWN)
            {
                s = "???";
            }
            else
            {
                s = obj[1];
            }
            if (colored && ev.color)
            {
                s = "<font color=\"" + ev.color + "\">" + s + "</font>";
            }
            result.push(s);
        }
        return result;
    }
    
    /**
	 * STATUS_XXXX
	 */
    private function get_status() : Int
    // Implement in subclass
    {
        
        return STATUS_UNKNOWN;
    }
    public function statusName(colored : Bool) : String
    {
        var obj : EnumValue = AllStatuses[status];
        var s : String = obj.name;
        if (colored && obj.color)
        {
            s = "<font color=\"" + obj.color + "\">" + s + "</font>";
        }
        return s;
    }
    /**
	 * Player knows about the quest
	 */
    private function get_isKnown() : Bool
    {
        return status > STATUS_UNKNOWN;
    }
    /**
	 * If quest is unknown, hint to reveal it. Can be empty
	 */
    private function get_hintToUnlock() : String
    {
        return "";
    }
    /**
	 * Quest was started but not completed
	 */
    private function get_isStarted() : Bool
    {
        return status == STATUS_IN_PROGRESS;
    }
    /**
	 * Quest was finished (successfully or not)
	 */
    private function get_isEnded() : Bool
    {
        return status == STATUS_COMPLETED || status == STATUS_FAILED;
    }
    private function get_isCompleted() : Bool
    {
        return status == STATUS_COMPLETED;
    }
    private function get_isFailed() : Bool
    {
        return status == STATUS_FAILED;
    }
    private static var AbstractQuest_static_initializer = {
        EnumValue.add(AllStatuses, STATUS_UNKNOWN, "UNKNOWN", {
                    name : "Unknown"
                });
        EnumValue.add(AllStatuses, STATUS_NOT_STARTED, "NOT_STARTED", {
                    name : "Not started"
                });
        EnumValue.add(AllStatuses, STATUS_IN_PROGRESS, "IN_PROGRESS", {
                    name : "In progress",
                    color : "#0080ff"
                });
        EnumValue.add(AllStatuses, STATUS_COMPLETED, "COMPLETED", {
                    name : "Completed",
                    color : "#00a000"
                });
        EnumValue.add(AllStatuses, STATUS_FAILED, "FAILED", {
                    name : "Failed",
                    color : "#a00000"
                });
        EnumValue.add(AllStatuses, STATUS_INVALID, "INVALID", {
                    name : "Invalid",
                    color : "#ff0000"
                });
        true;
    }

}


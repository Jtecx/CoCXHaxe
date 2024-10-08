package classes;

import haxe.Constraints.Function;

/**
	 * ...
	 * @author Gedan
	 */
class Room
{
    public function new()
    {
    }
    
    public var RoomName : String;  // Index name  
    public var RoomDisplayName : String;  // Header text  
    
    public var NorthExit : String;
    public var NorthExitCondition : Function;
    
    public var EastExit : String;
    public var EastExitCondition : Function;
    
    public var SouthExit : String;
    public var SouthExitCondition : Function;
    
    public var WestExit : String;
    public var WestExitCondition : Function;
    
    public var RoomFunction : Function;
}

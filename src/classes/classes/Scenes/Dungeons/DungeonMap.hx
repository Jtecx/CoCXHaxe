package classes.scenes.dungeons;

import haxe.Constraints.Function;

/**
 * A map for **one** dungeon (or closed dungeon section.
 * Contains all necessary methods and information for checking the player location (INSIDE the dungeon) and printing the map.
 */
class DungeonMap
{
    /*
    Reworked map - Svalkash edition.
    DON'T USE NUMERIC CONSTANTS.
    Map layouts work the same way as before.
    BUT, instead of writing maps for each room, you can make a map for dungeon (section), and then use letters and symbols to substitute.
    '0'-'9' - special meaning, usually some alternating part or locked/unlocked doors
    'a'-'z', then 'A'-'Z' - substitute for location codes.
    ---
    Usual markers:
    P - player
    L - locked door
    S - stairs
    E - exit (NYI)
    ---
    Room names are not displayed on the map. You can add a fancy functions do get 'ANY' location name and add it here.
    */
    
    //Dungeon name, printed above the map.
    private var mapName : String;
    
    //The map itself, representing the dungeon layout. May contain specific symbols that will be parsed later.
    private var map : Array<Dynamic>;
    
    //Rooms associative array. Each room character translates into a constant from AbstractContent and is compared to player's position.
    //If the player is there, 'P' is displayed. Otherwise, either ' ' (space) or the original character (if contained in notSpaces).
    //MUST contain all rooms of the current dungeon (even if they are not present on the map) to detec that the player is in the dungeon.
    private var rooms : Dynamic;
    
    //Function with unique symbol  replacements. Like, replace '1' with a locked door check. Returns empty object by default.
    private var getSpecial : Function;
    
    //Array of symbols from rooms which should not be replaced by spaces. Contains only 'S' by default.
    private var notSpaces : Array<Dynamic>;
    
    public function new(mapName : String, map : Array<Dynamic>, rooms : Dynamic, special : Function = null, notSpaces : Array<Dynamic> = null)
    {
        this.mapName = mapName;
        this.map = map;
        this.rooms = rooms;
        if (special != null)
        {
            this.getSpecial = special;
        }
        else
        {
            this.getSpecial = function() : Dynamic
                    {
                        return { };
                    };
        }
        if (notSpaces != null)
        {
            this.notSpaces = notSpaces;
        }
        else
        {
            this.notSpaces = ["S", "s"];
        }
    }
    
    //Parses the map (inserts the player position and special elements) and returns the resultant String.
    // The Legend is not included.
    //For each room, the provided position (usually it's dungeonLoc, but can be *anything else* - D3 is an example)
    public function parseMap(location : Dynamic) : String
    //get basic map & associative objects
    {
        
        var special : Dynamic = getSpecial();
        //parse buffered map
        var fullMap : String = mapName + "\n\n";
        for (line in map)
        
        //check each character{
            
            for (i in 0...line.length)
            {
                var char : String = line.charAt(i);
                if (special.exists(char))
                
                //replace special points (locked doors){
                    
                    fullMap += Reflect.field(special, char);
                }
                else if (rooms.exists(char))
                
                //replace room contents (player or nothing.. if in 'notSpaces', not replaced by space){
                    
                    fullMap += ((location == Reflect.field(rooms, char)) ? "P" : Lambda.indexOf(notSpaces, char) != -(1) ? char : " ");
                }
                else
                {
                    fullMap += char;
                }
            }
            //add \n to the end of the line
            fullMap += "\n";
        }
        return fullMap;
    }
    
    //Checks if the player is in the dungeon by iterating over all possible rooms and comparing them to dungeonLoc
    public function playerIsHere(location : Dynamic) : Bool
    {
        for (room/* AS3HX WARNING could not determine type for var: room exp: EIdent(rooms) type: Dynamic */ in rooms)
        {
            if (location == room)
            {
                return true;
            }
        }
        return false;
    }
}

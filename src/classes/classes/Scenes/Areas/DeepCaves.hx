/**
 * @author Ormael
 * Area with lvl 65-95 enemies.
 * Currently a Work in Progress
 */
package classes.scenes.areas;

import classes.*;
import classes.scenes.aPI.Encounters;
import classes.scenes.aPI.GroupEncounter;
import classes.scenes.SceneLib;

class DeepCaves extends BaseContent
{
    public var deepCavesEncounter(get, never) : GroupEncounter;

    
    public function new()
    {
        super();
        onGameInit(init);
    }
    
    private var _deepCavesEncounter : GroupEncounter = null;
    private function get_deepCavesEncounter() : GroupEncounter
    {
        return _deepCavesEncounter;
    }
    
    private function init() : Void
    {
        _deepCavesEncounter = Encounters.group("deepcaves", { });
    }
    
    public var areaLevel(default, never) : Int = 65;
    public function isDiscovered() : Bool
    {
        return SceneLib.exploration.counters.deepCaves > 0;
    }
    public function canDiscover() : Bool
    {
        return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
    }
    public function timesExplored() : Int
    {
        return SceneLib.exploration.counters.deepCaves;
    }
    
    
    public function exploreCaves() : Void
    {
        clearOutput();
        SceneLib.exploration.counters.deepCaves++;
        doNext(camp.returnToCampUseOneHour);
        deepCavesEncounter.execEncounter();
        flushOutputTextToGUI();
    }  //lvl 65 - dark elf sniper caves ver  
}


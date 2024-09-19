/**
 * @author Ormael
 * Area with lvl 15-25 enemies.
 * Currently a Work in Progress
 */
package classes.scenes.areas;

import classes.BaseContent;
import classes.scenes.aPI.Encounters;
import classes.scenes.aPI.GroupEncounter;
import classes.scenes.SceneLib;

class DeepDesert extends BaseContent
{
    public var deepDesertEncounter(get, never) : GroupEncounter;

    //public var gorgonScene:GorgonScene = new GorgonScene();przenieść do deep desert potem
    
    public function new()
    {
        super();
        onGameInit(init);
    }
    
    private var _deepDesertEncounter : GroupEncounter = null;
    private function get_deepDesertEncounter() : GroupEncounter
    {
        return _deepDesertEncounter;
    }
    
    private function init() : Void
    {
        _deepDesertEncounter = Encounters.group("deepdesert", { });
    }
    
    public var areaLevel(default, never) : Int = 65;
    public function isDiscovered() : Bool
    {
        return SceneLib.exploration.counters.desertDeep > 0;
    }
    public function canDiscover() : Bool
    {
        return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
    }
    public function timesExplored() : Int
    {
        return SceneLib.exploration.counters.desertDeep;
    }
    
    public function exploreDeepDesert() : Void
    {
        clearOutput();
        SceneLib.exploration.counters.desertDeep++;
        doNext(camp.returnToCampUseOneHour);
        deepDesertEncounter.execEncounter();
        flushOutputTextToGUI();
    }
}


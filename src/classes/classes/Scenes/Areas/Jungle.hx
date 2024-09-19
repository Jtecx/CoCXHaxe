/**
 * @author Ormael
 * Area with lvl ?60-90? enemies.
 * Currently a Work in Progress
 */
package classes.scenes.areas;

import classes.BaseContent;
import classes.scenes.aPI.Encounters;
import classes.scenes.aPI.GroupEncounter;

class Jungle extends BaseContent
{
    public var jungleEncounter(get, never) : GroupEncounter;

    
    public function new()
    {
        super();
        onGameInit(init);
    }
    
    private var _jungleEncounter : GroupEncounter = null;
    private function get_jungleEncounter() : GroupEncounter
    {
        return _jungleEncounter;
    }
    
    private function init() : Void
    {
        _jungleEncounter = Encounters.group("jungle", { });
    }
    
    public function isDiscovered() : Bool
    {
        return false;
    }
    public function timesExplored() : Int
    {
        return 0;
    }
    
    public function exploreJungle() : Void
    {
        clearOutput();
        //flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD]++;
        doNext(camp.returnToCampUseOneHour);
        jungleEncounter.execEncounter();
        flushOutputTextToGUI();
    }
}


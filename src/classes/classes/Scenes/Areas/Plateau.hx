/**
 * @author Ormael
 * Area with lvl 35-55 enemies.
 * Currently a Work in Progress
 */
package classes.scenes.areas;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.CoC;
import classes.scenes.aPI.Encounters;
import classes.scenes.aPI.GroupEncounter;
import classes.scenes.areas.caves.*;
import classes.scenes.monsters.DarkElfScene;
import classes.scenes.SceneLib;

class Plateau extends BaseContent
{
    public var plateauEncounter(get, never) : GroupEncounter;

    
    public function new()
    {
        super();
        onGameInit(init);
    }
    
    private var _plateauEncounter : GroupEncounter = null;
    private function get_plateauEncounter() : GroupEncounter
    {
        return _plateauEncounter;
    }
    
    private function init() : Void
    {
        _plateauEncounter = Encounters.group("plateau", { });
    }
    
    public function explorePlateau() : Void
    {
        clearOutput();
        //flags[kFLAGS.TAMED_02_NAME]++;
        doNext(camp.returnToCampUseOneHour);
        plateauEncounter.execEncounter();
        flushOutputTextToGUI();
    }
    
    //lvl 35 enemy for sure added
    
    public var darkelfScene : DarkElfScene = new DarkElfScene();
}

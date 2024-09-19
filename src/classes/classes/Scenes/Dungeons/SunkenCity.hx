/**
 * Side Dungeon: The Sunken City (aka CoC-ish eldritch monstrosity from the ages of the gods lair)
 * @author Liadri
 */
package classes.scenes.dungeons;

import classes.EventParser;
import classes.globalFlags.KFLAGS;

class SunkenCity extends DungeonAbstractContent
{
    
    public function new()
    {
        super();
    }
    
    public function exitDungeon() : Void
    {
        inDungeon = false;
        clearOutput();
        outputText("You leave the river dungeon behind and take off through the He'Xin'Dao back towards camp.");
        doNext(camp.returnToCampUseOneHour);
    }
}


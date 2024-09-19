package classes.scenes.monsters;

import classes.*;
import classes.scenes.SceneLib;

//import classes.GlobalFlags.kACHIEVEMENTS;
//import classes.GlobalFlags.kFLAGS;
//import classes.display.SpriteDb;
class AngelScene extends BaseContent
{
    
    public function new()
    {
        super();
    }
    
    public function angeloidGroupEncounter() : Void
    {
        clearOutput();
        outputText("Your wanderings lead you nowhere in particular, but as you begin to think about heading back, you suddenly hear sound of many wings flapping.  Turning around you notice a large group of angeloids flying toward you. They're closing in with supernatural speed, and before you can take more than a few steps, they're surrounding you. \"<i>Don't be afraid!!!</i>\"  No way around it, you ready your [weapon] for the fight.");
        startCombat(new AngeloidGroup());
        //camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_IMPS);
        doNext(playerMenu);
    }
    
    public function angelEncounter() : Void
    {
        clearOutput();
        outputText("");
        startCombat(new AngelLR());
        //camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_IMPS);
        doNext(playerMenu);
    }
}


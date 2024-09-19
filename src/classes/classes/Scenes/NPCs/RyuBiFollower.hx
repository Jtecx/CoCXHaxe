/**
 * ...
 * @author Ormael
 */
package classes.scenes.nPCs;

import classes.*;
import classes.globalFlags.KFLAGS;

class RyuBiFollower extends NPCAwareContent
{
    
    public function new()
    {
        super();
    }
    
    public function RyuBiEnterTheDragon() : Void
    {
        clearOutput();
        outputText("A huge dragon and you. (placeholder text for now so not mind it and just kick the dragon ass)");
        startCombat(new RyuBiDragon());
    }
    
    public function RyuBiWins() : Void
    {
        clearOutput();
        outputText("The dragon approaches your defeated form, giving a seemingly disappointed growl before knocking you unconscious. You wake up after a while, alone and slowly head back to camp.");
        cleanupAfterCombat();
        return;
    }
    
    public function RyuBiLost() : Void
    {
        clearOutput();
        outputText("You stand over the defeated dragon triumphantly. With a sudden burst of momentum, the dragon ");
        if (silly())
        {
            outputText("throws a handful of sand in your eyes.\n\n\"<i>Fucking Pocket Sand!!!</i>\" you curse aloud, trying to remove it as soon as possible. Sadly as you expunge the sand from your eyes. You realize the dragon is nowhere in sight. Fucking. Pocket Sand");
        }
        else
        {
            outputText("knocks you flying a good few meters away as they rise from the ground. You struggle to collect yourself and notice the dragon is nowhere in sight");
        }
        outputText(". Victorious, but without the dragon as a spoil of war, you return to the camp.");  /*
	if (flags[kFLAGS.RYUBI_DEFEATS_COUNTER] >= 1) flags[kFLAGS.RYUBI_DEFEATS_COUNTER]++;
	else flags[kFLAGS.RYUBI_DEFEATS_COUNTER] = 1;
	if (flags[kFLAGS.RYUBI_LVL_UP] == 0) {
		if (flags[kFLAGS.RYUBI_DEFEATS_COUNTER] == 1) flags[kFLAGS.RYUBI_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.RYUBI_LVL_UP]++;
	}
	if (flags[kFLAGS.RYUBI_LVL_UP] == 1) {
		if (flags[kFLAGS.RYUBI_DEFEATS_COUNTER] == 1) flags[kFLAGS.RYUBI_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.RYUBI_LVL_UP]++;
	}
	if (flags[kFLAGS.RYUBI_LVL_UP] == 2) {
		if (flags[kFLAGS.RYUBI_DEFEATS_COUNTER] == 2) flags[kFLAGS.RYUBI_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.RYUBI_LVL_UP]++;
	}
	if (flags[kFLAGS.RYUBI_LVL_UP] == 3) {
		if (flags[kFLAGS.RYUBI_DEFEATS_COUNTER] == 2) flags[kFLAGS.RYUBI_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.RYUBI_LVL_UP]++;
	}
	if (flags[kFLAGS.RYUBI_LVL_UP] == 4) {
		outputText("Placeholder");
		flags[kFLAGS.RYUBI_LVL_UP]++;
	}
	if (flags[kFLAGS.RYUBI_LVL_UP] == 5) {
		outputText("Placeholder");
		flags[kFLAGS.RYUBI_LVL_UP]++;
	}
	if (flags[kFLAGS.RYUBI_LVL_UP] == 6) {
		outputText("Placeholder");
		flags[kFLAGS.RYUBI_LVL_UP]++;
	}*/  
        if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2)
        {
        }
        cleanupAfterCombat();
    }
}

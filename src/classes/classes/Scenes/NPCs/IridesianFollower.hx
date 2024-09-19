/**
 * Multicolored angelic unicorn-gazer hybrid ^^
 * @author Ormael (for now)
 */
package classes.scenes.nPCs;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;

class IridesianFollower extends NPCAwareContent
{
    
    public function new()
    {
        super();
    }
    
    public function firstMeetingIridesian() : Void
    {
        clearOutput();
        outputText("As you wander the battlefield you hear nearby sounds of the battle. Walking into that direction you finds large group of imps battling lone person dressed into robe. From under the hood sticks out medium length single horn and throu holes on the back extends many pairs of tentacle-like appendixes.\n\n");
        outputText("\"<i>Begone foul creatures!!!</i>\" you can hear the sole figure yelling ocassionaly when another imp fell after one of back tentacles tips glowing for brief moment. In few minutes you spends watching it deals with most of remaining imps as the rest fleed in all directions. Then he turns his attnetion toward you.\n\n");
        outputText("\"<i>Another Tarnished One?</i>\" he speaks slowly until assuming combat posture. \"<i>Rip or Tear? What you choose?</i>\"\n\n");
        startCombat(new Iridesian());
        doNext(playerMenu);
    }
    public function firstMeetingIridesianVictory() : Void
    {
    }
    public function firstMeetingIridesianDefeat() : Void
    {
    }
    public function repeatMeetingIridesian() : Void
    {
        clearOutput();
    }
}

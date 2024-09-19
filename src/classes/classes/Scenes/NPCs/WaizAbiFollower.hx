/**
 * ...
 * @author Ormael
 */
package classes.scenes.nPCs;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;
import classes.internals.SaveableState;

class WaizAbiFollower extends NPCAwareContent implements SaveableState
{
    public static var WaizAbiState : Float;  //state or status (friend, lover, etc.)  
    public static var WaizAbiAffection : Float;
    public static var WaizAbiWrathMulti : Float;
    public static var WaizAbiHPMulti : Float;
    public static var WaizAbiSoulforceMulti : Float;
    public static var WaizAbiLustMulti : Float;
    public static var WaizAbiOtherSecondaryBarsMulti : Float;  //mana, fatigue ?and hunger?  
    public static var WaizAbiStrMulti : Float;
    public static var WaizAbiSpeMulti : Float;
    public static var WaizAbiTouMulti : Float;
    public static var WaizAbiWisMulti : Float;
    public static var WaizAbiIntMulti : Float;
    public static var WaizAbiLibMulti : Float;
    public static var WaizAbiSensMulti : Float;
    
    public function stateObjectName() : String
    {
        return "WaizAbiFollower";
    }
    
    public function resetState() : Void
    {
        WaizAbiState = 0;
        WaizAbiAffection = 0;
        WaizAbiWrathMulti = 1;
        WaizAbiHPMulti = 1;
        WaizAbiSoulforceMulti = 1;
        WaizAbiLustMulti = 1;
        WaizAbiOtherSecondaryBarsMulti = 1;
        WaizAbiStrMulti = 1;
        WaizAbiSpeMulti = 1;
        WaizAbiTouMulti = 1;
        WaizAbiWisMulti = 1;
        WaizAbiIntMulti = 1;
        WaizAbiLibMulti = 1;
        WaizAbiSensMulti = 1;
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            WaizAbiState : WaizAbiState,
            WaizAbiAffection : WaizAbiAffection,
            WaizAbiWrathMulti : WaizAbiWrathMulti,
            WaizAbiHPMulti : WaizAbiHPMulti,
            WaizAbiSoulforceMulti : WaizAbiSoulforceMulti,
            WaizAbiLustMulti : WaizAbiLustMulti,
            WaizAbiOtherSecondaryBarsMulti : WaizAbiOtherSecondaryBarsMulti,
            WaizAbiStrMulti : WaizAbiStrMulti,
            WaizAbiSpeMulti : WaizAbiSpeMulti,
            WaizAbiTouMulti : WaizAbiTouMulti,
            WaizAbiWisMulti : WaizAbiWisMulti,
            WaizAbiIntMulti : WaizAbiIntMulti,
            WaizAbiLibMulti : WaizAbiLibMulti,
            WaizAbiSensMulti : WaizAbiSensMulti
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            WaizAbiState = Reflect.field(o, "WaizAbiState");
            WaizAbiAffection = Reflect.field(o, "WaizAbiAffection");
            WaizAbiWrathMulti = Reflect.field(o, "WaizAbiWrathMulti");
            WaizAbiHPMulti = Reflect.field(o, "WaizAbiHPMulti");
            WaizAbiSoulforceMulti = Reflect.field(o, "WaizAbiSoulforceMulti");
            WaizAbiLustMulti = Reflect.field(o, "WaizAbiLustMulti");
            WaizAbiOtherSecondaryBarsMulti = Reflect.field(o, "WaizAbiOtherSecondaryBarsMulti");
            WaizAbiStrMulti = Reflect.field(o, "WaizAbiStrMulti");
            WaizAbiSpeMulti = Reflect.field(o, "WaizAbiSpeMulti");
            WaizAbiTouMulti = Reflect.field(o, "WaizAbiTouMulti");
            WaizAbiWisMulti = Reflect.field(o, "WaizAbiWisMulti");
            WaizAbiIntMulti = Reflect.field(o, "WaizAbiIntMulti");
            WaizAbiLibMulti = Reflect.field(o, "WaizAbiLibMulti");
            WaizAbiSensMulti = Reflect.field(o, "WaizAbiSensMulti");
        }
        // loading from old save
        else
        {
            
            resetState();
        }
    }
    
    public function new()
    {
        super();
        Saves.registerSaveableState(this);
    }
    //WaizAbiStory: 1 - x, 2 - x, 3 - x
    public function bimboMonkey() : Void
    {
        clearOutput();
        outputText("\"<i>O Hai there,</i>\" she says looking over you from head to feet and back. \"<i>Mmmmm maybe you could put a good 'fight'...If not, beating you down could be...Fun...</i>\" Her voice trails off, her gaze dropping to your [legs], her eyes half-lidded. She licks her lips slowly, gaze slowly moving back up your frame.\n\n");
        outputText("On one hand, her muscular arms flex, but on the other, she's giving you a rather lascivious glance. You ask her why she's speaking in riddles. Is the bimbo asking for a fight, or a fuck?</i> You ask, only to get a smile, her lip curling ever so slightly. \n\n");
        outputText("\"<i>Oh, poor little champion. Faced with a choice, and you don't know how to react.</i>\" She smirks, bringing one hand to grasp her formidible breast. \"<i> Maybe this is one thing that you get to choose. I get my fun either way. </i>\"She awaits your reaction, blatantly oogling your body while she sips from her wine glass.\n\n");
        menu();
        addButton(1, "Sex", bimboMonkeySex);  //(Koshya appearance here)  
        addButton(2, "Fight", bimboMonkeyFight);  //(And here)  
        //3 - Drink (but not he.... jk also here appears)
        addButton(14, "Back", curry(SceneLib.journeyToTheEast.enteringInn, false));
    }  //outputText("\"<i></i>\"\n\n");  
    public function bimboMonkeySex() : Void
    {
        clearOutput();
        outputText("Then maybe a good 'fight'?\n\n");
        outputText("\"<i>Really???</i>\" her eyes light up, and she leaps to her feet, carelessly putting her glass to one side. After getting up she grabs your hand, and leads you to the entrance.\n\n");
        outputText("\"<i>Stop right there!</i>\" An angry voice calls to you, heavy footsteps getting closer. You turn, catching sight of your pursuer. She's a pale blue skinned woman, with average-sized breasts and hips, both hidden under a layer of light armor. She pivots, unfolding a single snow-white wing, forcefully putting the limb between you and the bimbo monkey. Your would-be paramour lets out an annoyed groan, but a single glare from the angelic woman is all it takes to cow her. The blue-skinned woman forces her way in, glaring at you with her lips curled in disgust.\n\n");
        outputText("\"<i>Return home, milady. Someone needs to be taught a lesson.</i>\" The newcomer silently glares at the bimbo-monkey, who eventually looks down and away, leaving the area with a huff. Once she's gone, the blue-skinned angel points towards the Soul Arena. \"<i>What's it going to be, sex-freak? Are you gonna join me in the ring, or do I need to drag you there myself?</i>\"\n\n");
        outputText("Slightly annoyed by the interuption to your 'fight', you give the angel a slow nod, entering the arena.\n\n");
        outputText("\"<i>Lesson one.</i>\" She sinks into a low combat stance, unfolding her wings. <i>\"What happens when a pervert tries to take advantage of milady? Let me demonstrate!</i>\"");
        startCombat(new Koshya());
    }
    public function bimboMonkeyFight() : Void
    {
        clearOutput();
        outputText("You're in the mood for a good beatdown.\n\n");
        outputText("\"<i>Ohhh, a beatdown? Well i can get behind that too.</i>\" she slowly puts the glass down. After getting up she takes your hand in a surprisingly strong grip, leading you out of the bar.\n\n");
        outputText("You follow her past the marketplace, around the lesson hall and into the Soul Arena. You quickly find an empty arena, and the bimbo monkey grins as you begin to face off. She leans back, a sudden wind slamming into you as she screams. Her eyes begin to glow red, her tail whipping behind her. As she roars, teeth glinting, she takes a step towards you...and a blur of motion lands between you two. The bimbo monkey tries to dodge around, but a white wing intercepts. As she turns to face you, you get a better look at this interloper. She has pale blue skin, and an unassuming face, just feminine enough to leave no doubt as to her gender. Her build is completely unspectacular, bust, hips and muscles almost tailored to be as average as possible. \n\n");
        outputText("\"<i>Ma'am, this battle is beneath you. I shall take your place in this battle.</i>\" She speaks gently, but the look in her eyes is stern. She may be acting as a servant, but this...almost sounds like an order.\n\n");
        outputText("\"<i>But why can't I even fight? No fucks, no fights... You're supposed to be my servant, not my nanny.</i>\"The bimbo monkey pouts but still obeys, jumping toward the nearby stands. \"<i>This time, I'll let it slide. But you won't interrupt my next fight...</i>\"\n\n");
        outputText("\"<i>Of course milady.</i>\" The angel woman brings her gaze to you. \"<i>Of course, you may still watch. This one should be able to provide you some entertainment.</i>\" \n\n");
        startCombat(new Koshya());
    }
    public function bimboMonkeyDrink() : Void
    {
        clearOutput();
        outputText("\"<i></i>\"\n\n");
    }
    
    public function WaizAbiMainMenu() : Void
    {
    }
}

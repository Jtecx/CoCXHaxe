package classes.transformations.transformations;

import classes.bodyParts.*;
import classes.geneticMemories.GillsMem;
import classes.items.MutationsHelper;
import classes.scenes.Metamorph;
import classes.transformations.*;

/**
 * Base class for transformation events.
 */
class GillsTransformations extends MutationsHelper
{
    /*
    *     ██████  ██ ██      ██      ███████
    *    ██       ██ ██      ██      ██
    *    ██   ███ ██ ██      ██      ███████
    *    ██    ██ ██ ██      ██           ██
    *     ██████  ██ ███████ ███████ ███████
    */
    
    /*
      */
    public var GillsNone(default, never) : Transformation = new SimpleTransformation("No Gills", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            var _sw1_ = (player.gills.type);            

            switch (_sw1_)
            {
                case Gills.ANEMONE:
                    desc += "Your chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.";
                default:
                    desc += "You feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water quite so long anymore.";
            }
            
            desc += " <b>You no longer have gills!</b>";
            
            player.gills.type = Gills.NONE;
            if (doOutput)
            {
                outputText(desc);
            }
        }, 
        // is present
        function() : Bool
        {
            return player.gills.type == Gills.NONE;
        });
    
    public var GillsFish(default, never) : Transformation = new SimpleTransformation("Fish Gills", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            var _sw2_ = (player.gills.type);            

            switch (_sw2_)
            {
                case Gills.ANEMONE:
                    desc += "You feel your gills tingle, a vague numbness registering across thier feathery exterior. You watch in awe as your gill's feathery folds dry out and fall off like crisp autumn leaves. The slits of your gills then rearrange themselves, becoming thinner and shorter, as they shift to the sides of your neck. They now close in a way that makes them almost invisible. As you run a finger over your neck you feel little more than several small raised lines where they meet your skin.";
                default:
                    TransformationUtils.applyTFIfNotPresent(transformations.GillsNone, doOutput);
                    
                    desc += "You feel a sudden tingle on your neck. You reach up to it to feel, whats the source of it. When you touch your neck, you feel that it begins to grow serveral narrow slits which slowly grow longer. After the changes have stopped you quickly head to a nearby puddle to take a closer look at your neck. You realize, that your neck has grown gills allowing you to breathe under water as if you were standing on land.";
            }
            
            desc += " <b>You now have fish gills!</b>";
            
            player.gills.type = Gills.FISH;
            if (doOutput)
            {
                outputText(desc);
            }
            Metamorph.unlockMetamorph(GillsMem.getMemory(GillsMem.FISH));
        }, 
        // is present
        function() : Bool
        {
            return player.gills.type == Gills.FISH;
        });
    
    public var GillsAnemone(default, never) : Transformation = new SimpleTransformation("Anemone Gills", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            var _sw3_ = (player.gills.type);            

            switch (_sw3_)
            {
                case Gills.FISH:
                    desc += "You feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your gills shrink into nothingness, leaving only smooth skin behind. When you think it's over you feel something emerge from under your neck, flowing down over your chest and brushing your nipples. You look in surprise as your new feathery gills finish growing out, a film of mucus forming over them shoftly after.";
                default:
                    TransformationUtils.applyTFIfNotPresent(transformations.GillsNone, doOutput);
                    
                    desc += "You feel a pressure in your lower esophageal region and pull your garments down to check the area. Before your eyes a pair of feathery gills start to push out of the center of your chest, just below your neckline, parting sideways and draping over your [nipple]s. They feel a bit uncomfortable in the open air at first, but soon a thin film of mucus covers them and you hardly notice anything at all.";
            }
            
            desc += " <b>You now have feathery gills!</b>";
            
            player.gills.type = Gills.ANEMONE;
            if (doOutput)
            {
                outputText(desc);
            }
            Metamorph.unlockMetamorph(GillsMem.getMemory(GillsMem.ANEMONE));
        }, 
        // is present
        function() : Bool
        {
            return player.gills.type == Gills.ANEMONE;
        });
    
    public var GillsInTentacleLegs(default, never) : Transformation = new SimpleTransformation("Tentacle Legs Gills", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            desc += "";
            
            player.gills.type = Gills.GILLS_IN_TENTACLE_LEGS;
            if (doOutput)
            {
                outputText(desc);
            }
        }, 
        // is present
        function() : Bool
        {
            return player.gills.type == Gills.GILLS_IN_TENTACLE_LEGS;
        });

    public function new()
    {
        super();
    }
}


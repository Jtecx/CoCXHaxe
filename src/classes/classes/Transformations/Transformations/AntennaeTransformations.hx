package classes.transformations.transformations;

import classes.transformations.*;
import classes.bodyParts.Antennae;
import classes.geneticMemories.AntennaeMem;
import classes.items.MutationsHelper;
import classes.scenes.Metamorph;

/**
 * Base class for transformation events.
 */
class AntennaeTransformations extends MutationsHelper
{
    /*
    *     █████  ███    ██ ████████ ███████ ███    ██ ███    ██  █████  ███████
    *    ██   ██ ████   ██ 	  ██    ██      ████   ██ ████   ██ ██   ██ ██
    *    ███████ ██ ██  ██    ██    █████   ██ ██  ██ ██ ██  ██ ███████ █████
    *    ██   ██ ██  ██ ██    ██    ██      ██  ██ ██ ██  ██ ██ ██   ██ ██
    *    ██   ██ ██   ████    ██    ███████ ██   ████ ██   ████ ██   ██ ███████
    */
    
    /*
      */
    public var AntennaeNone(default, never) : Transformation = new SimpleTransformation("No Antennae", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            desc += "The muscles in your brow clench tightly, and you feel a tremendous pressure on your upper forehead. When it passes, you touch yourself and discover your antennae.type have vanished!";
            player.antennae.type = Antennae.NONE;
            
            if (doOutput)
            {
                outputText(desc);
            }
        }, 
        // is present
        function() : Bool
        {
            return player.antennae.type == Antennae.NONE;
        });
    
    public var AntennaeMantis(default, never) : Transformation = new SimpleTransformation("Mantis Antennae", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            if (player.antennae.type == Antennae.BEE)
            {
                desc += "Your head itches momentarily as your two floppy antennae changes slowly into long prehensile ones similar to those seen on mantis.";
            }
            else if (player.antennae.type == Antennae.ANT)
            {
                desc += "Your head itches momentarily as your two rigid antennae loosen up, ending up more like those on a Mantis";
            }
            else
            {
                desc += "Your head itches momentarily as two long prehensile antennae sprout from your [hair].";
            }
            player.antennae.type = Antennae.MANTIS;
            
            if (doOutput)
            {
                outputText(desc);
            }
            Metamorph.unlockMetamorph(AntennaeMem.getMemory(AntennaeMem.MANTIS));
        }, 
        // is present
        function() : Bool
        {
            return player.antennae.type == Antennae.MANTIS;
        });
    
    public var AntennaeBee(default, never) : Transformation = new SimpleTransformation("Bee Antennae", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            if (player.antennae.type == Antennae.MANTIS)
            {
                desc += "Your head itches momentarily as your two long prehensile antennae changes slowly into floppy ones similar to those seen at bees.";
            }
            else if (player.antennae.type == Antennae.ANT)
            {
                desc += "Your head itches momentarily as your two rigid antennae changes slowly into floppy ones similar to those seen on bees.";
            }
            else
            {
                desc += "Your head itches momentarily as two floppy antennae sprout from your " + hairDescript() + ".";
            }
            player.antennae.type = Antennae.BEE;
            
            if (doOutput)
            {
                outputText(desc);
            }
            Metamorph.unlockMetamorph(AntennaeMem.getMemory(AntennaeMem.BEE));
        }, 
        // is present
        function() : Bool
        {
            return player.antennae.type == Antennae.BEE;
        });
    
    public var AntennaeCentipede(default, never) : Transformation = new SimpleTransformation("Centipede Antennae", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            desc += "Your head itches momentarily as two long antennae sprout from atop your forehead. You can move both independently as if they're an extension of you.";
            player.antennae.type = Antennae.CENTIPEDE;
            
            if (doOutput)
            {
                outputText(desc);
            }
            Metamorph.unlockMetamorph(AntennaeMem.getMemory(AntennaeMem.CENTIPEDE));
        }, 
        // is present
        function() : Bool
        {
            return player.antennae.type == Antennae.CENTIPEDE;
        });
    
    public var AntennaeFireSnail(default, never) : Transformation = new SimpleTransformation("Fire Snail Antennae", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "Two large lumps suddenly pushes out of your head and before you know it a pair of prehensile horn-like antennae are flopping in front of your forehead <b>just like those of a slug or snail</b>.";
            
            desc += "";
            player.antennae.type = Antennae.FIRE_SNAIL;
            Metamorph.unlockMetamorph(AntennaeMem.getMemory(AntennaeMem.FIRE_SNAIL));
            
            if (doOutput)
            {
                outputText(desc);
            }
        }, 
        // is present
        function() : Bool
        {
            return player.antennae.type == Antennae.FIRE_SNAIL;
        });
    
    public var AntennaeSeaDragon(default, never) : Transformation = new SimpleTransformation("Sea Dragon Antennae", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            desc += "A strange feeling washes over you as something crawls along your neck. You reach your hand up as large, thin strands of flesh suddenly shoot out from right beneath your ears.\n\nIt would almost resemble tentacles, but instead, they start producing dim bioluminescent lights, much like the whiskers of deep-sea creatures. <b>Just like a sea dragon you now have four bioluminescent neck strands!</b>";
            player.antennae.type = Antennae.SEA_DRAGON;
            if (doOutput)
            {
                outputText(desc);
            }
            Metamorph.unlockMetamorph(AntennaeMem.getMemory(AntennaeMem.SEA_DRAGON));
        }, 
        // is present
        function() : Bool
        {
            return player.antennae.type == Antennae.SEA_DRAGON;
        });
    
    public var AntennaeJabberwocky(default, never) : Transformation = new SimpleTransformation("Jabberwocky Antennae", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            desc += "A strange feeling washes over you as something crawls along your neck. You reach your hand up as two large, thin strands of scale covered flesh suddenly shoot out from right beneath your ears.\n\nIt would almost resemble tentacles thought some could say they are dragon whiskers. <b>Just like a jabberwocky you got two neck tentacles!</b>";
            player.antennae.type = Antennae.JABBERWOCKY;
            if (doOutput)
            {
                outputText(desc);
            }
            Metamorph.unlockMetamorph(AntennaeMem.getMemory(AntennaeMem.JABBERWOCKY));
        }, 
        // is present
        function() : Bool
        {
            return player.antennae.type == Antennae.JABBERWOCKY;
        });
    
    public var AntennaeAnt(default, never) : Transformation = new SimpleTransformation("Ant Antennae", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            if (player.antennae.type == Antennae.BEE)
            {
                desc += "Your head itches momentarily as your two floppy antennae change slowly into long, stiff-yet-prehensile ones similar to those seen on ants.";
            }
            else if (player.antennae.type == Antennae.MANTIS)
            {
                desc += "Your head itches momentarily as your two antennae stiffen up, ending up more like those on an ant";
            }
            else
            {
                desc += "Your head itches momentarily as two long prehensile antennae sprout from your [hair].";
            }
            player.antennae.type = Antennae.ANT;
            
            if (doOutput)
            {
                outputText(desc);
            }
            Metamorph.unlockMetamorph(AntennaeMem.getMemory(AntennaeMem.ANT));
        }, 
        // is present
        function() : Bool
        {
            return player.antennae.type == Antennae.ANT;
        });
    public var AntennaeMoth(default, never) : Transformation = new SimpleTransformation("Moth Antennae", 
        // apply effect
        function(doOutput : Bool) : Void
        {
            var desc : String = "";
            
            desc += " you suddenly feel a headache as you look around the world, you suddenly feel calm as if the headache you had before was never there,  you look in the lake and see 2 antennae sticking out of your head. <b>You now have Antennae</b>";
            player.antennae.type = Antennae.MOTH;
            if (doOutput)
            {
                outputText(desc);
            }
        }, 
        // is present
        function() : Bool
        {
            return player.antennae.type == Antennae.MOTH;
        });

    public function new()
    {
        super();
    }
}


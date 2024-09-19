package classes.transformations.transformations;

import classes.Race;
import classes.transformations.*;
import classes.items.MutationsHelper;
import classes.scenes.Metamorph;

/**
 * Base class for transformation events.
 */
class RaceTransformations extends MutationsHelper
{
    
    public static function raceTransform(name : String, raceArr : Array<Dynamic>, raceID : Race) : Transformation
    {
        var desc : String = "[pg]<b>You are now a" + name + "</b>\n";
        
        var newTF : Transformation = new SimpleTransformation(name + " Full Transform", 
        function(doOutput : Bool) : Void
        {
            if (doOutput)
            {
                outputText(desc);
            }
            Metamorph.runMetamorph(raceArr);
        }, 
        function() : Bool
        {
            return player.isRace(raceID);
        }, 
        function() : Bool
        {
            return true;
        });
        
        return newTF;
    }

    public function new()
    {
        super();
    }
}



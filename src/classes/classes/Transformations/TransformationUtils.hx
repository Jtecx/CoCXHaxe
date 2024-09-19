package classes.transformations;

import classes.EngineCore;
import classes.internals.Utils;
import classes.CoC;
import classes.bodyParts.LowerBody;

class TransformationUtils
{
    private function new()
    {
    }
    
    public static function allPresent(transformations : Array<Dynamic>) : Bool
    {
        return transformations.every(function(tf : Transformation, args : Array<Dynamic> = null) : Bool
                {
                    return tf.isPresent();
                });
    }
    public static function anyPresent(transformations : Array<Dynamic>) : Bool
    {
        return transformations.some(function(tf : Transformation, args : Array<Dynamic> = null) : Bool
                {
                    return tf.isPresent();
                });
    }
    public static function anyPossible(transformations : Array<Dynamic>) : Bool
    {
        return transformations.some(function(tf : PossibleEffect, args : Array<Dynamic> = null) : Bool
                {
                    return tf.isPossible();
                });
    }
    public static function missingTfs(transformations : Array<Dynamic>) : Array<Dynamic>
    {
        return transformations.filter(function(tf : Transformation, args : Array<Dynamic> = null) : Bool
                {
                    return !tf.isPresent();
                });
    }
    public static function possibleEffects(transformations : Array<Dynamic>) : Array<Dynamic>
    {
        return transformations.filter(function(tf : PossibleEffect, args : Array<Dynamic> = null) : Bool
                {
                    return tf.isPossible();
                });
    }
    public static function randomPossibleEffect(transformations : Array<Dynamic>) : PossibleEffect
    {
        var choices : Array<Dynamic> = possibleEffects(transformations);
        if (choices.length == 0)
        {
            trace("No possible effects!");
            return null;
        }
        var choice : PossibleEffect = Utils.randomChoice(choices);
        trace("Picked " + choice.name + " out of " + Utils.mapOneProp(choices, "name").join(", ") + " (dropped " + (transformations.length - choices.length) + " impossible)");
        return choice;
    }
    
    public static function applyTFIfNotPresent(transformation : Dynamic, doOutput : Bool = true) : Void
    {
        if (transformation.isPossible())
        {
            transformation.applyEffect(doOutput);
            if (doOutput)
            {
                EngineCore.outputText("\n\n");
            }
        }
    }
    
    // For Tail TFs: If the lower body doesn't allow a tail, humanize the lower body
    public static function removeLowerBodyIfIncompatible(player : Dynamic, doOutput : Bool = true) : Void
    {
        if (!LowerBody.allowsTail(player.lowerBody))
        {
            CoC.instance.transformations.LowerBodyHuman.applyEffect(doOutput);
            if (doOutput)
            {
                EngineCore.outputText("\n\n");
            }
        }
    }
    
    /**
     * Pick `count` effects from `effects` array (if `allowDuplicates` is false, don't pick them twice) and apply
     * their effects.
     * @return Number of effects applied
     */
    public static function pickAndRunMultipleEffects(effects : Array<Dynamic>, count : Int, doOutput : Bool = true, allowDuplicates : Bool = false, textSeparator : String = "\n\n") : Int
    {
        if (!allowDuplicates)
        {
            effects = effects.copy();
        }
        var result : Int = 0;
        while (count-- > 0)
        {
            var tf : PossibleEffect = randomPossibleEffect(effects);
            if (tf == null)
            {
                break;
            }
            if (doOutput)
            {
                EngineCore.outputText(textSeparator);
            }
            tf.applyEffect(doOutput);
            if (!allowDuplicates)
            {
                effects.splice(Lambda.indexOf(effects, tf), 1);
            }
            result++;
        }
        return result;
    }
}


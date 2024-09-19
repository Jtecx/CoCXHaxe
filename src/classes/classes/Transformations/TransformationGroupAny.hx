package classes.transformations;

import flash.errors.Error;

/**
 * TFs grouped with "OR".
 * - is present - any present
 * - is possible - any possible
 * - apply effect - pick random possible
 */
class TransformationGroupAny extends Transformation
{
    
    public var tfs : Array<Dynamic>;
    
    public function new(
            name : String,
            tfs : Array<Dynamic>)
    {
        super(name);
        if (tfs.length == 0)
        {
            throw new Error("Group TF " + name + " initialized with empty list");
        }
        this.tfs = tfs;
    }
    
    override public function isPresent() : Bool
    {
        for (tf in tfs)
        {
            if (tf.isPresent())
            {
                return true;
            }
        }
        return false;
    }
    
    override public function isPossible() : Bool
    {
        var anyPossible : Bool = false;
        for (tf in tfs)
        {
            if (tf.isPresent())
            {
                return false;
            }
            if (tf.isPossible())
            {
                anyPossible = true;
            }
        }
        return anyPossible;
    }
    
    override public function applyEffect(doOutput : Bool = true) : Void
    {
        var tf : PossibleEffect = TransformationUtils.randomPossibleEffect(tfs);
        if (tf != null)
        {
            tf.applyEffect(doOutput);
        }
    }
}


package classes.transformations;

import flash.errors.Error;

/**
 * TFs grouped with "OR".
 * - is present - all present
 * - is possible - any possible
 * - apply effect - pick random possible
 */
class TransformationGroupAll extends Transformation
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
            if (!tf.isPresent())
            {
                return false;
            }
        }
        return true;
    }
    
    override public function isPossible() : Bool
    {
        for (tf in tfs)
        {
            if (tf.isPossible())
            {
                return true;
            }
        }
        return false;
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


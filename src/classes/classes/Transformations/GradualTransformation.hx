package classes.transformations;

import flash.errors.Error;
import classes.CoCSettings;

/**
 * Wrapper for several TFs organized into queue.
 * Every TF in queue requires previous step to be completed.
 *
 * Application: next TF after last present.
 * IsPresent: if last tier is present.
 * IsPossible: if next tier above first missing is possible.
 *
 * Use OrderedTransformation when you group DIFFERENT PART tfs and want to establish an order.
 * Use GradualTransformation when you have tfs of SAME PART and want them to happen one-by-one.
 */
class GradualTransformation extends Transformation
{
    
    public var tfs : Array<Dynamic>;
    public var tierCount : Int;
    
    public function new(
            name : String,
            tfs : Array<Dynamic>)
    {
        super(name);
        this.tfs = tfs.copy();
        tierCount = tfs.length;
        if (tierCount == 0)
        {
            throw new Error("Multi-tier TF " + name + " initialized with empty list");
        }
        for (tf in tfs)
        {
            if (tf == null)
            {
                throw new Error("Multi-tier TF " + name + " contains nulls");
            }
        }
    }
    
    /**
	 * @return int Max tier (starting 1) of present TF. 0 if no tier present
	 */
    public function currentTier() : Int
    {
        var i : Int = tierCount;
        while (i-- > 0)
        {
            if (tfs[i].isPresent())
            {
                return as3hx.Compat.parseInt(i + 1);
            }
        }
        return 0;
    }
    
    /**
	 * @return Transformation Next transformation, or null if at max tier
	 */
    public function nextTierTf() : Transformation
    {
        var i : Int = currentTier();  // current tier = index of next  
        if (i < tierCount)
        {
            return tfs[i];
        }
        return null;
    }
    
    override public function isPresent() : Bool
    {
        return tfs[tfs.length - 1].isPresent();
    }
    
    override public function isPossible() : Bool
    {
        var tf : Transformation = nextTierTf();
        return tf && tf.isPossible();
    }
    
    override public function applyEffect(doOutput : Bool = true) : Void
    {
        var tf : Transformation = nextTierTf();
        if (tf == null)
        {
            CoC_Settings.error("Multi-tier TF " + name + " apply called at max tier");
            return;
        }
        tf.applyEffect(doOutput);
    }
    
    public function toString() : String
    {
        return "MultiTierTrasformation('" + name + "', [" + mapOneProp(tfs, "name").join(", ") + "])";
    }
}


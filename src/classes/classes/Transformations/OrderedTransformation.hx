package classes.transformations;

import flash.errors.Error;
import classes.CoCSettings;

/**
 * Wrapper for several TFs organized into queue.
 * Every TF in queue requires all previous steps to be completed.
 *
 * Application: first possible TF
 * IsPresent: if all are present
 * IsPossible: if any is possible
 *
 * Use OrderedTransformation when you group DIFFERENT PART tfs and want to establish an order.
 * Use GradualTransformation when you have tfs of SAME PART and want them to happen one-by-one.
 */
class OrderedTransformation extends Transformation
{
    
    public var tfs : Array<Dynamic>;
    public var tierCount : Int;
    public var compatible : Bool;
    
    public function new(
            name : String,
            tfs : Array<Dynamic>)
    {
        super(name);
        this.tfs = tfs.copy();
        tierCount = tfs.length;
        if (tierCount == 0)
        {
            throw new Error("Ordered TF " + name + " initialized with empty list");
        }
        for (tf in tfs)
        {
            if (tf == null)
            {
                throw new Error("Ordered TF " + name + " contains nulls");
            }
        }
    }
    
    /**
     * @return int Last present tier, 0 if none
     */
    public function currentTier() : Int
    {
        var i : Int = 0;
        while (i < tierCount)
        {
            if (!tfs[i].isPresent())
            {
                return i;
            }
            i++;
        }
        return tierCount;
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
            CoC_Settings.error("Ordered TF " + name + " apply called at max tier");
            return;
        }
        tf.applyEffect(doOutput);
    }
    
    public function toString() : String
    {
        return "OrderedTrasformation('" + name + "', [" + mapOneProp(tfs, "name").join(", ") + "])";
    }
}


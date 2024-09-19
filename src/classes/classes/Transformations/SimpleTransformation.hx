package classes.transformations;

import haxe.Constraints.Function;

class SimpleTransformation extends Transformation
{
    private var applyTfFn : Function;
    private var isPresentFn : Function;
    private var isPossibleFn : Function;
    
    public function new(
            name : String,
            applyTfFn : Function,
            isPresentFn : Function,
            isPossibleFn : Function = null)
    {
        super(name);
        this.applyTfFn = applyTfFn;
        this.isPresentFn = isPresentFn;
        this.isPossibleFn = isPossibleFn;
    }
    
    override public function isPresent() : Bool
    {
        return isPresentFn();
    }
    
    override public function isPossible() : Bool
    {
        return ((isPossibleFn != null)) ? isPossibleFn() : !isPresentFn();
    }
    
    override public function applyEffect(doOutput : Bool = true) : Void
    {
        applyTfFn(doOutput);
    }
}


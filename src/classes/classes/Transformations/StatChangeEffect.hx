package classes.transformations;

import haxe.Constraints.Function;

class StatChangeEffect extends PossibleEffect
{
    private var applyTfFn : Function;
    private var isPossibleFn : Function;
    
    public function new(
            name : String,
            applyTfFn : Function,
            isPossibleFn : Function = null)
    {
        super(name);
        this.applyTfFn = applyTfFn;
        this.isPossibleFn = isPossibleFn;
    }
    
    override public function isPossible() : Bool
    {
        return ((isPossibleFn != null)) ? isPossibleFn() : true;
    }
    
    override public function applyEffect(doOutput : Bool = true) : Void
    {
        applyTfFn(doOutput);
    }
}


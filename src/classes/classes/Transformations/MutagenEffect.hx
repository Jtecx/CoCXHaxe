package classes.transformations;

import haxe.Constraints.Function;

class MutagenEffect extends PossibleEffect
{
    public var statName : String;
    public var buffAmount : Float;
    public var text : String;
    private var isPossibleFn : Function;
    
    public function new(
            effectName : String,
            statName : String,
            buffAmount : Float,
            text : String,
            isPossibleFn : Function = null)
    {
        super(effectName);
        this.statName = statName;
        this.buffAmount = buffAmount;
        this.text = text;
        this.isPossibleFn = isPossibleFn;
    }
    
    
    override public function isPossible() : Bool
    {
        return ((isPossibleFn != null)) ? isPossibleFn() && MutagenBonus(statName, buffAmount, false) : MutagenBonus(statName, buffAmount, false);
    }
    
    override public function applyEffect(doOutput : Bool = true) : Void
    {
        if (doOutput)
        {
            outputText(text);
        }
        MutagenBonus(statName, buffAmount);
    }
}


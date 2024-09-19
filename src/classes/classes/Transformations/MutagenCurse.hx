package classes.transformations;

import haxe.Constraints.Function;

class MutagenCurse extends PossibleEffect
{
    public var statName : String;
    public var curseAmount : Float;
    public var text : String;
    private var isPossibleFn : Function;
    
    public function new(
            effectName : String,
            statName : String,
            curseAmount : Float,
            text : String,
            isPossibleFn : Function = null)
    {
        super(effectName);
        this.statName = statName;
        this.curseAmount = curseAmount;
        this.text = text;
        this.isPossibleFn = isPossibleFn;
    }
    
    
    override public function isPossible() : Bool
    {
        return ((isPossibleFn != null)) ? isPossibleFn() : true;
    }
    
    override public function applyEffect(doOutput : Bool = true) : Void
    {
        if (doOutput)
        {
            outputText(text);
        }
        player.addCurse(statName, curseAmount, 1);
    }
}


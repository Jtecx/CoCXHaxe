package classes.transformations;


class DynstatEffect extends PossibleEffect
{
    public var statName : String;
    public var buffAmount : Float;
    public var text : String;
    
    public function new(
            effectName : String,
            statName : String,
            buffAmount : Float,
            text : String)
    {
        super(effectName);
        this.statName = statName;
        this.buffAmount = buffAmount;
        this.text = text;
    }
    
    
    override public function isPossible() : Bool
    {
        return true;
    }
    
    override public function applyEffect(doOutput : Bool = true) : Void
    {
        if (doOutput)
        {
            outputText(text);
        }
        dynStats(statName, buffAmount);
    }
}


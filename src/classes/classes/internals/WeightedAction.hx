package classes.internals;

import haxe.Constraints.Function;

/**
	 * Class for performing weighted random actions (function/method calls) derived from WeightedDrop by aimozg
	 * @since May 7, 2017
	 * @author Stadler76
	 */
class WeightedAction
{
    private var actions : Array<Dynamic> = [];
    private var sum : Float = 0;
    
    public function new(first : Function = null, firstWeight : Float = 0)
    {
        if (first != null)
        {
            actions.push([first, firstWeight]);
            sum += firstWeight;
        }
    }
    
    public function add(action : Function, weight : Float = 1) : WeightedAction
    {
        actions.push([action, weight]);
        sum += weight;
        return this;
    }
    
    public function addMany(weight : Float, _actions : Array<Dynamic> = null) : WeightedAction
    {
        for (action in _actions)
        {
            actions.push([action, weight]);
            sum += weight;
        }
        return this;
    }
    
    public function exec() : Void
    {
        var random : Float = Math.random() * sum;
        var action : Function = null;
        var actions : Array<Dynamic> = this.actions.slice();
        while (random > 0 && actions.length > 0)
        {
            var pair : Array<Dynamic> = actions.shift();
            action = pair[0];
            random -= pair[1];
        }
        
        if (action != null)
        {
            action();
        }
    }
    
    public function clone() : WeightedAction
    {
        var other : WeightedAction = new WeightedAction();
        other.actions = actions.copy();
        other.sum = sum;
        return other;
    }
}


package classes.internals.race;

import haxe.Constraints.Function;
import classes.BodyData;

class RacialRequirement
{
    
    public var group : String;
    private var _name : String;
    private var _nameFn : Function;
    /**
	 * `(bodyData) => boolean`
	 */
    public var checkFn : Function;
    private var _score : Int;
    public var failScore : Int;
    public var minScore : Int;
    
    /**
	 * @param group ex. "face"
	 * @param name ex. "Wolf"
	 * @param check `(body:BodyData) => boolean`
	 * @param score points if check passed
	 * @param failScore points if check failed
	 * @param minScore
	 */
    public function new(
            group : String,
            name : Dynamic,
            check : Function,
            score : Int,
            failScore : Int,
            minScore : Int)
    {
        this.group = group;
        if (as3hx.Compat.typeof((name)) == "function")
        {
            this._nameFn = name;
        }
        else
        {
            this._name = name;
        }
        this.checkFn = check;
        this._score = score;
        this.failScore = failScore;
        this.minScore = minScore;
    }
    
    public function getName() : String
    {
        if (_nameFn != null)
        {
            return _nameFn();
        }
        if (_name != null)
        {
            return _name;
        }
        return "";
    }
    public function setNameStr(name : String) : RacialRequirement
    {
        this._nameFn = null;
        this._name = name;
        return this;
    }
    public function withNameFn(nameFn : Function) : RacialRequirement
    {
        return new RacialRequirement(
        group, 
        nameFn, 
        checkFn, 
        _score, 
        failScore, 
        minScore);
    }
    
    public function passScore(body : BodyData) : Int
    {
        return _score;
    }
    public function varyingScore() : Bool
    {
        return false;
    }
    
    public function check(body : BodyData, currentScore : Int) : Bool
    {
        return (minScore == 0 || currentScore >= minScore) && checkFn(body);
    }
    public function calcScore(body : BodyData, currentScore : Int) : Int
    {
        if (minScore > 0 && currentScore < minScore)
        {
            return 0;
        }
        return (check(body, currentScore)) ? passScore(body) : failScore;
    }
    public function describe(body : BodyData) : String
    {
        var score : Int = this.passScore(body);
        return getName() + " (" + ((score > 0) ? "+" + score : score) + ")";
    }
    
    public function withCondition(conditionFn : Function, conditionName : String) : RacialRequirement
    {
        return new RacialRequirement(
        group, 
        conditionName + " " + getName(), 
        function(body : BodyData) : Bool
        {
            return conditionFn(body) && checkFn(body);
        }, 
        _score, 
        failScore, 
        minScore);
    }
    
    /**
	 * Group multiple requirements as a single one. Uses score of first.
	 * @param nameSeparator string to join description, ex. " and " -> "fox ears and naga tail"
	 */
    public static function joinAnd(
            group : String,
            nameSeparator : String,
            req1 : RacialRequirement, rest : Array<Dynamic> = null) : RacialRequirement
    {
        var nameFns : Array<Dynamic> = [req1.getName];
        var checkfns : Array<Dynamic> = [req1.checkFn];
        for (i in rest)
        {
            nameFns.push(i.getName);
            checkfns.push(i.checkFn);
        }
        return new RacialRequirement(
        group, 
        function() : String
        {
            var names : Array<Dynamic> = new Array<Dynamic>(nameFns.length);
            for (i in 0...nameFns.length)
            {
                names[i] = nameFns[i]();
            }
            return names.join(nameSeparator);
        }, 
        function(body : BodyData) : Bool
        {
            for (fn in checkfns)
            {
                if (!fn(body))
                {
                    return false;
                }
            }
            return true;
        }, 
        req1._score, 
        req1.failScore, 
        req1.minScore);
    }
}


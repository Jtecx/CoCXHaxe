package classes.transformations;

import haxe.Constraints.Function;

/**
 * Base class for transformation events.
 */
class Transformation extends PossibleEffect
{
    public function new(name : String)
    {
        super(name);
    }
    
    /**
	 * Returns true if this transformation is already present at player
	 */
    public function isPresent() : Bool
    {
        return false;
    }
    
    /**
	 * Returns true if this transformation could be applied to player.
	 * By default, transformation is possible if it is not present.
	 */
    override public function isPossible() : Bool
    {
        return !isPresent();
    }
    
    /**
	 * Creates a new transformation from this one by adding extra condition.
	 * @param extraConditionFn function():Boolean returning true if new TF should apply
	 */
    public function copyWithExtraCondition(newName : String, extraConditionFn : Function) : Transformation
    {
        var thiz : Transformation = this;
        return new SimpleTransformation(newName, 
        applyEffect, 
        isPresent, 
        function() : Bool
        {
            return extraConditionFn() && thiz.isPossible();
        });
    }
    
    public function copyWithExtraEffect(newName : String, extraEffectFn : Function) : Transformation
    {
        var thiz : Transformation = this;
        return new SimpleTransformation(newName, 
        function(doOutput : Bool) : Void
        {
            thiz.applyEffect(doOutput);
            extraEffectFn(doOutput);
        }, 
        isPresent, 
        isPossible);
    }
    
    public function registerTf(substance : Int, essence : Int) : Transformation
    {
        registerEffect(substance, essence);
        return this;
    }
    public static function findSETf(substance : Int, essence : Int) : PossibleEffect
    {
        return try cast(findEffect("TF_" + substance + "_" + essence), PossibleEffect) catch(e:Dynamic) null;
    }
    public function registerTfMultiple(substance : Int, essences : Array<Dynamic> = null) : Transformation
    {
        for (essence in essences)
        {
            registerTf(substance, essence);
        }
        return this;
    }
    public function withAlchemyNames(shortName : String, longName : String) : Transformation
    {
        alchemyShortName = shortName;
        alchemyLongName = longName;
        return this;
    }
}


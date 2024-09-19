package classes.transformations;

import classes.BaseContent;
import classes.items.alchemy.AlchemyLib;
import flash.utils.Dictionary;

/**
 * Abstract superclass for applicable effects that have a condition (for example, transformative effects)
 */
class PossibleEffect extends BaseContent
{
    // TF id -> PossibleEffect[]
    public static var registry : Dictionary = new Dictionary();
    
    
    /**
	 * Name (for display and debugging)
	 */
    public var name : String;
    
    // See AlchemyLib
    public var substance : Int = AlchemyLib.AS_NONE;
    public var essence : Int = AlchemyLib.AE_NONE;
    public var residue : Int = AlchemyLib.AR_NONE;
    public var alchemyShortName : String = "Nothing";
    public var alchemyLongName : String = "Nothing";
    
    public function new(name : String)
    {
        super();
        this.name = name;
    }
    public function isPossible() : Bool
    {
        return true;
    }
    
    /**
	 * Apply effect the effect to player.
	 * If doOutput is false, do not print any text.
	 * Should not do clearOutput or setup any menus!
	 */
    public function applyEffect(doOutput : Bool = true) : Void
    {
    }
    
    public function registerEffectRaw(id : String) : PossibleEffect
    {
        if (!(Lambda.has(registry, id)))
        {
            Reflect.setField(registry, id, []);
        }
        Reflect.field(registry, id).push(this);
        return this;
    }
    public function registerEffect(substance : Int, essence : Int) : PossibleEffect
    {
        this.substance = substance;
        this.essence = essence;
        if (alchemyShortName == "Nothing")
        {
            this.alchemyShortName = AlchemyLib.Essences[essence].short + AlchemyLib.Substances[substance].short;
            this.alchemyLongName = AlchemyLib.Essences[essence].name + " " + AlchemyLib.Substances[substance].name;
        }
        registerEffectRaw("TF_" + substance + "_" + essence);
        return this;
    }
    public static function findEffect(id : String) : PossibleEffect
    {
        if (Lambda.has(registry, id))
        {
            return randomChoice(Reflect.field(registry, id));
        }
        return null;
    }
}


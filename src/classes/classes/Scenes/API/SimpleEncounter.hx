/*
 * Created by aimozg on 26.03.2017.
 */
package classes.scenes.aPI;

import haxe.Constraints.Function;
import classes.CoCSettings;
import classes.internals.Utils;

class SimpleEncounter implements Encounter
{
    private var _weight : Dynamic;
    private var _whenFn : Function;
    private var name : String;
    private var _body : Function;
    public var adjustment : Float = 0;  // added to the chance  
    
    public function new(name : String, whenFn : Function, weight : Dynamic, body : Function)
    {
        if (!(Std.is(weight, Function)) && !(Std.is(weight, Float)))
        {
            CoC_Settings.error("Encounters.make(name=" + name + ", weight=" + (as3hx.Compat.typeof(weight)) + ")");
            weight = 100;
        }
        this.name = name;
        this._weight = weight;
        this._whenFn = whenFn;
        this._body = body;
    }
    
    // chance or 0 if cannot happen
    public function encounterChance() : Float
    {
        if (!canHappen())
        {
            return 0;
        }
        return adjustedChance();
    }
    
    public function canHappen() : Bool
    {
        return !(Std.is(_whenFn, Function) && !_whenFn()) && originalChance() > 0;
    }
    
    public function adjustedChance() : Float
    {
        return Utils.round(originalChance() + adjustment, 2);
    }
    
    public function originalChance() : Float
    {
        if (Std.is(_weight, Function))
        {
            return _weight();
        }
        return _weight;
    }
    
    public function execEncounter() : Void
    {
        var rslt : Dynamic = _body();
        if (rslt != null && rslt != null)
        {
            trace("WARNING SimpleEncounter returned " + rslt + " (" + (as3hx.Compat.typeof(rslt)) + "), value ignored");
        }
    }
    
    public function encounterName() : String
    {
        return name;
    }
    
    /**
	 * Return a copy of this encounter with extra condition and chance multipliers.
	 * @param when Extra condition. Can be null if not needed
	 * @param chances Chance multipliers. Can be null or empty array if not needed
	 * @return
	 */
    public function wrap(whenFn : Function, chances : Array<Dynamic>) : SimpleEncounter
    {
        if (whenFn != null)
        {
            if (this._whenFn != null)
            {
                whenFn = FnHelpers.FN.all(whenFn, this._whenFn);
            }
        }
        else
        {
            whenFn = this._whenFn;
        }
        var result : SimpleEncounter = new SimpleEncounter(
        name, 
        whenFn, 
        !(chances != null || chances.length == 0) ? this._weight : FnHelpers.FN.product(chances.concat(this._weight)), 
        this._body);
        for (key in Reflect.fields(this))
        {
            if (!(Lambda.has(result, key)))
            {
                Reflect.setField(result, key, Reflect.field(this, key));
            }
        }
        return result;
    }
    public function getKind() : String
    {
        var kind : Dynamic = null;
        if (Lambda.has(this, "kind"))
        {
            kind = Reflect.field(this, "kind");
        }
        if (Std.is(kind, Function))
        {
            kind = kind();
        }
        return (kind != null) ? Std.string(kind).toLowerCase() : "";
    }
    public function getLabel() : String
    {
        var label : Dynamic = getTooltipHeader();
        if (Lambda.has(this, "shortLabel"))
        {
            label = Reflect.field(this, "shortLabel");
        }
        if (Std.is(label, Function))
        {
            label = label();
        }
        return Std.string(label);
    }
    public function getTooltipHint() : String
    {
        var hint : Dynamic = "Trigger this encounter.";
        if (Lambda.has(this, "hint"))
        {
            hint = Reflect.field(this, "hint");
        }
        if (Std.is(hint, Function))
        {
            hint = hint();
        }
        return Std.string(hint);
    }
    public function getTooltipHeader() : String
    {
        var hint : Dynamic = Utils.capitalizeFirstLetter(encounterName());
        if (Lambda.has(this, "label"))
        {
            hint = Reflect.field(this, "label");
        }
        if (Std.is(hint, Function))
        {
            hint = hint();
        }
        return Std.string(hint);
    }
}


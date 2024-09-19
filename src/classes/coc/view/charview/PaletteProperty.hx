/**
 * Coded by aimozg on 28.07.2017.
 */
package coc.view.charview;

import coc.script.Eval;
import coc.view.Color;

class PaletteProperty
{
    public var name : String;
    private var srcfn : Eval;
    private var defaultt : Int;
    private var lookupNames : Array<Dynamic>;
    
    public function new(name : String, expr : String, defaultt : Int, lookupNames : Array<Dynamic>)
    {
        this.name = name;
        this.srcfn = Eval.compile(expr);
        this.defaultt = defaultt;
        this.lookupNames = lookupNames.slice(0);
    }
    
    public function sourceValue(src : Dynamic) : Dynamic
    {
        return srcfn.call(src);
    }
    public function colorValue(src : Dynamic, lookupObjects : Dynamic) : Int
    {
        var sv : String = Std.string(sourceValue(src));
        return lookup(sv, lookupObjects);
    }
    public function lookup(sv : String, lookupObjects : Dynamic) : Int
    {
        if (sv.charAt(0) == "$")
        {
            return Color.convertColor(sv.substr(1));
        }
        for (ln in lookupNames)
        {
            var lookup : Dynamic = Reflect.field(lookupObjects, Std.string(ln));
            if (lookup != null && Lambda.has(lookup, sv))
            {
                return Color.convertColor(Reflect.field(lookup, sv));
            }
        }
        return defaultt;
    }
}


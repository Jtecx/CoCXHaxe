/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.view.charview;

import coc.script.Eval;
import coc.view.*;
import coc.xlogic.Compiler;
import coc.xlogic.Statement;

class CharViewCompiler extends Compiler
{
    private var charview : CharView;
    public function new(charview : CharView)
    {
        super();
        this.charview = charview;
    }
    
    override private function unknownTag(tag : String, x : FastXML) : Statement
    {
        var attrs : Dynamic = attrMap(x);
        switch (tag)
        {
            case "set", "show":

                switch (tag)
                {case "set":
                        if (Lambda.has(attrs, "value"))
                        {
                            return new SetVarStatement(Reflect.field(attrs, "var"), Reflect.field(attrs, "value"));
                        }
                        else
                        {
                            return new SetVarStatement(Reflect.field(attrs, "var"), "\"" + Eval.escapeString(Std.string(x.node.text.innerData())) + "\"");
                        }
                }
                return new LayerPart(charview.composite, Reflect.field(attrs, "part"), true);
            case "hide":
                return new LayerPart(charview.composite, Reflect.field(attrs, "part"), false);
            case "animate":
                return new AnimateStatement(Reflect.field(attrs, "layer"), Reflect.field(attrs, "name"));
        }
        return super.unknownTag(tag, x);
    }
}


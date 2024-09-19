/**
 * Coded by aimozg on 30.08.2019.
 */
package coc.view.charview;

import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

class SetVarStatement extends Statement
{
    public var name : String;
    public var expr : Eval;
    
    public function new(name : String, expr : String)
    {
        super();
        this.name = name;
        this.expr = Eval.compile(expr);
    }
    
    override public function execute(context : ExecContext) : Void
    {
        var value : Dynamic = expr.vcall(context.scopes);
        context.debug(this, " -> " + value);
        context.scopes[0][name] = value;
    }
    
    public function toString() : String
    {
        return "<set var='" + name + "' value=\"" + expr.src + "\">";
    }
}


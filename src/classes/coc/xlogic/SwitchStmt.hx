/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic;

import coc.script.Eval;

class SwitchStmt extends Statement
{
    public var valueExpr : Eval;
    public var cases : Array<Dynamic> = [];
    public var defaults : StmtList = new StmtList();
    
    public function new(valueAttr : String = null)
    {
        super();
        if (valueAttr != null)
        {
            valueExpr = Eval.compile(valueAttr);
        }
    }
    
    override public function execute(context : ExecContext) : Void
    {
        var hasValue : Bool = valueExpr != null;
        var value : Dynamic = (hasValue) ? valueExpr.vcall(context.scopes) : null;
        if (hasValue)
        {
            context.debug(this, "value = " + value);
        }
        else
        {
            context.debug(this, "enter");
        }
        for (block in cases)
        {
            if (block.check(context, hasValue, value))
            {
                context.execute(block);
                return;
            }
        }
        context.debug(this, "default");
        context.execute(defaults);
    }
    
    public function toString() : String
    {
        return "<switch" + ((valueExpr != null) ? " value=\"" + valueExpr.src + "\">" : "") +
        " [case " + cases.length + "]" +
        " [default " + defaults.stmts.length + "] </switch>";
    }
}


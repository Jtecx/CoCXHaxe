/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic;

import coc.script.Eval;

class IfStmt extends Statement
{
    public var expr : Eval;
    public var thenBlock : Array<Dynamic> = [];
    public var elseBlock : Statement = null;
    
    public function new(condition : String)
    {
        super();
        this.expr = Eval.compile(condition);
    }
    
    override public function execute(context : ExecContext) : Void
    {
        if (expr.vcall(context.scopes))
        {
            context.debug(this, "then");
            context.executeAll(thenBlock);
        }
        else if (elseBlock != null)
        {
            context.debug(this, "else");
            context.execute(elseBlock);
        }
        else
        {
            context.debug(this, "skip");
        }
    }
    
    public function toString() : String
    {
        return "<if test=\"" + expr.src + "\"> [then " + thenBlock.length + "] " +
        ((elseBlock != null) ? "<else/> " : "") + "</if>";
    }
}


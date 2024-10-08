/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts;

import classes.EngineCore;
import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

class OutputStmt extends Statement
{
    private var content : Eval;
    public function new(content : String)
    {
        super();
        this.content = Eval.compile(content);
    }
    
    override public function execute(context : ExecContext) : Void
    {
        var value : String = "" + content.vcall(context.scopes);
        context.debug(this, "value = \"" + Eval.escapeString(value) + "\"");
        EngineCore.outputText("" + value);
    }
    
    public function toString() : String
    {
        return "<output>" + content.src + "</output>";
    }
}


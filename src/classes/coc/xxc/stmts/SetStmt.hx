package coc.xxc.stmts;

import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

class SetStmt extends Statement
{
    private var varname : String;
    private var content : Eval;
    private var op : String;
    public function new(varname : String, content : String, op : String = "=")
    {
        super();
        this.varname = varname;
        this.content = Eval.compile(content);
        this.op = op;
    }
    
    override public function execute(context : ExecContext) : Void
    {
        var left : Dynamic = context.getValue(varname);
        var right : Dynamic = content.vcall(context.scopes);
        var rslt : Dynamic;
        switch (op)
        {
            case "append", "+", "+=":
                rslt = Eval.calculateOp(left, "+", right);
            case "set", "=":
                rslt = right;
            default:
                rslt = Eval.calculateOp(left, op, right);
        }
        context.debug(this, "left = " + left + ", right = " + right + ", rslt = " + rslt);
        context.setValue(varname, rslt);
    }
    
    
    public function toString() : String
    {
        return "<set var=\"" + varname + "\" value=\"" + content.src + "\" op=\"" + op + "\"/>";
    }
}


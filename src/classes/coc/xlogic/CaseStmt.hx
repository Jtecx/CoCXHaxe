/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic;

import coc.script.Eval;

class CaseStmt extends Statement
{
    public var testAttr(never, set) : String;
    public var valueAttr(never, set) : String;
    public var valuesAttr(never, set) : String;
    public var ltAttr(never, set) : String;
    public var lteAttr(never, set) : String;
    public var gtAttr(never, set) : String;
    public var gteAttr(never, set) : String;
    public var neAttr(never, set) : String;

    private var testExpr : Eval;
    private var valueExpr : Eval;
    private var valuesExpr : Eval;
    private var ltExpr : Eval;
    private var lteExpr : Eval;
    private var gtExpr : Eval;
    private var gteExpr : Eval;
    private var neExpr : Eval;
    public var thenBlock : StmtList = new StmtList();
    private function set_testAttr(value : String) : String
    {
        testExpr = (value != null) ? Eval.compile(value) : null;
        return value;
    }
    private function set_valueAttr(value : String) : String
    {
        valueExpr = (value != null) ? Eval.compile(value) : null;
        return value;
    }
    private function set_valuesAttr(value : String) : String
    {
        valuesExpr = (value != null) ? Eval.compile("[" + value + "]") : null;
        return value;
    }
    private function set_ltAttr(value : String) : String
    {
        ltExpr = (value != null) ? Eval.compile(value) : null;
        return value;
    }
    private function set_lteAttr(value : String) : String
    {
        lteExpr = (value != null) ? Eval.compile(value) : null;
        return value;
    }
    private function set_gtAttr(value : String) : String
    {
        gtExpr = (value != null) ? Eval.compile(value) : null;
        return value;
    }
    private function set_gteAttr(value : String) : String
    {
        gteExpr = (value != null) ? Eval.compile(value) : null;
        return value;
    }
    private function set_neAttr(value : String) : String
    {
        neExpr = (value != null) ? Eval.compile(value) : null;
        return value;
    }
    public function new()
    {
        super();
    }
    public function check(context : ExecContext, useValue : Bool, checkValue : Dynamic) : Bool
    {
        if (testExpr != null && testExpr.vcall(context.scopes))
        {
            context.debug(this, " => test true");
            return true;
        }
        if (useValue)
        {
            var pass : Bool = true;
            if (valueExpr != null)
            {
                pass = pass && checkValue == valueExpr.vcall(context.scopes);
            }
            if (valuesExpr != null)
            {
                pass = pass && valuesExpr.vcall(context.scopes).indexOf(checkValue) >= 0;
            }
            if (ltExpr != null)
            {
                pass = pass && checkValue < ltExpr.vcall(context.scopes);
            }
            if (lteExpr != null)
            {
                pass = pass && checkValue <= lteExpr.vcall(context.scopes);
            }
            if (gtExpr != null)
            {
                pass = pass && checkValue > gtExpr.vcall(context.scopes);
            }
            if (gteExpr != null)
            {
                pass = pass && checkValue >= gteExpr.vcall(context.scopes);
            }
            if (neExpr != null)
            {
                pass = pass && checkValue != neExpr.vcall(context.scopes);
            }
            context.debug(this, (pass) ? "value pass" : "value fail");
            return pass;
        }
        context.debug(this, "skip");
        return false;
    }
    
    override public function execute(context : ExecContext) : Void
    {
        context.execute(thenBlock);
    }
    
    public function toString() : String
    {
        return "<case" +
        ((testExpr != null) ? " test=\"" + testExpr.src + "\"" : "") +
        ((valueExpr != null) ? " value=\"" + valueExpr.src + "\"" : "") +
        ((valuesExpr != null) ? " values=\"" + valuesExpr.src + "\"" : "") +
        ((ltExpr != null) ? " lt=\"" + ltExpr.src + "\"" : "") +
        ((lteExpr != null) ? " lte=\"" + lteExpr.src + "\"" : "") +
        ((gtExpr != null) ? " gt=\"" + gtExpr.src + "\"" : "") +
        ((gteExpr != null) ? " gte=\"" + gteExpr.src + "\"" : "") +
        ((neExpr != null) ? " ne=\"" + neExpr.src + "\"" : "") +
        "> [" + thenBlock.stmts.length + "] </case>";
    }
}


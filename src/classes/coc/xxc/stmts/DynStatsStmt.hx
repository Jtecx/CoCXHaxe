/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts;

import classes.CoC;
import classes.internals.Utils;
import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.StoryContext;

class DynStatsStmt extends Statement
{
    private var args : Dynamic = { };
    public function new()
    {
        super();
    }
    public function setAttr(attrname : String, expr : String) : Void
    {
        if (expr == null)
        {
            Reflect.deleteField(args, expr);
        }
        else
        {
            Reflect.setField(args, attrname, Eval.compile(expr));
        }
    }
    
    override public function execute(context : ExecContext) : Void
    {
        var game : CoC = (try cast(context, StoryContext) catch(e:Dynamic) null).game;
        var arr : Array<Dynamic> = [];
        for (name in Reflect.fields(args))
        {
            var value : Dynamic = (try cast(Reflect.field(args, name), Eval) catch(e:Dynamic) null).vcall(context.scopes);
            arr.push(name);
            arr.push(value);
            
        }
        game.player.dynStats.apply(game, arr);
    }
    
    public function toString() : String
    {
        return "<dynStats " + Utils.keys(args) + "/>";
    }
}


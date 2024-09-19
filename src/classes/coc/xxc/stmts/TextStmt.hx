/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts;

import classes.EngineCore;
import classes.internals.Utils;
import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

class TextStmt extends Statement
{
    public static inline var TRIMSTYLE_NONE : Int = 0;
    public static inline var TRIM_LEFT : Int = 1;  //  Trim leading whitespace  
    public static inline var TRIM_RIGHT : Int = 2;  //  Trim trailing whitespace  
    public static inline var TRIM_UNINDENT : Int = 4;  //  Remove whitespace right after line break  
    public static inline var TRIM_SQUEEZE : Int = 8;  //  Replace single line breaks with spaces  
    public static inline var TRIM_NT_TN : Int = 16;  // Remove leading \n\t+ and trailing \t*\n  
    public static var TRIMSTYLE_MAX : Int = TRIM_LEFT | TRIM_RIGHT | TRIM_UNINDENT | TRIM_SQUEEZE;
    private var content : String;
    public function new(content : String, trimStyle : Int)
    {
        super();
        content = new as3hx.Compat.Regex('\\r', "g").replace(content, "");
        if ((trimStyle & TRIM_LEFT) != 0)
        {
            content = Utils.trimLeft(content);
        }
        if ((trimStyle & TRIM_RIGHT) != 0)
        {
            content = Utils.trimRight(content);
        }
        if ((trimStyle & TRIM_NT_TN) != 0)
        {
            content = new as3hx.Compat.Regex('^\\n[ \\t]+', "").replace(content, "").replace(new as3hx.Compat.Regex('[ \\t]*\\n$', ""), "");
        }
        if ((trimStyle & TRIM_UNINDENT) != 0)
        {
            content = new as3hx.Compat.Regex('\\n[ \\t]+', "g").replace(content, "\n");
        }
        if ((trimStyle & TRIM_SQUEEZE) != 0)
        {
            content = new as3hx.Compat.Regex('\\n\\n', "g").replace(content, "\\n\\n").replace(new as3hx.Compat.Regex('\\\\n\\n', "g"), "\\n\\n").replace(new as3hx.Compat.Regex('\\n', "g"), " ");
        }
        this.content = content;
    }
    
    override public function execute(context : ExecContext) : Void
    {
        context.debug(this, "print");
        EngineCore.outputText(content);
    }
    
    public function toString() : String
    {
        return "(text) \"" + Eval.escapeString(content.substr(0, 20)) + ((content.length > 20) ? "\"...[+" + (content.length - 20) + "]" : "\"");
    }
}


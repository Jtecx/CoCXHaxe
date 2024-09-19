package coc.script;

import flash.errors.Error;
import classes.internals.Utils;

class EvalCompiler
{
    private var expr : String;
    private var _src : String;
    public function new(expr : String)
    {
        this._src = expr;
        this.expr = expr;
    }
    
    // Expressions are converted to [OPCODE, X, Y, Z] (X, Y, Z optional)
    
    // Special operations
    private static inline var OPCODE_ERROR : Int = 0;  // throw X (X is literal string)  
    private static inline var OPCODE_ID : Int = 1;  // X (X is an identifier string)  
    private static inline var OPCODE_LITERAL : Int = 2;  // X (X is a primitive)  
    private static inline var OPCODE_INDEX : Int = 3;  // X[Y]  
    private static inline var OPCODE_DOT : Int = 4;  // X.Y (y is literal string)  
    private static inline var OPCODE_CALL : Int = 5;  // X(Y1, Y2, ...)  
    private static inline var OPCODE_ARRAY : Int = 6;  // [X1, X2, X3, ...]  
    private static inline var OPCODE_OBJECT : Int = 7;  // { [X1]: X2, [X3]: X4, ... }  
    // Unary operations
    private static inline var OPCODE_NOT : Int = 100;  // !X  
    private static inline var OPCODE_NEG : Int = 101;  // -X  
    private static inline var OPCODE_BINNOT : Int = 102;  // ~X  
    // Binary operations
    private static inline var OPCODE_OR : Int = 200;  // X || Y  
    private static inline var OPCODE_AND : Int = 201;  // X && Y  
    private static inline var OPCODE_GTE : Int = 202;  // X >= Y  
    private static inline var OPCODE_GT : Int = 203;  // X > Y  
    private static inline var OPCODE_LTE : Int = 204;  // X <= Y  
    private static inline var OPCODE_LT : Int = 205;  // X < Y  
    private static inline var OPCODE_NEQUIV : Int = 206;  // X !== Y  
    private static inline var OPCODE_NEQ : Int = 207;  // X != Y  
    private static inline var OPCODE_EQUIV : Int = 209;  // X === Y  
    private static inline var OPCODE_EQ : Int = 210;  // X == Y  
    private static inline var OPCODE_ADD : Int = 211;  // X + Y  
    private static inline var OPCODE_SUB : Int = 212;  // X - Y  
    private static inline var OPCODE_MUL : Int = 213;  // X * Y  
    private static inline var OPCODE_DIV : Int = 214;  // X / Y  
    private static inline var OPCODE_MOD : Int = 215;  // X % Y  
    // Ternary operation
    private static inline var OPCODE_IF : Int = 300;  // X ? Y : Z  
    
    public static var RX_FLOAT : as3hx.Compat.Regex = new as3hx.Compat.Regex('^[+\\-]?(?:\\d+(\\.\\d+)?|\\.\\d+)(?:e[+\\-]?\\d+)?$', "");
    public static var RX_INT : as3hx.Compat.Regex = new as3hx.Compat.Regex('^[+\\-]?(?:0x)?\\d+$', "");
    public static var RX_SIMPLESTRING : as3hx.Compat.Regex = new as3hx.Compat.Regex('^(?:'[^'\\\\]*'|"[^"\\\\]*")$', "");
    
    private static var LA_BLOCK_COMMENT : as3hx.Compat.Regex = new as3hx.Compat.Regex('^\\/\\*([^*\\/]|\\*[^\\/]|[^\\*]\\/)*\\*+\\/', "");
    private static var LA_FLOAT : as3hx.Compat.Regex = new as3hx.Compat.Regex('^[+\\-]?(\\d+(\\.\\d+)?|\\.\\d+)(e[+\\-]?\\d+)?', "");
    private static var LA_INT : as3hx.Compat.Regex = new as3hx.Compat.Regex('^[+\\-]?(0x)?\\d+', "");
    private static var LA_SIMPLESTRING : as3hx.Compat.Regex = new as3hx.Compat.Regex('^('[^'\\\\]*'|"[^"\\\\]*")', "");
    private static var LA_ID : as3hx.Compat.Regex = new as3hx.Compat.Regex('^[a-zA-Z_$][a-zA-Z_$0-9]*', "");
    private static var LA_OPERATOR : as3hx.Compat.Regex = new as3hx.Compat.Regex('^(>=?|<=?|!==?|={1,3}|\\|\\||&&|or|and|eq|neq?|[lg](te|t|e)|[-+*\\/%])', "");
    private static var OP_PRIORITIES : Dynamic = {
            || : 10,
            or : 10,
            && : 20,
            and : 20,
            >= : 30,
            > : 30,
            <= : 30,
            < : 30,
            !== : 30,
            != : 30,
            === : 30,
            == : 30,
            = : 30,
            lt : 30,
            le : 30,
            lte : 30,
            gt : 30,
            ge : 30,
            gte : 30,
            neq : 30,
            ne : 30,
            eq : 30,
            + : 40,
            - : 40,
            * : 50,
            / : 50,
            % : 50
        };
    private static var OP_OPCODES : Dynamic = {
            || : OPCODE_OR,
            or : OPCODE_OR,
            && : OPCODE_AND,
            and : OPCODE_AND,
            >= : OPCODE_GTE,
            > : OPCODE_GT,
            <= : OPCODE_LTE,
            < : OPCODE_LT,
            !== : OPCODE_NEQUIV,
            != : OPCODE_NEQ,
            === : OPCODE_EQUIV,
            == : OPCODE_EQ,
            = : OPCODE_EQ,
            lt : OPCODE_LT,
            le : OPCODE_LTE,
            lte : OPCODE_LTE,
            gt : OPCODE_GT,
            ge : OPCODE_GTE,
            gte : OPCODE_GTE,
            neq : OPCODE_NEQ,
            ne : OPCODE_NEQ,
            eq : OPCODE_EQ,
            + : OPCODE_ADD,
            - : OPCODE_SUB,
            * : OPCODE_MUL,
            / : OPCODE_DIV,
            % : OPCODE_MOD
        };
    
    public static function execute(code : Dynamic, scopes : Array<Dynamic>) : Dynamic
    {
        if (!(Std.is(code, Array)))
        {
            return code;
        }
        var opcode : Int = Reflect.field(code, Std.string(0));
        var x : Dynamic;
        var y : Dynamic;
        var z : Dynamic;
        var i : Int;
        switch (opcode)
        {
            case OPCODE_ERROR, OPCODE_ID:

                switch (opcode)
                {case OPCODE_ERROR:
                        throw new Error(Std.string(Reflect.field(code, Std.string(1))));
                }
                return lookup(Reflect.field(code, Std.string(1)), scopes);
            case OPCODE_LITERAL:
                return Reflect.field(code, Std.string(1));
            case OPCODE_INDEX:
                x = execute(Reflect.field(code, Std.string(1)), scopes);
                y = execute(Reflect.field(code, Std.string(2)), scopes);
                z = Reflect.field(x, Std.string(y));
                if (Std.is(z, Function))
                {
                    z = Utils.bindThis(z, x);
                }
                return z;
            case OPCODE_DOT:
                x = execute(Reflect.field(code, Std.string(1)), scopes);
                y = Std.string(Reflect.field(code, Std.string(2)));
                z = Reflect.field(x, Std.string(y));
                if (Std.is(z, Function))
                {
                    z = Utils.bindThis(z, x);
                }
                return z;
            case OPCODE_CALL:
                x = execute(Reflect.field(code, Std.string(1)), scopes);
                y = [];
                i = 2;
                while (i < code.length)
                {
                    y.push(execute(Reflect.field(code, Std.string(i++)), scopes));
                }
                return (try cast(x, Function) catch(e:Dynamic) null).apply(null, y);
            case OPCODE_ARRAY:
                x = [];
                i = 1;
                while (i < code.length)
                {
                    x.push(execute(Reflect.field(code, Std.string(i++)), scopes));
                }
                return x;
            case OPCODE_OBJECT:
                x = { };
                i = 1;
                while (i < code.length)
                {
                    var key : String = Std.string(execute(Reflect.field(code, Std.string(i++)), scopes));
                    var value : Dynamic = execute(Reflect.field(code, Std.string(i++)), scopes);
                    Reflect.setField(x, key, value);
                }
                return x;
            case OPCODE_NOT:
                return !execute(Reflect.field(code, Std.string(1)), scopes);
            case OPCODE_NEG:
                return -execute(Reflect.field(code, Std.string(1)), scopes);
            case OPCODE_BINNOT:
                return ~execute(Reflect.field(code, Std.string(1)), scopes);
            case OPCODE_IF:
                return (execute(Reflect.field(code, Std.string(1)), scopes)) ? execute(Reflect.field(code, Std.string(2)), scopes) : execute(Reflect.field(code, Std.string(3)), scopes);
            case OPCODE_OR:
                return execute(Reflect.field(code, Std.string(1)), scopes) || execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_AND:
                return execute(Reflect.field(code, Std.string(1)), scopes) && execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_GTE:
                return execute(Reflect.field(code, Std.string(1)), scopes) >= execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_GT:
                return execute(Reflect.field(code, Std.string(1)), scopes) > execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_LTE:
                return execute(Reflect.field(code, Std.string(1)), scopes) <= execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_LT:
                return execute(Reflect.field(code, Std.string(1)), scopes) < execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_NEQUIV:
                return execute(Reflect.field(code, Std.string(1)), scopes) != execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_NEQ:
                return execute(Reflect.field(code, Std.string(1)), scopes) != execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_EQUIV:
                return execute(Reflect.field(code, Std.string(1)), scopes) == execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_EQ:
                return execute(Reflect.field(code, Std.string(1)), scopes) == execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_ADD:
                return execute(Reflect.field(code, Std.string(1)), scopes) + execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_SUB:
                return execute(Reflect.field(code, Std.string(1)), scopes) - execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_MUL:
                return execute(Reflect.field(code, Std.string(1)), scopes) * execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_DIV:
                return execute(Reflect.field(code, Std.string(1)), scopes) / execute(Reflect.field(code, Std.string(2)), scopes);
            case OPCODE_MOD:
                return execute(Reflect.field(code, Std.string(1)), scopes) % execute(Reflect.field(code, Std.string(2)), scopes);
        }
        throw new Error("Unknown Eval opcode " + Std.string(opcode));
    }
    
    private static function lookup(id : String, scopes : Array<Dynamic>) : Dynamic
    {
        switch (id)
        {
            case "Math":return Math;
            case "undefined":return null;
            case "null":return null;
            case "int":return Int;
            case "uint":return Int;
            case "String":return String;
            case "string":return String;
            case "Number":return Float;
            case "true":return true;
            case "false":return false;
            default:
                for (thiz in scopes)
                {
                    if (Lambda.has(thiz, id))
                    {
                        return Reflect.field(thiz, id);
                    }
                }
                return null;
        }
    }
    
    private static function error(src : String, expr : String, msg : String, tail : Bool = true) : Error
    {
        return new Error("In expr: " + src + "\n" + msg + ((tail) ? ": " + expr : ""));
    }
    public static function compile(expr : String) : Dynamic
    {
        if (expr.match(RX_INT))
        {
            return as3hx.Compat.parseInt(expr);
        }
        if (expr.match(RX_FLOAT))
        {
            return as3hx.Compat.parseFloat(expr);
        }
        if (expr.match(RX_SIMPLESTRING))
        {
            return expr.substring(1, expr.length - 1);
        }
        return new EvalCompiler(expr).evalUntil("");
    }
    
    private function evalUntil(until : String) : Dynamic
    {
        var x : Dynamic = evalExpr(0);
        if (expr == until || expr.charAt(0) == until)
        {
            return x;
        }
        if (until != null)
        {
            throw error(_src, expr, "Operator or " + until + "expected");
        }
        throw error(_src, expr, "Operator expected");
    }
    private function evalExpr(minPrio : Int) : Dynamic
    {
        var m : Array<Dynamic>;
        var x : Dynamic;
        eatWs();
        if (eatStr("not") || eatStr("!"))
        {
            return [OPCODE_NOT, evalExpr(minPrio)];
        }
        else if (eatStr("-"))
        {
            return [OPCODE_NEG, evalExpr(minPrio)];
        }
        else if (eatStr("~"))
        {
            return [OPCODE_BINNOT, evalExpr(minPrio)];
        }
        else if (eatStr("("))
        {
            x = evalUntil(")");
            eatStr(")");
        }
        else if (eatStr("["))
        {
            if (eatStr("]"))
            {
                x = [OPCODE_ARRAY];
            }
            else
            {
                x = [OPCODE_ARRAY, evalExpr(0)];
                while (eatStr(","))
                {
                    x.push(evalExpr(0));
                }
                if (!eatStr("]"))
                {
                    throw error(_src, expr, "Expected ',' or ']'");
                }
            }
        }
        else if (m != null = eat(LA_FLOAT))
        {
            x = as3hx.Compat.parseFloat(m[0]);
        }
        else if (m != null = eat(LA_INT))
        {
            x = as3hx.Compat.parseInt(m[0]);
        }
        else if (m != null = eat(LA_SIMPLESTRING))
        {
            x = m[0].substring(1, m[0].length - 1);
        }
        else if (m != null = eat(new as3hx.Compat.Regex('^['"]', "")))
        {
            var delim : String = m[0];
            var s : String = "";
            var rex : as3hx.Compat.Regex = (delim == "\"") ? new as3hx.Compat.Regex('^[^"\\\\]+', "") : new as3hx.Compat.Regex('^[^'\\\\]+', "");
            while (true)
            {
                if (eatStr("\\"))
                {
                    var c : String = eatN(1);
                    if (c == "n")
                    {
                        s += "\n";
                    }
                    else if (c == "t")
                    {
                        s += "\t";
                    }
                    else if (c == "\r")
                    {
                        s += "";
                    }
                    else
                    {
                        s += c;
                    }
                }
                else if (eatStr(delim))
                {
                    break;
                }
                else if (m != null = eat(rex))
                {
                    s += m[0];
                }
                else
                {
                    throw error(_src, expr, "Expected text");
                }
            }
            x = s;
        }
        else if (m != null = eat(LA_ID))
        {
            x = [OPCODE_ID, m[0]];
        }
        else
        {
            throw error(_src, expr, "Not a sub-expr");
        }
        return evalPostExpr(x, minPrio);
    }
    private function evalPostExpr(x : Dynamic, minPrio : Int) : Dynamic
    {
        var m : Array<Dynamic>;
        var y : Dynamic;
        var z : Dynamic;
        while (true)
        {
            eatWs();
            if (eatStr("()"))
            {
                x = [OPCODE_CALL, x];
            }
            else if (eatStr("("))
            {
                x = [OPCODE_CALL, x];
                while (true)
                {
                    y = evalExpr(0);
                    x.push(y);
                    if (eatStr(")"))
                    {
                        break;
                    }
                    if (!eatStr(","))
                    {
                        throw error(_src, expr, "Expected ')' or ','");
                    }
                }
            }
            else if (eatStr("."))
            {
                m = eat(LA_ID);
                if (m == null)
                {
                    throw error(_src, expr, "Identifier expected");
                }
                x = [OPCODE_DOT, x, m[0]];
            }
            else if (eatStr("["))
            {
                y = evalUntil("]");
                eatWs();
                if (!eatStr("]"))
                {
                    throw error(_src, expr, "Expected ']'");
                }
                x = [OPCODE_INDEX, x, y];
            }
            else if (eatStr("?"))
            {
                y = evalUntil(":");
                if (!eatStr(":"))
                {
                    throw error(_src, expr, "Expected ':'");
                }
                z = evalExpr(0);
                x = [OPCODE_IF, x, y, z];
            }
            else if (m != null = eat(LA_OPERATOR))
            {
                var opcode : Int = Reflect.field(OP_OPCODES, Std.string(m[0]));
                var p : Int = Reflect.field(OP_PRIORITIES, Std.string(m[0]));
                if (p > minPrio)
                {
                    y = evalExpr(p);
                    x = [opcode, x, y];
                }
                else
                {
                    unshift(m[0]);
                    break;
                }
            }
            else
            {
                break;
            }
        }
        return x;
    }
    private function eat(rex : as3hx.Compat.Regex) : Array<Dynamic>
    {
        var m : Array<Dynamic> = expr.match(rex);
        if (m != null)
        {
            eatN(m[0].length);
        }
        return m;
    }
    private function unshift(s : String) : Void
    {
        expr = s + expr;
    }
    private function eatN(n : Int) : String
    {
        var s : String = expr.substr(0, n);
        expr = expr.substr(n);
        return s;
    }
    private function eatStr(s : String) : Bool
    {
        if (expr.substr(0, s.length).indexOf(s) == 0)
        {
            eatN(s.length);
            return true;
        }
        return false;
    }
    private function eatWs() : Void
    //noinspection StatementWithEmptyBodyJS
    {
        
        while (eat(new as3hx.Compat.Regex('^\\s+', "")) || eat(LA_BLOCK_COMMENT))
        {
        }
    }
}


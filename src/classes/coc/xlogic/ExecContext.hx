/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic;

import flash.errors.Error;
import classes.CoC;

class ExecContext
{
    public var scopes(get, set) : Array<Dynamic>;

    public function new(_thiz : Array<Dynamic>)
    {
        this._scopes = _thiz;
    }
    private var _scopes : Array<Dynamic> = [];
    private function get_scopes() : Array<Dynamic>
    {
        return _scopes;
    }
    private function set_scopes(value : Array<Dynamic>) : Array<Dynamic>
    {
        _scopes = value;
        return value;
    }
    public function getValue(varname : String) : Dynamic
    {
        for (s in _scopes)
        {
            if (Lambda.has(s, varname))
            {
                return Reflect.field(s, varname);
            }
        }
        return null;
    }
    public function setValue(varname : String, value : Dynamic) : Void
    {
        for (s in _scopes)
        {
            if (Lambda.has(s, varname))
            {
                Reflect.setField(s, varname, value);
                return;
            }
        }
        Reflect.setField(_scopes[0], varname, value);
    }
    public function substituteVars(expr : String) : String
    {
        return new as3hx.Compat.Regex('\\$(\\w+)|\\$\\{(\\w+)\\}', "g").replace(expr, function() : String
                {
                    return getValue(arguments[1] || arguments[2]);
                });
    }
    public function hasValue(varname : String) : Bool
    {
        for (s in _scopes)
        {
            if (Lambda.has(s, varname))
            {
                return true;
            }
        }
        return false;
    }
    public function execute(stmt : Statement) : Void
    {
        stmt.execute(this);
    }
    public function executeAll(stmts : Array<Dynamic>) : Void
    {
        for (statement in stmts)
        {
            statement.execute(this);
        }
    }
    public function error(where : Statement, message : String) : Void
    {
        throw new Error("In " + where + ": " + message);
    }
    public function pushScope(scope : Dynamic) : Void
    {
        scopes.unshift(scope);
    }
    public function popScope() : Void
    {
        scopes.shift();
    }
    /**
	 * For debugging
	 */
    public function debug(where : Statement, s : String) : Void
    {
        if (!CoC.instance.debug)
        {
            return;
        }
        trace("" + where + " " + s);
    }
}


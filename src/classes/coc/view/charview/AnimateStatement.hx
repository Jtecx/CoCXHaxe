package coc.view.charview;

import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

class AnimateStatement extends Statement
{
    public var layer : String;
    public var name : String;
    public var _prefix : Bool;
    public var _hasVars : Bool;
    
    public function new(layer : String, name : String)
    {
        super();
        this.name = name;
        var pp : Array<Dynamic> = layer.match(new as3hx.Compat.Regex('([^\\*]*)\\*', ""));
        if (pp != null)
        {
            this._prefix = true;
            this.layer = pp[1];
        }
        else
        {
            this.layer = layer;
        }
        this._hasVars = name.indexOf("$") >= 0;
    }
    
    override public function execute(context : ExecContext) : Void
    {
        var cv : CharViewContext = try cast(context, CharViewContext) catch(e:Dynamic) null;
        var name : String = this.name;
        if (_hasVars)
        {
            name = context.substituteVars(name);
        }
        if (_prefix)
        {
            cv.charview.composite.setMultiAnimation(layer, name);
        }
        else
        {
            cv.charview.composite.setAnimation(layer, name);
        }
    }
    
    public function toString() : String
    {
        return "<animate layer=\"" + layer + "\" name=\"" + name + "\"/>";
    }
}


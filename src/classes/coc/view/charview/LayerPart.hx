/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview;

import coc.view.CompositeImage;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

class LayerPart extends Statement
{
    private var name : String;
    private var image : CompositeImage;
    private var visible : Bool;
    private var _prefix : Bool;
    private var _hasVars : Bool;
    
    public function new(image : CompositeImage, name : String, visible : Bool)
    {
        super();
        this.image = image;
        this.visible = visible;
        var pp : Array<Dynamic> = name.match(new as3hx.Compat.Regex('([^\\*]*)\\*', ""));
        if (pp != null)
        {
            this._prefix = true;
            this.name = pp[1];
        }
        else
        {
            this.name = name;
        }
        this._hasVars = name.indexOf("$") >= 0;
    }
    
    override public function execute(context : ExecContext) : Void
    {
        var name : String = this.name;
        if (_hasVars)
        {
            name = context.substituteVars(name);
        }
        context.debug(this, name);
        if (_prefix)
        {
            image.setMultiVisibility(name, visible);
        }
        else
        {
            image.setVisibility(name, visible);
        }
    }
    
    
    public function toString() : String
    {
        return "<" + ((visible) ? "show" : "hide") + " part='" + name + "'>" + ((_prefix) ? " [prefix+]" : "") + ((_hasVars) ? " [vars+]" : "");
    }
}


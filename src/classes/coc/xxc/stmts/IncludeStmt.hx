/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts;

import flash.errors.Error;
import coc.view.CoCLoader;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.Story;
import coc.xxc.StoryCompiler;
import flash.events.Event;

class IncludeStmt extends Statement
{
    public var loaded(get, never) : Bool;

    private var _loaded : Bool = false;
    private var body : Statement = null;
    private var path : String;
    private function get_loaded() : Bool
    {
        return _loaded;
    }
    public function new(story : Story, compiler : StoryCompiler, path : String, required : Bool = true)
    {
        super();
        this.path = path;
        CoCLoader.loadText(compiler.basedir + path, function(success : Bool, content : Dynamic, event : Event) : Void
                {
                    if (_loaded)
                    {
                        return;
                    }
                    if (!success && required)
                    {
                        throw new Error("Required scenario not found: " + path);
                    }
                    _loaded = true;
                    FastXML.ignoreWhitespace = false;
                    try
                    {
                        body = compiler.attach(story).compile(FastXML.parse(content));
                    }
                    catch (e : Error)
                    {
                        _loaded = false;
                        compiler.detach(story);
                        if (required)
                        {
                            throw e;
                        }
                    }
                });
    }
    
    override public function execute(context : ExecContext) : Void
    {
        if (!_loaded)
        {
            trace("Content not loaded: " + path);
            return;
        }
        if (body != null)
        {
            context.execute(body);
        }
    }
}


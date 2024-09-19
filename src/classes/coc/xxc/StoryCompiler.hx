/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc;

import flash.errors.Error;
import coc.script.Eval;
import coc.xlogic.Compiler;
import coc.xlogic.Statement;
import coc.xlogic.StmtList;
import coc.xxc.stmts.*;

class StoryCompiler extends Compiler
{
    public var basedir(get, never) : String;

    private var _basedir : String;
    
    private function get_basedir() : String
    {
        return _basedir;
    }
    public function new(basedir : String)
    {
        super();
        this._basedir = basedir;
        if (basedir.charAt(basedir.length - 1) != "/")
        {
            this._basedir += "/";
        }
    }
    private var stack : Array<Dynamic> = [];
    public function clone(basedir : String = "") : StoryCompiler
    {
        return new StoryCompiler((basedir != null) ? basedir : _basedir);
    }
    
    public function attach(story : Story) : StoryCompiler
    {
        if (stack.length > 0)
        {
            throw new Error("StoryCompiler.attach called mid-compilation");
        }
        while (story)
        {
            stack.push(story);
            story = story.parent;
        }
        return this;
    }
    public function detach(story : Story) : StoryCompiler
    {
        while (story)
        {
            if (stack.length == 0)
            {
                throw new Error("Inconsistent stack during detach");
            }
            if (stack.pop() != story)
            {
                throw new Error("Inconsistent stack during detach");
            }
            story = story.parent;
        }
        return this;
    }
    override private function compileTag(tag : String, x : FastXML) : Statement
    {
        switch (tag)
        {
            case "b", "i":
                var list : StmtList = new StmtList();
                list.stmts.push(new TextStmt("<" + tag + ">", 0));
                compileChildrenInto(x, list.stmts);
                list.stmts.push(new TextStmt("</" + tag + ">", 0));
                return list;
            case "display":
                return compileDisplay(x);
            case "dynStats":
                return compileDynStats(x);
            case "encounter":
                return compileEncounter(x);
            case "include":
                return includeFile(x.att.path, x.att.required != "false");
            case "output":
                return compileOutput(x);
            case "lib", "macro":
                return compileStory(x, true);
            case "set":
                return compileSet(x);
            case "story", "string", "text":
                return compileStory(x, false);
            case "zone":
                return try cast(compileStoryBody(new ZoneStmt(stack[0], x.att.name), x), ZoneStmt) catch(e:Dynamic) null;
            /*case "extend-encounter":
				return extendEncounter(x);*/
            case "extend-story":
                return compileStoryBody(locate(x.att.name), x);
            case "extend-zone":
                return try cast(compileStoryBody(locate(x.att.name), x), ZoneStmt) catch(e:Dynamic) null;
            default:
                return super.compileTag(tag, x);
        }
    }
    public function includeFile(path : String, required : Bool) : IncludeStmt
    {
        var basedir : String = _basedir;
        var l : Int = path.lastIndexOf("/");
        if (l > 0)
        {
            basedir += path.substring(0, l);
            path = path.substring(l + 1);
        }
        return new IncludeStmt(stack[0], clone(basedir), path, required);
    }
    private function compileDisplay(x : FastXML) : DisplayStmt
    {
        return new DisplayStmt(stack[0], x.att.ref);
    }
    
    private function compileDynStats(x : FastXML) : DynStatsStmt
    {
        var attrs : Dynamic = attrMap(x);
        var d : DynStatsStmt = new DynStatsStmt();
        for (attr in Reflect.fields(attrs))
        {
            d.setAttr(attr, Reflect.field(attrs, attr));
        }
        return d;
    }
    private function peekZone() : ZoneStmt
    {
        var zone : ZoneStmt = try cast(stack[0], ZoneStmt) catch(e:Dynamic) null;
        if (zone == null)
        {
            throw new Error("Not a <zone> " + Std.string(stack[0]).substr(0, 20));
        }
        return zone;
    }
    private function compileEncounter(x : FastXML) : Statement
    {
        var encounter : Story = compileStory(x);
        peekZone().add(encounter, x.att.chance, x.att.when);
        return null;
    }
    private function compileOutput(x : FastXML) : OutputStmt
    {
        return new OutputStmt(Std.string(x.node.text.innerData()));
    }
    private function compileSet(x : FastXML) : SetStmt
    {
        var attrs : Dynamic = attrMap(x);
        var expr : String;
        var op : String;
        if (Lambda.has(attrs, "value"))
        {
            expr = Reflect.field(attrs, "value");
        }
        else
        {
            expr = "'" + Eval.escapeString(Std.string(x.node.text.innerData())) + "'";
        }
        if (Lambda.has(attrs, "op"))
        {
            op = Reflect.field(attrs, "op");
        }
        else
        {
            op = "=";
        }
        return new SetStmt(Reflect.field(attrs, "var"), expr, op);
    }
    private function compileStory(x : FastXML, isLib : Bool = false) : Story
    {
        return compileStoryBody(new Story(x.node.localName.innerData(), stack[0], x.att.name, isLib), x);
    }
    private function compileStoryBody(story : Story, x : FastXML) : Story
    {
        stack.unshift(story);
        compileChildrenInto(x, story.stmts);
        stack.shift();
        return story;
    }
    override private function compileText(x : FastXML) : Statement
    {
        if (stack.length == 0 || stack[0].tagname == "lib")
        {
            return super.compileText(x);
        }
        var s : String = Std.string(x);
        if (new as3hx.Compat.Regex('^\\s+', "g").replace(s, "").replace(new as3hx.Compat.Regex('\\s+$', "g"), "") == "")
        {
            return null;
        }
        var trimStyle : Int;
        if (stack[0].tagname == "string")
        {
            trimStyle = TextStmt.TRIMSTYLE_NONE;
        }
        else
        {
            trimStyle = TextStmt.TRIM_SQUEEZE | TextStmt.TRIM_UNINDENT;
            var ptn : FastXMLList = x.node.parent.innerData().text();
            if (x == ptn.get(0))
            {
                trimStyle = trimStyle | TextStmt.TRIM_LEFT;
            }
        }
        return new TextStmt(s, trimStyle);
    }
    private function locate(ref : String) : Story
    {
        var story : Story = stack[0].locate(ref);
        if (story == null)
        {
            throw new Error("Unable to locate ref=" + ref + " from " + Std.string(stack[0]).substr(0, 20));
        }
        return story;
    }
}


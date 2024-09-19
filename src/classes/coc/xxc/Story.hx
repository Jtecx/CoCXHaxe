/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc;

import flash.errors.Error;
import coc.xlogic.ExecContext;
import coc.xlogic.StmtList;

class Story extends StmtList
{
    public var parent : Story;
    public var name : String;
    public var lib : Dynamic;  /* [name:String]:Story */  
    public var isLib : Bool;
    public var tagname : String;
    
    public function toString() : String
    {
        return "<" + tagname + " name=\"" + name + "\" isLib=" + isLib + "\"> [" + stmts.length + "] </" + tagname + ">";
    }
    public function new(tagname : String, parent : Story, name : String, isLib : Bool = false)
    {
        super();
        this.tagname = tagname;
        this.parent = parent;
        this.name = name;
        this.isLib = isLib;
        this.lib = { };
        if (parent != null)
        {
            parent.addChild(this);
        }
    }
    public function addChild(story : Story) : Void
    {
        if (story.name == "")
        {
            return;
        }
        if (Lambda.has(lib, story.name))
        {
            throw new Error("Duplicate story name " + story.name);
        }
        Reflect.setField(lib, Std.string(story.name), story);
    }
    public function locate(ref : String) : Story
    {
        return locateSplit(this, ref.split("/"));
    }
    
    override public function execute(context : ExecContext) : Void
    {
        if (isLib)
        {
            return;
        }
        forceExecute(context);
    }
    /**
	 * Executes Story even if it is a lib
	 */
    public function forceExecute(context : ExecContext) : Void
    {
        context.debug(this, "enter");
        super.execute(context);
    }
    public function bind(context : ExecContext) : BoundStory
    {
        return new BoundStory(this, context);
    }
    public static function locateSplit(story : Story, ref : Array<Dynamic>) : Story
    {
        ref = ref.copy();
        while (ref.length > 0 && story)
        {
            var name : String = ref.shift();
            switch (name)
            {
                case "":
                    if (story.parent)
                    {
                        story = story.parent;
                        ref.unshift("");
                    }
                case ".", "..":

                    switch (name)
                    {case ".":
                        // do nothing
                        break;
                    }
                    story = story.parent;
                default:
                    if (Lambda.has(story.lib, name))
                    {
                        story = story.lib[name];
                    }
                    else
                    {
                        story = null;
                    }
            }
        }
        return story;
    }
}


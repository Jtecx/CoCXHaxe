/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts;

import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.Story;

class DisplayStmt extends Statement
{
    private var story : Story;
    private var ref : Array<Dynamic>;
    public function new(story : Story, ref : String)
    {
        super();
        this.story = story;
        this.ref = ref.split("/");
    }
    
    override public function execute(context : ExecContext) : Void
    {
        context.debug(this, "enter");
        var obj : Story = Story.locateSplit(story, ref);
        if (obj == null)
        {
            context.error(this, "Cannot dereference " + ref.join("/"));
            return;
        }
        obj.forceExecute(context);
    }
    
    public function toString() : String
    {
        return "<display ref=\"" + ref + "\"/>";
    }
}


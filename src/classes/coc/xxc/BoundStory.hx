/**
 * Coded by aimozg on 01.09.2017.
 */
package coc.xxc;

import coc.xlogic.ExecContext;

class BoundStory
{
    private var story : Story;
    private var context : ExecContext;
    public function new(story : Story, context : ExecContext)
    {
        this.story = story;
        this.context = context;
    }
    public function execute() : Void
    {
        story.execute(context);
    }
    public function display(ref : String, locals : Dynamic = null) : Void
    {
        var obj : Story = story.locate(ref);
        if (obj == null)
        {
            context.error(story, "Cannot dereference " + ref);
            return;
        }
        context.pushScope(locals || { });
        obj.forceExecute(context);
        context.popScope();
    }
    public function locate(ref : String) : BoundStory
    {
        var obj : Story = story.locate(ref);
        if (obj == null)
        {
            context.error(story, "Cannot dereference " + ref);
            return null;
        }
        return new BoundStory(obj, context);
    }
}


package coc.view;


class AnimationDef
{
    public var name : String;
    public var frames : Array<Dynamic> = [];
    public var animationDuration : Int = 0;
    public function new(
            name : String)
    {
        this.name = name;
    }
    
    public function addFrame(
            frameDuration : Int,
            dx : Int,
            dy : Int,
            i : String) : Void
    {
        var tStart : Int = this.animationDuration;
        var tEnd : Int = as3hx.Compat.parseInt(tStart + frameDuration);
        this.animationDuration += frameDuration;
        this.frames.push([tStart, tEnd, dx, dy, i]);
    }
}


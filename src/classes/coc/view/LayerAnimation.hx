package coc.view;

import flash.display.BitmapData;

class LayerAnimation
{
    private var frames : Array<Dynamic> = [];
    private var animationDuration : Int = 0;
    private var time : Int = 0;
    private var frameIndex : Int = 0;
    
    public function new(
            def : AnimationDef,
            layer : CompositeLayer,
            compositeImage : CompositeImage)
    {
        this.animationDuration = def.animationDuration;
        //		trace("assigning to layer "+layer.name+" animation "+def.name);
        for (i in 0...def.frames.length)
        {
            var fd : Array<Dynamic> = def.frames[i];
            var fimage : CompositeLayer = null;
            var fname : String = fd[4];
            if (fname != null)
            {
                if (fname.indexOf("%") >= 0)
                {
                    fname = StringTools.replace(fname, "%", layer.name);
                }
                fimage = compositeImage.getLayer(fname);
            }
            this.frames.push(new AnimationFrame(fd[0], fd[1], fd[2], fd[3], fimage));
        }
    }
    public function reset() : Void
    {
        time = 0;
        frameIndex = 0;
    }
    
    public function advanceTime(dt : Int, t2 : Int) : Bool
    {
        var fi0 : Int = frameIndex;
        time += dt;
        while (time >= frames[frameIndex].tEnd)
        {
            frameIndex++;
            if (frameIndex >= frames.length)
            {
                time %= animationDuration;
                frameIndex = 0;
            }
        }
        //			trace("[time="+time+"] "+name+" "+fi0+"->"+frameIndex);
        return frameIndex != fi0;
    }
    
    public function dx() : Int
    {
        if (this.frames.length == 0)
        {
            return 0;
        }
        return this.frames[frameIndex].dx;
    }
    
    public function dy() : Int
    {
        if (this.frames.length == 0)
        {
            return 0;
        }
        return this.frames[frameIndex].dy;
    }
    
    public function image() : CompositeLayer
    {
        if (this.frames.length == 0)
        {
            return null;
        }
        return this.frames[frameIndex].image;
    }
}



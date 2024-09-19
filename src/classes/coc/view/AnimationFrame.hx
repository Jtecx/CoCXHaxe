package coc.view;


class AnimationFrame
{
    public var tStart : Int;
    public var tEnd : Int;
    public var dx : Int;
    public var dy : Int;
    public var image : CompositeLayer;
    //	public var src:BitmapData;
    //	public var dst:BitmapData;
    
    public function new(
            tStart : Int,
            tEnd : Int,
            dx : Int,
            dy : Int,
            image : CompositeLayer)
    {
        this.tStart = tStart;
        this.tEnd = tEnd;
        this.dx = dx;
        this.dy = dy;
        this.image = image;
    }
}


package classes;


/**
	 * ...
	 * @author Yoffy
	 */
class Image
{
    public var id(get, never) : String;
    public var url(get, never) : String;
    public var width(get, never) : Int;
    public var height(get, never) : Int;

    private var _id : String;
    private var _url : String;
    private var _width : Int;
    private var _height : Int;
    
    public function new(id : String, url : String, w : Int, h : Int)
    {
        _id = id;
        _url = url;
        _width = w;
        _height = h;
    }
    
    private function get_id() : String
    {
        return _id;
    }
    
    private function get_url() : String
    {
        return _url;
    }
    
    private function get_width() : Int
    {
        return _width;
    }
    
    private function get_height() : Int
    {
        return _height;
    }
}


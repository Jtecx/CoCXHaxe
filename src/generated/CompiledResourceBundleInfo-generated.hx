
@:meta(ExcludeClass())

class CompiledResourceBundleInfo
{
    public static var compiledLocales(get, never) : Array<Dynamic>;
    public static var compiledResourceBundleNames(get, never) : Array<Dynamic>;

    private static function get_compiledLocales() : Array<Dynamic>  /* of String */  
    {
        return ["en_US"];
    }
    
    private static function get_compiledResourceBundleNames() : Array<Dynamic>  /* of String */  
    {
        return ["logging"];
    }

    public function new()
    {
    }
}



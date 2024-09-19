package classes;


/**
	 * ...
	 * @author Fake-Name
	 */
class CoCSettings
{
    
    
    public static var debugBuild : Bool = CONFIG;
    public static var mobileBuild : Bool = CONFIG;
    
    // Horrible static abuse FTW
    public static var haltOnErrors : Bool = false;
    public static var buttonEvents : Array<Dynamic> = [];
    private static inline var bufferSize : Int = 50;
    
    /**
		 * trace("ERROR "+description);
		 * If haltOnErrors=true, throws Error
		 */
    public static function error(description : String = "") : Void
    {
        trace("ERROR " + description);
        if (debugBuild && CoC.instance && CoC.instance.mainView)
        {
            EngineCore.outputText("\n\n<b>ERROR: " + description + "</b>\n\n");
        }
        if (haltOnErrors)
        {
            throw cast((description), Error);
        }
    }
    
    /**
		 * trace("ERROR Abstract method call: "+clazz+"."+method+"(). "+description);
		 * If haltOnErrors=true, throws Error
		 */
    public static function errorAMC(clazz : String, method : String, description : String = "") : Void
    {
        error("Abstract method call: " + clazz + "." + method + "(). " + description);
    }
    
    public static function appendButtonEvent(inString : String) : Void
    {
        CoC_Settings.buttonEvents.unshift(inString);  // Push the new item onto the head of the array  
        
        if (CoC_Settings.buttonEvents.length > CoC_Settings.bufferSize)
        
        // if the array has become too long, pop the last item{
            
            {
                CoC_Settings.buttonEvents.pop();
            }
        }
    }
    public static function getButtonEvents() : String
    {
        var retStr : String = "";
        for (x in Reflect.fields(CoC_Settings.buttonEvents))
        {
            retStr += CoC_Settings.buttonEvents[x] + "\n";
            trace("x = ", x, "Array Val = ", CoC_Settings.buttonEvents[x]);
        }
        return retStr;
    }
    
    public function new()
    {
    }
    private static var CoC_Settings_static_initializer = {
        debug;
        AIR;
        true;
    }

}



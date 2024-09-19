package classes.internals;

import flash.errors.IllegalOperationError;
import mx.logging.Log;
import mx.logging.ILogger;

/**
	 * Factory to create loggers for classes.
	 */
class LoggerFactory
{
    /**
		 * Symbols that cannot be used in a category name
		 */
    public static inline var ILLEGAL_SYMBOLS : String = "[]~$^&\/(){}<>+=`!#%?,:;'\"@";
    
    private static var PACKAGE_DELIMITER : as3hx.Compat.Regex = new as3hx.Compat.Regex('::', "g");
    private static inline var PACKAGE_DELIMITER_REPLACEMENT : String = ".";
    
    public function new()
    {
        throw new IllegalOperationError("This class cannot be instantiated.");
    }
    
    /**
		 * Create a logger for the given class. Loggers are cached by mx.logging.Log, so using the same Class
		 * multiple times will return the same logger instance.
		 * @param	clazz to create a logger for
		 * @return a new logger for the class
		 */
    public static function getLogger(clazz : Class<Dynamic>) : ILogger
    {
        var sanitizedFQN : String = Type.getClassName(clazz).replace(PACKAGE_DELIMITER, PACKAGE_DELIMITER_REPLACEMENT);
        return Log.getLogger(sanitizedFQN);
    }
}


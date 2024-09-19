import mx.resources.ResourceBundle;

@:meta(ExcludeClass())

class EnUS$loggingProperties extends ResourceBundle
{
    
    public function en_US__DOLLAR__logging_properties()
    {
        super("en_US", "logging");
    }
    
    override private function getContent() : Dynamic
    {
        var content : Dynamic = 
        {
            levelLimit : "Logging level cannot be set to LogEventLevel.ALL.",
            invalidLen : "Categories must be at least one character in length.",
            charsInvalid : "Error for filter '{0}': The following characters are not valid: []~$^&/(){}<>+=_-`!@#%?,:;'\".",
            invalidTarget : "Invalid target specified.",
            invalidChars : "Categories can not contain any of the following characters: []`~,!@#$%*^&()]{}+=|';?><./\".",
            charPlacement : "Error for filter '{0}': '*' must be the right most character."
        };
        return content;
    }

    public function new()
    {
        super();
    }
}





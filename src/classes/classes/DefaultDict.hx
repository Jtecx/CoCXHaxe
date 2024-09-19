


package classes;

import flash.utils.Proxy;


// This is a special class that immitates a array/dictionary, and
// yet has some special behaviour to make it look & act like any arbitrary aray value
// is pre-initialized to 0.
class DefaultDict extends Proxy
{
    // Actual key<->value pairs are stored in _dict
    private var _dict : Dynamic;
    
    // Set to true to print any access to defaultDict members
    private var debugPrintDict : Bool = false;
    private var defaultValue : Dynamic = 0;
    private var size : Int = MAX_FLAG_VALUE;
    
    public function new(_defaultValue : Dynamic = 0, _size : Int = MAX_FLAG_VALUE)
    {
        super();
        defaultValue = _defaultValue;
        size = _size;
        _dict = {};
        if (debugPrintDict)
        {
            trace("Instantiating default dict class");
        }
    }
    
    // used to determine status of the query 'name in defaultDict'.
    // Since we want to *look* like have any arbitrary key, we always return true.
    override private function hasProperty(name : Dynamic) : Bool
    {
        if (debugPrintDict)
        {
            trace("hasProperty", name);
        }
        return true;
    }
    
    // called when someone requests defaultDict[name] or defaultDict.name
    // we have a special case to override the query for defaultDict.length, since
    // that is used for determining how many flags the save/load mechanism iterates over.
    // I'm going to update that to properly iterating over each item in the save eventually
    // but this makes it work as a stop-gap measure
    override private function getProperty(name : Dynamic) : Dynamic
    {
        if (debugPrintDict)
        {
            trace("getProperty Called");
        }
        if (name == "length")
        {
            if (debugPrintDict)
            {
                trace("Querying array length. Faking out retVal");
            }
            return size;
        }
        
        // If we have name as a key in _dict, return _dict[name]. Else, return 0
        if (Lambda.has(_dict, name))
        {
            if (debugPrintDict)
            {
                trace("Flag " + name + " being accessed. Value = " + Reflect.field(_dict, Std.string(name)));
            }
            return Reflect.field(_dict, Std.string(name));
        }
        else
        {
            if (debugPrintDict)
            {
                trace("Unset Flag " + name + " being accessed.");
            }
            return defaultValue;
        }
    }
    
    // Overrides any attempt to set a class member or indice (defaultDict[name] = x or defaultDict.name = x)
    // If x == 0, it removes {name} from _dict if it's present, otherwise does nothing. Else, it sets _dict[name] = x
    override private function setProperty(name : Dynamic, value : Dynamic) : Void
    {
        if (value != defaultValue)
        {
            if (debugPrintDict)
            {
                trace("setProperty ", name, value);
            }
            Reflect.setField(_dict, Std.string(name), value);
        }
        else if (Lambda.has(_dict, name))
        {
            if (debugPrintDict)
            {
                trace("setProperty " + name + " to " + value + " Deleting key");
            }
            Reflect.deleteField(_dict, Std.string(name));
        }
        else if (debugPrintDict)
        {
            trace("setProperty " + name + " to " + value + " Ignoring");
        }
    }
    
    // callProperly is called when functions are called on instances of defaultDict,
    // e.g. defaultDict.push(), etc...
    // Since we don't have an array length, per se, we just swallow instances of push.
    // otherwise, we just apply the called function name to _dict.
    override private function callProperty(methodName : Dynamic, args : Array<Dynamic> = null) : Dynamic
    {
        if (debugPrintDict)
        {
            trace("call Property ", methodName);
        }
        if (Std.string(methodName) == "push")
        {
            if (debugPrintDict)
            {
                trace("Doing nothing (this ain't an array anymore!)");
            }
        }
        else
        {
            var res : Dynamic;
            res = Reflect.field(_dict, Std.string(methodName)).apply(_dict, args);
            return res;
        }
    }
    
    
    // you have to implement object management bits yourself, since unfortunately the proxy
    // object doesn't have default stuff you can just override where you want special behaviour
    // As such, the following functions just make defaultDict iterable, and manage removing
    // things, etc...
    
    //public function getIteratorObj():IIterator
    //{
    //	return IIterator(_dict);
    //
    //}
    
    override private function deleteProperty(name : Dynamic) : Bool
    {
        if (debugPrintDict)
        {
            trace("deleteProperty", name);
        }
        return Reflect.deleteField(_dict, Std.string(name));
    }
    
    
    override private function nextName(index : Int) : String
    {
        if (debugPrintDict)
        {
            trace("nextName", index);
        }
        return Std.string(index - 1);
    }
    
    override private function nextValue(index : Int) : Dynamic
    {
        if (debugPrintDict)
        {
            trace("nextValue", index);
        }
        return Reflect.field(_dict, Std.string(index - 1));
    }
    
    override private function nextNameIndex(index : Int) : Int
    {
        if (debugPrintDict)
        {
            trace("nextNameIndex ", index);
        }
        if (!(Lambda.has(_dict, index)))
        {
            if (debugPrintDict)
            {
                trace("Returning 0");
            }
            return 0;
        }
        return as3hx.Compat.parseInt(index + 1);
    }
    
    public static inline var MAX_FLAG_VALUE : Int = 3500;
}

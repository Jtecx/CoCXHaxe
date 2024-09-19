/**
 * Created by aimozg on 25.04.2017.
 */
package classes.internals;


/**
 * Interface for serialization to/deserialization from plain objects.
 * Built-in Flash serialization breaks inter-version compatibility.
 */
interface Jsonable
{

    function saveToObject() : Dynamic
    ;
    function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    ;
}


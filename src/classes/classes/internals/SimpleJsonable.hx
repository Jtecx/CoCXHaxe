/**
 * Created by aimozg on 25.04.2017.
 */
package classes.internals;


class SimpleJsonable extends Utils implements Jsonable
{
    private var myPublicPrimitives(default, never) : Array<Dynamic> = [];
    private var myPublicJsonables(default, never) : Array<Dynamic> = [];
    /**
	 * @see Utils.copyObject
	 * @param names names of !public! !primitive!-typed properties that should be saved/loaded
	 */
    private function addPublicPrimitives(names : Array<Dynamic>) : Void
    {
        myPublicPrimitives.push.apply(myPublicPrimitives, names);
    }
    /**
	 * @param names names of !public! !Jsonable!-typed properties that should be saved/loaded
	 */
    private function addPublicJsonables(names : Array<Dynamic>) : Void
    {
        myPublicJsonables.push.apply(myPublicJsonables, names);
    }
    public function saveToObject() : Dynamic
    {
        var o : Dynamic = { };
        if (myPublicPrimitives.length > 0)
        {
            o = copyObjectEx(o, this, myPublicPrimitives, true);
        }
        for (key in myPublicJsonables)
        {
            Reflect.setField(o, Std.string(key), (try cast(Reflect.field(this, Std.string(key)), Jsonable) catch(e:Dynamic) null).saveToObject());
        }
        return o;
    }
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (!(Std.is(o, Dynamic)) || o == null)
        {
            o = { };
        }
        if (myPublicPrimitives.length > 0)
        {
            copyObjectEx(this, o, myPublicPrimitives, false, ignoreErrors);
        }
        for (key in myPublicJsonables)
        {
            var v : Dynamic = Reflect.field(o, Std.string(key));
            if (!(Std.is(v, Dynamic)) || v == null)
            {
                v = { };
            }
            try
            {
                (try cast(Reflect.field(this, Std.string(key)), Jsonable) catch(e:Dynamic) null).loadFromObject(v, ignoreErrors);
            }
            catch (e : Dynamic)
            {
                if (!ignoreErrors)
                {
                    throw e;
                }
                trace(e);
            }
        }
    }
    public static function getPublicPrimitives(o : SimpleJsonable) : Array<Dynamic>
    {
        return o.myPublicPrimitives;
    }
    public static function getPublicJsonables(o : SimpleJsonable) : Array<Dynamic>
    {
        return o.myPublicJsonables;
    }

    public function new()
    {
        super();
    }
}


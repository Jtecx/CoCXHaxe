/**
 * Created by aimozg on 25.04.2017.
 */
package classes.bodyParts;

import classes.CoCSettings;
import classes.Creature;
import classes.internals.SimpleJsonable;
import classes.Measurements;

class BodyPart extends SimpleJsonable
{
    public var creature(get, never) : Creature;
    public var type(get, set) : Int;

    
    private var _type : Int = 0;
    public function restore(keepColor : Bool = true) : Void
    {
        type = 0;
    }
    private var _creature : Creature;
    private function get_creature() : Creature
    {
        return _creature;
    }
    public function hasMaterial(type : Int) : Bool
    {
        return false;
    }
    public function new(creature : Creature, publicPrimitives : Array<Dynamic>)
    {
        super();
        if (creature == null)
        {
            trace("[ERROR] " + this + " has no host");
        }
        else
        {
            creature.bodyParts.push(this);
        }
        addPublicPrimitives(["type"]);
        addPublicPrimitives(publicPrimitives);
        this._creature = creature;
    }
    private function get_type() : Int
    {
        return _type;
    }
    private function set_type(value : Int) : Int
    {
        _type = value;
        return value;
    }
    
    public function isAny(args : Array<Dynamic> = null) : Bool
    {
        while (args.length == 1 && Std.is(args[0], Array))
        {
            args = args[0];
        }
        for (i_type in args)
        {
            if (type == i_type)
            {
                return true;
            }
        }
        return false;
    }
    public function isNeither(args : Array<Dynamic> = null) : Bool
    {
        if (args.length == 1 && Std.is(args[0], Array))
        {
            args = args[0];
        }
        for (i_type in args)
        {
            if (type == i_type)
            {
                return false;
            }
        }
        return true;
    }
    /**
	 * Should be implemented in subclasses.
	 */
    public function descriptionFull() : String
    {
        CoC_Settings.errorAMC("BodyPart", "describe");
        return "something";
    }
    public function setProps(p : Dynamic) : Void
    {
        copyObjectEx(this, p, myPublicPrimitives);
    }
    
    public function setAllProps(p : Dynamic, keepTone : Bool = true) : Void
    {
        restore(keepTone);
        setProps(p);
    }
    /**
	 * Tests each property in `p` against this object property with the same name.
	 * Keys should be equal to public this properties.
	 * Value can be either primitives, objects, or arrays.
	 * If value is a primitive, this property should be equal
	 * If value is an object and this property is a BodyPart, this sub-object is passed to its checkProps
	 * If value is an array, this property should pass any of the elements' checks
	 *
	 * Example:
	 *
	 * player.skin.checkProps({
	 *     coverage: [0, 1, 2], // either none, low, or mid coverage
	 *     base: {
	 *         type: PLAIN,
	 *         color: ["blue", "light blue"]
	 *     }
	 * });
	 *
	 * @return true if all tests are passed
	 */
    public function checkProps(p : Dynamic) : Bool
    {
        for (key in Reflect.fields(p))
        {
            var v : Array<Dynamic> = (Std.is(Reflect.field(p, key), Array)) ? Reflect.field(p, key) : [Reflect.field(p, key)];
            var thiz : Dynamic = Reflect.field(this, key);
            for (test in v)
            {
                if (Std.is(thiz, BodyPart) && Std.is(test, Dynamic))
                {
                    if (!thiz.checkProps(test))
                    {
                        return false;
                    }
                }
                else if (thiz != test)
                {
                    return false;
                }
            }
        }
        return true;
    }
}


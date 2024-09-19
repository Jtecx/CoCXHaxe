/**
 * Created by aimozg on 26.03.2017.
 */
package classes.scenes.aPI;

import haxe.Constraints.Function;
import classes.internals.Utils;

class GroupEncounter implements Encounter
{
    public var components : Array<Dynamic>;
    private var name : String;
    public function new(name : String, components : Array<Dynamic>)
    {
        this.name = name;
        this.components = [];
        for (c in components)
        {
            add(c);
        }
    }
    
    public function encounterName() : String
    {
        return name;
    }
    
    /**
	 * Builds and adds encounters.
	 * Sample usage:
	 * build({
	 *   name: "encounter1", call: function1,
	 *   chance: 0.2, when: Encounters.fn.ifMinLevel(5)
	 * },{
	 *   name: "encounter2",
	 *   call: function():void{},
	 *   chance: function():Number {}, // default 1
	  *  when: function():Boolean {} // default true
	 * })
	 * @param defs Array of defs objects or Encounter-s.
	 * @see Encounters.build
	 */
    public function add(defs : Array<Dynamic> = null) : GroupEncounter
    {
        for (def in defs)
        {
            if (Std.is(def, GroupEncounter) && !(Std.is(def, ComplexEncounter)))
            {
                Utils.pushAll(components, (try cast(def, GroupEncounter) catch(e:Dynamic) null).components);
            }
            else if (Std.is(def, Encounter))
            {
                components.push(def);
            }
            else
            {
                components.push(Encounters.build(def));
            }
        }
        return this;
    }
    
    public function execEncounter() : Void
    {
        trace(Encounters.debug_indent + encounterName() + ".execEncounter()");
        Encounters.debug_indent += "  ";
        Encounters.select(components).execEncounter();
        Encounters.debug_indent = Encounters.debug_indent.slice(2);
    }
    /**
	 * @param [filter] function(e:Encounter):boolean
	 * @return
	 */
    public function pickEncounter(filter : Function = null) : Encounter
    {
        var e : Encounter = Encounters.select(components, filter);
        if (Std.is(e, GroupEncounter))
        {
            return (try cast(e, GroupEncounter) catch(e:Dynamic) null).pickEncounter(filter);
        }
        return e;
    }
    /**
	 * @param [filter] function(e:Encounter):boolean
	 * @return
	 */
    public function pickEncounterOrNull(filter : Function = null) : Encounter
    {
        var e : Encounter = Encounters.selectOrNull(components, filter);
        if (Std.is(e, GroupEncounter))
        {
            return (try cast(e, GroupEncounter) catch(e:Dynamic) null).pickEncounterOrNull(filter);
        }
        return e;
    }
    
    public function findByName(name : String) : SimpleEncounter
    {
        for (encounter in components)
        {
            var se : SimpleEncounter = try cast(encounter, SimpleEncounter) catch(e:Dynamic) null;
            if (se != null && se.encounterName() == name)
            {
                return se;
            }
            if (Std.is(encounter, GroupEncounter))
            {
                se = (try cast(encounter, GroupEncounter) catch(e:Dynamic) null).findByName(name);
                if (se != null)
                {
                    return se;
                }
            }
        }
        return null;
    }
    
    public function encounterChance() : Float
    {
        var sum : Float = 0;
        for (encounter in components)
        {
            var chance : Float = encounter.encounterChance();
            if (chance >= Encounters.ALWAYS)
            {
                return Encounters.ALWAYS;
            }
            if (chance > 0)
            {
                sum += chance;
            }
        }
        return sum;
    }
    
    /**
	 * Return a copy of this group encounter with extra condition and chance multipliers
	 * @param when Extra condition. Can be null if not needed
	 * @param chances Chance multipliers. Can be null or empty array if not needed
	 * @return
	 */
    public function wrap(when : Function, chances : Array<Dynamic>) : GroupEncounter
    {
        var result : GroupEncounter = new GroupEncounter(name, []);
        for (e in components)
        {
            result.components.push(Encounters.wrap2(e, when, chances));
        }
        return result;
    }
    public function withCondition(when : Function) : GroupEncounter
    {
        return wrap(when, null);
    }
    public function withChanceFactor(chance : Dynamic) : GroupEncounter
    {
        return wrap(null, [chance]);
    }
}


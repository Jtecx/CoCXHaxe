/**
 * Created by aimozg on 01.04.2017.
 */
package classes.scenes.aPI;

import haxe.Constraints.Function;

/**
 * A lazily initialized (on first access) Encounter wrapper
 */
class LateinitEncounter implements Encounter
{
    private var proxied(get, never) : Encounter;

    
    private var _proxied : Encounter = null;
    private var scope : Dynamic = null;
    private function get_proxied() : Encounter
    {
        return _proxied = (_proxied != null) ? _proxied : createEncounter.apply(scope);
    }
    private var createEncounter : Function;
    
    public function encounterChance() : Float
    {
        return proxied.encounterChance();
    }
    
    public function execEncounter() : Void
    {
        proxied.execEncounter();
    }
    
    public function encounterName() : String
    {
        return proxied.encounterName();
    }
    
    /**
	 *
	 * @param scope: A "this" object that is implicitly or explicitly used in function
	 * @param createEncounterFn: A function that constructs an Encounter.
	 */
    public function new(scope : Dynamic, createEncounterFn : Function)
    {
        this.createEncounter = createEncounterFn;
        this.scope = scope;
    }
}


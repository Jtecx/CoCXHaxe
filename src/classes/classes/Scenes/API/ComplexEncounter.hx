/**
 * Created by aimozg on 26.03.2017.
 */
package classes.scenes.aPI;


class ComplexEncounter extends GroupEncounter
{
    private var _chance : Dynamic;
    
    /**
	 * @param chance Number, Boolean, or function() returning Number|Boolean,
	 * @param components Array of Encounter-s
	 */
    public function new(name : String, chance : Dynamic, components : Array<Dynamic>)
    {
        super(name, components);
        this._chance = chance;
    }
    
    override public function encounterChance() : Float
    {
        return Encounters.convertChance(_chance);
    }
}


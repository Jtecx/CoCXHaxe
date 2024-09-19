package classes;

import haxe.Constraints.Function;
import classes.scenes.SceneLib;

class PotionType
{
    // declare properties here
    public var ID : String;
    public var name : String;
    public var description : String;
    public var recipe : Dynamic;
    public var effect : Function;
    
    public function new(ID : String, name : String, description : String, recipe : Dynamic, effect : Function)
    {
        this.ID = ID;
        this.name = name;
        this.description = description;
        this.recipe = recipe;
        this.effect = effect;
        
        Reflect.setField(ALL_POTIONS, ID, this);
    }
    
    /**
     * key = ID
     * object = PotionType
     */
    public static var ALL_POTIONS : Dynamic = { };
}


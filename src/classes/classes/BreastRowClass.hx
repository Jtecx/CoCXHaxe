package classes;

import classes.internals.Utils;

class BreastRowClass
{
    //constructor
    public function new()
    {
    }
    public var breasts : Float = 2;
    public var nipplesPerBreast : Float = 1;
    public var breastRating : Float = 0;
    public var lactationMultiplier : Float = 0;
    //Fullness used for lactation....if 75 or greater warning bells start going off!
    //If it reaches 100 it reduces lactation multiplier.
    public var milkFullness : Float = 0;
    public var fullness : Float = 0;
    public var fuckable : Bool = false;
    
    public function validate() : String
    {
        var error : String = "";
        error += Utils.validateNonNegativeNumberFields(this, "BreastRowClass.validate", [
                "breasts", "nipplesPerBreast", "breastRating", "lactationMultiplier", 
                "milkFullness", "fullness"
        ]);
        return error;
    }
}

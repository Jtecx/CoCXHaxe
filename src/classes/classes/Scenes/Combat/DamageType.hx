package classes.scenes.combat;

import classes.internals.EnumValue;

class DamageType
{
    
    public static var Types : Array<Dynamic> = [];
    
    // Unspecified damage type that does ignores damage type-based resitances and bonuses
    public static inline var GENERIC : Int = 0;
    
    
    public static inline var PHYSICAL : Int = 1;
    
    
    public static inline var MAGICAL : Int = 2;
    
    
    public static inline var FIRE : Int = 3;
    
    
    public static inline var ICE : Int = 4;
    
    
    public static inline var LIGHTNING : Int = 5;
    
    
    public static inline var DARKNESS : Int = 6;
    
    
    public static inline var TRUE : Int = 7;
    
    
    public static inline var WATER : Int = 8;
    
    
    public static inline var WIND : Int = 9;
    
    
    public static inline var EARTH : Int = 10;
    
    
    public static inline var ACID : Int = 11;
    
    
    private function new()
    {
    }
    private static var DamageType_static_initializer = {
        EnumValue.add(Types, GENERIC, "GENERIC", {
                    name : "generic"
                });
        EnumValue.add(Types, PHYSICAL, "PHYSICAL", {
                    name : "physical"
                });
        EnumValue.add(Types, MAGICAL, "MAGICAL", {
                    name : "magical"
                });
        EnumValue.add(Types, FIRE, "FIRE", {
                    name : "fire"
                });
        EnumValue.add(Types, ICE, "ICE", {
                    name : "ice"
                });
        EnumValue.add(Types, LIGHTNING, "LIGHTNING", {
                    name : "lightning"
                });
        EnumValue.add(Types, DARKNESS, "DARKNESS", {
                    name : "darkness"
                });
        EnumValue.add(Types, TRUE, "TRUE", {
                    name : "true"
                });
        EnumValue.add(Types, WATER, "WATER", {
                    name : "water"
                });
        EnumValue.add(Types, WIND, "WIND", {
                    name : "wind"
                });
        EnumValue.add(Types, EARTH, "EARTH", {
                    name : "earth"
                });
        EnumValue.add(Types, ACID, "ACID", {
                    name : "acid"
                });
        true;
    }

}


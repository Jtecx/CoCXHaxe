package classes.bodyParts;

import classes.Creature;

class Hips extends BodyPart
{
    public static inline var RATING_BOYISH : Int = 0;
    public static inline var RATING_SLENDER : Int = 2;
    public static inline var RATING_AVERAGE : Int = 4;
    public static inline var RATING_AMPLE : Int = 6;
    public static inline var RATING_CURVY : Int = 10;
    public static inline var RATING_FERTILE : Int = 15;
    public static inline var RATING_INHUMANLY_WIDE : Int = 20;
    
    public function new(creature : Creature)
    {
        super(creature, null);
    }
}


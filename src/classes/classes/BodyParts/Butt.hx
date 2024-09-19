package classes.bodyParts;

import classes.Creature;

class Butt extends BodyPart
{
    public static inline var RATING_BUTTLESS : Int = 0;
    public static inline var RATING_TIGHT : Int = 2;
    public static inline var RATING_AVERAGE : Int = 4;
    public static inline var RATING_NOTICEABLE : Int = 6;
    public static inline var RATING_LARGE : Int = 8;
    public static inline var RATING_JIGGLY : Int = 10;
    public static inline var RATING_EXPANSIVE : Int = 13;
    public static inline var RATING_HUGE : Int = 16;
    public static inline var RATING_INCONCEIVABLY_BIG : Int = 20;
    
    public function new(creature : Creature)
    {
        super(creature, null);
    }
}


/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.stats;

import classes.Creature;

interface IStat
{
    
    var statName(get, never) : String;    
    var host(get, never) : Creature;    
    var value(get, never) : Float;    
    var min(get, never) : Float;    
    var max(get, never) : Float;

}


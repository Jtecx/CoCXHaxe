/**
 * ...
 * @author Ormael
 */
package classes.items;

import classes.items.vehicles.*;

@:final class VehiclesLib extends ItemConstants
{
    public static inline var DEFAULT_VALUE : Float = 6;
    
    public static var NOTHING : Nothing = new Nothing();
    
    public var GOBMALP(default, never) : GoblinMechAlpha = new GoblinMechAlpha();
    public var GOBMPRI(default, never) : GoblinMechPrime = new GoblinMechPrime();
    public var GS_MECH(default, never) : GiantSlayerMech = new GiantSlayerMech();
    public var HB_MECH(default, never) : HowlingBansheeMech = new HowlingBansheeMech();
    
    public function new()
    {
        super();
    }
}


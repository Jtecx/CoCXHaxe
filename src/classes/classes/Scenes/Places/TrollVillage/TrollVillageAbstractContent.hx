/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */
package classes.scenes.places.trollVillage;

import classes.*;
import classes.CoC;
import classes.scenes.places.TrollVillage;
import classes.scenes.SceneLib;

class TrollVillageAbstractContent extends BaseContent
{
    private var trollVillage(get, never) : TrollVillage;

    private function get_trollVillage() : TrollVillage
    {
        return SceneLib.trollVillage;
    }
    @:allow(classes.scenes.places.trollVillage)
    private function new()
    {
        super();
    }
}


/**
 * Created by aimozg on 08.01.14.
 */
package classes.scenes.places.farm;

import classes.*;
import classes.scenes.places.Farm;
import classes.scenes.SceneLib;

class AbstractFarmContent extends BaseContent
{
    private var farm(get, never) : Farm;

    public function new()
    {
        super();
    }
    private function get_farm() : Farm
    {
        return SceneLib.farm;
    }
}

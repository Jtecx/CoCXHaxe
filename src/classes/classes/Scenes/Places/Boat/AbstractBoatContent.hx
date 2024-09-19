/**
 * Created by aimozg on 06.01.14.
 */
package classes.scenes.places.boat;

import classes.*;
import classes.scenes.places.Boat;
import classes.scenes.SceneLib;

class AbstractBoatContent extends BaseContent
{
    private var boat(get, never) : Boat;

    private function get_boat() : Boat
    {
        return SceneLib.boat;
    }
    public function new()
    {
        super();
    }
}

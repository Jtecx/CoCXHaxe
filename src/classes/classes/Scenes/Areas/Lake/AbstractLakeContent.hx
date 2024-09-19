/**
 * Created by aimozg on 06.01.14.
 */
package classes.scenes.areas.lake;

import classes.*;
import classes.scenes.areas.Lake;
import classes.scenes.SceneLib;

class AbstractLakeContent extends BaseContent
{
    private var lake(get, never) : Lake;

    private function get_lake() : Lake
    {
        return SceneLib.lake;
    }
    public function new()
    {
        super();
    }
}

/**
 * ...
 * @author Ormael
 */
package classes.scenes.places.heXinDao;

import classes.*;
import classes.scenes.places.HeXinDao;
import classes.scenes.SceneLib;

class HeXinDaoAbstractContent extends BaseContent
{
    private var heXinDao(get, never) : HeXinDao;

    private function get_heXinDao() : HeXinDao
    {
        return SceneLib.hexindao;
    }

    @:allow(classes.scenes.places.heXinDao)
    private function new()
    {
        super();
    }
}

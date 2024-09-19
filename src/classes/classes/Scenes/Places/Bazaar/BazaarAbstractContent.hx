/**
 * Created by aimozg on 06.01.14.
 */
package classes.scenes.places.bazaar;

import classes.*;
import classes.scenes.places.Bazaar;
import classes.scenes.SceneLib;

class BazaarAbstractContent extends BaseContent
{
    private var bazaar(get, never) : Bazaar;

    private function get_bazaar() : Bazaar
    {
        return SceneLib.bazaar;
    }
    public function new()
    {
        super();
    }
}

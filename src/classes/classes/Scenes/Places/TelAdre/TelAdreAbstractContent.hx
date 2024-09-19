/**
 * Created by aimozg on 05.01.14.
 */
package classes.scenes.places.telAdre;

import classes.*;
import classes.CoC;
import classes.scenes.places.TelAdre;
import classes.scenes.SceneLib;

class TelAdreAbstractContent extends BaseContent
{
    private var telAdre(get, never) : TelAdre;

    private function get_telAdre() : TelAdre
    {
        return SceneLib.telAdre;
    }
    @:allow(classes.scenes.places.telAdre)
    private function new()
    {
        super();
    }
}

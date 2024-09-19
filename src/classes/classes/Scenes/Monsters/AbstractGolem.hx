/**
 * Created by aimozg on 22.05.2017.
 */
package classes.scenes.monsters;

import classes.Monster;
import classes.PerkLib;

class AbstractGolem extends Monster
{
    public function new(plural : Bool)
    {
        super();
        // argument so superclass constructor always called
        this.plural = plural;
        this.lustVuln = 0.01;
        this.createBreastRow(0, 1);
        initGenderless();
        createPerk(PerkLib.Resolute, 0, 0, 0, 0);
        createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
    }
}

/**
 * ...
 * @author Ormael
 */
package classes.scenes.monsters;

import classes.Monster;
import classes.PerkLib;
import classes.StatusEffects;

class AbstractAngel extends Monster
{
    
    public function new(plural : Bool)
    {
        super();
        // argument so superclass constructor always called
        this.plural = plural;
        this.lustVuln = 0.01;
        this.createBreastRow(0, 1);
        initGenderless();
        createStatusEffect(StatusEffects.LowtierMagicImmunity, 0, 0, 0, 0);
        createPerk(PerkLib.EnemyTrueAngel, 0, 0, 0, 0);
    }
}

/**
 * ...
 * @author Ormael
 */
package classes.scenes.nPCs;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.globalFlags.KFLAGS;

class ThflthkhNgha extends Monster
{
    
    public function new()
    {
        super();
        this.a = " ";
        this.short = "Thflthkh'ngha";
        this.imageName = "ThflthkhNgha";
        this.long = "You are currently battling Thflthkh'ngha. Her look is very disturbing with features that you could hardly find in this realm.";
        createVagina(true, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        createStatusEffect(StatusEffects.BonusVCapacity, 10, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("A"));
        this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.createStatusEffect(StatusEffects.BonusACapacity, 10, 0, 0, 0);
        this.tallness = rand(8) + 70;
        this.hips.type = Hips.RATING_BOYISH;
        this.butt.type = Butt.RATING_BUTTLESS;
        this.level = 0;
        this.gems = 5 + rand(5);
        this.drop = NO_DROP;
        checkMonster();
    }
}

/**
 * ...
 * @author Ormael
 */
package classes.scenes.monsters;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.Tail;
import classes.internals.*;
import classes.CoC;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;

class CorruptedFleshGolemBasic extends AbstractFleshGolem
{
    public function corruptedGolemSwordSlash() : Void
    {
        outputText("The corrupted golem's head tilts, shaking slightly. She lunges, teeth chattering as she swings her swords at you.");
        var damage : Float = as3hx.Compat.parseInt((str + weaponAttack) - rand(player.tou) - player.armorDef);
        //Dodge
        if (damage <= 0 || (player.getEvasionRoll()))
        {
            outputText(" You slide underneath the surprise slash!");
        }
        else
        {
            if (hasStatusEffect(StatusEffects.Provoke))
            {
                damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
            }
            outputText(" She slash you chest. ");
            damage = player.takePhysDamage(damage, true);
            damage = player.takePhysDamage(damage, true);
        }
    }
    public function corruptedGolemLustAttack() : Void
    {
        outputText("She smirks and licks her lips as she gives her cock a squeeze, milking a few beads of clear pre from the tip.  You shake your head and try to ignore your growing need.");
        player.takeLustDamage(10 + player.lib / 6 + player.cor / 6, true);
    }
    
    override private function performCombatAction() : Void
    {
        if (hasStatusEffect(StatusEffects.Provoke))
        {
            var choiceP : Float = rand(4);
            if (choiceP < 2)
            {
                eAttack();
            }
            if (choiceP > 1)
            {
                corruptedGolemSwordSlash();
            }
        }
        else
        {
            var choice : Float = rand(4);
            if (choice < 2)
            {
                eAttack();
            }
            if (choice == 2)
            {
                corruptedGolemSwordSlash();
            }
            if (choice == 3)
            {
                corruptedGolemLustAttack();
            }
        }
    }
    
    public function new()
    {
        super(false);
        this.a = "the ";
        this.short = "corrupted basic flesh golem";
        this.imageName = "corrupted basic flesh golem";
        this.long = "You're currently fighting a corrupted basic flesh golem. She's seven feet tall, her flesh covered sporadically by fragments of what must have once been a decorative set of armour. They seem to have been broken in places, but the shards of armor still provide decent protection. Several large holes in the armour were clearly made intentionally, exposing a throbbing cock and firm breasts. The golem keeps its head aligned with you, large, gaping mouth open constantly. She clutches a pair of swords in her meaty fists.";
        this.createCock(12, 2, CockTypesEnum.DEMON);
        this.balls = 0;
        this.ballSize = 0;
        this.cumMultiplier = 3;
        this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_LOOSE);
        this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("C"));
        this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
        this.ass.analWetness = AssClass.WETNESS_MOIST;
        this.createStatusEffect(StatusEffects.BonusACapacity, 200, 0, 0, 0);
        initStrTouSpeInte(120, 140, 110, 10);
        initWisLibSensCor(10, 100, 50, 100);
        this.tallness = 84;
        this.hips.type = Hips.RATING_AVERAGE + 1;
        this.butt.type = Butt.RATING_AVERAGE + 1;
        this.bodyColor = "pink";
        this.weaponName = "dual swords";
        this.weaponVerb = "slash";
        this.weaponAttack = 50;
        this.armorName = "white armor";
        this.armorDef = 40;
        this.armorMDef = 20;
        this.bonusHP = 350;
        this.lust = 30;
        this.bonusLust = 185;
        this.lustVuln = .5;
        this.level = 35;
        this.additionalXP = 350;
        this.gems = rand(10) + 5;
        this.tailType = Tail.DEMONIC;
        this.drop = new WeightedDrop().add(consumables.BIMBOLQ, 1).add(consumables.BROBREW, 1).add(weapons.DDAGGER, 10).add(weapons.DL_AXE_, 10).add(weapons.DSWORD_, 10).add(weapons.DKATANA, 10).add(weapons.D_LANCE, 10);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
        checkMonster();
    }
}


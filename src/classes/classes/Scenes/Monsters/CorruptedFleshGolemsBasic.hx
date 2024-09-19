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

class CorruptedFleshGolemsBasic extends AbstractFleshGolem
{
    public function corruptedGolemsSwordSlash() : Void
    {
        outputText("The corrupted golems visage twists into a grimace of irritation, and few of them swings their swords at you.");
        var damage : Float = as3hx.Compat.parseInt(((str + weaponAttack) * 2) - rand(player.tou) - player.armorDef);
        //Dodge
        if (damage <= 0 || (player.getEvasionRoll()))
        {
            outputText(" You slide underneath the surprise slashes!");
        }
        else
        {
            if (hasStatusEffect(StatusEffects.Provoke))
            {
                damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
            }
            outputText(" They slash you from a few different angles. ");
            damage = player.takePhysDamage(damage, true);
            damage = player.takePhysDamage(damage, true);
            damage = player.takePhysDamage(damage, true);
            damage = player.takePhysDamage(damage, true);
            damage = player.takePhysDamage(damage, true);
        }
    }
    public function corruptedGolemsLustAttack() : Void
    {
        outputText("Two of them smirks and licks their lips while gives their cocks a squeeze, milking a few beads of clear pre from the tip.  You shake your head and try to ignore your growing need.");
        player.takeLustDamage(20 + player.lib / 3 + player.cor / 3, true);
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
                corruptedGolemsSwordSlash();
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
                corruptedGolemsSwordSlash();
            }
            if (choice == 3)
            {
                corruptedGolemsLustAttack();
            }
        }
    }
    
    public function new()
    {
        super(true);
        this.a = "the ";
        this.short = "corrupted basic flesh golems";
        this.imageName = "corrupted basic flesh golems";
        this.long = "You're currently fighting corrupted basic flesh golems. They're seven feet tall with flesh covered by white armor fragments, which still leaving genitalia, with pretty sizable cocks, or breasts exposed. Despite not possesing visible eyes on her elongated head, they're using pair of weapons to attack enemies.";
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
        this.bonusLust = 186;
        this.lustVuln = .5;
        this.level = 36;
        this.additionalXP = 350;
        this.gems = rand(10) + 5;
        this.tailType = Tail.DEMONIC;
        this.drop = new WeightedDrop().add(consumables.BIMBOLQ, 1).add(consumables.BROBREW, 1).add(weapons.DDAGGER, 10).add(weapons.DL_AXE_, 10).add(weapons.DSWORD_, 10).add(weapons.DKATANA, 10).add(weapons.D_LANCE, 10);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
        checkMonster();
    }
}


/**
 * ...
 * @author Liadri
 */
package classes.scenes.areas.ocean;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.LowerBody;
import classes.scenes.SceneLib;
import classes.internals.*;

class Scylla extends Monster
{
    public function scyllaConstrict() : Void
    {
        outputText("" + this.capitalA + this.short + "’s tentacles grab you all at once and start to squeeze you!");
        player.createStatusEffect(StatusEffects.ScyllaBind, 0, 0, 0, 0);
        if (!player.hasPerk(PerkLib.Juggernaut) && armorPerk != "Heavy")
        {
            player.takePhysDamage(4 + rand(6));
        }
    }
    
    public function scyllaInkSpray() : Void
    {
        clearOutput();
        outputText("" + this.capitalA + this.short + " stretches all her tentacles apart revealing a huge gaping pussy at the center which spray a cloud of ink all around you impairing your vision. ");
        if (!player.isImmuneToBlind())
        {
            player.createStatusEffect(StatusEffects.Blind, 2, 0, 0, 0);
        }
    }
    
    public function scyllaTentacleSlap() : Void
    {
        clearOutput();
        var damage : Float = 0;
        damage += eBaseStrengthDamage() * 2;
        outputText("" + this.capitalA + this.short + " slaps you with her tentacles, dealing ");
        player.takePhysDamage(damage, true);
        player.takePhysDamage(damage, true);
        player.takePhysDamage(damage, true);
        player.takePhysDamage(damage, true);
        player.takePhysDamage(damage, true);
        player.takePhysDamage(damage, true);
        outputText(" damage!");
    }
    public function scyllaTentacleSlap2() : Void
    {
        clearOutput();
        var damage : Float = 0;
        damage += eBaseStrengthDamage() * 2;
        outputText("" + this.capitalA + this.short + " slaps you with her tentacles, dealing ");
        player.takePhysDamage(damage, true);
        player.takePhysDamage(damage, true);
        outputText(" damage!");
    }
    
    override private function performCombatAction() : Void
    {
        var choice : Float = rand(6);
        if (choice < 3)
        {
            if (player.hasStatusEffect(StatusEffects.ScyllaBind))
            {
                scyllaTentacleSlap2();
            }
            else
            {
                scyllaTentacleSlap();
            }
        }
        if (choice == 3 || choice == 4)
        {
            if (player.hasStatusEffect(StatusEffects.ScyllaBind))
            {
                scyllaTentacleSlap2();
            }
            else
            {
                scyllaConstrict();
            }
        }
        if (choice == 5)
        {
            if (player.hasStatusEffect(StatusEffects.Blind) || player.hasStatusEffect(StatusEffects.ScyllaBind))
            {
                if (player.hasStatusEffect(StatusEffects.ScyllaBind))
                {
                    scyllaTentacleSlap2();
                }
                else
                {
                    scyllaTentacleSlap();
                }
            }
            else
            {
                scyllaInkSpray();
            }
        }
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.scyllaScene.oceanScyllaWin();
    }
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.scyllaScene.oceanScyllaLoss();
    }
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "scylla";
        this.imageName = "scylla";
        this.long = "You are currently fighting ten feet tall scylla. She looks like mix between an octopus and a woman. Eight long tentacles grow at the place where her legs should be, each easily twice her length.";
        // this.plural = false;
        this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
        this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("E"));
        this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = 10 * 12;
        this.hips.type = Hips.RATING_AMPLE;
        this.butt.type = Butt.RATING_NOTICEABLE;
        this.lowerBody = LowerBody.SCYLLA;
        this.skin.setBaseOnly({
                    color : "slippery"
                });
        this.hairColor = "brown";
        this.hairLength = 5;
        initStrTouSpeInte(450, 250, 250, 150);
        initWisLibSensCor(150, 200, 150, 0);
        this.weaponName = "tentacle";
        this.weaponVerb = "slash";
        this.weaponAttack = 86;
        this.armorName = "thick skin";
        this.armorDef = 104;
        this.armorMDef = 52;
        this.bonusHP = 5000;
        this.bonusLust = 420;
        this.lust = 20;
        this.lustVuln = .2;
        this.level = 70;
        this.gems = 0;
        this.drop = new WeightedDrop(consumables.BLACKIN, 1);
        this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
        this.createPerk(PerkLib.WaterNature, 0, 0, 0, 0);
        checkMonster();
    }
}


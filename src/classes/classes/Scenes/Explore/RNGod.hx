/**
 * ...
 * @author Ormael
 */
package classes.scenes.explore;

import classes.*;
import classes.globalFlags.*;
import classes.Appearance;
import classes.bodyParts.*;
import classes.BreastRowClass;
import classes.Cock;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.SceneLib;
import classes.VaginaClass;

class RNGod extends Monster
{
    
    
    
    public function new()
    {
        super();
        this.a = " ";
        this.short = "RNGod";
        this.long = "You’re facing RNGod. As randomness of it telling " + player.mf("he", "she") + "'s probably stronger than you so why fight " + player.mf("him", "her") + "? Some rumors say that " + player.mf("he", "she") + "'s Lady Godiva parent. Crazy isn't it?";
        this.plural = false;
        this.tallness = player.tallness;
        if (player.hasBalls())
        {
            this.balls = player.balls;
            this.ballSize = player.ballSize;
        }
        else
        {
            this.balls = 0;
            this.ballSize = 0;
        }
        this.hoursSinceCum = player.hoursSinceCum;
        hips.type = player.hips.type;
        if (hips.type < 1)
        {
            hips.type = 1;
        }
        butt.type = player.butt.type;
        if (butt.type < 1)
        {
            butt.type = 1;
        }
        lowerBody = player.lowerBody;
        skinDesc = player.skinDesc;
        initStrTouSpeInte(Math.round(player.str * 1.2) + rand(player.str), Math.round(player.tou * 1.2) + rand(player.tou), Math.round(player.spe * 1.2) + rand(player.spe), Math.round(player.inte * 1.2) + rand(player.inte));
        initWisLibSensCor(Math.round(player.wis * 1.2) + rand(player.wis), Math.round(player.lib * 1.2) + rand(player.lib), Math.round(player.sens * 1.2) + rand(player.sens), player.cor);
        this.weaponName = player.weaponName;
        this.weaponAttack = player.weaponAttack + rand(player.weaponAttack);
        this.weaponVerb = player.weaponVerb;
        this.armorDef = player.armorDef + rand(player.armorDef);
        this.armorMDef = player.armorMDef + rand(player.armorMDef);
        this.armorName = player.armorName;
        this.bonusHP = 2500 * (1 + rand(10));
        this.bonusLust = (player.level + rand(16) + Math.round(player.lib * 1.2) + rand(player.lib) + Math.round(player.sens * 1.2) + rand(player.sens)) * (1 + rand(3));
        this.bonusMana = 100 * (1 + rand(10));
        this.bonusSoulforce = 100 * (1 + rand(10));
        this.lustVuln = 0.1 * (1 + rand(10));
        this.lust = 20;
        this.level = player.level + rand(16);
        this.ass.analLooseness = player.ass.analLooseness;
        this.ass.analWetness = player.ass.analWetness;
        if (player.cocks.length > 0)
        {
            for (i in 0...player.cocks.length)
            {
                this.createCock((try cast(player.cocks[i], Cock) catch(e:Dynamic) null).cockLength, (try cast(player.cocks[i], Cock) catch(e:Dynamic) null).cockThickness, (try cast(player.cocks[i], Cock) catch(e:Dynamic) null).cockType);
            }
        }
        if (player.vaginas.length > 0)
        {
            this.createVagina();
            (try cast(this.vaginas[0], VaginaClass) catch(e:Dynamic) null).vaginalLooseness = player.vaginas[0].vaginalLooseness;
            (try cast(this.vaginas[0], VaginaClass) catch(e:Dynamic) null).vaginalWetness = player.vaginas[0].vaginalWetness;
            (try cast(this.vaginas[0], VaginaClass) catch(e:Dynamic) null).virgin = player.vaginas[0].virgin;
        }
        //Genderless get forced to have a cunny
        if (player.vaginas.length == 0 && player.cocks.length == 0)
        {
            this.createVagina();
            (try cast(this.vaginas[0], VaginaClass) catch(e:Dynamic) null).vaginalLooseness = 2;
            (try cast(this.vaginas[0], VaginaClass) catch(e:Dynamic) null).vaginalWetness = 6;
            (try cast(this.vaginas[0], VaginaClass) catch(e:Dynamic) null).virgin = false;
        }
        this.breastRows = [];
        for (i in 0...player.breastRows.length)
        {
            this.createBreastRow();
            var tbr : BreastRowClass = this.breastRows[i];
            var sbr : BreastRowClass = player.breastRows[i];
            
            tbr.breastRating = sbr.breastRating;
            tbr.breasts = sbr.breasts;
            tbr.fuckable = sbr.fuckable;
            tbr.lactationMultiplier = sbr.lactationMultiplier;
            tbr.milkFullness = sbr.milkFullness;
            tbr.nipplesPerBreast = sbr.nipplesPerBreast;
        }
        this.pronoun1 = "[he]";
        this.pronoun2 = "[him]";
        this.pronoun3 = "[his]";
        this.gems = rand(100);
        this.drop = NO_DROP;
        this.tailType = Tail.FOX;
        this.tail.count = 9;
        this.createPerk(PerkLib.EnemyGodType, 0, 0, 0, 0);
        if (rand(2) == 0)
        {
            this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
        }
        if (rand(2) == 0)
        {
            this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
        }
        if (rand(2) == 0)
        {
            this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
        }
        if (rand(2) == 0)
        {
            this.createPerk(PerkLib.EnemyGhostType, 0, 0, 0, 0);
        }
        if (rand(2) == 0)
        {
            this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
        }
        if (rand(2) == 0)
        {
            this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
        }
        if (rand(2) == 0)
        {
            if (rand(2) == 0)
            {
                if (rand(2) == 0)
                {
                    this.createPerk(PerkLib.EnemyColossalType, 0, 0, 0, 0);
                }
                else
                {
                    this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
                }
            }
            else
            {
                this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
            }
        }
        if (rand(2) == 0)
        {
            if (rand(4) == 0)
            {
                this.createPerk(PerkLib.LightningNature, 0, 0, 0, 0);
            }
            else if (rand(3) == 0)
            {
                this.createPerk(PerkLib.DarknessNature, 0, 0, 0, 0);
            }
            else if (rand(2) == 0)
            {
                this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
            }
            else
            {
                this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
            }
        }
        checkMonster();
    }
}

package classes.scenes.dungeons.helDungeon;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.Horns;
import classes.bodyParts.LowerBody;
import classes.bodyParts.Tail;
import classes.bodyParts.Wings;
import classes.scenes.SceneLib;
import classes.internals.WeightedDrop;

class PhoenixSquad extends Monster
{
    //ATTACK ONE: SPARTAN RUSH
    public function phoenixSquadRush() : Void
    {
        outputText("You fall back under a hail of scimitar attacks.  The sheer number of phoenixes attacking is bad enough, but their attacks are perfectly coordinated, leaving virtually no room for escape or maneuver without getting hit!\n");
        //(Effect: Multiple medium-damage attacks)
        //(Effect: Multiple light attacks)
        createStatusEffect(StatusEffects.Attacks, 3 + rand(2), 0, 0, 0);
        eAttack();
    }
    
    //ATTACK TWO: FIRE BREATH
    public function phoenixSquadFireBreath() : Void
    //(Effect: One heavy-damage attack)
    {
        
        var damage : Float = inte + wis + rand(50);
        outputText("Suddenly, the shield wall parts, revealing a single member of the platoon, a particularly muscular girl with a raging erection.  Before you can consider what's going on, she rears back and huffs at you.  To your horror, a great gout of fire erupts from her mouth, rolling towards you.  You dive, but are still caught partially in the inferno.");
        if (player.hasStatusEffect(StatusEffects.Blizzard))
        {
            player.addStatusValue(StatusEffects.Blizzard, 1, -1);
            outputText("  Luckly blizzard still surrounding you lowering amount of fire that pass throu it.");
            damage *= 0.2;
        }
        damage = Math.round(damage);
        damage = player.takeFireDamage(damage, true);
    }
    //ATTACK THREE: LUSTBANG GRENADE
    public function phoenixSquadLustbang() : Void
    {
        outputText("\"<i>LUSTBANG OUT!</i>\" one of the rear-most phoenixes shouts, causing all the other warriors to duck down behind their shields.  Oh, shit!  A large glass sphere rolls out from the shield wall, and immediately explodes in a great pink cloud.  You cough and wave your arms, but by the time the cloud has dissipated, you feel lightheaded and lusty, barely able to resist the urge to throw yourself at the phoenixes and beg for their cocks and cunts.");
        //(Effect: Large lust increase)
        player.takeLustDamage(Math.round(30 + (player.lib / 2)), true);
    }
    
    override private function performCombatAction() : Void
    {
        if (!hasStatusEffect(StatusEffects.Platoon))
        {
            phoenixSquadRush();
            createStatusEffect(StatusEffects.Platoon, 0, 0, 0, 0);
        }
        else if (statusEffectv1(StatusEffects.Platoon) == 0)
        {
            phoenixSquadFireBreath();
            addStatusValue(StatusEffects.Platoon, 1, 1);
        }
        else
        {
            phoenixSquadLustbang();
            removeStatusEffect(StatusEffects.Platoon);
        }
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.dungeons.heltower.phoenixSquadLosesToPC();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        if (player.isGargoyle())
        {
            SceneLib.dungeons.heltower.gargoyleBadEndPhoenixTower();
        }
        else
        {
            SceneLib.dungeons.heltower.phoenixSquadMurdersPC();
        }
    }
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "phoenix squad";
        this.imageName = "phoenixmob";
        this.long = "You are faced with a squad of heavy infantry, all armed to the teeth and protected by chain vests and shields. They look like a cross between salamander and harpy, humanoid save for crimson wings, scaled feet, and long fiery tails. They stand in a tight-knit shield wall, each phoenix protecting herself and the warrior next to her with their tower-shield. Their scimitars cut great swaths through the room as they slowly advance upon you.";
        this.plural = true;
        this.pronoun1 = "they";
        this.pronoun2 = "them";
        this.pronoun3 = "their";
        this.createCock();
        this.balls = 2;
        this.ballSize = 1;
        this.cumMultiplier = 3;
        this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_LOOSE);
        createBreastRow(Appearance.breastCupInverse("D"));
        this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.tallness = rand(8) + 70;
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.lowerBody = LowerBody.SALAMANDER;
        this.bodyColor = "red";
        this.hairColor = "black";
        this.hairLength = 15;
        initStrTouSpeInte(183, 152, 143, 90);
        initWisLibSensCor(90, 110, 53, 0);
        this.weaponName = "spears";
        this.weaponVerb = "stab";
        this.weaponAttack = 59;
        this.armorName = "armor";
        this.armorDef = 52;
        this.armorMDef = 12;
        this.bonusHP = 1100;
        this.bonusLust = 204;
        this.lust = 20;
        this.lustVuln = .15;
        this.level = 41;
        this.gems = rand(40) + 300;
        this.additionalXP = 100;
        this.horns.type = Horns.DRACONIC_X2;
        this.horns.count = 2;
        this.tailType = Tail.SALAMANDER;
        this.wings.type = Wings.FEATHERED_PHOENIX;
        this.drop = new WeightedDrop(consumables.NOCELIQ, 1);
        this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
        this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
        this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
        checkMonster();
    }
}



package classes.scenes.dungeons.demonLab;

import classes.AssClass;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.Horns;
import classes.bodyParts.Tail;
import classes.CockTypesEnum;
import classes.globalFlags.KFLAGS;
import classes.items.DynamicItems;
import classes.items.WeaponLib;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.SceneLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.WeightedDrop;

/**
 * ...
 * @author Canadian Snas
 */
class MutantIncubus extends Monster
{
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "Mutant Incubus";
        this.imageName = "demonmob";
        this.long = "You're fighting a mutant Incubus. The right side of his face is noticeably larger than the left, and his eye glows with a sickening purple light, not unlike the eyes of the Driders you’ve met in the swamp. He wears two blades, one at each hip, with an oddly pink, circular guard. He also has a tail, but instead of the usual spadelike tip, his tail ends in a vicious looking stinger, dripping with venom. ";
        this.plural = false;
        this.pronoun1 = "he";
        this.pronoun2 = "him";
        this.pronoun3 = "his";
        this.createCock(18, 2);
        this.createCock(18, 2, CockTypesEnum.DEMON);
        this.balls = 2;
        this.ballSize = 1;
        this.cumMultiplier = 3;
        // this.hoursSinceCum = 0;
        this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
        createBreastRow(0);
        this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
        this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
        this.tallness = rand(8) + 70;
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.bodyColor = "red";
        this.hairColor = "black";
        this.hairLength = 15;
        initStrTouSpeInte(290, 170, 220, 140);
        initWisLibSensCor(140, 350, 80, 100);
        this.weaponName = "claws";
        this.weaponVerb = "stab";
        this.weaponAttack = 40;
        this.armorName = "demonic skin";
        this.armorDef = 185;
        this.armorMDef = 160;
        this.bonusHP = 400;
        this.bonusLust = 485;
        this.lust = 20;
        this.level = 55;
        this.gems = rand(60) + 220;
        this.randomDropChance = 0.1;
        this.randomDropParams = {
                    rarity : DynamicItems.RARITY_CHANCES_LESSER
                };
        this.drop = new WeightedDrop().addMany(1, 
                        consumables.SUCMILK, 
                        consumables.INCUBID, 
                        consumables.OVIELIX, 
                        consumables.B__BOOK
            );
        
        this.tailType = Tail.DEMONIC;
        this.horns.type = Horns.DEMON;
        this.horns.count = 2;
        this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
        this.createPerk(PerkLib.OverMaxHP, 55, 0, 0, 0);
        checkMonster();
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.dungeons.demonLab.AfterFirstFight();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.dungeons.demonLab.BadEndExperiment();
    }
    
    private function BladeFlurry() : Void
    {
        if (hasStatusEffect(StatusEffects.Blacken))
        {
            outputText("From the darkness, you feel the air moving…too late to dodge. The Incubus seems to be everywhere, slashing at you from multiple angles at once! ");
            if (!player.immuneToBleed())
            {
                if (player.hasStatusEffect(StatusEffects.IzmaBleed))
                {
                    player.addStatusValue(StatusEffects.IzmaBleed, 1, 1);
                }
                else
                {
                    player.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
                }
            }
            for (i1 in 0...8)
            {
                player.buff("Blackened Blade Furry").addStats({
                                            str : -5
                                        }).withText("Blackened Blade Furry!").combatPermanent();
                eOneAttack(true);
            }
        }
        else
        {
            outputText("The mutant incubus grits his teeth, slashing at you with his thin swords. They flick in behind your guard, leaving thin, bleeding wounds. Your muscles feel weaker where the swords hit. ");
            if (!player.immuneToBleed())
            {
                if (player.hasStatusEffect(StatusEffects.IzmaBleed))
                {
                    player.addStatusValue(StatusEffects.IzmaBleed, 1, 1);
                }
                else
                {
                    player.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
                }
            }
            for (i2 in 0...4)
            {
                player.buff("Blade Furry").addStats({
                                            str : -2
                                        }).withText("Blade Furry!").combatPermanent();
                eOneAttack(true);
            }
        }
        outputText("\n");
    }
    
    private function StingerTail() : Void
    {
        outputText("The mutant incubus lunges forward, stabbing at you. You dodge that, then a sweeping slash from his other blade…only to realise, too late, that they were feints! The Incubus drives his tail into your stomach, dumping a load of venom into your system! ");
        player.createStatusEffect(StatusEffects.MutantIncubusVenom, 5, 0, 0, 0);
        player.buff("Mutant Incubus Venom").addStats({
                                    int : -5
                                }).withText("Poisoned!").combatTemporary(5);
    }
    
    private function Blacken() : Void
    {
        outputText("The incubus groans, and the room shudders around you. From the incubus’s body spews a gaseous substance. It quickly fills the room, concealing the demon from view. All you can see of your foe is a single glowing purple eye…Wait. Your vision blurs for a moment, and the glowing eye seems to multiply, spreading through the room. Hitting the Mutant Incubus will be MUCH harder now! ");
        player.buff("Black Gas").addStats({
                                    spe : -5
                                }).withText("Black Gas!").combatPermanent();
        player.createStatusEffect(StatusEffects.Blind, 3, 0, 0, 0);
        createStatusEffect(StatusEffects.Blacken, 3, 0, 0, 0);
    }
    
    override private function performCombatAction() : Void
    {
        if (hasStatusEffect(StatusEffects.Blacken))
        {
            BladeFlurry();
        }
        else
        {
            var choice : Float = rand(5);
            switch (choice)
            {
                case 0, 1:
                    BladeFlurry();
                case 2, 3:
                    StingerTail();
                case 4:
                    Blacken();
            }
        }
    }
}


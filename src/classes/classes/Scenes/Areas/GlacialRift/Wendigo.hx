/**
 * ...
 * @author Liadri
 */
package classes.scenes.areas.glacialRift;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.Wings;
import classes.lists.BreastCup;
import classes.scenes.SceneLib;
import classes.internals.*;

class Wendigo extends Monster
{
    public function WendigoPossess() : Void
    {
        outputText("The wendigo suddenly seems to vanish into thin air. Just as you thought the monster was gone you feel something entering your body. ");
        if (SceneLib.shouldraFollower.followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff))
        {
            outputText("For a split second you feel the malevolent presence within your body before suddenly shouldra manifest herself forcing it out.\n\n");
            outputText("\"<i>Always glad to have your back champ. I ain't letting anything else go piggy back on this ride, not on my watch!</i>\"");
        }
        else
        {
            outputText("The thing just possessed you!");
            player.createStatusEffect(StatusEffects.PossessionWendigo, 0, 0, 0, 0);
        }
    }
    
    public function WendigoSpectralScream() : Void
    {
        outputText("The wendigo howl a soul-chilling scream. You try to move but realize to your horror that your body is paralyzed by fear! ");
        var damage : Float = 0;
        damage += eBaseIntelligenceDamage();
        player.takeMagicDamage(damage, true);
        player.createStatusEffect(StatusEffects.Fear, 3, 0, 0, 0);
        player.addCurse("wis.mult", 1, 3);
    }
    
    public function WendigoClaw() : Void
    {
        outputText("The wendigo tries to rend you with its claws. ");
        WendigoClaw2();
        WendigoClaw2();
    }
    public function WendigoClaw2() : Void
    {
        var dodged : String = player.getEvasionReason();
        if (dodged != null)
        {
            switch (dodged)
            {
                case EVASION_SPEED:
                    outputText("Using your superior combat skills you manage to avoid attack completely. ");
                case EVASION_EVADE:
                    outputText("Using your skills at evading attacks, you anticipate and sidestep wendigo attack. ");
                case EVASION_MISDIRECTION:
                    outputText("Using Raphael's teachings, you anticipate and sidestep wendigo attacks. ");
                case EVASION_FLEXIBILITY:
                    outputText("With your incredible flexibility, you squeeze out of the way of wendigo's attack. ");
                case EVASION_UNHINDERED:
                    outputText("Using your superior combat skills you manage to avoid attack completely. ");
                default:
                    outputText("Using your superior combat skills you manage to avoid attack completely. ");
            }
        }
        //var isCursed:Boolean = player.buff("Wendigo curse").isPresent();
        else
        {
            
            var damage : Float = 0;
            damage += eBaseDamage();
            player.takePhysDamage(damage, true);
            //if (!isCursed) player.buff("Wendigo curse").addStats( {"tou.mult": -0.05} ).withText("Wendigo curse!").combatPermanent();
            //else player.buff("Wendigo curse").addStats( {"tou.mult":-0.05} ).combatPermanent();
            player.addCurse("tou.mult", 1, 3);
            if (!player.hasStatusEffect(StatusEffects.WendigoPsychosis) && !player.hasPerk(PerkLib.EndlessHunger))
            {
                player.createStatusEffect(StatusEffects.WendigoPsychosis, 168, 0, 0, 0);
            }
        }
    }
    
    override private function performCombatAction() : Void
    {
        var choice : Float = rand(4);
        if (choice < 2)
        {
            WendigoClaw();
        }
        if (choice == 2)
        {
            if (player.hasStatusEffect(StatusEffects.Fear))
            {
                WendigoClaw();
            }
            else
            {
                WendigoSpectralScream();
            }
        }
        if (choice == 3)
        {
            WendigoPossess();
        }
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.glacialRift.wendigoScene.winAgainstWendigo();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.glacialRift.wendigoScene.loseToWendigo();
    }
    
    override private function get_long() : String
    {
        var str : String = "";
        str += "Your opponent is a wendigo, a monster plagued by constant lustful hunger. Its spectral blue eyes leer at you, mad with desire as it fixates your crotch";
        if (player.biggestTitSize() >= BreastCup.FLAT)
        {
            str += " and breast";
        }
        str += " looking for a chance to overpower you. Its claws look sharp and deadly and not in a natural way, you suspect magic at work here.";
        return str;
    }
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "wendigo";
        this.imageName = "wendigo";
        this.long = "";
        // this.plural = false;
        this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
        createBreastRow(Appearance.breastCupInverse("EE"));
        this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = 60 + rand(6);
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.skin.setBaseOnly({
                    color : "snow white"
                });
        this.skinDesc = "skin";
        this.hairColor = "silver white";
        this.hairLength = 15;
        initStrTouSpeInte(160, 150, 350, 189);
        initWisLibSensCor(225, 350, 175, -70);
        this.weaponName = "claws";
        this.weaponVerb = "slash";
        this.weaponAttack = 52;
        this.armorName = "skin";
        this.armorDef = 100;
        this.armorMDef = 400;
        this.bonusHP = 3000;
        this.bonusLust = 609;
        this.lust = 20;
        this.lustVuln = .05;
        this.level = 84;
        this.additionalXP = 600;
        this.gems = 120 + rand(40);
        this.drop = new WeightedDrop().add(consumables.QWHITED, 1).add(consumables.SNOWW_D, 5).add(consumables.ICICLE_, 2);
        this.wings.type = Wings.LEVITATION;
        this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
        this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
        checkMonster();
    }
}


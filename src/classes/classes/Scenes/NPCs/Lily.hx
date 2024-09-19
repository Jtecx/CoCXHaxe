/**
 * ...
 * @author Ormael
 */
package classes.scenes.nPCs;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.LowerBody;
import classes.globalFlags.KFLAGS;
import classes.items.WeaponLib;
import classes.scenes.SceneLib;
import classes.internals.*;
import classes.scenes.combat.CombatAbilities;

class Lily extends Monster
{
    private function lilyBasicAttack() : Void
    {
        outputText("The drider woman draws her recurve bow, nocking an arrow and firing in less than half a second. You try to dodge, but the arrow hits you in the [foot], pinning you to the ground. ");
        damageCalc();
        var lBAR : Float = 1;
        if (flags[kFLAGS.LILY_LVL_UP] >= 2)
        {
            lBAR += 1;
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 4)
        {
            lBAR += 1;
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 6)
        {
            lBAR += 1;
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 8)
        {
            lBAR += 1;
        }
        while (lBAR-- > 0)
        {
            lilyBasicAttackRe();
        }
    }
    private function lilyBasicAttackRe() : Void
    {
        var choices : Float = 4;
        if (!player.hasStatusEffect(StatusEffects.Disarmed) && !player.isFistOrFistWeapon())
        {
            choices += 1;
        }
        var re : Float = rand(choices);
        switch (re)
        {
            case 0:
                outputText("Another arrow follows, sinking deep into your [chest]. ");
                damageCalc();
            case 1:
                outputText("Another arrow follows, sinking into your [leg]. ");
                damageCalc();
            case 2:
                outputText("An arrow is fired into your shoulder. ");
                damageCalc();
            case 3:
                outputText("The drider fires an arrow with an explosive tip. You cover your [face] as the concussive blast erupts, sending metal shards into your body. ");
                damageCalc();
                if (rand(10) == 0 && !player.hasPerk(PerkLib.Resolute) && !player.hasStatusEffect(StatusEffects.Stunned))
                {
                    player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
                }
            case 4:
                outputText("You look down at your foot, and another arrow comes whistling at you. You block with your [weapon], but the impact sends your [weapon] tumbling from your hands. ");
                if (rand(3) == 0)
                {
                    flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
                    player.setWeapon(WeaponLib.FISTS);
                    player.createStatusEffect(StatusEffects.Disarmed, 2, 0, 0, 0);
                }
            default:
                outputText("Another arrow follows, sinking deep into your [chest]. ");
                damageCalc();
        }
    }
    
    private function lilyWebAttack() : Void
    {
        outputText("She spins, exposing her spider back-half and spinnerets. The Drider spits webbing in great strands.");
        //Determine if dodged!
        if (player.getEvasionRoll())
        {
            outputText("You dodge away, avoiding the sticky strands! As she spins back around, your opponent…seems to be looking at the strands in disappointment. Is it your imagination, or does she seem to regret the loss of silk?");
        }
        //Got hit
        else
        {
            if (player.buff("Web").isPresent())
            {
                outputText("The silky strands hit you, weighing you down and restricting your movement even further.\n");
                player.buff("Web").addStats({
                                            spe : -25
                                        }).withText("Web").combatPermanent();
            }
            else
            {
                outputText("You’re unable to dodge, and the heavy strands wrap around your arms and legs, weighing you down and restricting your movements.");
                if (player.canFly())
                {
                    outputText("  Your wings struggle uselessly in the bindings, no longer able to flap fast enough to aid you.");
                }
                outputText("\n");
                player.buff("Web").addStats({
                                            spe : -25
                                        }).withText("Web").combatPermanent();
            }
        }
    }
    
    private function lilyVolley() : Void
    {
        outputText("Several arrows come flying at you, and you see the Drider-woman’s top half through the treeline. You gasp, disbelieving, as said arrows seem to multiply into a veritable shower of shafts, and you barely have time to crouch down, making yourself less of a target. ");
        if (CombatAbilities.EAspectAir.isActive())
        {
            outputText("Still surrounding you wind wall stops them without much trouble. ");
        }
        var lFB : Float = 6;
        if (flags[kFLAGS.LILY_LVL_UP] >= 3)
        {
            lFB += 3;
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 5)
        {
            lFB += 3;
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 7)
        {
            lFB += 3;
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 9)
        {
            lFB += 3;
        }
        while (lFB-- > 0)
        {
            LilyFireBow();
        }
    }
    public function LilyFireBow() : Void
    {
        if (CombatAbilities.EAspectAir.isActive())
        {
            CombatAbilities.EAspectAir.advance(true);
        }
        else
        {
            damageCalc();
        }
    }
    
    private function damageCalc() : Void
    {
        var damage : Float = 0;
        damage += eBaseSpeedDamage() * 0.2;
        if (damage < 10)
        {
            damage = 10;
        }
        //weapon bonus
        if (this.weaponRangeAttack < 51)
        {
            damage *= (1 + (this.weaponRangeAttack * 0.03));
        }
        else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101)
        {
            damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
        }
        else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151)
        {
            damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
        }
        else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201)
        {
            damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
        }
        else
        {
            damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
        }
        player.takePhysDamage(damage, true);
        if (flags[kFLAGS.LILY_LVL_UP] >= 3)
        {
            var lustArrowDmg : Float = (flags[kFLAGS.LILY_LVL_UP] * 2);
            if (flags[kFLAGS.LILY_LVL_UP] >= 9)
            {
                lustArrowDmg += (this.inte / 5 + rand(player.lib - player.inte * 2 + player.cor) / 5);
            }
            player.takeLustDamage(lustArrowDmg, true);
        }
    }
    
    override private function performCombatAction() : Void
    {
        var choice0 : Float = rand(3);
        switch (choice0)
        {
            case 0:
                lilyBasicAttack();
            case 1:
                lilyWebAttack();
            case 2:
                lilyVolley();
            default:
                lilyBasicAttack();
        }
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        if (LilyFollower.LilyFollowerState)
        {
            SceneLib.lily.LilySparLost();
        }
        else
        {
            SceneLib.lily.LilyAfterBattle();
        }
    }
    
    public function new()
    {
        super();
        if (flags[kFLAGS.LILY_LVL_UP] < 2)
        {
            initStrTouSpeInte(70, 75, 110, 100);
            initWisLibSensCor(100, 80, 50, 80);
            this.weaponAttack = 3;
            this.weaponRangeAttack = 30;
            this.armorDef = 60;
            this.armorMDef = 6;
            this.bonusHP = 400;
            this.bonusLust = 152;
            this.level = 22;
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 2 && flags[kFLAGS.LILY_LVL_UP] < 9)
        {
            var mod : Int = as3hx.Compat.parseInt(flags[kFLAGS.LILY_LVL_UP] - 1);
            initStrTouSpeInte(70 + 4 * mod, 75 + 6 * mod, 110 + 20 * mod, 100 + 5 * mod);
            initWisLibSensCor(100 + 5 * mod, 80 + 25 * mod, 50 + 20 * mod, 80);
            this.weaponAttack = 3 + 1 * mod;
            this.weaponRangeAttack = 30 + 5 * mod;
            this.armorDef = 60 + 10 * mod;
            this.armorMDef = 6 + 1 * mod;
            this.bonusHP = 400 + 50 * mod;
            this.bonusLust = 152 + 51 * mod;
            this.level = 22 + 6 * mod;
        }
        if (flags[kFLAGS.LILY_LVL_UP] == 9)
        {
            initStrTouSpeInte(102, 123, 270, 140);
            initWisLibSensCor(140, 280, 210, 80);
            this.weaponAttack = 11;
            this.weaponRangeAttack = 70;
            this.armorDef = 140;
            this.armorMDef = 14;
            this.bonusHP = 800;
            this.bonusLust = 560;
            this.level = 70;
        }
        this.imageName = "corrupteddrider";
        if (LilyFollower.LilyTalked > 0)
        {
            this.a = "";
            this.short = "Lily";
            this.long = "Lily is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, DD-cup breasts with their shiny black nipples.  Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  On her face and forehead, a sextet of lust-filled, " + LilyFollower.LilySkinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + LilyFollower.LilyHairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  Her spider-half has eight spindly legs with black and " + LilyFollower.LilyHairColor + " stripes - a menacing display if ever you've seen one.";
        }
        else
        {
            this.a = "the ";
            this.short = "corrupted drider";
            this.long = "This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, DD-cup breasts with their shiny black nipples.  Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  On her face and forehead, a sextet of lust-filled, " + LilyFollower.LilySkinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + LilyFollower.LilyHairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  Her spider-half has eight spindly legs with black and " + LilyFollower.LilyHairColor + " stripes - a menacing display if ever you've seen one.";
        }
        // this.plural = false;
        this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
        this.createStatusEffect(StatusEffects.BonusVCapacity, 70, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("DD"));
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.createStatusEffect(StatusEffects.BonusACapacity, 70, 0, 0, 0);
        this.tallness = 10 * 12;
        this.hips.type = Hips.RATING_CURVY + 2;
        this.butt.type = Butt.RATING_LARGE + 1;
        this.lowerBody = LowerBody.DRIDER;
        this.bodyColor = LilyFollower.LilySkinTone;
        this.hairColor = LilyFollower.LilyHairColor;
        this.hairLength = 24;
        this.weaponName = "claws";
        this.weaponVerb = "claw";
        this.weaponRangeName = "bow";
        this.armorName = "carapace";
        this.armorPerk = "";
        this.armorValue = 70;
        this.nipplesPierced = 1;
        this.lust = 35;
        this.lustVuln = .2;
        this.gems = rand(15) + 35;
        this.drop = new WeightedDrop().add(consumables.B_GOSSR, 5).add(useables.T_SSILK, 1).add(null, 4);
        this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
        this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
        if (flags[kFLAGS.LILY_LVL_UP] >= 2)
        {
            this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
            this.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
            this.createPerk(PerkLib.Masochist, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 3)
        {
            this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
            this.createPerk(PerkLib.NakedTruth, 0, 0, 0, 0);
            this.createPerk(PerkLib.JobSeducer, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 4)
        {
            this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
            this.createPerk(PerkLib.JobHunter, 0, 0, 0, 0);
            this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 5)
        {
            this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
            this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
            this.createPerk(PerkLib.JobCourtesan, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 6)
        {
            this.createPerk(PerkLib.HalfStepToSuperiorSelfControl, 0, 0, 0, 0);
            this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 7)
        {
            this.createPerk(PerkLib.SuperiorSelfControl, 0, 0, 0, 0);
            this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 8)
        {
            this.createPerk(PerkLib.HalfStepToPeerlessSelfControl, 0, 0, 0, 0);
            this.createPerk(PerkLib.PrestigeJobArcaneArcher, 0, 0, 0, 0);
        }
        if (flags[kFLAGS.LILY_LVL_UP] >= 9)
        {
            this.createPerk(PerkLib.PeerlessSelfControl, 0, 0, 0, 0);
            this.createPerk(PerkLib.LegendaryLibido, 0, 0, 0, 0);
        }
        checkMonster();
    }
}


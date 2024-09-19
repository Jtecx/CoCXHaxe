/**
 * ...
 * @author Ormael
 */
package classes.scenes.monsters;

import classes.*;
import classes.bodyParts.Wings;
import classes.scenes.SceneLib;

class AngelHR extends AbstractAngel
{
    private function angelReactsToLustiness() : Void
    {
        outputText("Angel stops their actions clearly overflowing with lust.");
        outputText("\n\n\"<i>Sinner!!! We.Must.Contact.Supreviser.</i>\"");
        outputText("\n\nThe angel starts to burn more and more intense causing you to temporaly avert your gaze. When you look agian at spot it was you could only see a bit of ashes.");
        gems = 0;
        XP = 0;
        HP = minHP() - 1;
        SceneLib.combat.cleanupAfterCombatImpl();
    }
    
    private function AngelEnergyRays() : Void
    {
        outputText("Angel fixates you with all of its eyes unleashing a barrage of rays at you! ");
        var omni : Float = 6;
        if (hasStatusEffect(StatusEffects.TrueFormAngel))
        {
            omni *= 5;
        }
        while (omni-- > 0)
        {
            AngelEnergyRaysD();
        }
        outputText("\n\n");
    }
    private function AngelEnergyRaysD() : Void
    {
        var damage : Float = eBaseWisdomDamage() * 0.75;
        damage += eBaseIntelligenceDamage() * 0.15;
        damage = Math.round(damage);
        damage = player.takeMagicDamage(damage, true);
    }
    
    private function AngelBaseAttack() : Void
    {
        outputText("Angel gather energy and then blasts it toward you. ");
        var damage : Float = eBaseWisdomDamage() * 0.5;
        damage += eBaseIntelligenceDamage() * 0.1;
        damage = Math.round(damage);
        damage = player.takeMagicDamage(damage, true);
        outputText("\n\n");
    }
    
    override private function performCombatAction() : Void
    {
        if (hasStatusEffect(StatusEffects.TrueFormAngel))
        {
            if (!hasStatusEffect(StatusEffects.TranscendentSoulField) && soulforce >= 10)
            {
                createStatusEffect(StatusEffects.TranscendentSoulField, 10, 10, 0, 0);
            }
            if (hasStatusEffect(StatusEffects.TranscendentSoulField))
            {
                if (soulforce >= 10)
                {
                    soulforce -= 10;
                }
                else
                {
                    removeStatusEffect(StatusEffects.TranscendentSoulField);
                }
            }
        }
        else
        {
            if (!hasStatusEffect(StatusEffects.TranscendentSoulField) && soulforce >= 5)
            {
                createStatusEffect(StatusEffects.TranscendentSoulField, 5, 5, 0, 0);
            }
            if (hasStatusEffect(StatusEffects.TranscendentSoulField))
            {
                if (soulforce >= 5)
                {
                    soulforce -= 5;
                }
                else
                {
                    removeStatusEffect(StatusEffects.TranscendentSoulField);
                }
            }
        }
        var choice : Float = rand(5);
        if (choice == 0)
        {
            AngelEnergyRays();
        }
        if (choice > 0)
        {
            AngelBaseAttack();
        }
    }
    
    private function angelification() : Void
    {
        clearOutput();
        var TB : Float = Math.round(touStat.core.value * 0.2);
        var SB : Float = Math.round(speStat.core.value * 0.1);
        var WB : Float = Math.round(wisStat.core.value * 0.3);
        touStat.core.value += TB;
        speStat.core.value += SB;
        wisStat.core.value += WB;
        createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
        addPerkValue(PerkLib.DieHardHP, 1, 9);
        addStatusValue(StatusEffects.TranscendentSoulField, 1, 5);
        addStatusValue(StatusEffects.TranscendentSoulField, 2, 5);
        HP = maxHP();
        bonusWrath += 300;
        bonusSoulforce += 600;
        outputText("Staggering back, Angel wastes no time and above it head starts to manifest sort of halo. All irises become uniform purple colored. And around it body manifest four crossed circles with two pairs of eyes looking exactly the same as main eye down to each detail including dual irises.\n"
                + "\"<i>Don't be afraid!!!</i>\" it whispers loud enough for you to hear before launching up to continue the fight.");
        createStatusEffect(StatusEffects.TrueFormAngel, 0, 0, 0, 0);
        SceneLib.combat.combatRoundOver();
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        if (hpVictory)
        {
            if (!hasStatusEffect(StatusEffects.TrueFormAngel))
            {
                angelification();
                return;
            }
            cleanupAfterCombat();
        }
        else
        {
            angelReactsToLustiness();
        }
    }
    
    override private function get_long() : String
    {
        var str : String = "You're currently fighting high-rank angel. It's looks like winged eyeball with small mouth full of jagged teeth and three eyes having two";
        if (hasStatusEffect(StatusEffects.TrueFormAngel))
        {
            str += " purple irises each. Around it body are four circles each with two pairs of eyes looking the same as the main eye and above head hoover halo.";
        }
        else
        {
            str += " irises each, one red and the other blue.";
        }
        if (hasStatusEffect(StatusEffects.TranscendentSoulField))
        {
            str += "\n\n<i>From time to time you can notice faint glimmers of orange protective field surrounding it.";
            if (hasStatusEffect(StatusEffects.TrueFormAngel))
            {
                str += " After your attacks it take octagonal shapes for a brief moment.";
            }
            str += "</i>";
        }
        return str;
    }
    
    public function new()
    {
        super(false);
        this.a = "the ";
        this.short = "high-rank angel";
        this.imageName = "angel";
        this.long = "";
        initStrTouSpeInte(7, 80, 40, 20);
        initWisLibSensCor(160, 4, 30, -100);
        this.tallness = 30;
        this.drop = NO_DROP;
        this.level = 18;
        this.bonusHP = 600;
        this.bonusLust = 49;
        this.bonusWrath = 150;
        this.bonusSoulforce = 300;
        this.additionalXP = 90;
        this.weaponName = "energy blast";
        this.weaponVerb = "shoot";
        this.weaponAttack = 6;
        this.armorName = "skin";
        this.armorDef = 18;
        this.armorMDef = 18;
        this.wings.type = Wings.FEATHERED_AVIAN;
        if (player.cor < 67)
        {
            this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 9, 0, 0, 0);
        }
        this.createStatusEffect(StatusEffects.TranscendentSoulField, 5, 5, 0, 0);  //X times less dmg, +X lvl diff bonus  
        this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
        this.createPerk(PerkLib.DieHardHP, 9, 0, 0, 0);
        checkMonster();
    }
}


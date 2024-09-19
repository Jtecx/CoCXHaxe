package classes.scenes.combat.spellsBlack;

import classes.globalFlags.KFLAGS;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.areas.mountain.WormMass;
import classes.scenes.combat.AbstractBlackSpell;
import classes.scenes.nPCs.Zenji;
import classes.StatusEffects;

class WaveOfEcstasySpell extends AbstractBlackSpell
{
    public function new()
    {
        super("Wave of Ecstasy", 
                "The arouse spell draws on your own inner lust in order to enflame the enemies passions.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_LUSTDMG, TAG_AOE, TAG_TIER1]
        );
        baseManaCost = 100;
    }
    
    override private function get_buttonName() : String
    {
        return "WaveOfEcstasy";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsWaveOfEcstasy);
    }
    
    override public function calcCooldown() : Int
    {
        return spellBlackCooldown();
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(target, false, false)) + " lust damage";
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        return adjustLustDamage(
                (scalingBonusIntelligence() + scalingBonusLibido()), 
                monster, 
                CAT_SPELL_BLACK, 
                randomize
        );
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You almost moan in pleasure as you draw on this spell, sending forth your lust like a shockwave. ");
            if (player.perkv1(PerkLib.ImpNobility) > 0)
            {
                outputText("Your imp cohorts assist your spellcasting, adding their diagrams to your own.  ");
            }
        }
        if (Std.is(monster, WormMass))
        {
            if (display)
            {
                outputText("The worms appear to be unaffected by your magic!\n\n");
            }
            return;
        }
        else if (Std.is(monster, Zenji))
        {
            if (monster.short == "Zenji")
            {
                outputText("\nZenji shakes off the effects of the spell.\n\n");
                outputText("\n\"<i>Gonna have ta do more dan dat ta break me.</i>\"\n\n");
            }
            else if (flags[kFLAGS.ZENJI_PROGRESS] == 2)
            {
                outputText("\nThe troll shakes off the effects of the spell, \"<i>I. Will. Not. Break.</i>\"\n\n");
            }
            else
            {
                outputText("\nThe troll shakes off the effects of the spell.\n\n");
                outputText("\n\"<i>Gonna have ta do more dan dat ta break me.</i>\"\n\n");
            }
            return;
        }
        else if (monster.lustVuln == 0)
        {
            if (display)
            {
                outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
            }
            return;
        }
        var lustDmg : Float = calcDamage(monster, true, true);
        if (display)
        {
            if (monster.plural)
            {
                outputText("Arousal breaks in the eyes of your many opponents as pleasure strikes them");
            }
            else
            {
                outputText("Unable to evade it [themonster] is struck squarely by the pleasure wave");
            }
        }
        
        var resultArray : Array<Dynamic> = critAndRepeatLust(display, lustDmg, CAT_SPELL_BLACK);
        if (!monster.hasPerk(PerkLib.Resolute))
        {
            monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
        }
        postLustSpellEffect(resultArray[1]);
    }
}


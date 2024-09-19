package classes.scenes.combat.spellsWhite;

import classes.PerkLib;
import classes.scenes.combat.AbstractWhiteSpell;
import classes.scenes.combat.Combat;
import classes.StatusEffects;

class HealSpell extends AbstractWhiteSpell
{
    public function new()
    {
        super(
                "Heal", 
                "Heal will attempt to use white magic to instantly close your wounds and restore your body.", 
                TARGET_SELF, 
                TIMING_INSTANT, 
                [TAG_HEALING]
        );
        baseManaCost = 30;
        useManaType = Combat.USEMANA_WHITE_HEAL;
        isBloodMagicApplicable = false;
        isLastResortApplicable = false;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsHeal);
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 3;
        calcC += spellGenericCooldown();
        if (player.weapon == weapons.U_STAFF)
        {
            calcC -= 2;
        }
        return calcC;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You chant a magical song of healing and recovery and your wounds start knitting themselves shut in response. ");
        }
        var heal : Float = 0;
        heal += scalingBonusIntelligence();
        if (player.hasPerk(PerkLib.WisenedHealer))
        {
            heal += scalingBonusWisdom();
        }
        heal *= healModWhite();
        if (player.armor == armors.NURSECL)
        {
            heal *= 1.2;
        }
        if (player.weapon == weapons.U_STAFF)
        {
            heal *= 1.5;
        }
        if (player.weapon == weapons.ECLIPSE)
        {
            heal *= 0.5;
        }
        if (player.weapon == weapons.OCCULUS)
        {
            heal *= 1.5;
        }
        if (player.hasPerk(PerkLib.CloseToDeath) && player.HP < (player.maxHP() * 0.25))
        {
            if (player.hasPerk(PerkLib.CheatDeath) && player.HP < (player.maxHP() * 0.1))
            {
                heal *= 2.5;
            }
            else
            {
                heal *= 1.5;
            }
        }
        //Determine if critical heal!
        var crit : Bool = false;
        var critHeal : Int = 5;
        critHeal += combatMagicalCritical();
        if (rand(100) < critHeal)
        {
            crit = true;
            heal *= 1.75;
        }
        heal = Math.round(heal);
        if (player.hasStatusEffect(StatusEffects.CombatWounds))
        {
            if (player.statusEffectv1(StatusEffects.CombatWounds) > 0.03)
            {
                player.addStatusValue(StatusEffects.CombatWounds, 1, -0.03);
            }
            else
            {
                player.removeStatusEffect(StatusEffects.CombatWounds);
            }
        }
        outputText("<b>([font-heal]+" + heal + "[/font])</b>.");
        if (crit)
        {
            outputText(" <b>*Critical Heal!*</b>");
        }
        HPChange(heal, false);
    }
}


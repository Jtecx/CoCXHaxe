package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.races.ElementalRace;

class FusionSpecialTrueEvasionSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "True Evasion", 
                "Become one with the wind, temporarily preventing damage.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF, TAG_MAGICAL, TAG_TIER2, TAG_WIND], 
                PerkLib.ElementalBody
        );
        baseSFCost = 400;
    }
    
    override private function get_isKnown() : Bool
    {
        return super.isKnown && ElementalRace.getElement(player) == ElementalRace.ELEMENT_SYLPH && player.statusEffectv2(StatusEffects.SummonedElementalsAirE) >= 5;
    }
    
    override public function calcCooldown() : Int
    {
        return 10;
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Become invulnerable for " + calcDuration() + "rounds.";
    }
    
    override public function sfCost() : Int
    {
        return sfCostMod(baseSFCost);
    }
    
    override public function calcDuration() : Int
    {
        return 3;
    }
    
    override public function durationEnd(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("<b>True Evasion effect ended!</b>\n\n");
        }
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        clearOutput();
        if (display)
        {
            outputText("You disperse with the ambient air letting things run through you rather than blocking them. Good fucking luck to whoever would want to strike you right now.\n\n");
        }
        setDuration();
    }
}

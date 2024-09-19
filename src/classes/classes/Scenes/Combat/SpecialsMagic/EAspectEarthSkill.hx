package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;

class EAspectEarthSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Elemental Aspect: Earth", 
                "Creates an Earth armor around the player, increasing armor and magic resistance for a few turns.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF, TAG_EARTH, TAG_TIER2], 
                StatusEffects.SummonedElementalsEarth
        );
    }
    
    override public function calcCooldown() : Int
    {
        return -1;
    }
    
    override public function calcDuration() : Int
    {
        return as3hx.Compat.parseInt(elementalAspectBaseDuration(StatusEffects.SummonedElementalsEarth) + combat.magic.perkRelatedDurationBoosting());
    }
    
    override private function get_buttonName() : String
    {
        return "Earth E.Asp";
    }
    
    private function costMultiplier() : Float
    {
        var spellMightMultiplier : Float = 1;
        if (player.hasPerk(PerkLib.EverLastingBuffs))
        {
            spellMightMultiplier *= 2;
        }
        if (player.hasPerk(PerkLib.EternalyLastingBuffs))
        {
            spellMightMultiplier *= 2;
        }
        return spellMightMultiplier;
    }
    
    override public function manaCost() : Float
    {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsCorruption) * costMultiplier();
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Increases physical and magical resistance by " + numberFormat(getBonus()) + " for " + calcDuration() + " rounds";
    }
    
    /**
     * Returns the bonus of this ability grants to physical and magical resistance
     * @return stoneskinbonus (Number) - ability defense bonus
     */
    public function getBonus() : Float
    {
        var stoneskinbonus : Float = 0;
        stoneskinbonus += player.inte * 0.5;
        stoneskinbonus += player.wis * 0.5;
        return Math.round(stoneskinbonus);
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("Your elemental lifts stone and dirt from the ground, encasing you in a earthen shell stronger than any armor.\n\n");
        }
        setDuration();
    }
    
    override public function durationEnd(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("<b>Stone Skin effect wore off!</b>\n\n");
        }
    }
}

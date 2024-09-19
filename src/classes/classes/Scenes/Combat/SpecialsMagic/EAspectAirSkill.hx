package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;

class EAspectAirSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Elemental Aspect: Air", 
                "Creates a Wind Wall that deflects incoming projectiles for a few turns. Each attack blocked lowers duration by one round", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF, TAG_WIND, TAG_TIER2], 
                StatusEffects.SummonedElementalsAir
        );
    }
    
    override public function calcCooldown() : Int
    {
        return -1;
    }
    
    override public function calcDuration() : Int
    {
        return as3hx.Compat.parseInt(elementalAspectBaseDuration(StatusEffects.SummonedElementalsAir) + combat.magic.perkRelatedDurationBoosting());
    }
    
    override public function manaCost() : Float
    {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsAir) * costMultiplier();
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
    
    override private function get_buttonName() : String
    {
        return "Air E.Asp";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Blocks certain projectile attacks for " + calcDuration() + " rounds";
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You call on your elemental projecting a air wall between you and [themonster] to deflect incoming projectiles.\n\n");
        }
        setDuration();
    }
    
    override public function durationEnd(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("<b>Wind Wall effect wore off!</b>\n\n");
        }
    }
}

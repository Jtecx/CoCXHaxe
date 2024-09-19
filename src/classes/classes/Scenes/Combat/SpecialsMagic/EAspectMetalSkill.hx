package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;

class EAspectMetalSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Elemental Aspect: Metal", 
                "Increases the player's unarmed damage for a few turns.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF, TAG_TIER2], 
                StatusEffects.SummonedElementalsMetal
        );
    }
    
    override public function calcCooldown() : Int
    {
        return -1;
    }
    
    override public function calcDuration() : Int
    {
        return as3hx.Compat.parseInt(elementalAspectBaseDuration(StatusEffects.SummonedElementalsMetal) + combat.magic.perkRelatedDurationBoosting());
    }
    
    override private function get_buttonName() : String
    {
        return "Metal E.Asp";
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
        return elementalAspectManaCost(StatusEffects.SummonedElementalsMetal) * costMultiplier();
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Increases unarmed damage by " + numberFormat(getBonus()) + " for " + calcDuration() + " rounds";
    }
    
    /**
     * Returns the bonus of this ability grants to unarmed attack
     * @return unarmedBonus (Number) - unarmed attack bonus
     */
    public function getBonus() : Float
    {
        var metalskinbonus : Float = 4;
        if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 6)
        {
            metalskinbonus += 2;
        }
        if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 11)
        {
            metalskinbonus += 2;
        }
        if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 16)
        {
            metalskinbonus += 2;
        }
        if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 21)
        {
            metalskinbonus += 2;
        }
        return metalskinbonus * player.statusEffectv2(StatusEffects.SummonedElementalsMetal) * (1 + player.newGamePlusMod());
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("Your elemental encases your body into a layer of flexible yet solid steel. The metal gives strength to your frame, empowering your unarmed strikes.\n\n");
        }
        setDuration();
    }
    
    override public function durationEnd(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("<b>Metal Skin effect wore off!</b>\n\n");
        }
    }
}

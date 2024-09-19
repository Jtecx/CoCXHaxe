package classes.scenes.combat.spellsBlood;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBloodSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class LifestealEnchantmentSpell extends AbstractBloodSpell
{
    public function new()
    {
        super(
                "Lifesteal Enchantment", 
                "Lifesteal Enchantment will add lifesteal effect to your weapons.  ", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF]
        );
        baseHpCost = 500;
        inflictBleed = false;
    }
    
    override private function get_buttonName() : String
    {
        return "LifestealEnch";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Duration: " + numberOfThings(calcDuration(), "round");
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsLifestealEnchantment);
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.LifestealEnchantment);
    }
    
    override public function calcDuration() : Int
    {
        var calcD : Int = 2;
        calcD += as3hx.Compat.parseInt(3 - spellGenericCooldown());
        if (player.hasPerk(PerkLib.BloodDemonIntelligence))
        {
            calcD *= 2;
        }
        return calcD;
    }
    
    override public function advance(display : Bool) : Void
    {
        if (player.statusEffectv1(StatusEffects.LifestealEnchantment) <= 0)
        {
            player.removeStatusEffect(StatusEffects.LifestealEnchantment);
        }
        else
        {
            player.addStatusValue(StatusEffects.LifestealEnchantment, 1, -1);
        }
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + ((player.HP < player.maxOverHP()) ? "wounds" : "skin pores") + ". Blood starts to gather around weapons, adding a crimson glow.");
        }
        player.createStatusEffect(StatusEffects.LifestealEnchantment, calcDuration(), 0, 0, 0);
    }
}


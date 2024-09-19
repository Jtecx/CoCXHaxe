package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;

class EAspectWoodSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Elemental Aspect: Wood", 
                "Heals the player by a minor amount. Grants a minor increase to armor / magic resistance for a few turns.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF, TAG_TIER2], 
                StatusEffects.SummonedElementalsWood
        );
    }
    
    override public function calcCooldown() : Int
    {
        return -1;
    }
    
    override public function calcDuration() : Int
    {
        return as3hx.Compat.parseInt(elementalAspectBaseDuration(StatusEffects.SummonedElementalsWood) + combat.magic.perkRelatedDurationBoosting());
    }
    
    override private function get_buttonName() : String
    {
        return "Wood E.Asp";
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
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Increases physical and magical resistance by " + numberFormat(getBonus()) + " for " + calcDuration() + " rounds. Heals the player for " + numberFormat(calcDamage(monster)) + " HP.";
    }
    
    /**
     * Returns the bonus of this ability grants to physical and magical resistance
     * @return stoneskinbonus (Number) - ability defense bonus
     */
    public function getBonus() : Float
    {
        var barkskinbonus : Float = 0;
        barkskinbonus += player.inte * 0.25;
        barkskinbonus += player.wis * 0.25;
        return Math.round(barkskinbonus);
    }
    
    override public function manaCost() : Float
    {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsWood) * costMultiplier();
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var amountToHeal : Float = elementalAspectBaseDamage(StatusEffects.SummonedElementalsWood, 0, true);
        
        if (player.hasPerk(PerkLib.WisenedHealer))
        {
            amountToHeal += (scalingBonusWisdom() / 2);
        }
        if (player.armor == armors.NURSECL)
        {
            amountToHeal *= 1.2;
        }
        if (player.weapon == weapons.U_STAFF)
        {
            amountToHeal *= 1.5;
        }
        if (player.weapon == weapons.ECLIPSE)
        {
            amountToHeal *= 0.5;
        }
        if (player.weapon == weapons.OCCULUS)
        {
            amountToHeal *= 1.5;
        }
        if (player.hasPerk(PerkLib.CloseToDeath) && player.HP < (player.maxHP() * 0.25))
        {
            if (player.hasPerk(PerkLib.CheatDeath) && player.HP < (player.maxHP() * 0.1))
            {
                amountToHeal *= 2.5;
            }
            else
            {
                amountToHeal *= 1.5;
            }
        }
        
        return amountToHeal;
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        var amountToHeal : Float = Math.round(calcDamage(monster));
        if (display)
        {
            outputText("Your elemental temporarily covers your skin with bark, shielding you against strikes. This is the bark of medicinal plants and as such you recover from your injuries. <b>([font-heal]+" + numberFormat(amountToHeal) + "[/font])</b>");
        }
        HPChange(amountToHeal, false);
        if (display)
        {
            outputText("\n\n");
        }
        setDuration();
    }
    
    override public function durationEnd(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("<b>Bark Skin effect wore off!</b>\n\n");
        }
    }
}

package classes.scenes.combat.spellsWhite;

import classes.PerkLib;
import classes.scenes.combat.AbstractWhiteSpell;
import classes.scenes.combat.CombatAbilities;
import classes.StatusEffects;

class ChargeRangeWeaponSpell extends AbstractWhiteSpell
{
    public function new()
    {
        super(
                "Charge Range Weapon", 
                "The Charge Range Weapon spell will surround your ranged weapons in magical energy, causing them to do even more damage.  The effect lasts for a few combat turns.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF]
        );
        baseManaCost = 60;
    }
    
    override private function get_buttonName() : String
    {
        return "Charge RW.";
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.ChargeRWeapon);
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsChargeR);
    }
    
    override public function manaCost() : Float
    {
        return super.manaCost() * costMultiplier();
    }
    
    override public function advance(display : Bool) : Void
    {
        if (player.statusEffectv2(StatusEffects.ChargeRWeapon) <= 0)
        {
            player.removeStatusEffect(StatusEffects.ChargeRWeapon);
            if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx) && player.mana >= CombatAbilities.ChargeRWeapon.manaCost())
            {
                CombatAbilities.ChargeRWeapon.autocast();
            }
            else if (display)
            {
                outputText("<b>Charged Range Weapon effect wore off!</b>\n\n");
            }
        }
        else if (!player.hasPerk(PerkLib.PureMagic))
        {
            player.addStatusValue(StatusEffects.ChargeRWeapon, 2, -1);
        }
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (player.weaponRangeName == "nothing")
        {
            return "Charge range weapon can't be casted without any range weapon.";
        }
        
        return "";
    }
    
    private function weaponSizeBoost() : Float
    {
        var ab12r : Float = 1;
        if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow" || player.weaponRangePerk == "Rifle")
        {
            ab12r *= 2;
        }
        if (player.weaponRangePerk == "Throwing")
        {
            ab12r *= 2.5;
        }
        if (player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms")
        {
            ab12r *= 3;
        }
        if (player.weaponRangePerk == "Dual 2H Firearm")
        {
            ab12r *= 5;
        }
        return ab12r;
    }
    private function weaponSizeManaCost() : Float
    {
        var ba21r : Float = 1;
        if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow" || player.weaponRangePerk == "Rifle")
        {
            ba21r *= 2;
        }
        if (player.weaponRangePerk == "Throwing")
        {
            ba21r *= 2.5;
        }
        if (player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms")
        {
            ba21r *= 3;
        }
        if (player.weaponRangePerk == "Dual 2H Firearm")
        {
            ba21r *= 5;
        }
        return ba21r;
    }
    
    
    private function costMultiplier() : Float
    {
        var spellChargeRangeWeaponMultiplier : Float = 1;
        spellChargeRangeWeaponMultiplier *= weaponSizeManaCost();
        if (player.hasStatusEffect(StatusEffects.SiegweirdTraining))
        {
            spellChargeRangeWeaponMultiplier *= 0.5;
        }
        if (player.hasPerk(PerkLib.EverLastingBuffs))
        {
            spellChargeRangeWeaponMultiplier *= 2;
        }
        if (player.hasPerk(PerkLib.EternalyLastingBuffs))
        {
            spellChargeRangeWeaponMultiplier *= 2;
        }
        if (player.hasPerk(PerkLib.SelfbuffsProficiencySu))
        {
            spellChargeRangeWeaponMultiplier *= 2;
        }
        return spellChargeRangeWeaponMultiplier;
    }
    
    override private function doSpellEffect(output : Bool = true) : Void
    {
        var ChargeRangeWeaponBoostCap : Float = 4;
        var ChargeRangeWeaponBoost : Float = 5;
        if (player.hasPerk(PerkLib.SelfbuffsProficiency))
        {
            var capB : Float = 1.2;
            if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx))
            {
                capB += 0.8;
            }
            if (player.hasPerk(PerkLib.SelfbuffsProficiencySu))
            {
                capB *= 5;
            }
            ChargeRangeWeaponBoostCap *= capB;
        }
        ChargeRangeWeaponBoostCap *= ChargeRangeWeaponBoost;
        if (player.hasPerk(PerkLib.DivineArmament))
        {
            ChargeRangeWeaponBoostCap *= 2;
            ChargeRangeWeaponBoost *= 2;
        }
        //ChargeRangeWeaponBoost += Math.round(player.intStat.max * 0.1); - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells (maybe only when they have a perk from the prestige job: magus/warlock/another related to spells)
        if (player.hasPerk(PerkLib.JobEnchanter))
        {
            ChargeRangeWeaponBoost *= 1.2;
        }
        ChargeRangeWeaponBoost *= spellModWhite();
        //ChargeRangeWeaponBoost = FnHelpers.FN.logScale(ChargeRangeWeaponBoost,ChargeWeaponABC,10);
        if (ChargeRangeWeaponBoost > ChargeRangeWeaponBoostCap)
        {
            ChargeRangeWeaponBoost = ChargeRangeWeaponBoostCap;
        }
        ChargeRangeWeaponBoost *= weaponSizeBoost();
        ChargeRangeWeaponBoost = Math.round(ChargeRangeWeaponBoost);
        var ChargeRangeWeaponDuration : Float = 5;
        ChargeRangeWeaponDuration += combat.magic.perkRelatedDurationBoosting();
        
        if (output)
        {
            outputText("You whisper the brief spell, the words of power cause mana to pour into your weapon as sparks of electricity burst into being. A halo of lightning hums, swirling around your [weaponrange] with a steady charge. Your ammunition crackles with hints of a magical charge as you prepare to fire, allowing your shots to deal more damage.");
        }
        player.createStatusEffect(StatusEffects.ChargeRWeapon, ChargeRangeWeaponBoost, ChargeRangeWeaponDuration, 0, 0);
    }
}


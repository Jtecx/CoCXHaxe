package classes.scenes.combat.spellsWhite;

import classes.PerkLib;
import classes.scenes.combat.AbstractWhiteSpell;
import classes.scenes.combat.CombatAbilities;
import classes.StatusEffects;

class ChargeArmorSpell extends AbstractWhiteSpell
{
    public function new()
    {
        super(
                "Charge Armor", 
                "The Charge Armor spell will surround your armor with magical energy, causing it to provide additional protection.  The effect lasts for a few combat turns.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF]
        );
        baseManaCost = 40;
    }
    
    
    override private function get_buttonName() : String
    {
        return "Charge A.";
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.ChargeArmor);
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsChargeA);
    }
    
    override public function manaCost() : Float
    {
        return super.manaCost() * costMultiplier();
    }
    
    override public function advance(display : Bool) : Void
    {
        if (player.hasStatusEffect(StatusEffects.ChargeArmor))
        {
            if (player.statusEffectv2(StatusEffects.ChargeArmor) <= 0)
            {
                player.removeStatusEffect(StatusEffects.ChargeArmor);
                if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx) && player.mana >= CombatAbilities.ChargeArmor.manaCost())
                {
                    CombatAbilities.ChargeArmor.autocast();
                }
                else if (display)
                {
                    outputText("<b>Charged Armor effect wore off!</b>\n\n");
                }
            }
            else if (!player.hasPerk(PerkLib.PureMagic))
            {
                player.addStatusValue(StatusEffects.ChargeArmor, 2, -1);
            }
        }
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (player.isNaked() && (!player.haveNaturalArmor() || player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)))
        {
            return "Charge armor can't be casted without wearing any armor or even underwear.";
        }
        
        return "";
    }
    
    private function armorTypeMultiplier() : Float
    {
        var a12b : Float = 1;
        if (player.armorPerk == "Medium")
        {
            a12b *= 2;
        }
        if (player.isInHeavyArmor())
        {
            a12b *= 3;
        }
        if (player.armorPerk == "Light Ayo")
        {
            a12b *= 4;
        }
        if (player.armorPerk == "Heavy Ayo")
        {
            a12b *= 5;
        }
        if (player.armorPerk == "Ultra Heavy Ayo")
        {
            a12b *= 7.5;
        }
        return a12b;
    }
    
    private function costMultiplier() : Float
    {
        var spellChargeArmorMultiplier : Float = 1;
        spellChargeArmorMultiplier *= armorTypeMultiplier();
        if (player.hasStatusEffect(StatusEffects.SiegweirdTraining))
        {
            spellChargeArmorMultiplier *= 0.5;
        }
        if (player.hasPerk(PerkLib.EverLastingBuffs))
        {
            spellChargeArmorMultiplier *= 2;
        }
        if (player.hasPerk(PerkLib.EternalyLastingBuffs))
        {
            spellChargeArmorMultiplier *= 2;
        }
        if (player.hasPerk(PerkLib.SelfbuffsProficiencySu))
        {
            spellChargeArmorMultiplier *= 2;
        }
        return spellChargeArmorMultiplier;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        var ChargeArmorBoostCap : Float = 4;
        var ChargeArmorBoost : Float = 5;
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
            ChargeArmorBoostCap *= capB;
        }
        ChargeArmorBoostCap *= ChargeArmorBoost;
        if (player.hasPerk(PerkLib.DivineArmament))
        {
            ChargeArmorBoostCap *= 2;
            ChargeArmorBoost *= 2;
        }
        //ChargeArmorBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells (maybe only if they have a perk from the prestige job: magus/warlock/another related to spells)
        if (player.hasPerk(PerkLib.JobEnchanter))
        {
            ChargeArmorBoost *= 1.2;
        }
        ChargeArmorBoost *= spellModWhite();
        //ChargeArmorBoost = FnHelpers.FN.logScale(ChargeArmorBoost,ChargeArmorABC,10);
        if (ChargeArmorBoost > ChargeArmorBoostCap)
        {
            ChargeArmorBoost = ChargeArmorBoostCap;
        }
        ChargeArmorBoost *= armorTypeMultiplier();
        ChargeArmorBoost = Math.round(ChargeArmorBoost);
        var ChargeArmorDuration : Float = 5;
        ChargeArmorDuration += combat.magic.perkRelatedDurationBoosting();
        if (display)
        {
            outputText("You utter the words of power, summoning an electrical charge around your");
            if (player.isNaked() && player.haveNaturalArmor() && player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor))
            {
                outputText(" natural armor.");
            }
            else
            {
                outputText(" [armor].");
            }
            outputText("  The electricity crackles stubbornly with a magical current, ensuring to protect you from even the fiercest blows.");
        }
        player.createStatusEffect(StatusEffects.ChargeArmor, ChargeArmorBoost, ChargeArmorDuration, 0, 0);
    }
}


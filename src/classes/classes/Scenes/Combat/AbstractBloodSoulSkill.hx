package classes.scenes.combat;

import classes.StatusEffectType;
import classes.StatusEffects;
import classes.PerkLib;
import classes.globalFlags.KFLAGS;

class AbstractBloodSoulSkill extends AbstractSoulSkill
{
    private var sfInfusion : Bool;
    
    public function new(
            name : String,
            desc : String,
            targetType : Int,
            timingType : Int,
            tags : Array<Dynamic>,
            knownCondition : Dynamic,
            canUseBlood : Bool = true,
            sfInfusion : Bool = false)
    {
        super(name, desc, targetType, timingType, tags, knownCondition, canUseBlood);
        this.sfInfusion = sfInfusion;
    }
    
    override private function get_category() : Int
    {
        return CAT_BLOOD_SOULSKILL;
    }
    
    override private function usabilityCheck() : String
    //Soulforce check will be handled in this class instead of AbstractSoulForce
    {
        
        var uc : String = super.usabilityCheck();
        if (uc != null && uc != "Your current soulforce is too low.")
        {
            return uc;
        }
        
        if (monster.hasStatusEffect(StatusEffects.Dig))
        {
            return "You can only use buff soulskills while underground.";
        }
        
        if (sfInfusion && (player.soulforce < sfCost()) && (!player.hasStatusEffect(StatusEffects.BloodCultivator) || !canUseBlood))
        {
            return "Your current soulforce is too low.";
        }
        
        if (combat.isEnemyInvisible)
        {
            return "You cannot use offensive soulskills against an opponent you cannot see or target.";
        }
        
        if (player.isGargoyle())
        {
            return "You cannot use blood soulskills if you don't have blood at all.";
        }
        
        return "";
    }
    
    override public function sfCost() : Int
    {
        return spellCostBlood(baseSFCost);
    }
    
    override public function costDescription() : Array<Dynamic>
    {
        var costs : Array<Dynamic> = super.costDescription();
        //Remove addition from Abstract soulSkill Implementation
        if (sfCost() > 0)
        {
            costs = costs.filter(function(cost : String, index : Int, array : Array<Dynamic>) : Bool
                            {
                                return cost.indexOf("Soulforce Cost:") != 0;
                            });
            if (sfInfusion)
            {
                costs.push("Soulforce Cost: " + super.sfCost());
            }
            costs.push("Blood Cost: " + sfCost());
        }
        return costs;
    }
    
    override public function useResources() : Void
    //Set last attack type for Blood Soulskill
    {
        
        if (lastAttackType != 0)
        {
            flags[kFLAGS.LAST_ATTACK_TYPE] = lastAttackType;
        }
        
        HPChange(-sfCost(), false);
        
        if (sfInfusion)
        {
            player.soulforce -= super.sfCost();
        }
    }
    
    //Used to specifiy the base name of the blood soulskill, which will be a suffix added for the SF version
    private function baseName() : String
    {
        return "";
    }
    
    override private function get_buttonName() : String
    {
        return baseName() + ((sfInfusion) ? " (SF)" : "");
    }
    
    private function bloodSoulSkillCoolDown(baseCooldown : Int) : Int
    {
        var cooldown : Int = baseCooldown;
        if (sfInfusion)
        {
            cooldown += 1;
        }
        return cooldown;
    }
    
    private function bloodPuppiesDamageBonusMod() : Int
    {
        var mod : Int = 1;
        
        if (player.hasPerk(PerkLib.YourPainMyPower))
        {
            mod += 1;
        }
        if (player.hasPerk(PerkLib.BloodDemonIntelligence))
        {
            mod += 2;
        }
        
        return mod;
    }
}

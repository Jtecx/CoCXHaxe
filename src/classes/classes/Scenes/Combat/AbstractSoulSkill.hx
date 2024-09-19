package classes.scenes.combat;

import classes.globalFlags.KFLAGS;
import classes.StatusEffectType;
import classes.StatusEffects;
import classes.PerkLib;
import classes.iMutations.IMutationsLib;
import classes.PerkType;

class AbstractSoulSkill extends CombatAbility
{
    private var knownCondition : Dynamic;
    private var canUseBlood : Bool;
    
    public function new(
            name : String,
            desc : String,
            targetType : Int,
            timingType : Int,
            tags : Array<Dynamic>,
            knownCondition : Dynamic,
            canUseBlood : Bool = true)
    {
        super(name, desc, targetType, timingType, tags);
        this.knownCondition = knownCondition;
        this.canUseBlood = canUseBlood;
    }
    
    override private function get_category() : Int
    {
        return CAT_SOULSKILL;
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if ((player.soulforce < sfCost()) && (!player.hasStatusEffect(StatusEffects.BloodCultivator) || !canUseBlood))
        {
            return "Your current soulforce is too low.";
        }
        
        if (canUseBlood && player.hasStatusEffect(StatusEffects.BloodCultivator) && ((player.HP - player.minHP()) - 1) < (sfCost()))
        {
            return "Your hp is too low to use this soulskill.";
        }
        
        return "";
    }
    
    override public function sfCost() : Int
    {
        var soulforcecost : Float = baseSFCost * soulskillCost() * soulskillcostmulti();
        return Math.round(soulforcecost);
    }
    
    override private function get_isKnown() : Bool
    {
        if (Std.is(knownCondition, StatusEffectType))
        {
            return player.hasStatusEffect(knownCondition);
        }
        if (Std.is(knownCondition, PerkType))
        {
            return player.hasPerk(knownCondition);
        }
        return false;
    }
    
    override public function useResources() : Void
    {
        super.useResources();
        if (player.hasStatusEffect(StatusEffects.BloodCultivator) && canUseBlood)
        {
            player.takePhysDamage(sfCost());
        }
        else
        {
            player.soulforce -= sfCost();
        }
    }
    
    private function display() : String
    {
        return "";
    }
    
    
    private function anubiHeartLeeching(dmg : Float) : Void
    {
        flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] = 1;
        var leech : Float = dmg;
        var leechCap : Float = 0.1;
        if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5))
        {
            leechCap *= 2;
            leech *= 0.2;
        }
        else
        {
            leech *= 0.1;
        }
        leech = Math.round(leech);
        if (leech > Math.round(player.maxHP() * leechCap))
        {
            leech = Math.round(player.maxHP() * leechCap);
        }
        HPChange(leech, false);
    }
    
    private function monsterDodgeSkill(skillName : String, display : Bool = true, hitModifier : Int = 0) : Bool
    {
        if (((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe, hitModifier))) && !monster.monsterIsStunned())
        {
            if ((monster.spe - player.spe < 8) && display)
            {
                outputText("[Themonster] narrowly avoids your " + skillName + "!\n\n");
            }
            else if ((monster.spe - player.spe < 20) && display)
            {
                outputText("[Themonster] dodges your " + skillName + " with superior quickness!\n\n");
            }
            else if (display)
            {
                outputText("[Themonster] deftly avoids your slow " + skillName + ".\n\n");
            }
            return true;
        }
        return false;
    }
    
    private function endTurnBySpecialHit(damage : Float, display : Bool = true) : Void
    {
        checkAchievementDamage(damage);
        if (display)
        {
            outputText("\n\n");
        }
        combat.WrathGenerationPerHit2(5);
        if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0)
        {
            anubiHeartLeeching(damage);
        }
        combat.heroBaneProc(damage);
        combat.EruptingRiposte();
    }
    
    private function endTurnByBloodSkillUse(damage : Float, display : Bool = true, endOfTurn : Bool = true) : Void
    {
        if (rand(20) < 4 && !monster.isImmuneToBleed())
        {
            if (monster.hasStatusEffect(StatusEffects.Hemorrhage))
            {
                monster.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
            }
            else
            {
                monster.createStatusEffect(StatusEffects.Hemorrhage, 2, 0.05, 0, 0);
            }
            if (display)
            {
                outputText(" The attack leaves many bloody gashes.");
            }
        }
        if (display)
        {
            outputText("\n\n");
        }
        
        if (endOfTurn)
        {
            checkAchievementDamage(damage);
            combat.WrathGenerationPerHit2(15);
            combat.heroBaneProc(damage);
        }
    }
}


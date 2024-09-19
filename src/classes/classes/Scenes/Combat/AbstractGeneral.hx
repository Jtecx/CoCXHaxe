package classes.scenes.combat;

import classes.StatusEffectType;
import classes.PerkType;
import classes.Races;

class AbstractGeneral extends CombatAbility
{
    private var knownCondition : Dynamic;
    private var fatigueType : Int = USEFATG_NORMAL;
    private var manaType : Int = USEMANA_NORMAL;
    
    public function new(
            name : String,
            desc : String,
            targetType : Int,
            timingType : Int,
            tags : Array<Dynamic>,
            knownCondition : Dynamic)
    {
        super(name, desc, targetType, timingType, tags);
        this.knownCondition = knownCondition;
    }
    
    override private function get_category() : Int
    {
        return CAT_UNIVERSAL;
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
        if (Std.is(knownCondition, Races))
        {
            return player.isRaceCached(knownCondition);
        }
        return false;
    }
    
    override public function useResources() : Void
    {
        super.useResources();
        
        var finalManaCost : Float = manaCost();
        var finalFatigueCost : Float = fatigueCost();
        var finalSFCost : Float = sfCost();
        var finalWrathCost : Float = wrathCost();
        
        if (finalManaCost > 0)
        {
            useMana(finalManaCost, manaType);
        }
        
        if (finalFatigueCost > 0)
        {
            fatigue(finalFatigueCost, fatigueType);
        }
        
        if (finalSFCost > 0)
        {
            player.soulforce -= finalSFCost;
        }
        
        if (finalWrathCost > 0)
        {
            player.wrath -= finalWrathCost;
        }
    }
    
    override private function usabilityCheck() : String
    // Run all check applicable to all abilities
    {
        
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (player.fatigueLeft() < fatigueCost())
        {
            return "You are too tired to use this ability.";
        }
        
        if (player.mana < manaCost())
        {
            return "Your mana is too low to use this ability.";
        }
        
        if (player.soulforce < sfCost())
        {
            return "Your soulforce is too low to use this ability.";
        }
        
        if (player.wrath < wrathCost())
        {
            return "Your wrath is too low to use this ability!";
        }
        
        return "";
    }
    
    private function sfCostMod(sfCost : Float) : Int
    {
        return Math.round(sfCost * soulskillCost() * soulskillcostmulti());
    }
}


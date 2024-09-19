package classes.scenes.combat;

import classes.PerkLib;
import classes.StatusEffects;

class AbstractDivineSpell extends AbstractSpell
{
    
    private function new(
            name : String,
            desc : String,
            targetType : Int,
            timingType : Int,
            tags : Array<Dynamic>)
    {
        super(name, desc, targetType, timingType, Combat.USEMANA_WHITE, tags);
    }
    
    override private function get_category() : Int
    {
        return CAT_SPELL_DIVINE;
    }
    
    override public function manaCost() : Float
    {
        return spellCostWhite(baseManaCost);
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (player.cor > 20 && !player.hasPerk(PerkLib.Equilibrium))
        {
            return "Your corruption is too high to cast this spell.";
        }
        if (player.lust >= combat.magic.getWhiteMagicLustCap())
        {
            return "You are far too aroused to focus on divine magic.";
        }
        if (player.statusEffectv2(StatusEffects.Sealed) == 10)
        {
            return "Your ability to use divine magic was sealed.";
        }
        
        return "";
    }
}


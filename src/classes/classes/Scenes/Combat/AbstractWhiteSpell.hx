package classes.scenes.combat;

import classes.PerkLib;
import classes.StatusEffects;

class AbstractWhiteSpell extends AbstractSpell
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
        return CAT_SPELL_WHITE;
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
        
        if (player.lust >= combat.magic.getWhiteMagicLustCap())
        {
            return "You are far too aroused to focus on white magic.";
        }
        if (player.hasPerk(PerkLib.HexKnowledge) && !player.hasPerk(PerkLib.Equilibrium))
        {
            return "Your chosen path of magic locked out this spell.";
        }
        if (player.statusEffectv2(StatusEffects.Sealed) == 10)
        {
            return "Your ability to use white magic was sealed.";
        }
        
        return "";
    }
}


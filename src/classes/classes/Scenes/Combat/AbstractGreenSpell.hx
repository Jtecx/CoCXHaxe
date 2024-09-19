package classes.scenes.combat;

import classes.PerkLib;
import classes.StatusEffects;

class AbstractGreenSpell extends AbstractSpell
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
        return CAT_SPELL_GREEN;
    }
    
    override public function manaCost() : Float
    {
        return spellCostGreen(baseManaCost);
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (player.hasStatusEffect(StatusEffects.NoPlantsArea))
        {
            return "Your can't use green magic in place where not plants exists or could grow.";
        }
        if (player.statusEffectv2(StatusEffects.Sealed) == 10)
        {
            return "Your ability to use green magic was sealed.";
        }
        
        return "";
    }
}


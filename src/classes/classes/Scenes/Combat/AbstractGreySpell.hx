package classes.scenes.combat;

import classes.PerkLib;
import classes.StatusEffects;

class AbstractGreySpell extends AbstractSpell
{
    
    private function new(
            name : String,
            desc : String,
            targetType : Int,
            timingType : Int,
            tags : Array<Dynamic>)
    {
        super(name, desc, targetType, timingType, Combat.USEMANA_GREY, tags);
    }
    
    override private function get_category() : Int
    {
        return CAT_SPELL_GREY;
    }
    
    override public function manaCost() : Float
    {
        return spellCostGrey(baseManaCost);
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        var threshold : Float = 50;
        if (!(
            player.hasPerk(PerkLib.GrandGreyArchmage) ||
            (threshold <= player.lust && player.lust <= player.maxLust() - threshold)))
        {
            return "You can't use any grey magics.";
        }
        if (player.statusEffectv2(StatusEffects.Sealed) == 10)
        {
            return "Your ability to use grey magic was sealed.";
        }
        
        return "";
    }
}


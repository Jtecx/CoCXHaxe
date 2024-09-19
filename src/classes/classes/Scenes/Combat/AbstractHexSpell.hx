package classes.scenes.combat;

import classes.PerkLib;
import classes.StatusEffects;

class AbstractHexSpell extends AbstractSpell
{
    public function new(
            name : String,
            desc : String,
            targetType : Int,
            timingType : Int,
            tags : Array<Dynamic>)
    {
        super(name, desc, targetType, timingType, Combat.USEMANA_BLACK, tags);
    }
    
    override private function get_category() : Int
    {
        return CAT_SPELL_HEX;
    }
    
    override public function manaCost() : Float
    {
        return spellCostBlack(baseManaCost);
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (player.cor < 80 && !player.hasPerk(PerkLib.Equilibrium))
        {
            return "Your corruption is too low to cast this spell.";
        }
        if (player.lust < combat.magic.getBlackMagicMinLust())
        {
            return "You aren't turned on enough to use any hex magics.";
        }
        if (player.statusEffectv2(StatusEffects.Sealed) == 10)
        {
            return "Your ability to use hex magic was sealed.";
        }
        
        return "";
    }
}


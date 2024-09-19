package classes.scenes.combat;

import classes.PerkLib;
import classes.StatusEffects;

class AbstractNecroSpell extends AbstractSpell
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
        return CAT_SPELL_NECRO;
    }
    
    override public function manaCost() : Float
    {
        return spellCostBlack(baseManaCost);
    }
    
    public function demonBonesCost() : Int
    {
        return 0;
    }
    
    override public function costDescription() : Array<Dynamic>
    {
        var costs : Array<Dynamic> = super.costDescription().concat();
        if (demonBonesCost() > 0)
        {
            costs.push("Bones Cost: " + demonBonesCost());
        }
        return costs;
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (demonBonesAvailable() < demonBonesCost() && !player.hasPerk(PerkLib.BoneSoul) && !player.hasPerk(PerkLib.Equilibrium))
        {
            return "You don't have enough demon bones to use any this necromancer spell.";
        }
        if (player.statusEffectv2(StatusEffects.Sealed) == 10)
        {
            return "Your ability to use necromantic magic was sealed.";
        }
        
        return "";
    }
    
    ////////////
    // Utilities
    ////////////
    
    /**
	 * Consume bones.
	 * This method should not be called in useResources but in doSpellEffect
	 * after power calculation instead; otherwise boneSoulBonus won't calculate correctly
	 */
    private function consumeBones(count : Int) : Void
    {
        addDemonBones(-Math.min(demonBonesAvailable(), count));
    }
    
    public static function demonBonesAvailable() : Int
    {
        if (player.hasPerk(PerkLib.PrestigeJobNecromancer))
        {
            return player.perkv1(PerkLib.PrestigeJobNecromancer);
        }
        else
        {
            return 0;
        }
    }
    
    public static function addDemonBones(delta : Int) : Void
    {
        player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, delta);
    }
    
    public static function boneSoulBonus(bonesCost : Int) : Float
    {
        if (!player.hasPerk(PerkLib.BoneSoul))
        {
            return 1.0;
        }
        var bones : Int = demonBonesAvailable();
        if (bones < 50)
        {
            return 1.0;
        }
        var bonus : Float = Math.round((bones - 50) / 10);
        if (bonus >= 2.0)
        {
            bonus = 2.0;
        }
        return 1.0 + bonus;
    }
}


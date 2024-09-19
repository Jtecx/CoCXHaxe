package classes.scenes.combat;

import classes.PerkLib;
import classes.StatusEffects;

class AbstractBloodSpell extends AbstractSpell
{
    private var inflictBleed : Bool = true;
    public function new(
            name : String,
            desc : String,
            targetType : Int,
            timingType : Int,
            tags : Array<Dynamic>)
    {
        super(name, desc, targetType, timingType, Combat.USEMANA_BLACK, tags);
    }
    
    public var baseHpCost : Float = 0;
    
    override private function get_category() : Int
    {
        return CAT_SPELL_BLOOD;
    }
    
    override public function hpCost() : Float
    {
        return spellCostBlood(baseHpCost);
    }
    
    override public function useResources() : Void
    {
        super.useResources();
        HPChange(-hpCost(), false);
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (player.isGargoyle())
        {
            return "You cannot use blood spells if you don't have blood at all.";
        }
        if (player.HP - player.minHP() - 1 < hpCost())
        {
            return "Your hp is too low to cast this spell.";
        }
        
        return "";
    }
    
    override private function postSpellEffect(display : Bool = true) : Void
    {
        super.postSpellEffect(display);
        endTurnByBloodSkillUse(display);
    }
    
    private function endTurnByBloodSkillUse(display : Bool = true) : Void
    {
        var chance : Float = 20;
        if (player.hasPerk(PerkLib.WayOfTheBlood))
        {
            chance += (5 * player.progressBloodDemon());
        }
        if (rand(100) < chance && inflictBleed && !monster.isImmuneToBleed())
        {
            var magn : Float = 0.05;
            if (player.hasPerk(PerkLib.WayOfTheBlood))
            {
                chance += (0.02 * player.progressBloodDemon());
            }
            if (monster.hasStatusEffect(StatusEffects.Hemorrhage))
            {
                monster.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
            }
            else
            {
                monster.createStatusEffect(StatusEffects.Hemorrhage, 2, magn, 0, 0);
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
    }
}


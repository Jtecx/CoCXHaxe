package classes.scenes.combat.spellsNecro;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractNecroSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class BloodShowerSpell extends AbstractNecroSpell
{
    public function new()
    {
        super(
                "Blood Shower", 
                "Force some of the blood out of one of the many defeated opponents on the opposite team leaving them on the brink of death as the stolen blood rains on the opponents, greatly damaging their morale. Only work on group type enemies with less than 80% of their HP left.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DEBUFF]
        );
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Reducing their damage dealt by 80%. Has a chance to strike fear in the heart of your foes.";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBloodShower);
    }
    
    override public function isActive() : Bool
    {
        return monster.hasStatusEffect(StatusEffects.BloodShower);
    }
    
    override private function usabilityCheck() : String
    {
        if ((!monster.plural
            || !monster.hasPerk(PerkLib.Enemy300Type)
            || !monster.hasPerk(PerkLib.EnemyGroupType)
            || !monster.hasPerk(PerkLib.EnemyLargeGroupType)) && monster.HP > monster.maxHP() * 0.8)
        {
            return "You can only use that spell on enemy groups that have less than 80% of members left.";
        }
        return super.usabilityCheck();
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You concentrate your powers on one of the bodies of your fallen foes forcibly extracting blood and making it rain on your opponent. ");
            if (rand(4) == 0)
            {
                outputText("Your opponents are routing in terror! ");
                monster.createStatusEffect(StatusEffects.Fear, 3, 0, 0, 0);
            }
        }
        monster.createStatusEffect(StatusEffects.BloodShower, 0, 0, 0, 0);
    }
}


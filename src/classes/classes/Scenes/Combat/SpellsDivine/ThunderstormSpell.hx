package classes.scenes.combat.spellsDivine;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractDivineSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class ThunderstormSpell extends AbstractDivineSpell
{
    public function new()
    {
        super(
                "Thunderstorm", 
                "Call upon the heavenly thunder, starting a lightning storm that will systematically zap your opponents every turn for up to 30 rounds.  ", 
                TARGET_ENEMY, 
                TIMING_LASTING, 
                [TAG_DAMAGING, TAG_LIGHTNING]
        );
        baseManaCost = 1200;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsThunderstorm);
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(target, false, false)) + " lightning damage for " + numberOfThings(calcDuration(), "round");
    }
    
    override public function isActive() : Bool
    {
        return player.statusEffectv2(StatusEffects.Thunderstorm) > 0;
    }
    
    override private function usabilityCheck() : String
    {
        if (player.hasStatusEffect(StatusEffects.Thunderstorm))
        {
            return "Can be casted only once per combat.";
        }
        return super.usabilityCheck();
    }
    
    override public function calcDuration() : Int
    {
        return 30;
    }
    
    override public function advance(display : Bool) : Void
    {
        player.addStatusValue(StatusEffects.Thunderstorm, 2, -1);
        if (display)
        {
            outputText("<b>A bolt of divine lightning falls from the sky and strikes [themonster]</b>. ");
        }
        doLightningDamage(player.statusEffectv1(StatusEffects.Thunderstorm), true, display);
        if (display)
        {
            outputText("\n\n");
        }
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        return adjustSpellDamage(
                scalingBonusIntelligence(randomize), 
                DamageType.LIGHTNING, 
                CAT_SPELL_DIVINE, 
                monster, 
                false, 
                casting
        );
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You call upon the anger of the gods to smite your foe and they gladly answer with thunder. Lightning begins to strike down upon your opponent" + ((monster.plural) ? "s" : "") + " with perfect precision.");
        }
        var damage : Float = calcDamage(monster, true, true);
        
        player.createStatusEffect(StatusEffects.Thunderstorm, damage, calcDuration(), 0, 0);
        damage = critAndRepeatDamage(display, damage, DamageType.LIGHTNING);
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}


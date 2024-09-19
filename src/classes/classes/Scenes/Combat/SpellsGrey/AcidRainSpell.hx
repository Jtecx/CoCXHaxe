package classes.scenes.combat.spellsGrey;

import classes.Monster;
import classes.scenes.combat.AbstractGreySpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class AcidRainSpell extends AbstractGreySpell
{
    public function new()
    {
        super(
                "Acid Rain", 
                "This spell causes a radical change in your surroundings. You can call forth an Acid Rain that will strike enemies in a wide area.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_ACID, TAG_AOE, TAG_TIER2]
        );
        baseManaCost = 500;
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " acid damage";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsAcidRain);
    }
    
    override public function calcCooldown() : Int
    {
        return spellGreyTier2Cooldown();
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var baseDamage : Float = 6 * scalingBonusIntelligence(randomize);
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        return adjustSpellDamage(baseDamage, DamageType.ACID, CAT_SPELL_GREY, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You raise both hands to the sky, your mana visibly pulsing into the air around you. [Monster A] [monster name] looks up as blackened clouds form above them, streaks of clear liquid pouring from the miniature clouds onto them. At first, your foes ignore the clouds, but as the first droplets hit them, they cry out in pain. Your cloud unleashes a downpour of acid, disguised as rain.\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.ACID, false, true, true);
        if (monster.hasStatusEffect(StatusEffects.AcidDoT))
        {
            monster.addStatusValue(StatusEffects.AcidDoT, 1, 1);
            monster.addStatusValue(StatusEffects.AcidDoT, 3, 1);
        }
        else
        {
            monster.createStatusEffect(StatusEffects.AcidDoT, 2, 0.02, 1, 0);
        }
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}

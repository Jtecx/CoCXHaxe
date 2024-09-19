package classes.scenes.combat.spellsWhite;

import classes.Monster;
import classes.scenes.combat.AbstractWhiteSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class FireStormSpell extends AbstractWhiteSpell
{
    public function new()
    {
        super(
                "Fire Storm", 
                "Drawing your own force of the willpower to fuel radical change in the surrounding you can call forth an Fire Storm that will attack enemies in a wide area.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_AOE, TAG_FIRE, TAG_TIER2]
        );
        baseManaCost = 500;
    }
    
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsFireStorm);
    }
    
    override public function calcCooldown() : Int
    {
        return spellWhiteTier2Cooldown();
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " fire damage.";
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var baseDamage : Float = scalingBonusIntelligence(randomize) * 6;
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        return adjustSpellDamage(baseDamage, DamageType.FIRE, CAT_SPELL_WHITE, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You narrow your eyes, deadly intent smoldering in your gaze. You draw as much mana as you can muster into a single finger, which you point at [themonster]. A few motes of light and heat form around [themonster], almost immediately exploding into a spiral of flame around them, howling like the storm-driven winds.");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.FIRE);
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}


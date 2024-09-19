package classes.scenes.combat.spellsBlack;

import classes.Monster;
import classes.scenes.combat.AbstractBlackSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class IceRainSpell extends AbstractBlackSpell
{
    public function new()
    {
        super(
                "Ice Rain", 
                "This spell causes a radical change in your surroundings. You can call forth an Ice Rain that will strike enemies in a wide area. Fueled by your own desires, this spell can backfire, making the user wet instead.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_ICE, TAG_AOE, TAG_TIER2]
        );
        baseManaCost = 500;
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " ice damage";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsIceRain);
    }
    
    override public function calcCooldown() : Int
    {
        return spellBlackTier2Cooldown();
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var baseDamage : Float = 6 * scalingBonusIntelligence(randomize);
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        return adjustSpellDamage(baseDamage, DamageType.ICE, CAT_SPELL_BLACK, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You narrow your eyes, focusing on the force of your lust as you raise your hands to the sky. Your mana and lust pulses, rising, pulling. A dark cloud coalesces above you, stretching further until there is nothing but an eerie darkness above you. You bring your head back down, focusing your gaze at  [monster a] [monster name] as countless razor-like shards of ice rain upon your opponent.\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.ICE);
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}


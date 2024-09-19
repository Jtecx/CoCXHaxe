package classes.scenes.combat.spellsBlack;

import classes.globalFlags.KACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBlackSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class IceSpikeSwiftcastSpell extends AbstractBlackSpell
{
    
    public function new()
    {
        super(
                "Ice Spike (S)", 
                "Drawing your own lust to concentrate it into chilling spike of ice that will attack your enemies.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_ICE, TAG_TIER1]
        );
        baseManaCost = 8;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsIceSpike) &&
        player.hasPerk(PerkLib.SwiftCasting);
    }
    
    override public function calcCooldown() : Int
    {
        return 0;
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var baseDamage : Float = 0.4 * scalingBonusIntelligence(randomize);
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        if (player.armorName == "FrancescaCloak")
        {
            baseDamage *= 2;
        }
        return adjustSpellDamage(baseDamage, DamageType.ICE, CAT_SPELL_BLACK, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form ice spike that shots toward [monster a] [monster name]!\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.ICE);
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}

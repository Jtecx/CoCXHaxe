package classes.scenes.combat.spellsBlack;

import classes.globalFlags.KACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBlackSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class DarknessShardSwiftcastSpell extends AbstractBlackSpell
{
    
    public function new()
    {
        super(
                "Darkness Shard (S)", 
                "Drawing your own lust to condense part of the ambient darkness into a shard to attack your enemies.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_DARKNESS, TAG_TIER1]
        );
        baseManaCost = 8;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsDarknessShard) &&
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
        return adjustSpellDamage(baseDamage, DamageType.DARKNESS, CAT_SPELL_BLACK, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You narrow your eyes, enfusing your mana with the sickly-sweet power of lust.  In the palm of your hand forms a shard of energy, blacker than night, which pushes the light away. You focus your will at your enemy, and your shadowy missile rockets toward [themonster]!\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.DARKNESS);
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}

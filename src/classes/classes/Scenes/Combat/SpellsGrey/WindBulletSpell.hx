package classes.scenes.combat.spellsGrey;

import classes.globalFlags.KACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractGreySpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class WindBulletSpell extends AbstractGreySpell
{
    public var ex : Bool;
    
    public function new(ex : Bool = false)
    {
        super(
                (ex) ? "Wind Bullet (Ex)" : "Wind Bullet", 
                (ex) ? 
                "Devastate the enemy ranks with a barrage of wrath-empowered wind bullets." : "Devastate the enemy ranks with a barrage of wind bullets.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_WIND, TAG_TIER1]
        );
        baseManaCost = 40;
        if (ex)
        {
            baseWrathCost = 100;
        }
        this.ex = ex;
    }
    
    override private function get_buttonName() : String
    {
        return (ex) ? "WindBullet(Ex)" : "Wind Bullet";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " wind damage";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsWindBullet) &&
        (!ex || player.hasPerk(PerkLib.MagesWrathEx));
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 0;
        calcC += spellGreyCooldown();
        if (player.weaponRange == weaponsrange.RG_TOME && player.level < 18)
        {
            if (player.level < 6)
            {
                calcC -= 1;
            }
            if (player.level < 12)
            {
                calcC -= 1;
            }
            calcC -= 1;
            if (calcC < 0)
            {
                calcC = 0;
            }
        }
        return calcC;
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var baseDamage : Float = 2 * scalingBonusIntelligence(randomize);
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        if (ex)
        {
            baseDamage *= 2;
        }
        return adjustSpellDamage(baseDamage, DamageType.WIND, CAT_SPELL_GREY, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You focus your intents at your opponent as the air swirls around them. By your command, the zephyr coalesces into a bullet that immediately darts into [themonster].\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.WIND);
        if (ex)
        {
            awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
        }
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}

package classes.scenes.combat.spellsGrey;

import classes.globalFlags.KACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractGreySpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class StalagmiteSpell extends AbstractGreySpell
{
    public var ex : Bool;
    
    public function new(ex : Bool = false)
    {
        super(
                (ex) ? "Stalagmite (Ex)" : "Stalagmite", 
                (ex) ? 
                "Harden part of the ground into an wrath-empowered earth spike to attack your enemy." : "Harden part of the ground into an earth spike to attack your enemy.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_EARTH, TAG_TIER1]
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
        return (ex) ? "Stalagmite(Ex)" : "Stalagmite";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " earth damage";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsStalagmite) &&
        (!ex || player.hasPerk(PerkLib.MagesWrathEx));
    }
    
    override private function usabilityCheck() : String
    {
        if (monster.hasStatusEffect(StatusEffects.Flying))
        {
            return "You can only use earth magic against enemy on the ground.";
        }
        if (player.hasStatusEffect(StatusEffects.Flying))
        {
            return "You can't use earth magic when too far from the ground.";
        }
        return super.usabilityCheck();
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
        return adjustSpellDamage(baseDamage, DamageType.EARTH, CAT_SPELL_GREY, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You spread your hands, focusing your mana down, down, deep into the earth below. [Monster A] [monster name] in front of you leaves a slight indent, that you can feel through the earth. With a moment of hard focus, you harden the earth underneath them into a spike of solid stone. With a cry of effort, you motion, and your spike of stone shoots up from below, striking your foe.\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.EARTH);
        if (ex)
        {
            awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
        }
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}

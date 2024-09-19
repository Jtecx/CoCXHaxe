package classes.scenes.combat.spellsBlack;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBlackSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class PolarMidnightSpell extends AbstractBlackSpell
{
    public function new()
    {
        super(
                "Polar Midnight", 
                "Cause a massive temperature drop which freezes the air solid in an area. Opponents caught in this spell take the cold damage and are stunned for 5 round.  " +
                "\n<b>Req. 1 turn channeling. Cooldown: 12 turns</b>", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_ICE, TAG_AOE, TAG_TIER3]
        );
        baseManaCost = 1250;
    }
    
    override private function get_buttonName() : String
    {
        return "PolarMidnight";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsPolarMidnight);
    }
    
    override public function calcCooldown() : Int
    {
        return spellBlackTier3Cooldown();
    }
    
    override public function setCooldown() : Void
    {
        if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1)
        {
            super.setCooldown();
        }
        else
        {  /* we're channeling, don't renew cooldown */  
            
        }
    }
    
    override public function useResources() : Void
    {
        if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1)
        {
            super.useResources();
        }
        else
        {  /* we're channeling, don't use mana */  
            
        }
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " ice damage. ";
    }
    
    public function calcDamage(target : Monster, randomize : Bool = true, casting : Bool = true) : Float
    {
        var baseDamage : Float = scalingBonusIntelligence(randomize) * 24;
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        return adjustSpellDamage(
                baseDamage, 
                DamageType.ICE, 
                CAT_SPELL_BLACK, 
                target, 
                true, 
                casting
        );
    }
    
    public function polarMidnightHit(display : Bool = true) : Void
    {
        player.removeStatusEffect(StatusEffects.ChanneledAttack);
        player.removeStatusEffect(StatusEffects.ChanneledAttackType);
        if ((player.hasPerk(PerkLib.GlacialStormSu) || player.hasPerk(PerkLib.GlacialStormMastered)) && player.hasStatusEffect(StatusEffects.CounterGlacialStorm))
        {
            player.addStatusValue(StatusEffects.CounterGlacialStorm, 3, -1);
        }
        if (display)
        {
            outputText("You drain the heat out of the air around your foe, causing its temperature to plummet far below its freezing point in an instant, effectively flash freezing your enemy for \n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.ICE);
        if (!monster.hasPerk(PerkLib.Resolute))
        {
            if (display)
            {
                outputText("\n\n[Monster A] [monster name] is encased in a thick layer of ice.\n\n");
            }
            monster.createStatusEffect(StatusEffects.FrozenSolid, 5, 0, 0, 0);
        }
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
    
    public function polarMidnightChannel(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You begin to channel magic, the air temperature dropping around you.");
        }
        player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
        player.createStatusEffect(StatusEffects.ChanneledAttackType, 5, 0, 0, 0);
        if (player.hasPerk(PerkLib.GlacialStormSu) || player.hasPerk(PerkLib.GlacialStormMastered))
        {
            player.addStatusValue(StatusEffects.CounterGlacialStorm, 3, 1);
        }
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1)
        {
            polarMidnightHit(display);
        }
        else
        {
            polarMidnightChannel(display);
        }
    }
}


package classes.scenes.combat.spellsWhite;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractWhiteSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class MeteorShowerSpell extends AbstractWhiteSpell
{
    public function new()
    {
        super(
                "Meteor Shower", 
                "Call down a rain of meteors on your opponents, stunning them for 1 round and dealing area damage. Hits 12 times.\n<b>Req. 1 turn channeling. Cooldown: 12 turns.</b>", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_FIRE, TAG_AOE, TAG_TIER3]
        );
        baseManaCost = 1250;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsMeteorShower);
    }
    
    override public function calcCooldown() : Int
    {
        return spellWhiteTier3Cooldown();
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (inDungeon || player.hasStatusEffect(StatusEffects.InsideSmallSpace))
        {
            return "You can't use this spell inside small spaces. Unless you want get killed along with your enemies.";
        }
        if (player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost))
        {
            return "You can't use this spell underwater.";
        }
        
        return "";
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
        return "~" + calcDamage(target, false, false) + "(x12) fire damage.";
    }
    
    public function calcDamage(target : Monster, randomize : Bool = true, casting : Bool = true) : Float
    {
        var baseDamage : Float = scalingBonusIntelligence(randomize) * 2;
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        return adjustSpellDamage(
                baseDamage, 
                DamageType.FIRE, 
                CAT_SPELL_WHITE, 
                target, 
                true, 
                casting
        );
    }
    
    public function meteorShowerHit(display : Bool = true) : Void
    {
        player.removeStatusEffect(StatusEffects.ChanneledAttack);
        player.removeStatusEffect(StatusEffects.ChanneledAttackType);
        if ((player.hasPerk(PerkLib.RagingInfernoSu) || player.hasPerk(PerkLib.RagingInfernoMastered)) && player.hasStatusEffect(StatusEffects.CounterRagingInferno))
        {
            player.addStatusValue(StatusEffects.CounterRagingInferno, 3, -1);
        }
        calcDamage(monster, true, true);
        if (display)
        {
            outputText("You call out to the celestial vault, knocking some rocks out of orbit and into a crash course towards your opponents.\n\n");
            outputText("[monster A] [monster name] takes ");
        }
        var meteor : Float = 12;
        var totalDamage : Float = 0;
        while (meteor-- > 0)
        {
            var damage : Float = calcDamage(monster, true, false);
            totalDamage += critAndRepeatDamage(false, damage, DamageType.FIRE, true);
        }
        if (display)
        {
            outputText(" damage!");
            outputText(" [Themonster] reels from the impact, trying to recover from this devastating assault as a meteor crash in the area.");
        }
        monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
        checkAchievementDamage(totalDamage);
        combat.heroBaneProc(totalDamage);
    }
    
    public function meteorShowerChannel(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You begin to channel magic, the sky reddening above you.");
        }
        player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
        player.createStatusEffect(StatusEffects.ChanneledAttackType, 6, 0, 0, 0);
        if (player.hasPerk(PerkLib.RagingInfernoSu) || player.hasPerk(PerkLib.RagingInfernoMastered))
        {
            player.addStatusValue(StatusEffects.CounterRagingInferno, 3, 1);
        }
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1)
        {
            meteorShowerHit(display);
        }
        else
        {
            meteorShowerChannel(display);
        }
    }
}


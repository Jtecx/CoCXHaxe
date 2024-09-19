/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.scenes.combat;

import classes.BaseContent;

class BaseCombatContent extends BaseContent
{
    private var inCombat(get, never) : Bool;
    private var combatRound(get, never) : Int;

    public function new()
    {
        super();
    }
    // ====================
    // COMBAT FLOW
    // ====================
    private function get_inCombat() : Bool
    {
        return combat.inCombat;
    }
    private function get_combatRound() : Int
    {
        return combat.combatRound;
    }
    private function combatMenu(newRound : Bool = true) : Void
    {
        combat.combatMenu(newRound);
    }
    // Returns true if combat is over. Setups doNext to win/loss/combat menu
    private function combatIsOver() : Bool
    {
        return combat.combatIsOver();
    }
    private function combatRoundOver() : Void
    {
        combat.combatRoundOver();
    }
    private function endHpVictory() : Void
    {
        combat.endHpVictory();
    }
    private function endLustVictory() : Void
    {
        combat.endLustVictory();
    }
    private function endHpLoss() : Void
    {
        combat.endHpLoss();
    }
    private function endLustLoss() : Void
    {
        combat.endLustLoss();
    }
    // ==================
    // APPLY EFFECTS
    // ==================
    private function doDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doDamage(damage, apply, display, ignoreDR);
    }
    private function doPhysicalDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doPhysicalDamage(damage, apply, display, ignoreDR);
    }
    private function doMinionPhysDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doMinionPhysDamage(damage, apply, display, ignoreDR);
    }
    private function doMagicDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doMagicDamage(damage, apply, display, ignoreDR);
    }
    private function doFireDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doFireDamage(damage, apply, display, ignoreDR);
    }
    private function doIceDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doIceDamage(damage, apply, display, ignoreDR);
    }
    private function doLightningDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doLightningDamage(damage, apply, display, ignoreDR);
    }
    private function doDarknessDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doDarknessDamage(damage, apply, display, ignoreDR);
    }
    private function doPoisonDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doPoisonDamage(damage, apply, display, ignoreDR);
    }
    private function doWindDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doWindDamage(damage, apply, display, ignoreDR);
    }
    private function doWaterDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doWaterDamage(damage, apply, display, ignoreDR);
    }
    private function doEarthDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doEarthDamage(damage, apply, display, ignoreDR);
    }
    private function doAcidDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doAcidDamage(damage, apply, display, ignoreDR);
    }
    private function doPlasmaDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doPlasmaDamage(damage, apply, display, ignoreDR);
    }
    private function doBlackIceDamage(damage : Float, apply : Bool = true, display : Bool = false, ignoreDR : Bool = false) : Float
    {
        return combat.doBlackIceDamage(damage, apply, display, ignoreDR);
    }
    private function doPsychicDamage(damage : Float, apply : Bool = true, display : Bool = false) : Float
    {
        return combat.doPsychicDamage(damage, apply, display);
    }
    private function doTrueDamage(damage : Float, apply : Bool = true, display : Bool = false) : Float
    {
        return combat.doTrueDamage(damage, apply, display);
    }
    private function combatParry() : Bool
    {
        return combat.combatParry();
    }
    private function combatParry2() : Float
    {
        return combat.combatParry2();
    }
    private function combatPhysicalCritical() : Float
    {
        return combat.combatPhysicalCritical();
    }
    private function combatMagicalCritical() : Float
    {
        return combat.combatMagicalCritical();
    }
    private function combatBlock(doFatigue : Bool = false) : Bool
    {
        return combat.combatBlock(doFatigue);
    }
    private function combatBlock2() : Float
    {
        return combat.combatBlock2();
    }
    private function unarmedAttack() : Float
    {
        return combat.unarmedAttack();
    }
    private function ghostStrength() : Float
    {
        return combat.ghostStrength();
    }
    private function ghostSpeed() : Float
    {
        return combat.ghostSpeed();
    }
    private function ghostToughness() : Float
    {
        return combat.ghostToughness();
    }
    // =================
    // CHECKS
    // =================
    private function hasSpells() : Bool
    {
        return player.hasSpells();
    }
    private function spellCount() : Float
    {
        return player.spellCount();
    }
    private function spellPerkUnlock() : Void
    {
        combat.spellPerkUnlock();
    }
    private function bowPerkUnlock() : Void
    {
        combat.bowPerkUnlock();
    }
    private function checkAchievementDamage(damage : Float) : Void
    {
        combat.checkAchievementDamage(damage);
    }
    private function isPlayerBound() : Bool
    {
        return combat.isPlayerBound();
    }
    private function isPlayerSilenced() : Bool
    {
        return combat.isPlayerSilenced();
    }
    private function isPlayerStunned() : Bool
    {
        return combat.isPlayerStunned();
    }
    private function isPlayerPowerStunned() : Bool
    {
        return combat.isPlayerPowerStunned();
    }
    private function isPlayerFeared() : Bool
    {
        return combat.isPlayerFeared();
    }
    // =================
    // MODIFIERS
    // =================
    private function physicalCost(mod : Float) : Float
    {
        return combat.physicalCost(mod);
    }
    private function bowCost(mod : Float) : Float
    {
        return combat.bowCost(mod);
    }
    private function soulskillCost() : Float
    {
        return combat.soulskills.soulskillCostImpl();
    }
    private function soulskillcostmulti() : Float
    {
        return combat.soulskills.soulskillcostmultiImpl();
    }
    private function soulskillMod() : Float
    {
        return combat.soulskills.soulskillModImpl();
    }
    private function soulskillPhysicalMod() : Float
    {
        return combat.soulskills.soulskillPhysicalModImpl();
    }
    private function soulskillMagicalMod() : Float
    {
        return combat.soulskills.soulskillMagicalModImpl();
    }
    private function soulskillCooldown(duration : Int = 2, physical : Bool = true) : Float
    {
        return combat.soulskills.soulskillCooldownImpl(duration, physical);
    }
    private function soulskillTier2Cooldown(duration : Int = 4, physical : Bool = true) : Float
    {
        return combat.soulskills.soulskillTier2CooldownImpl(duration, physical);
    }
    private function soulskillTier3Cooldown(duration : Int = 10, physical : Bool = true) : Float
    {
        return combat.soulskills.soulskillTier3CooldownImpl(duration, physical);
    }
    private function scalingBonusStrength(randomize : Bool = true) : Float
    {
        return combat.scalingBonusStrength(randomize);
    }
    private function scalingBonusStrengthCompanion(randomize : Bool = true) : Float
    {
        return combat.scalingBonusStrengthCompanion(randomize);
    }
    private function scalingBonusToughness(randomize : Bool = true) : Float
    {
        return combat.scalingBonusToughness(randomize);
    }
    private function scalingBonusToughnessCompanion(randomize : Bool = true) : Float
    {
        return combat.scalingBonusToughnessCompanion(randomize);
    }
    private function scalingBonusSpeed(randomize : Bool = true) : Float
    {
        return combat.scalingBonusSpeed(randomize);
    }
    public function scalingBonusIntelligence(randomize : Bool = true) : Float
    {
        return combat.scalingBonusIntelligence(randomize);
    }
    private function scalingBonusIntelligenceCompanion(randomize : Bool = true) : Float
    {
        return combat.scalingBonusIntelligenceCompanion(randomize);
    }
    private function scalingBonusWisdom(randomize : Bool = true) : Float
    {
        return combat.scalingBonusWisdom(randomize);
    }
    private function scalingBonusWisdomCompanion(randomize : Bool = true) : Float
    {
        return combat.scalingBonusWisdomCompanion(randomize);
    }
    private function scalingBonusLibido(randomize : Bool = true) : Float
    {
        return combat.scalingBonusLibido(randomize);
    }
    private function meleePhysicalForce() : Float
    {
        return combat.meleePhysicalForce();
    }
    private function rangePhysicalForce() : Float
    {
        return combat.rangePhysicalForce();
    }
    private function firearmsForce() : Float
    {
        return combat.firearmsForce();
    }
    private function spellCost(mod : Float) : Float
    {
        return combat.magic.spellCostImpl(mod);
    }
    public function spellCostWhite(mod : Float) : Float
    {
        return combat.magic.spellCostWhiteImpl(mod);
    }
    private function spellCostBlack(mod : Float) : Float
    {
        return combat.magic.spellCostBlackImpl(mod);
    }
    private function spellCostGrey(mod : Float) : Float
    {
        return combat.magic.spellCostGreyImpl(mod);
    }
    public function spellCostGreen(mod : Float) : Float
    {
        return combat.magic.spellCostGreenImpl(mod);
    }
    private function healCost(mod : Float) : Float
    {
        return combat.magic.healCostImpl(mod);
    }
    private function healCostWhite(mod : Float) : Float
    {
        return combat.magic.healCostWhiteImpl(mod);
    }
    private function healCostBlack(mod : Float) : Float
    {
        return combat.magic.healCostBlackImpl(mod);
    }
    private function spellCostBlood(mod : Float) : Float
    {
        return combat.magic.spellCostBloodImpl(mod);
    }
    private function spellMod() : Float
    {
        return combat.magic.spellModImpl();
    }
    private function spellModBlack() : Float
    {
        return combat.magic.spellModBlackImpl();
    }
    private function spellModWhite() : Float
    {
        return combat.magic.spellModWhiteImpl();
    }
    private function spellModGrey() : Float
    {
        return combat.magic.spellModGreyImpl();
    }
    private function spellModBlood() : Float
    {
        return combat.magic.spellModBloodImpl();
    }
    private function spellModGreen() : Float
    {
        return combat.magic.spellModGreenImpl();
    }
    private function spellBlackCooldown() : Float
    {
        return combat.magic.spellBlackCooldownImpl();
    }
    private function spellBlackTier2Cooldown() : Float
    {
        return combat.magic.spellBlackTier2CooldownImpl();
    }
    private function spellBlackTier3Cooldown() : Float
    {
        return combat.magic.spellBlackTier3CooldownImpl();
    }
    private function spellGreyCooldown() : Float
    {
        return combat.magic.spellGreyCooldownImpl();
    }
    private function spellGreyTier2Cooldown() : Float
    {
        return combat.magic.spellGreyTier2CooldownImpl();
    }
    private function spellWhiteCooldown() : Float
    {
        return combat.magic.spellWhiteCooldownImpl();
    }
    private function spellWhiteTier2Cooldown() : Float
    {
        return combat.magic.spellWhiteTier2CooldownImpl();
    }
    private function spellWhiteTier3Cooldown() : Float
    {
        return combat.magic.spellWhiteTier3CooldownImpl();
    }
    private function spellGenericCooldown() : Float
    {
        return combat.magic.spellGenericCooldownImpl();
    }
    private function healMod() : Float
    {
        return combat.magic.healModImpl();
    }
    private function healModBlack() : Float
    {
        return combat.magic.healModBlackImpl();
    }
    private function healModWhite() : Float
    {
        return combat.magic.healModWhiteImpl();
    }
    public function calcInfernoMod(damage : Float, incCnt : Bool) : Float
    {
        return combat.magic.calcInfernoModImpl(damage, incCnt);
    }
    private function calcGlacialMod(damage : Float, incCnt : Bool) : Float
    {
        return combat.magic.calcGlacialModImpl(damage, incCnt);
    }
    private function calcVoltageMod(damage : Float, incCnt : Bool) : Float
    {
        return combat.magic.calcVoltageModImpl(damage, incCnt);
    }
    private function calcEclypseMod(damage : Float, incCnt : Bool) : Float
    {
        return combat.magic.calcEclypseModImpl(damage, incCnt);
    }
    private function calcTideMod(damage : Float, incCnt : Bool) : Float
    {
        return combat.magic.calcTideModImpl(damage, incCnt);
    }
    private function calcQuakeMod(damage : Float, incCnt : Bool) : Float
    {
        return combat.magic.calcQuakeModImpl(damage, incCnt);
    }
    private function calcGaleMod(damage : Float, incCnt : Bool) : Float
    {
        return combat.magic.calcGaleModImpl(damage, incCnt);
    }
    private function calcCorrosionMod(damage : Float, incCnt : Bool) : Float
    {
        return combat.magic.calcCorrosionModImpl(damage, incCnt);
    }
    
    private function maintainInfernoMod() : Void
    {
        combat.magic.maintainInfernoModImpl();
    }
    
    private function maintainGlacialMod() : Void
    {
        combat.magic.maintainGlacialModImpl();
    }
    
    private function maintainVoltageMod() : Void
    {
        combat.magic.maintainVoltageModImpl();
    }
    
    private function maintainEclypseMod() : Void
    {
        combat.magic.maintainEclypseModImpl();
    }
    
    private function maintainTideMod() : Void
    {
        combat.magic.maintainTideModImpl();
    }
    
    private function maintainQuakeMod() : Void
    {
        combat.magic.maintainQuakeModImpl();
    }
    
    private function maintainGaleMod() : Void
    {
        combat.magic.maintainGaleModImpl();
    }
    
    private function maintainCorrosionMod() : Void
    {
        combat.magic.maintainCorrosionModImpl();
    }
}


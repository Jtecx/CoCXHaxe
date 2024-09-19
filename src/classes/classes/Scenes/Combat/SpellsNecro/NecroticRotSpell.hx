package classes.scenes.combat.spellsNecro;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractNecroSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class NecroticRotSpell extends AbstractNecroSpell
{
    public function new()
    {
        super(
                "Necrotic Rot", 
                "Deals damage and cause the opponent wounds to fester and worsen increasing damage taken from physical attacks by 25%. This effect stacks.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING]
        );
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " true damage";
    }
    
    override public function calcCooldown() : Int
    {
        return spellBlackCooldown();
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsNecroticRot);
    }
    
    override public function demonBonesCost() : Int
    {
        var calcDBC : Int = 5;
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            calcDBC -= 1;
        }
        if (player.hasStatusEffect(StatusEffects.BonusEffectsNecroSet) && player.statusEffectv3(StatusEffects.BonusEffectsNecroSet) > 0)
        {
            calcDBC -= 1;
        }
        return calcDBC;
    }
    
    override private function usabilityCheck() : String
    {
        if (monster.hasPerk(PerkLib.EnemyElementalType)
            || monster.hasPerk(PerkLib.EnemyGhostType))
        {
            return "Your enemy lacks physical body.";
        }
        if (monster.plural
            || monster.hasPerk(PerkLib.Enemy300Type)
            || monster.hasPerk(PerkLib.EnemyGroupType)
            || monster.hasPerk(PerkLib.EnemyLargeGroupType))
        {
            return "You can only strike one target.";
        }
        return super.usabilityCheck();
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var damage : Float = adjustSpellDamage(
                scalingBonusIntelligence() * 2, 
                DamageType.TRUE, 
                CAT_SPELL_NECRO, 
                monster, 
                true, 
                casting
        );
        if (player.hasPerk(PerkLib.Necromancy))
        {
            damage *= 1.5;
        }
        damage *= boneSoulBonus(demonBonesCost());
        return damage;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You curse [themonster] with rot causing wounds old and new to open wide with increased deadliness as [monster his] flesh festers! ");
        }
        var damage : Float = calcDamage(monster, true, true);
        consumeBones(demonBonesCost());
        damage = critAndRepeatDamage(display, damage, DamageType.TRUE);
        checkAchievementDamage(damage);
        if (monster.hasStatusEffect(StatusEffects.NecroticRot))
        {
            monster.addStatusValue(StatusEffects.NecroticRot, 1, 1);
        }
        else
        {
            monster.createStatusEffect(StatusEffects.NecroticRot, 1, 0, 0, 0);
        }
    }
}


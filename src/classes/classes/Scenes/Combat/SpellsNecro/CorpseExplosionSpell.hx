package classes.scenes.combat.spellsNecro;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractNecroSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class CorpseExplosionSpell extends AbstractNecroSpell
{
    public function new()
    {
        super(
                "Corpse Explosion", 
                "Execute one of the many defeated opponents on the opposite team causing it to explode in a shower of gore and piercing bones. Only work on group type enemies with less than 80% of their HP left.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING]
        );
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " true damage.";
    }
    
    override public function calcCooldown() : Int
    {
        return spellBlackTier2Cooldown();
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsCorpseExplosion);
    }
    
    override private function usabilityCheck() : String
    {
        if ((!monster.plural
            || !monster.hasPerk(PerkLib.Enemy300Type)
            || !monster.hasPerk(PerkLib.EnemyGroupType)
            || !monster.hasPerk(PerkLib.EnemyLargeGroupType)) && monster.HP > monster.maxHP() * 0.8)
        {
            return "You can only use that spell on enemy groups that have less than 80% of members left.";
        }
        if (monster.statusEffectv1(StatusEffects.CorpseExplosion) >= 4)
        {
            return "You can't use that spell on enemy groups that have less than 20% of members left.";
        }
        return super.usabilityCheck();
    }
    
    public function calcDebuffPower(monster : Monster, randomize : Bool = true) : Float
    {
        var shatterIt : Float = 0.2;
        shatterIt *= boneSoulBonus(demonBonesCost());
        return shatterIt;
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var damage : Float = adjustSpellDamage(
                scalingBonusIntelligence() * 5, 
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
        return damage;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You concentrate your powers on one of the bodies of your fallen foes causing it to bloat and explode! ");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.TRUE);
        checkAchievementDamage(damage);
        if (monster.hasStatusEffect(StatusEffects.CorpseExplosion))
        {
            monster.addStatusValue(StatusEffects.CorpseExplosion, 1, 1);
        }
        else
        {
            monster.createStatusEffect(StatusEffects.CorpseExplosion, 1, 0, 0, 0);
        }
    }
}


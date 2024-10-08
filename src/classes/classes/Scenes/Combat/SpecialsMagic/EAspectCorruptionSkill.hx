package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.Combat;

class EAspectCorruptionSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Elemental Aspect: Corruption", 
                "Attack with a stronger version of a corruption-attributed basic elemental attack. Damage is increased the more pure the enemy.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER2], 
                StatusEffects.SummonedElementalsCorruption
        );
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }
    
    override public function calcCooldown() : Int
    {
        return -1;
    }
    
    override private function get_buttonName() : String
    {
        return "Corruption E.Asp";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(monster)) + " magical damage";
    }
    
    override public function manaCost() : Float
    {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsCorruption);
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var damage : Float = elementalAspectBaseDamage(StatusEffects.SummonedElementalsCorruption);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsCorruption, damage);
        if (monster != null)
        {
            damage *= combat.corruptionScalingDA();
        }
        
        return damage;
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        var damage : Float = calcDamage(monster);
        
        //Determine if critical hit!
        var crit : Bool = false;
        var critChance : Int = 5;
        critChance += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals))
        {
            critChance = 0;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            damage *= 1.5;
        }
        
        damage = Math.round(damage);
        
        if (display)
        {
            outputText("Your corruption elemental condenses corruption from air into solid matter, striking your opponent with them ");
        }
        doMagicDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>Critical!</b>");
        }
        outputText("\n\n");
    }
}

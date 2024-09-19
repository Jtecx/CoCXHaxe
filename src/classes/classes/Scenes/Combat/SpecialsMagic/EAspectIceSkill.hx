package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.Combat;

class EAspectIceSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Elemental Aspect: Ice", 
                "Attack with a stronger version of a ice-attributed basic elemental attack.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_ICE, TAG_MAGICAL, TAG_TIER2], 
                StatusEffects.SummonedElementalsIce
        );
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }
    
    override public function calcCooldown() : Int
    {
        return -1;
    }
    
    override private function get_buttonName() : String
    {
        return "Ice E.Asp";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(monster)) + " ice damage";
    }
    
    override public function manaCost() : Float
    {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsIce);
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var damage : Float = elementalAspectBaseDamage(StatusEffects.SummonedElementalsIce);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsIce, damage);
        
        return damage;
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        var damage : Float = calcDamage(monster);
        damage = calcGlacialMod(damage, true);
        
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
            outputText("Your elemental produces a ray of hyper condensed cold and aims it straight at [themonster] dealing ");
        }
        doIceDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>Critical!</b>");
        }
        outputText("\n\n");
    }
}

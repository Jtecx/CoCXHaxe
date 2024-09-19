package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.Combat;

class EAspectLightningSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Elemental Aspect: Lightning", 
                "Attack with a stronger version of a lightning-attributed basic elemental attack.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_LIGHTNING, TAG_MAGICAL, TAG_TIER2], 
                StatusEffects.SummonedElementalsLightning
        );
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }
    
    override public function calcCooldown() : Int
    {
        return -1;
    }
    
    override private function get_buttonName() : String
    {
        return "Lightning E.Asp";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(monster)) + " lightning damage";
    }
    
    override public function manaCost() : Float
    {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsLightning);
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var damage : Float = elementalAspectBaseDamage(StatusEffects.SummonedElementalsLightning);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsLightning, damage);
        
        return damage;
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        var damage : Float = calcDamage(monster);
        damage = calcVoltageMod(damage, true);
        
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
            outputText("Your elemental charges electricity, then discharges it with a blinding bolt doing ");
        }
        doLightningDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>Critical!</b>");
        }
        outputText("\n\n");
    }
}

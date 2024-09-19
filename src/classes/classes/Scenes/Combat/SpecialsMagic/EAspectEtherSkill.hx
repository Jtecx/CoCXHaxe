package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.Combat;

class EAspectEtherSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Elemental Aspect: Ether", 
                "Attack with a stronger version of a ether-attributed basic elemental attack. Deals increased damage if the enemy is weak to Fire, Ice, Lightning or Darkness.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER2], 
                StatusEffects.SummonedElementalsEther
        );
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }
    
    override public function calcCooldown() : Int
    {
        return -1;
    }
    
    override private function get_buttonName() : String
    {
        return "Ether E.Asp";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(monster)) + " magic damage";
    }
    
    override public function manaCost() : Float
    {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsEther);
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var damage : Float = elementalAspectBaseDamage(StatusEffects.SummonedElementalsEther);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsEther, damage);
        damage *= 0.5;
        
        if (monster != null && monster.hasPerk(PerkLib.FireNature))
        {
            damage *= 5;
        }
        if (monster != null && monster.hasPerk(PerkLib.FireVulnerability))
        {
            damage *= 2;
        }
        if (monster != null && monster.hasPerk(PerkLib.IceNature))
        {
            damage *= 5;
        }
        if (monster != null && monster.hasPerk(PerkLib.IceVulnerability))
        {
            damage *= 2;
        }
        if (monster != null && monster.hasPerk(PerkLib.LightningNature))
        {
            damage *= 5;
        }
        if (monster != null && monster.hasPerk(PerkLib.LightningVulnerability))
        {
            damage *= 2;
        }
        if (monster != null && monster.hasPerk(PerkLib.DarknessNature))
        {
            damage *= 5;
        }
        if (monster != null && monster.hasPerk(PerkLib.DarknessVulnerability))
        {
            damage *= 2;
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
            outputText("Your elemental unleash a barrage of star shaped bolts of arcane energy, blasting your opponent. ");
        }
        doMagicDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>Critical!</b>");
        }
        outputText("\n\n");
    }
}

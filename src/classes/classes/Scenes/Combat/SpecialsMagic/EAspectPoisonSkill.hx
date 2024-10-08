package classes.scenes.combat.specialsMagic;

import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.Combat;

class EAspectPoisonSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Elemental Aspect: Poison", 
                "Attack with a stronger version of a poison-attributed basic elemental attack.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_LUSTDMG, TAG_MAGICAL, TAG_TIER2], 
                StatusEffects.SummonedElementalsPoison
        );
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }
    
    override public function calcCooldown() : Int
    {
        return -1;
    }
    
    override private function get_buttonName() : String
    {
        return "Poison E.Asp";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(monster)) + " poison damage and ~" + numberFormat(calcLustDamage(monster)) + " lust damage";
    }
    
    override public function manaCost() : Float
    {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsPoison);
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var damage : Float = elementalAspectBaseDamage(StatusEffects.SummonedElementalsPoison);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsPoison, damage);
        
        return damage;
    }
    
    public function calcLustDamage(monster : Monster) : Float
    {
        var lustDamage : Float = calcDamage(monster) * 0.75;
        
        if (player.armor == armors.ELFDRES && player.isElf())
        {
            lustDamage *= 2;
        }
        if (player.armor == armors.FMDRESS && player.isWoodElf())
        {
            lustDamage *= 2;
        }
        
        return lustDamage;
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
            outputText("Your poison elemental condenses aphrodisiac poison into spikes, striking your opponent with them ");
        }
        doPoisonDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>Critical!</b>");
        }
        
        var lustDamage : Float = calcLustDamage(monster);
        monster.teased(Math.round(monster.lustVuln * lustDamage));
        outputText("\n\n");
    }
}

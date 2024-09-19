package classes.scenes.combat.general;

import classes.PerkLib;
import classes.Monster;
import classes.scenes.combat.Combat;
import classes.scenes.combat.AbstractGeneral;
import classes.StatusEffects;

class GoblinLustBombSkill extends AbstractGeneral
{
    
    public function new()
    {
        super(
                "Aphrodigas Gun", 
                "Gass the opponent with aphrodisiacs. Increased damage to groups.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_LUSTDMG], 
                null
        );
        lastAttackType = Combat.LAST_ATTACK_LUST;
        icon = "A_Tease";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Deals ~" + numberFormat(calcLustDamage(target)) + " lust damage.";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.isInGoblinMech();
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (!(player.hasKeyItem("Lustnade Launcher") >= 0 || player.hasKeyItem("Aphrodigas Gun") >= 0))
        {
            return "No way you could make an enemy more aroused by striking a seductive pose and exposing parts of your body while piloting goblin mech.";
        }
        
        if (monster.hasStatusEffect(StatusEffects.Dig))
        {
            return "The enemy cannot see your tease when they're underground.";
        }
        
        if (combat.isEnemyInvisible)
        {
            return "You cannot tease an opponent you cannot see or target, heck is it even looking at you right now?";
        }
        
        return "";
    }
    
    override private function get_name() : String
    {
        if (player.hasKeyItem("Lustnade Launcher") >= 0)
        {
            return "Lustnade Launcher";
        }
        else
        {
            return super.name;
        }
    }
    
    override private function get_description() : String
    {
        if (player.hasKeyItem("Lustnade Launcher") >= 0)
        {
            return "Launch Lustnade at enemy, dealing really heavy lust damage.";
        }
        else
        {
            return super.description;
        }
    }
    
    public function calcLustDamage(monster : Monster) : Float
    {
        var lustDmg : Float = scalingBonusIntelligence() + scalingBonusLibido();
        if (player.hasKeyItem("Lustnade Launcher") >= 0)
        {
            lustDmg = combat.teases.teaseAuraLustDamageBonus(monster, lustDmg);
        }
        if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))
        {
            lustDmg *= 5;
        }
        lustDmg = combat.goblinDamageBonus(lustDmg);
        lustDmg = combat.tinkerDamageBonus(lustDmg);
        if (monster != null && monster.plural)
        {
            lustDmg *= 5;
        }
        if (monster != null)
        {
            lustDmg *= monster.lustVuln;
        }
        return lustDmg;
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        clearOutput();
        
        var lustDmg : Float = calcLustDamage(monster);
        var hitChance : Float = 75;
        
        //Determine if critical tease!
        var crit : Bool = false;
        var critChance : Int = 5;
        critChance += combat.teases.combatTeaseCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals))
        {
            critChance = 0;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            lustDmg *= 1.75;
            if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !player.enemiesImmuneToLustResistanceDebuff())
            {
                monster.lustVuln += 0.05;
            }
            if (monster.lustVuln > monster.lustVulnCap())
            {
                monster.lustVuln = monster.lustVulnCap();
            }
        }
        
        if (player.hasKeyItem("Lustnade Launcher") >= 0)
        {
            if (display)
            {
                outputText("You ready the Lustnade launcher and shoot." +
                        " The exploding container covers the entire area in pink mist, massively arousing everyone in the vicinity.");
            }
            
            monster.teased(Math.round(lustDmg), false, display);
        }
        else
        {
            if (display)
            {
                outputText("You spray a cloud of aphrodisiac with your gas gun. [Themonster] tries to pinch [monster his] nose and hold [monster his] breath ");
            }
            
            if (rand(100) <= hitChance)
            {
                if (display)
                {
                    outputText("but it’s too late and you can see arousal flushing [themonster]'s skin.\n");
                }
                monster.teased(Math.round(lustDmg), false, display);
            }
            else if (display)
            {
                outputText("and it worked, to an extent, allowing your opponent to retreat away from the gas.");
            }
        }
        if (display)
        {
            outputText("\n\n");
        }
    }
}

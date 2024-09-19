package classes.scenes.combat.soulskills;

import classes.PerkLib;
import classes.scenes.combat.AbstractBloodSoulSkill;
import classes.Monster;
import classes.globalFlags.KFLAGS;
import classes.scenes.combat.Combat;

class BloodDewdropsPuppiesSkill extends AbstractBloodSoulSkill
{
    public function new(sfInfusion : Bool = false)
    {
        super(
                "Blood Puppies: Blood Dewdrops", 
                "Command Blood Puppies to attack the enemy with Blood Dewdrops. Deals increased damage to groups.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_PHYSICAL], 
                PerkLib.MyBloodForBloodPuppies, 
                true, 
                sfInfusion
        );
        baseSFCost = 80;
        lastAttackType = Combat.LAST_ATTACK_PHYS;
    }
    
    override private function baseName() : String
    {
        return "BP: Blood Dewdrops";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(target) * 4) + " blood damage";
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var damage : Float = scalingBonusWisdom() * spellModBlood() * 6.75;
        var damageFloor : Float = 10;
        damage *= bloodPuppiesDamageBonusMod();
        damage *= soulskillPhysicalMod();
        if (damage < damageFloor)
        {
            damage = damageFloor;
        }
        if (monster != null && monster.plural)
        {
            damage *= 10;
        }
        if (player.hasPerk(PerkLib.BloodAffinity))
        {
            damage *= 2;
        }
        if (player.hasPerk(PerkLib.BloodMastery))
        {
            damage *= 2;
        }
        damage *= combat.bloodDamageBoostedByDao();
        return Math.round(damage);
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("Giving command to your blood puppies, they start focusing the power of blood. Within an instant, many red dewdrops shoot from one of their front paws each, flying toward [themonster]! ");
        }
        var damage : Float = calcDamage(monster);
        //Determine if critical hit!
        var crit : Bool = false;
        var critChance : Int = 5;
        critChance += combatPhysicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals))
        {
            critChance = 0;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            damage *= ((bloodPuppiesDamageBonusMod() / 2) + 1.25);
        }
        doDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        doDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        doDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        doDamage(damage, true, display);
        if (crit && display)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        if (flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] != 1)
        {
            flags[kFLAGS.IN_COMBAT_PLAYER_BLOOD_PUPPIES_ATTACKED] = 1;
        }
        endTurnByBloodSkillUse(damage, display, false);
    }
}

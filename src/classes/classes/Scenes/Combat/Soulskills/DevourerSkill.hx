package classes.scenes.combat.soulskills;

import classes.scenes.combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.globalFlags.KFLAGS;
import classes.scenes.combat.Combat;

class DevourerSkill extends AbstractSoulSkill
{
    public function new()
    {
        super(
                "Devourer", 
                "Form a small sphere inscribed by symbols to drain from enemy a bit of lust and/or wrath.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DEBUFF, TAG_TIER2], 
                StatusEffects.KnowsHeavensDevourer
        );
        lastAttackType = Combat.LAST_ATTACK_SPELL;
    }
    
    override private function get_buttonName() : String
    {
        return "Devourer";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Drains ~" + numberFormat(calcLustDrain(target, false)) + "lust and ~" + numberFormat(calcWrathDrain(target, false)) + " wrath";
    }
    
    override public function calcCooldown() : Int
    {
        return soulskillTier2Cooldown(4, false);
    }
    
    private function calcLustDrain(monster : Monster, apply : Bool) : Float
    {
        var drainAmount : Float = 0;
        if (monster == null)
        {
            return drainAmount;
        }
        if (monster.lust > 400)
        {
            if (apply)
            {
                monster.lust -= 400;
            }
            drainAmount += 200;
        }
        else
        {
            var devouredLust : Float = monster.lust;
            if (apply)
            {
                monster.lust = 0;
            }
            drainAmount += Math.round(devouredLust / 2);
        }
        return drainAmount;
    }
    
    private function calcWrathDrain(monster : Monster, apply : Bool) : Float
    {
        var drainAmount : Float = 0;
        if (monster == null)
        {
            return drainAmount;
        }
        if (monster.wrath > 400)
        {
            if (apply)
            {
                monster.wrath -= 400;
            }
            drainAmount += 200;
        }
        else
        {
            var devouredWrath : Float = monster.wrath;
            if (apply)
            {
                monster.wrath = 0;
            }
            drainAmount += Math.round(devouredWrath / 2);
        }
        return drainAmount;
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You start to concentrate and between your hands forms small black sphere inscribed with many tiny symbols. With a simple flick of hand you send it toward [themonster], which preparing to defend. But sphere stops a round twenty centimiters before [monster his]. ");
            outputText("And then it starts greedy sucking our any bit of lust or wrath it can find in [themonster] trasmiting part of it back to you.");
        }
        var transferedWrath : Float = calcLustDrain(monster, true);
        var transferedLust : Float = calcWrathDrain(monster, true);
        if (transferedLust > 0)
        {
            if (display)
            {
                outputText("(+" + transferedLust + " lust)");
            }
            player.lust += transferedLust;
        }
        if (transferedWrath > 0)
        {
            if (display)
            {
                outputText("(+" + transferedWrath + " wrath)");
            }
            player.wrath += transferedWrath;
        }
        if (display)
        {
            outputText("\n\n");
        }
    }
}

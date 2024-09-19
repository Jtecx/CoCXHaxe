package classes.scenes.combat.spellsGreen;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractGreenSpell;
import classes.StatusEffects;

class DeathBlossomSpell extends AbstractGreenSpell
{
    public function new()
    {
        super("Death Blossom", 
                "Deliver deadly poison and strong aphrodisiac by causing nearby vegetation to bloom corrupted flowers which inflicts their poison each round for 3 rounds. Deals severe tease and poison damage over time intensifying every round by 20%.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_LUSTDMG, TAG_TIER2]
        );
        baseManaCost = 100;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsDeathBlossom);
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(target, false, false)) + " lust poison damage and poison DoT intensifying every round by 20%";
    }
    
    override public function calcCooldown() : Int
    {
        return spellWhiteTier2Cooldown();
    }
    
    override public function calcDuration() : Int
    {
        var dura : Float = 5;
        if (player.hasPerk(PerkLib.GreenMagic))
        {
            dura *= 2;
        }
        return dura;
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (!combat.isNearPlants())
        {
            return "Death Blossom require to have plants nearby.";
        }
        
        return "";
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var baseDamage : Float = 3 * scalingBonusIntelligence() + 3 * scalingBonusLibido();
        return adjustLustDamage(baseDamage, monster, CAT_SPELL_GREEN, randomize);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You concentrate your desire on the nearby plants causing their flowers to spontaneously bloom in a cloud of corrupted pollen.\n");
        }
        monster.createStatusEffect(StatusEffects.DeathBlossom, calcDuration(), 1, 0, 0);
        
        var lustDmg : Float = calcDamage(monster, true, true);
        var resultArray : Array<Dynamic> = critAndRepeatLust(display, lustDmg, CAT_SPELL_GREEN);
        postLustSpellEffect(resultArray[1]);
        if (display)
        {
            outputText("\n");
        }
    }
}


package classes.scenes.combat.spellsWhite;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractWhiteSpell;
import classes.StatusEffects;

class MentalShieldSpell extends AbstractWhiteSpell
{
    public function new()
    {
        super(
                "Mental Shield", 
                "Protects against lust effects for 10 rounds, halving the damage.  ", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF]
        );
        baseManaCost = 300;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsMentalShield);
    }
    
    override private function get_description() : String
    {
        return "Protects against lust effects for " + calcDuration() + " rounds, halving the damage.  ";
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 7;
        calcC += spellGenericCooldown();
        return calcC;
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.MentalShield);
    }
    
    override public function calcDuration() : Int
    {
        var mentalshieldduration : Float = 10;
        if (player.hasPerk(PerkLib.DefensiveStaffChanneling) && (player.weapon.isStaffType() || player.weaponOff.isStaffType() || player.weapon.isWandType() || player.weaponOff.isWandType()))
        {
            mentalshieldduration *= 1.2;
        }
        return Math.round(mentalshieldduration);
    }
    
    override public function advance(display : Bool) : Void
    {
        if (player.statusEffectv1(StatusEffects.MentalShield) <= 0)
        {
            player.removeStatusEffect(StatusEffects.MentalShield);
        }
        else
        {
            player.addStatusValue(StatusEffects.MentalShield, 1, -1);
        }
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You draw on your inner calm, forcing it out in the form of a powerful magical ward to weaken the effect of your opponent’s depraved attacks on you.");
        }
        player.createStatusEffect(StatusEffects.MentalShield, calcDuration(), 0, 0, 0);
    }
}


package classes.scenes.combat.spellsGrey;

import classes.EngineCore;
import classes.Monster;
import classes.scenes.combat.AbstractGreySpell;
import classes.StatusEffects;

class EnergyDrainSpell extends AbstractGreySpell
{
    public function new()
    {
        super(
                "Energy Drain", 
                "Fatigue the target (-20% damage for 7 rounds) and recover mana by draining the target's mana (up to 4x of spell cost).", 
                TARGET_ENEMY, 
                TIMING_LASTING, 
                [TAG_DEBUFF, TAG_RECOVERY]
        );
        baseManaCost = 350;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsEnergyDrain);
    }
    
    override public function isActive() : Bool
    {
        return monster.hasStatusEffect(StatusEffects.EnergyDrain);
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 4;
        calcC += spellGenericCooldown();
        return calcC;
    }
    
    override public function calcDuration() : Int
    {
        return 7;
    }
    
    public function calcMagnitude(target : Monster) : Float
    {
        var energydrain : Float = monster.mana;
        energydrain = Math.min(monster.mana, manaCost() * 5);
        return Math.round(energydrain);
    }
    
    
    override public function advance(display : Bool) : Void
    {
        if (monster.hasStatusEffect(StatusEffects.EnergyDrain))
        {
            if (monster.statusEffectv1(StatusEffects.EnergyDrain) <= 0)
            {
                monster.removeStatusEffect(StatusEffects.EnergyDrain);
            }
            else
            {
                monster.addStatusValue(StatusEffects.EnergyDrain, 1, -1);
            }
        }
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (!backfired(display))
        {
            if (display)
            {
                outputText("You point at [themonster] and with a sharp pulling gesture you rip out some of their vigor for your own use. They won’t be hitting at full strength for a while.");
            }
            var magnitude : Float = calcMagnitude(monster);
            if (magnitude > 0)
            {
                monster.createStatusEffect(StatusEffects.EnergyDrain, calcDuration(), 0, 0, 0);
            }
            player.mana += magnitude;
            monster.mana -= magnitude;
        }
    }
}


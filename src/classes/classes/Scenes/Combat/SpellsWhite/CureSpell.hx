package classes.scenes.combat.spellsWhite;

import classes.scenes.combat.AbstractWhiteSpell;
import classes.StatusEffectType;
import classes.StatusEffects;

class CureSpell extends AbstractWhiteSpell
{
    
    /**
	 * Spell completely removes these buffs
	 */
    public var CurableBuffs(default, never) : Array<Dynamic> = [
        "LightningArrowStr", 
        "LightningArrowSpe", 
        "FireArrow", 
        "IceArrow", 
        "Illusion", 
        "Fear", 
        "CombatDebuffStr", 
        "CombatDebuffSpe", 
        "BasiliskGaze", 
        "LightningArrow", 
        "AkbalDebuff", 
        "FrostGiantDebuff", 
        "GnollSpearThrowerDebuff", 
        "YoungFrostGiantDebuff", 
        "PoisonedArrow", 
        "MalikoreVenom", 
        "ManticoreVenom", 
        "Nightmare", 
        "Entwine", 
        "Poison"
    ];
    
    /**
	 * Spell removes these status effects
	 */
    public var CurableEffects(default, never) : Array<Dynamic> = [
        StatusEffects.BurnDoT, 
        StatusEffects.AcidSlap, 
        StatusEffects.DriderKiss, 
        StatusEffects.AikoLightningArrow, 
        StatusEffects.NagaVenom, 
        StatusEffects.MedusaVenom, 
        StatusEffects.DriderIncubusVenom, 
        StatusEffects.Poison, 
        StatusEffects.AcidDoT, 
        StatusEffects.FrostburnDoT, 
        StatusEffects.FrozenLung, 
        StatusEffects.Blind
    ];
    
    public function new()
    {
        super(
                "Cure", 
                "Negate all status ailments. Restore stat damaged by poison.", 
                TARGET_SELF, 
                TIMING_INSTANT, 
                [TAG_RECOVERY]
        );
        baseManaCost = 500;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsCure);
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 4;
        calcC += spellGenericCooldown();
        return calcC;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You channel white magic to rid yourself of all negative effect affecting you.");
        }
        for (buff in CurableBuffs)
        {
            player.buff(buff).remove();
        }
        for (type in CurableEffects)
        {
            player.removeStatusEffect(type);
        }
        if (player.statStore.hasBuff("Weakened") || player.statStore.hasBuff("Drained"))
        {
            for (stat in ["str", "spe", "tou", "int", "wis", "lib", "sens"])
            {
                player.removeCurse(stat, 6, 1);
                player.removeCurse(stat, 3, 2);
                if (stat != "sens")
                {
                    player.removeCurse(stat + ".mult", 0.06, 1);
                    player.removeCurse(stat + ".mult", 0.03, 2);
                }
            }
        }
    }
}


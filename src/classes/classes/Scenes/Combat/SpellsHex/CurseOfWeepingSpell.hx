package classes.scenes.combat.spellsHex;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractHexSpell;
import classes.scenes.combat.Combat;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class CurseOfWeepingSpell extends AbstractHexSpell
{
    public function new()
    {
        super(
                "Curse of Weeping", 
                "Draw your own blood and inflict on your target a terrible curse, dealing high damage for 6 rounds.", 
                TARGET_ENEMY, 
                TIMING_LASTING, 
                [TAG_DAMAGING]
        );
        baseManaCost = 300;
        useManaType = Combat.USEMANA_BLACK;
        canBackfire = true;
    }
    
    override private function get_buttonName() : String
    {
        return "CurseOfWeep";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "" +
        numberFormat(calcDamage(target, false, false)) + " damage over " +
        numberOfThings(calcDuration(), "round") +
        "; " + calcBackfirePercent() + "% backfire";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsCurseOfWeeping);
    }
    
    override public function isActive() : Bool
    {
        return monster.hasStatusEffect(StatusEffects.CurseOfWeeping);
    }
    
    override public function calcDuration() : Int
    {
        return 6;
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 7;
        calcC += spellGenericCooldown();
        if (player.hasPerk(PerkLib.Necromancy))
        {
            calcC -= 1;
        }
        return calcC;
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (player.HP < hpCost())
        {
            return "Your HP is too low to cast this spell. ";
        }
        
        return "";
    }
    
    override public function advance(display : Bool) : Void
    {
        if (monster.statusEffectv1(StatusEffects.CurseOfWeeping) <= 0)
        {
            monster.removeStatusEffect(StatusEffects.CurseOfWeeping);
        }
        else
        {
            monster.addStatusValue(StatusEffects.CurseOfWeeping, 1, -1);
            if (display)
            {
                outputText("Your foe is bleeding due to your curse. ");
            }
            var hemorrhage3Damage : Float = 0;
            hemorrhage3Damage += monster.statusEffectv2(StatusEffects.CurseOfWeeping);
            hemorrhage3Damage *= 0.2;
            if (player.hasPerk(PerkLib.Necromancy))
            {
                hemorrhage3Damage *= 1.5;
            }
            hemorrhage3Damage = Math.round(hemorrhage3Damage);
            combat.doDamage(hemorrhage3Damage, true, display);
            if (display)
            {
                outputText("\n\n");
            }
        }
    }
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        return adjustSpellDamage(
                scalingBonusIntelligence() * 2, 
                DamageType.GENERIC, 
                CAT_SPELL_HEX, 
                monster, 
                false, 
                casting
        );
    }
    
    override public function hpCost() : Float
    {
        return Math.round(player.maxHP() * 0.5);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You focus on your magic, trying to draw on it without enhancing your own arousal.\n");
        }
        if (!backfired(display))
        {
            if (display)
            {
                outputText("You cut deep into your arm, drawing plenty of your blood and letting it flow in a large pattern on the ground as you hex your target with a powerful malediction, causing it to bleed from every orifice. [Themonster] screams in pain, unable to stop the blood flow. ");
            }
            HPChange(-hpCost(), false);
            var CurseOfWeepingMod : Float = calcDamage(monster, true, true);
            monster.createStatusEffect(StatusEffects.CurseOfWeeping, calcDuration(), CurseOfWeepingMod, 0, 0);
            doDamage(CurseOfWeepingMod, true, true);
        }
    }
}


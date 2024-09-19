package classes.scenes.combat.spellsWhite;

import classes.globalFlags.KACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractWhiteSpell;
import classes.scenes.combat.DamageType;
import classes.scenes.dungeons.d3.Lethice;
import classes.scenes.nPCs.Diva;
import classes.StatusEffects;

class WhitefireSpell extends AbstractWhiteSpell
{
    
    private var ex : Bool;
    
    private function new(ex : Bool = false)
    {
        super(
                (ex) ? "Whitefire (Ex)" : "Whitefire", 
                (ex) ? 
                "Whitefire (Ex) is a potent wrath-empowered fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors." : "Whitefire is a potent fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_FIRE, TAG_TIER1]
        );
        baseManaCost = 40;
        baseWrathCost = (ex) ? 100 : 0;
        this.ex = ex;
    }
    
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " fire damage";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsWhitefire) &&
        (!ex || player.hasPerk(PerkLib.MagesWrathEx));
    }
    
    override public function calcCooldown() : Int
    {
        var calcC : Int = 0;
        calcC += spellWhiteCooldown();
        if (player.weaponRange == weaponsrange.RW_TOME && player.level < 18)
        {
            if (player.level < 6)
            {
                calcC -= 1;
            }
            if (player.level < 12)
            {
                calcC -= 1;
            }
            calcC -= 1;
            if (calcC < 0)
            {
                calcC = 0;
            }
        }
        return calcC;
    }
    
    /**
	 * Calculate real (or theoretic) damage dealt by this spell
	 * @param monster Target, or null if no target (ex. for description outside combat)
	 * @param randomize true: Apply random bonus, false: Apply average bonus
	 * @return {Number} Damage dealt by this spell
	 */
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    {
        var baseDamage : Float = 2 * scalingBonusIntelligence(randomize);
        if (player.weaponRangeName == "Artemis")
        {
            baseDamage *= 1.5;
        }
        if (ex)
        {
            baseDamage *= 2;
        }
        return adjustSpellDamage(baseDamage, DamageType.FIRE, CAT_SPELL_WHITE, monster, true, casting);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (Std.is(monster, Lethice) && (try cast(monster, Lethice) catch(e:Dynamic) null).fightPhase == 2)
        {
            if (display)
            {
                outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
            }
            monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
        }
        else if (display)
        {
            outputText("You narrow your eyes, focusing your mana into your thumb and middle finger.  You let the heat build, flowing from your mind and down your arm, until you raise your hand. You snap your fingers, releasing your power and the heat in an instant. [themonster] is enveloped in a flash of white flames.\n");
        }
        var damage : Float = calcDamage(monster, true, true);
        damage = critAndRepeatDamage(display, damage, DamageType.FIRE);
        if (ex)
        {
            awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
        }
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}



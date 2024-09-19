package classes.scenes.combat.spellsBlack;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractBlackSpell;
import classes.StatusEffects;

class MightSpell extends AbstractBlackSpell
{
    public function new()
    {
        super(
                "Might", 
                "The Might spell draws upon your lust and uses it to fuel a temporary increase in muscle size and power.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF]
        );
        baseManaCost = 50;
        canBackfire = true;
    }
    
    override public function manaCost() : Float
    {
        return super.manaCost() * costMultiplier();
    }
    
    private function costMultiplier() : Float
    {
        var spellMightMultiplier : Float = 1;
        if (player.hasPerk(PerkLib.EverLastingBuffs))
        {
            spellMightMultiplier *= 2;
        }
        if (player.hasPerk(PerkLib.EternalyLastingBuffs))
        {
            spellMightMultiplier *= 2;
        }
        if (player.hasPerk(PerkLib.SelfbuffsProficiencySu))
        {
            spellMightMultiplier *= 2;
        }
        return spellMightMultiplier;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsMight);
    }
    
    override public function isActive() : Bool
    {
        return player.statStore.hasBuff("Might");
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        var boost : Float = Math.round(calcBoost());
        var effect : String = "+" + boost + "% tou";
        if (player.hasStatusEffect(StatusEffects.FortressOfIntellect))
        {
            effect += ", +" + Math.round(boost * 1.25) + "% int";
        }
        else
        {
            effect += "&str";
        }
        effect += " for " + calcDuration() + " rounds";
        var backfire : Int = calcBackfirePercent();
        if (backfire > 0)
        {
            effect += "; " + backfire + "% backfire";
        }
        return effect;
    }
    
    /**
	 * In %
	 */
    public function calcBoost() : Float
    {
        var MightBoostCap : Float = 1.5;
        if (player.hasPerk(PerkLib.SelfbuffsProficiency))
        {
            var capB : Float = 1.3;
            if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx))
            {
                capB += 0.7;
            }
            if (player.hasPerk(PerkLib.SelfbuffsProficiencySu))
            {
                capB *= 5;
            }
            MightBoostCap *= capB;
        }
        MightBoostCap *= player.intStat.core.max;
        MightBoostCap = Math.round(MightBoostCap);
        var MightBoost : Float = player.intStat.core.value;
        //MightBoost += Math.round(player.intStat.max * 0.1); - może tylko jak bedzie mieć perk z prestige job: magus / warock / inny związany z spells (maybe only when they have a perk from the prestige job: magus/warlock/another related to spells)
        if (MightBoost < 10)
        {
            MightBoost = 10;
        }
        if (player.hasPerk(PerkLib.JobEnchanter))
        {
            MightBoost *= 1.2;
        }
        MightBoost *= spellModBlack();
        if (MightBoost > MightBoostCap)
        {
            MightBoost = MightBoostCap;
        }
        return Math.round(MightBoost);
    }
    
    override public function calcDuration() : Int
    {
        var MightDuration : Float = 5;
        MightDuration += combat.magic.perkRelatedDurationBoosting();
        return MightDuration;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You flush, drawing on your body's desires to empower your muscles and toughen you up.\n\n");
        }
        if (!backfired(display))
        {
            if (display)
            {
                outputText("The rush of success and power flows through your body.  You feel like you can do anything!");
            }
            var MightBoost : Float = calcBoost();
            var MightDuration : Float = calcDuration();
            var tempTou : Float = MightBoost;
            var tempInt : Float = 0;
            var tempStr : Float = 0;
            if (player.hasStatusEffect(StatusEffects.FortressOfIntellect))
            {
                tempInt = Math.round(MightBoost * 1.25);
            }
            else
            {
                tempStr = MightBoost;
            }
            var oldHPratio : Float = player.hp100 / 100;
            var buffValues : Dynamic = {
                tou.mult : tempTou / 100
            };
            if (tempInt > 0)
            {
                Reflect.setField(buffValues, "int.mult", tempInt / 100);
            }
            if (tempStr > 0)
            {
                Reflect.setField(buffValues, "str.mult", tempStr / 100);
            }
            player.buff("Might").setStats(buffValues).combatTemporary(MightDuration);
            player.HP = oldHPratio * player.maxHP();
        }
    }
}


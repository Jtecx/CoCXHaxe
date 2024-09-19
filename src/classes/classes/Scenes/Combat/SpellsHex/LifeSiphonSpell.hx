package classes.scenes.combat.spellsHex;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractHexSpell;
import classes.scenes.combat.Combat;
import classes.StatusEffects;

class LifeSiphonSpell extends AbstractHexSpell
{
    public function new()
    {
        super(
                "Life Siphon", 
                "Create a funnel between you and your target, forcefully stealing its vitality to recover your own.", 
                TARGET_ENEMY, 
                TIMING_LASTING, 
                [TAG_DAMAGING, TAG_HEALING]
        );
        baseManaCost = 750;
        useManaType = Combat.USEMANA_MAGIC_HEAL;
        canBackfire = true;
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "" + numberFormat(calcDamage(target, false, false)) + " HP leech for " +
        numberOfThings(calcDuration(), "round") +
        "; " + calcBackfirePercent() + "% backfire";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsLifeSiphon);
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.LifeSiphon);
    }
    
    override public function calcDuration() : Int
    {
        return 15;
    }
    
    override public function advance(display : Bool) : Void
    {
        if (player.statusEffectv1(StatusEffects.LifeSiphon) <= 0)
        {
            player.removeStatusEffect(StatusEffects.LifeSiphon);
        }
        else
        {
            player.addStatusValue(StatusEffects.LifeSiphon, 1, -1);
            if (display)
            {
                outputText("<b>[Themonster] health is being funneled to you through your life siphon hex. ([font-heal]+" + player.statusEffectv2(StatusEffects.LifeSiphon) + "[/font])</b>\n\n");
            }
            HPChange(player.statusEffectv2(StatusEffects.LifeSiphon), false);
            monster.HP -= player.statusEffectv2(StatusEffects.LifeSiphon);
        }
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var lifesiphon : Float = 0;
        lifesiphon += player.inte;
        if (player.hasPerk(PerkLib.WisenedHealer))
        {
            lifesiphon += player.wis;
        }
        if (monster != null)
        {
            if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34)
            {
                lifesiphon = Math.round(lifesiphon * 1.2);
            }
            lifesiphon *= corruptMagicPerkFactor(monster);
        }
        if (player.hasPerk(PerkLib.Necromancy))
        {
            lifesiphon *= 1.5;
        }
        if (player.hasPerk(PerkLib.CorruptMagic) && player.hasStatusEffect(StatusEffects.DarkRitual))
        {
            lifesiphon *= 2;
        }
        return Math.round(lifesiphon);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You focus on your magic, trying to draw on it without enhancing your own arousal.\n");
        }
        if (!backfired(display))
        {
            var lifesiphon : Float = calcDamage(monster, true, true);
            if (display)
            {
                outputText("You wave a sign linking yourself to [themonster] as you begin to funnel its health and vitality to yourself.");
            }
            monster.HP -= lifesiphon;
            HPChange(lifesiphon, false);
            player.createStatusEffect(StatusEffects.LifeSiphon, 15, lifesiphon, 0, 0);
        }
    }
}


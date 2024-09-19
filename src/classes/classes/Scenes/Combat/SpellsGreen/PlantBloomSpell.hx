package classes.scenes.combat.spellsGreen;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractGreenSpell;
import classes.StatusEffects;
import classes.CoC;

class PlantBloomSpell extends AbstractGreenSpell
{
    public function new()
    {
        super("Plant Bloom", 
                "Cause nearby plants to turn into invasive vines, inflicting lust damage.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_LUSTDMG, TAG_TIER1]
        );
        baseManaCost = 40;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsPlantGrowth) && (!CoC.instance.inCombat || combat.isNearPlants());
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(target, false, false)) + " lust poison damage";
    }
    
    override public function calcCooldown() : Int
    {
        return as3hx.Compat.parseInt(1 + spellWhiteCooldown());
    }
    
    override public function advance(display : Bool) : Void
    {
        if (player.hasStatusEffect(StatusEffects.PlantGrowth))
        {
            if (player.statusEffectv1(StatusEffects.PlantGrowth) <= 0)
            {
                player.removeStatusEffect(StatusEffects.PlantGrowth);
                if (display)
                {
                    outputText("<b>Plant Growth effect wore off!</b>\n\n");
                }
            }
            else
            {
                player.addStatusValue(StatusEffects.PlantGrowth, 1, -1);
            }
        }
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var baseDamage : Float = scalingBonusIntelligence() + scalingBonusLibido();
        return adjustLustDamage(baseDamage, monster, CAT_SPELL_GREEN, randomize);
    }
    
    override public function calcDuration() : Int
    {
        var dura : Float = 4;
        if (player.hasPerk(PerkLib.GreenMagic))
        {
            dura *= 2;
        }
        return dura;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (combat.isNearPlants())
        {
            if (display)
            {
                outputText("You focus your intent on the flora around you, infusing them with the power of your emotions. The onslaught of lust causes flowers to bloom into a pollen cloud as vine surges from the canopy and darts to your opponent.");
            }
            if (monster.lustVuln == 0)
            {
                if (display)
                {
                    outputText("\nIt has no effect!  Your foe clearly does not experience lust in the same way as you.\n");
                }
                return;
            }
            player.createStatusEffect(StatusEffects.PlantGrowth, calcDuration(), 0, 0, 0);
            
            var lustDmg : Float = calcDamage(monster, true, true);
            var resultArray : Array<Dynamic> = critAndRepeatLust(display, lustDmg, CAT_SPELL_GREEN);
            postLustSpellEffect(resultArray[1]);
            if (display)
            {
                outputText("\n");
            }
        }
    }
}


package classes.scenes.combat.spellsGreen;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractGreenSpell;
import classes.StatusEffects;
import classes.CoC;

class PlantGrowthSpell extends AbstractGreenSpell
{
    public function new()
    {
        super("Plant Growth", 
                "Grow plants around the caster.", 
                TARGET_SELF, 
                TIMING_INSTANT, 
                [TAG_BUFF]
        );
        baseManaCost = 50;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsPlantGrowth) && (!CoC.instance.inCombat || !combat.isNearPlants());
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Allows the use of Green Magic spells";
    }
    
    override public function calcCooldown() : Int
    {
        return as3hx.Compat.parseInt(1 + spellWhiteCooldown());
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You focus your energy on the world around you, causing vegetation to surge out of the ground at an accelerated rate into a verdant patch of vines and other tentacle greenery.\n");
        }
        player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
    }
}


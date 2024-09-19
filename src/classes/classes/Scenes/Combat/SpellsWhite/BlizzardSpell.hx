package classes.scenes.combat.spellsWhite;

import classes.PerkLib;
import classes.scenes.combat.AbstractWhiteSpell;
import classes.StatusEffects;

class BlizzardSpell extends AbstractWhiteSpell
{
    public function new()
    {
        super(
                "Blizzard", 
                "Blizzard is a potent ice based defense spell that will reduce the power of any fire based attack used against the user.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF, TAG_ICE]
        );
        baseManaCost = 50;
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBlizzard);
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.Blizzard);
    }
    
    override public function advance(display : Bool) : Void
    {
        if (player.hasStatusEffect(StatusEffects.Blizzard))
        
        //Remove blizzard if countdown to 0{
            
            if (player.statusEffectv1(StatusEffects.Blizzard) <= 0)
            {
                player.removeStatusEffect(StatusEffects.Blizzard);
                if (display)
                {
                    outputText("<b>The swirling snow around you stops, the flakes melted into water. You're no longer protected from fire attacks!</b>\n\n");
                }
            }
            else
            {
                player.addStatusValue(StatusEffects.Blizzard, 1, -1);
                if (display)
                {
                    outputText("<b>The blizzard is noticably thinner than before.</b>\n\n");
                }
            }
        }
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("your mana trailing from your hands and feet and into the air around you. You feel the temperature drop around you, thick snowflakes in a spiraling sheet around you. This icy shield grants you more protection from fire attacks...For now\n\n");
        }
        var blizzardmagnitude : Float = 0;
        if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity))
        {
            blizzardmagnitude += 2 + player.inte / 10;
        }
        else
        {
            blizzardmagnitude += 1 + player.inte / 25;
        }
        if (player.hasPerk(PerkLib.DefensiveStaffChanneling) && (player.weapon.isStaffType() || player.weaponOff.isStaffType() || player.weapon.isWandType() || player.weaponOff.isWandType()))
        {
            blizzardmagnitude *= 1.2;
        }
        player.createStatusEffect(StatusEffects.Blizzard, Math.round(blizzardmagnitude), 0, 0, 0);
    }
}


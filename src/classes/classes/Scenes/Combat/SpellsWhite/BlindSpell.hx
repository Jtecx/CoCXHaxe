package classes.scenes.combat.spellsWhite;

import classes.scenes.combat.AbstractWhiteSpell;
import classes.scenes.dungeons.d3.Lethice;
import classes.scenes.dungeons.d3.LivingStatue;
import classes.scenes.dungeons.ebonLabyrinth.Draculina;
import classes.scenes.nPCs.Diva;
import classes.scenes.SceneLib;
import classes.StatusEffects;

class BlindSpell extends AbstractWhiteSpell
{
    public function new()
    {
        super("Blind", 
                "Blind is a fairly self-explanatory spell.  It will create a bright flash just in front of the victim's eyes, blinding them for a time.  However if they blink it will be wasted.", 
                TARGET_ENEMY, 
                TIMING_LASTING, 
                [TAG_DEBUFF]
        );
        baseManaCost = 30;
    }
    
    
    override public function isActive() : Bool
    {
        return monster.hasStatusEffect(StatusEffects.Blind);
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBlind);
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        
        if (monster.hasStatusEffect(StatusEffects.Blind))
        {
            return "[Themonster] is already blinded!";
        }
        
        //You can still use Blind if Draculina is the monster invisible
        if (uc == "You cannot use offensive skills against an opponent you cannot see or target.")
        {
            if (monster && Std.is(monster, Draculina))
            {
                return "";
            }
        }
        
        return uc;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        var successrate : Int = 60;
        successrate -= as3hx.Compat.parseInt(player.inte * 0.4);
        if (successrate > 20)
        {
            successrate = 20;
        }
        if (rand(100) > successrate)
        {
            if (Std.is(monster, Lethice) && (try cast(monster, Lethice) catch(e:Dynamic) null).fightPhase == 2)
            {
                if (display)
                {
                    outputText("You hold your [weapon] aloft and thrust your will forward, causing it to erupt in a blinding flash of light. The demons of the court scream and recoil from the radiant burst, clutching at their eyes and trampling over each other to get back.");
                    
                    outputText("\n\n<i>\"Damn you, fight!\"</i> Lethice screams, grabbing her whip and lashing out at the back-most demons, driving them forward -- and causing the middle bunch to be crushed between competing forces of retreating demons! <i>\"Fight, or you'll be in the submission tanks for the rest of your miserable lives!\"</i>");
                }
            }
            else if (Std.is(monster, LivingStatue))
            {
                if (display)
                {
                    outputText("Sadly, blindness means nothing to a statue!");
                }
            }
            else
            {
                if (display)
                {
                    outputText("You glare at [themonster] and point at [monster him].  A bright flash erupts before [monster him]!\n");
                    outputText("<b>[Themonster] ");
                    
                    if (monster.plural && monster.short != "imp horde")
                    {
                        outputText("are blinded!</b>");
                    }
                    else
                    {
                        outputText("is blinded!</b>");
                    }
                }
                monster.createStatusEffect(StatusEffects.Blind, Math.min(2 + player.inte / 20, 10), 0, 0, 0);
            }
        }
        else if (display)
        {
            outputText(monster.capitalA + monster.short + " blinked!");
        }
    }
}


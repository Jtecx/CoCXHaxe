package classes.scenes.combat.soulskills;

import classes.scenes.combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.globalFlags.KFLAGS;
import classes.PerkLib;

class BladeDanceSkill extends AbstractSoulSkill
{
    public function new()
    {
        super(
                "Blade Dance", 
                "Attack twice (four times if double attack is active, six times if triple attack is active and etc.).", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_PHYSICAL], 
                PerkLib.BladeWarden
        );
        baseSFCost = 50;
        processPostCallback = false;
    }
    
    override private function get_buttonName() : String
    {
        return "Blade Dance";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Deals 2 sets of physical damage attacks";
    }
    
    override public function sfCost() : Int
    {
        var soulforcecost : Float = baseSFCost * soulskillCost() * (1 + flags[kFLAGS.MULTIATTACK_STYLE_MAIN]) * (1 + flags[kFLAGS.MULTIATTACK_STYLE_OFF]);
        return Math.round(soulforcecost);
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You momentarily attune yourself to the song of the mother tree, and dance forward, darting around your enemy, your blade slicing the air and foe alike.\n\n");
        }
        player.createStatusEffect(StatusEffects.BladeDance, 0, 0, 0, 0);
        if (player.isInGoblinMech() || player.isInNonGoblinMech())
        {
            combat.basemechmeleeattacks();
        }
        else
        {
            combat.basemeleeattacks();
        }
    }
}

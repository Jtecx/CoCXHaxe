package classes.scenes.combat.soulskills;

import classes.scenes.combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.PerkLib;

class ResonanceVolleySkill extends AbstractSoulSkill
{
    public function new()
    {
        super(
                "Resonance Volley", 
                "Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_PHYSICAL], 
                PerkLib.WildWarden, 
                false
        );
        baseSFCost = 150;
        processPostCallback = false;
    }
    
    override private function get_buttonName() : String
    {
        return "Resonance Volley";
    }
    
    override public function sfCost() : Int
    {
        return baseSFCost;
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You ready your bow, infusing it with a figment of soulforce. The energy awakens the wood’s connection to the world tree, causing the bow to pulse beneath your fingers.\n\n");
        }
        player.createStatusEffect(StatusEffects.ResonanceVolley, 0, 0, 0, 0);
        combat.fireBow();
    }
}

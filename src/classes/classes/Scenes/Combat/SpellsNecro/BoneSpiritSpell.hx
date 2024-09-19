package classes.scenes.combat.spellsNecro;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractNecroSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class BoneSpiritSpell extends AbstractNecroSpell
{
    public function new()
    {
        super(
                "Bone spirit", 
                "Turn an ordinary set of bones into a vengeance mad apparition that will charge at your target. Upon contact it will explode dealing massive true damage.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING]
        );
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + calcDamage(target, false, false) + " true damage";
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBoneSpirit);
    }
    
    override public function demonBonesCost() : Int
    {
        var calcDBC : Int = 5;
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            calcDBC -= 1;
        }
        if (player.hasStatusEffect(StatusEffects.BonusEffectsNecroSet) && player.statusEffectv3(StatusEffects.BonusEffectsNecroSet) > 0)
        {
            calcDBC -= 1;
        }
        return calcDBC;
    }
    
    public function calcDamage(monster : Monster, randomize : Bool = true, casting : Bool = true) : Float
    //casting - Increase Elemental Counter while casting (like Raging Inferno)
    {
        
        var damage : Float = adjustSpellDamage(
                scalingBonusIntelligence() * 3, 
                DamageType.TRUE, 
                CAT_SPELL_NECRO, 
                monster, 
                true, 
                casting
        );
        if (player.hasPerk(PerkLib.Necromancy))
        {
            damage *= 1.5;
        }
        damage *= boneSoulBonus(demonBonesCost());
        return damage;
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You wrap your soulforce around the bones and shape them into a horrifying bone wraith sending it flying and laughing madly toward [themonster]. The ghastly apparition explodes upon contact into a hundred sharp bone shards grievously wounding [themonster]. ");
        }
        var damage : Float = calcDamage(monster, true, true);
        consumeBones(demonBonesCost());
        damage = critAndRepeatDamage(display, damage, DamageType.TRUE);
        checkAchievementDamage(damage);
        combat.heroBaneProc(damage);
    }
}


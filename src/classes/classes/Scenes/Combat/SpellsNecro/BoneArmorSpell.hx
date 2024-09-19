package classes.scenes.combat.spellsNecro;

import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.AbstractNecroSpell;
import classes.scenes.combat.DamageType;
import classes.StatusEffects;

class BoneArmorSpell extends AbstractNecroSpell
{
    public function new()
    {
        super(
                "Bone armor", 
                "Animate bones to create an impenetrable shield lasting 5 rounds and reducing all damage taken by 50%.", 
                TARGET_SELF, 
                TIMING_LASTING, 
                [TAG_BUFF]
        );
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "50% protection for " + numberOfThings(calcDuration(), "round");
    }
    
    override private function get_isKnown() : Bool
    {
        return player.hasStatusEffect(StatusEffects.KnowsBoneArmor);
    }
    
    override public function demonBonesCost() : Int
    {
        var calcDBC : Int = 10;
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            calcDBC -= 2;
        }
        if (player.hasStatusEffect(StatusEffects.BonusEffectsNecroSet) && player.statusEffectv3(StatusEffects.BonusEffectsNecroSet) > 0)
        {
            calcDBC -= 2;
        }
        return calcDBC;
    }
    
    override public function isActive() : Bool
    {
        return player.hasStatusEffect(StatusEffects.BoneArmor);
    }
    
    override public function calcDuration() : Int
    {
        var duration : Float = 5;
        duration *= boneSoulBonus(demonBonesCost());
        return Math.floor(duration);
    }
    
    override private function doSpellEffect(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("You animate a set of bones to fly around you, deflecting incoming attacks.\n\n");
        }
        var dura : Int = calcDuration();
        consumeBones(demonBonesCost());
        player.createStatusEffect(StatusEffects.BoneArmor, dura, 0, 0, 0);
    }
}


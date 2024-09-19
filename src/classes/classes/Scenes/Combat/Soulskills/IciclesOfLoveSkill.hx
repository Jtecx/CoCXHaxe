package classes.scenes.combat.soulskills;

import classes.scenes.combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.globalFlags.KFLAGS;
import classes.scenes.combat.Combat;
import classes.internals.SaveableState;
import classes.PerkLib;
import classes.Saves;

class IciclesOfLoveSkill extends AbstractSoulSkill implements SaveableState
{
    private var uses : Int = 0;
    private var skillIcon : String = "I_IOLBMAN";
    public function new()
    {
        super(
                "Icicles of Love", 
                "Weaponize your lust, crystalizing it into cold, sharp icicles.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_ICE, TAG_RECOVERY, TAG_MAGICAL], 
                StatusEffects.KnowsIciclesOfLove
        );
        lastAttackType = Combat.LAST_ATTACK_SPELL;
        Saves.registerSaveableState(this);
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            uses = Reflect.field(o, "uses");
        }
        else
        {
            resetState();
        }
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            uses : uses
        };
    }
    
    public function stateObjectName() : String
    {
        return "IciclesOfLove";
    }
    
    public function resetState() : Void
    {
        uses = 0;
    }
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        if (player.lust < 50)
        {
            return "Your current lust is too low.";
        }
        return "";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        var lustRestore : Float = calcLustRestore();
        return "~" + numberFormat(calcDamage(target, lustRestore)) + " ice damage, restores ~" + numberFormat(lustRestore) + " lust";
    }
    
    override private function get_description() : String
    {
        var desc : String = super.description;
        var currentLevel : Int = player.statusEffectv1(knownCondition);
        switch (currentLevel)
        {
            case 1:desc += "\nRank: Rankless";
            case 2:desc += "Effective against groups.\nRank: Low Rank";
            case 3:desc += "Highly effective against groups.\nRank: Mid Rank";
            case 4:desc += "Highly effective against groups.\nRank: High Rank";
        }
        return desc;
    }
    
    override public function presentTags() : Array<Dynamic>
    {
        var result : Array<Dynamic> = super.presentTags();
        var currentLevel : Int = player.statusEffectv1(knownCondition);
        if (currentLevel > 1)
        {
            result.push(TAG_AOE);
        }
        return result;
    }
    
    override public function hasTag(tag : Int) : Bool
    {
        var currentLevel : Int = player.statusEffectv1(knownCondition);
        return super.hasTag(tag) || (currentLevel > 1 && (tag == TAG_AOE));
    }
    
    override public function calcCooldown() : Int
    {
        return Math.max(0, player.statusEffectv1(knownCondition) - 1);
    }
    
    private function calcLustRestore() : Float
    {
        var restoreAmount : Float = 0;
        var restoreMult : Float = 0;
        switch (player.statusEffectv1(knownCondition))
        {
            case 1:restoreMult = 0.1;
            case 2:restoreMult = 0.2;
            case 3:restoreMult = 0.25;
            case 4:restoreMult = 0.3;
        }
        restoreAmount += Math.round(player.lust * restoreMult);
        return restoreAmount;
    }
    
    public function calcDamage(monster : Monster, baseDamage : Float) : Float
    {
        var currentLevel : Int = player.statusEffectv1(knownCondition);
        var damage : Float = baseDamage * (5 * currentLevel);
        if (currentLevel > 1)
        {
            damage += scalingBonusWisdom() * (currentLevel - 1);
            damage *= soulskillMagicalMod() * (currentLevel - 1);
        }
        //group enemies bonus
        if (monster != null && monster.plural)
        {
            if (currentLevel > 2)
            {
                damage *= 5;
            }
            else if (currentLevel > 1)
            {
                damage *= 2;
            }
        }
        damage *= combat.iceDamageBoostedByDao();
        return Math.round(damage);
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        var lustRestore : Float = calcLustRestore();
        player.lust -= lustRestore;
        var damage : Float = calcDamage(monster, lustRestore);
        if (display)
        {
            outputText("You start concentrate on the lust flowing in your body, your veins while imaging a joy of sharing icicles of love with enemy. Shortly after that lust starts to gather around your hands getting colder and colder till it envelop your hands in icicles.\n\n");
            outputText("And with almost orgasmic joy, you sends a wave of ice shards toward [themonster] while mumbling about 'sharing the icicles of love'. ");
        }
        doIceDamage(damage, true, display);
        if (display)
        {
            outputText("\n\n");
        }
        levelUpCheck(true, display);
    }
    
    private function levelUpCheck(increment : Bool = true, display : Bool = true) : Void
    {
        var currentLevel : Int = player.statusEffectv1(knownCondition);
        var nextLevelUp : Int = ((currentLevel > 1)) ? 10 : 5;
        var maxLevel : Int = 4;
        if (currentLevel <= 0 || currentLevel >= maxLevel)
        {
            return;
        }
        if (increment && uses < nextLevelUp)
        {
            uses++;
        }
        if (Math.isFinite(nextLevelUp))
        {
            notificationView.popupProgressBar2(skillIcon, skillIcon, 
                    name + " Mastery", (uses - 1) / nextLevelUp, uses / nextLevelUp
            );
        }
        if (currentLevel == 1 && uses >= nextLevelUp && player.hasPerk(PerkLib.SoulApprentice))
        {
            if (display)
            {
                outputText("Your skill at using the \"" + name + "\" soulskill has progressed!\n");
                outputText("<b>\"" + name + "\" rank has increased from (Rankless) to (Low Rank)!</b>\n\n");
            }
            player.changeStatusValue(knownCondition, 1, 2);
            uses = 0;
        }
        if (currentLevel == 2 && uses >= nextLevelUp && player.hasPerk(PerkLib.SoulWarrior))
        {
            if (display)
            {
                outputText("Your skill at using the \"" + name + "\" soulskill has progressed!\n");
                outputText("<b>\"" + name + "\" rank has increased from (Low Rank) to (Mid Rank)!</b>\n\n");
            }
            player.changeStatusValue(knownCondition, 1, 3);
            uses = 0;
        }
        if (currentLevel == 3 && uses >= nextLevelUp && player.hasPerk(PerkLib.SoulScholar))
        {
            if (display)
            {
                outputText("Your skill at using the \"" + name + "\" soulskill has progressed!\n");
                outputText("<b>\"" + name + "\" rank has increased from (Mid Rank) to (High Rank)!</b>\n\n");
            }
            player.changeStatusValue(knownCondition, 1, 4);
            uses = 0;
        }
    }
}

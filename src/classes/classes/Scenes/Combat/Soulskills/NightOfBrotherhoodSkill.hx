package classes.scenes.combat.soulskills;

import classes.scenes.combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.globalFlags.KFLAGS;
import classes.scenes.combat.Combat;
import classes.internals.SaveableState;
import classes.PerkLib;
import classes.Saves;

class NightOfBrotherhoodSkill extends AbstractSoulSkill implements SaveableState
{
    private var uses : Int = 0;
    private var skillIcon : String = "I_NOBBMAN";
    public function new()
    {
        super(
                "Night of Brotherhood", 
                "Condense your wrath into a wreath of shadows, filled with the hate of your brotherhood.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_DARKNESS, TAG_RECOVERY, TAG_MAGICAL], 
                StatusEffects.KnowsNightOfBrotherhood
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
        return "NightOfBrotherhood";
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
        if (player.wrath < 250)
        {
            return "Your current wrath is too low.";
        }
        return "";
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        var wrathRestore : Float = calcWrathRestore();
        return "~" + numberFormat(calcDamage(target, wrathRestore)) + " darkness damage, restores ~" + numberFormat(wrathRestore) + " wrath";
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
    
    private function calcWrathRestore() : Float
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
        restoreAmount += Math.round(player.wrath * restoreMult);
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
        damage *= combat.darknessDamageBoostedByDao();
        return Math.round(damage);
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        var wrathRestore : Float = calcWrathRestore();
        player.wrath -= wrathRestore;
        var damage : Float = calcDamage(monster, wrathRestore);
        if (display)
        {
            outputText("You start concentrate on the wrath flowing in your body, your veins while imaging a joy of sharing storm of sisterhood with enemy. Shortly after that wrath starts to gather around your hands till it envelop your hands in ligthing.\n\n");
            outputText("With joy, you sends a mass of ligthing toward [themonster] while mumbling about 'sharing the storm of sisterhood'. ");
        }
        doDarknessDamage(damage, true, display);
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

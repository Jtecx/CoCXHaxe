package classes.scenes.combat.specialsMagic;

import flash.errors.Error;
import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.Combat;
import classes.races.ElementalRace;

class FusionSpecial5thSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Fusion Special: Firth", 
                "Attack with the power of your fused elemental over a wide area. Your elemental's power lingers, causing additional damage over time", 
                TARGET_ENEMY, 
                TIMING_LASTING, 
                [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER3, TAG_AOE], 
                PerkLib.ElementalBody
        );
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
        baseSFCost = 600;
    }
    
    override private function get_isKnown() : Bool
    {
        return super.isKnown && player.statusEffectv2(elementDescriptionArr[ElementalRace.getElement(player)][2]) >= 8;
    }
    
    private var elementDescriptionArr : Array<Dynamic> = [
        ["Fusion 5th", "magical", null, null], 
        ["Vortex", "wind", StatusEffects.SummonedElementalsAirE, TAG_WIND], 
        ["Earthquake", "earth", StatusEffects.SummonedElementalsEarthE, TAG_EARTH], 
        ["Eruption", "fire", StatusEffects.SummonedElementalsFireE, TAG_FIRE], 
        ["Tsunami", "water", StatusEffects.SummonedElementalsWaterE, TAG_WATER]
    ];
    
    override private function usabilityCheck() : String
    {
        var uc : String = super.usabilityCheck();
        if (uc != null)
        {
            return uc;
        }
        
        if (ElementalRace.getElement(player) == ElementalRace.ELEMENT_SYLPH && player.hasStatusEffect(StatusEffects.InsideSmallSpace))
        {
            return "You can't use this inside too small spaces.";
        }
        
        if (ElementalRace.getElement(player) == ElementalRace.ELEMENT_GNOME && monster.hasStatusEffect(StatusEffects.Flying))
        {
            return "You can't reach flying targets.";
        }
        
        return "";
    }
    
    override public function calcCooldown() : Int
    {
        return 8;
    }
    
    override public function calcDuration() : Int
    {
        return 5;
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "~" + numberFormat(calcDamage(monster)) + " " + elementDescriptionArr[ElementalRace.getElement(player)][1] + " damage";
    }
    
    override private function get_name() : String
    {
        return elementDescriptionArr[ElementalRace.getElement(player)][0];
    }
    
    override public function sfCost() : Int
    {
        return sfCostMod(baseSFCost);
    }
    
    override public function presentTags() : Array<Dynamic>
    {
        var result : Array<Dynamic> = super.presentTags();
        
        var element : Int = ElementalRace.getElement(player);
        if (element != 0)
        {
            result.push(elementDescriptionArr[element][3]);
        }
        
        return result;
    }
    
    override public function hasTag(tag : Int) : Bool
    {
        return super.hasTag(tag) || (ElementalRace.getElement(player) && (elementDescriptionArr[ElementalRace.getElement(player)][3] == tag));
    }
    
    public function calcDamage(monster : Monster) : Float
    {
        var damage : Float = 0;
        var multiInt : Float = 3;
        var multiWis : Float = 3;
        var element : Int = player.statusEffectv2(elementDescriptionArr[ElementalRace.getElement(player)][2]);
        
        //Deals no damage when unfused with an elemental
        if (element == 0)
        {
            return 0;
        }
        
        if (element >= 4)
        {
            multiInt += 0.6 * (element - 3);
            multiWis += 0.6 * (element - 3);
        }
        if (element >= 7)
        {
            multiInt += 0.6 * (element - 6);
            multiWis += 0.6 * (element - 6);
        }
        if (element >= 10)
        {
            multiInt += 0.6 * (element - 9);
            multiWis += 0.6 * (element - 9);
        }
        damage += scalingBonusIntelligence() * multiInt;
        damage += scalingBonusWisdom() * multiWis;
        
        switch (ElementalRace.getElement(player))
        {
            case ElementalRace.ELEMENT_GNOME:damage *= 2;
                damage *= combat.earthDamageBoostedByDao();
            case ElementalRace.ELEMENT_IGNIS:damage *= combat.fireDamageBoostedByDao();
            case ElementalRace.ELEMENT_SYLPH:if (monster != null && monster.isFlying())
                {
                    damage *= 4;
                }
                damage *= combat.windDamageBoostedByDao();
            case ElementalRace.ELEMENT_UNDINE:damage *= combat.waterDamageBoostedByDao();
        }
        
        damage *= soulskillMagicalMod();
        if (monster != null && monster.plural)
        {
            damage *= 5;
        }
        
        return damage;
    }
    
    override public function advance(display : Bool) : Void
    {
        switch (ElementalRace.getElement(player))
        {
            case ElementalRace.ELEMENT_GNOME:if (display)
                {
                    outputText("The aftershocks of your attack continues to stike [Themonster]! ");
                }
                doEarthDamage(calcDamage(monster), true, display);
                if (display)
                {
                    outputText("\n\n");
                }
            case ElementalRace.ELEMENT_IGNIS:if (display)
                {
                    outputText("A volanic vent sprews lava, burning [Themonster]! ");
                }
                doFireDamage(calcDamage(monster), true, display);
                if (display)
                {
                    outputText("\n\n");
                }
            case ElementalRace.ELEMENT_SYLPH:if (display)
                {
                    outputText("[Themonster] continues to be struck by debris in the vortex! ");
                }
                doWindDamage(calcDamage(monster), true, display);
                if (display)
                {
                    outputText("\n\n");
                }
            case ElementalRace.ELEMENT_UNDINE:if (display)
                {
                    outputText("Just as [Themonster] gathers their bearings, another wave crashes into them! ");
                }
                doWaterDamage(calcDamage(monster), true, display);
                if (display)
                {
                    outputText("\n\n");
                }
            default:throw new Error("Should not be able to call ability when not fused");
        }
        if (rand(5) == 0 && !monster.hasPerk(PerkLib.Resolute) && !monster.monsterIsStunned())
        {
            outputText("\nThe experience leaves [Themonster] dazed!");
            monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
        }
        super.advance(display);
    }
    
    override public function durationEnd(display : Bool = true) : Void
    {
        if (display)
        {
            outputText("<b>The lingering elemental effects has ended.</b>");
        }
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        switch (ElementalRace.getElement(player))
        {
            case ElementalRace.ELEMENT_GNOME:if (display)
                {
                    outputText("You brutally ram your fists into the ground, awakening Mother Earth's rage. The entire area starts to shake, as the earth cracks and breaks all around [Themonster]! ");
                }
            case ElementalRace.ELEMENT_IGNIS:if (display)
                {
                    outputText("You slam your palm to the ground, causing the area around you to erupt into a sea of small volcanoes! The vents begins to spew lava, drowning [Themonster] in large molten rocks!. ");
                }
            case ElementalRace.ELEMENT_SYLPH:if (display)
                {
                    outputText("You move your palm upward, clouds swirling as you create an all powerful vortex of air, pulling everything around within it. [Themonster] is swiftly sucked inside to be hammered by countless debris and rocks! ");
                }
            case ElementalRace.ELEMENT_UNDINE:if (display)
                {
                    outputText("You turn both palms downward, deversing a deluge of water in front of you. What first started as a cresting wave of water becomes a castle-breaching tsunami within seconds, engulfing [Themonster] in its deadly and powerful currents! ");
                }
            default:throw new Error("Should not be able to call ability when not fused");
        }
        
        var damage : Float = calcDamage(monster);
        
        //Determine if critical hit!
        var crit : Bool = false;
        var critChance : Int = 5;
        critChance += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals))
        {
            critChance = 0;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            damage *= 1.5;
        }
        
        damage = Math.round(damage);
        
        switch (ElementalRace.getElement(player))
        {
            case ElementalRace.ELEMENT_GNOME:damage = calcQuakeMod(damage, true);
                doEarthDamage(damage, true, display);
                if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch))
                {
                    if (monster.hasStatusEffect(StatusEffects.AcidDoT))
                    {
                        monster.addStatusValue(StatusEffects.AcidDoT, 1, 1);
                        monster.addStatusValue(StatusEffects.AcidDoT, 3, 1);
                    }
                    else
                    {
                        monster.createStatusEffect(StatusEffects.AcidDoT, 4, 0.02, 1, 0);
                    }
                }
            case ElementalRace.ELEMENT_IGNIS:damage = calcInfernoMod(damage, true);
                doFireDamage(damage, true, display);
                if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch))
                {
                    if (monster.hasStatusEffect(StatusEffects.BurnDoT))
                    {
                        monster.addStatusValue(StatusEffects.BurnDoT, 1, 1);
                    }
                    else
                    {
                        monster.createStatusEffect(StatusEffects.BurnDoT, 10, 0.02, 0, 0);
                    }
                }
            case ElementalRace.ELEMENT_SYLPH:damage = calcGaleMod(damage, true);
                doWindDamage(damage, true, display);
                if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch))
                {
                    if (monster.hasStatusEffect(StatusEffects.Hemorrhage))
                    {
                        monster.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
                    }
                    else
                    {
                        monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.05 * combat.BleedDamageBoost(), 0, 0);
                    }
                }
            case ElementalRace.ELEMENT_UNDINE:damage = calcTideMod(damage, true);
                doWaterDamage(damage, true, display);
                if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch))
                {
                    monster.statStore.addBuffObject({
                                str : -10,
                                spe : -10
                            }, "Poison", {
                                text : "Poison"
                            });
                    if (monster.hasStatusEffect(StatusEffects.FrostburnDoT))
                    {
                        monster.addStatusValue(StatusEffects.FrostburnDoT, 1, 1);
                    }
                    else
                    {
                        monster.createStatusEffect(StatusEffects.FrostburnDoT, 4, 0, 0, 0);
                    }
                }
            default:throw new Error("Should not be able to call ability when not fused");
        }
        
        outputText("\n\n");
        setDuration();
    }
}

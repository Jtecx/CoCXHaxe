package classes.scenes.combat.specialsMagic;

import flash.errors.Error;
import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.Combat;
import classes.races.ElementalRace;

class FusionSpecial1stSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Fusion Special: First", 
                "Attack with the power of your fused elemental.", 
                TARGET_ENEMY, 
                TIMING_INSTANT, 
                [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER2], 
                PerkLib.ElementalBody
        );
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
        baseSFCost = 100;
    }
    
    private var elementDescriptionArr : Array<Dynamic> = [
        ["Fusion 1st", "magical", null, null], 
        ["Wind Blade", "wind", StatusEffects.SummonedElementalsAirE, TAG_WIND], 
        ["Wild Growth", "earth", StatusEffects.SummonedElementalsEarthE, TAG_EARTH], 
        ["Pyroblast", "fire", StatusEffects.SummonedElementalsFireE, TAG_FIRE], 
        ["Hydraulic Torrent", "water", StatusEffects.SummonedElementalsWaterE, TAG_WATER]
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
        return 0;
    }
    
    override private function get_buttonName() : String
    {
        return elementDescriptionArr[ElementalRace.getElement(player)][0];
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
        var multiInt : Float = 2;
        var multiWis : Float = 2;
        var element : Int = player.statusEffectv2(elementDescriptionArr[ElementalRace.getElement(player)][2]);
        
        //Deals no damage when unfused with an elemental
        if (element == 0)
        {
            return 0;
        }
        
        if (element >= 4)
        {
            multiInt += 0.4 * (element - 3);
            multiWis += 0.4 * (element - 3);
        }
        if (element >= 7)
        {
            multiInt += 0.4 * (element - 6);
            multiWis += 0.4 * (element - 6);
        }
        if (element >= 10)
        {
            multiInt += 0.4 * (element - 9);
            multiWis += 0.4 * (element - 9);
        }
        damage += scalingBonusIntelligence() * multiInt;
        damage += scalingBonusWisdom() * multiWis;
        
        switch (ElementalRace.getElement(player))
        {
            case ElementalRace.ELEMENT_GNOME:damage *= combat.earthDamageBoostedByDao();
            case ElementalRace.ELEMENT_IGNIS:damage *= combat.fireDamageBoostedByDao();
            case ElementalRace.ELEMENT_SYLPH:damage *= combat.windDamageBoostedByDao();
            case ElementalRace.ELEMENT_UNDINE:damage *= combat.waterDamageBoostedByDao();
        }
        
        damage *= soulskillMagicalMod();
        
        return damage;
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        switch (ElementalRace.getElement(player))
        {
            case ElementalRace.ELEMENT_GNOME:if (display)
                {
                    outputText("You smash both of your fists into the ground, causing vegetation to grow at an accelerated rate. [Themonster] is punched out of nowhere as a grown tree suddenly sprouts from beneath! ");
                }
            case ElementalRace.ELEMENT_IGNIS:if (display)
                {
                    outputText("You gather energy in your mouth before spitting a pyroclastic mather at your opponent, searing their flesh and setting [themonster] on fire. ");
                }
            case ElementalRace.ELEMENT_SYLPH:if (display)
                {
                    outputText("You rub your palms together before unleashing the energy in the form of razor sharp winds. [Themonster] eyes grow wide in surprise as your attack leaves deep bleeding cuts in its flesh! ");
                }
            case ElementalRace.ELEMENT_UNDINE:if (display)
                {
                    outputText("You push both of your palms toward your opponent, your arms turning to a pair of powerful water jets that batters [themonster] with rock crushing pressure! ");
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
    }
}

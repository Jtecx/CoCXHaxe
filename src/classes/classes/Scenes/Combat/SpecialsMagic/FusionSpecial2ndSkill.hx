package classes.scenes.combat.specialsMagic;

import flash.errors.Error;
import classes.scenes.combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.scenes.combat.Combat;
import classes.races.ElementalRace;

class FusionSpecial2ndSkill extends AbstractMagicSpecial
{
    public function new()
    {
        super(
                "Fusion Special: Second", 
                "Heals the player with the power of your fused elemental.", 
                TARGET_SELF, 
                TIMING_INSTANT, 
                [TAG_HEALING, TAG_MAGICAL, TAG_TIER2], 
                PerkLib.ElementalBody
        );
        baseSFCost = 200;
    }
    
    private var elementDescriptionArr : Array<Dynamic> = [
        ["Fusion 2nd", "magical", null, null], 
        ["Healing Breeze", "wind", StatusEffects.SummonedElementalsAirE, TAG_WIND], 
        ["Synthesis", "earth", StatusEffects.SummonedElementalsEarthE, TAG_EARTH], 
        ["Warmth", "fire", StatusEffects.SummonedElementalsFireE, TAG_FIRE], 
        ["Lifewater", "water", StatusEffects.SummonedElementalsWaterE, TAG_WATER]
    ];
    
    override public function calcCooldown() : Int
    {
        return 3;
    }
    
    override private function get_buttonName() : String
    {
        return elementDescriptionArr[ElementalRace.getElement(player)][0];
    }
    
    override public function describeEffectVs(target : Monster) : String
    {
        return "Heals ~" + numberFormat(calcDamage(monster)) + " health";
    }
    
    override public function sfCost() : Int
    {
        return sfCostMod(baseSFCost);
    }
    
    override private function get_name() : String
    {
        return elementDescriptionArr[ElementalRace.getElement(player)][0];
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
        var amountToHeal : Float = 0;
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
            multiInt += 0.8 * (element - 3);
            multiWis += 0.8 * (element - 3);
        }
        if (element >= 7)
        {
            multiInt += 0.8 * (element - 6);
            multiWis += 0.8 * (element - 6);
        }
        if (element >= 10)
        {
            multiInt += 0.8 * (element - 9);
            multiWis += 0.8 * (element - 9);
        }
        amountToHeal += scalingBonusIntelligence() * multiInt;
        amountToHeal += scalingBonusWisdom() * multiWis;
        
        if (player.hasPerk(PerkLib.WisenedHealer))
        {
            amountToHeal += scalingBonusWisdom();
        }
        if (player.armor == armors.NURSECL)
        {
            amountToHeal *= 1.2;
        }
        if (player.weapon == weapons.U_STAFF)
        {
            amountToHeal *= 1.5;
        }
        if (player.weapon == weapons.ECLIPSE)
        {
            amountToHeal *= 0.5;
        }
        if (player.weapon == weapons.OCCULUS)
        {
            amountToHeal *= 1.5;
        }
        if (player.hasPerk(PerkLib.CloseToDeath) && player.HP < (player.maxHP() * 0.25))
        {
            if (player.hasPerk(PerkLib.CheatDeath) && player.HP < (player.maxHP() * 0.1))
            {
                amountToHeal *= 2.5;
            }
            else
            {
                amountToHeal *= 1.5;
            }
        }
        
        return amountToHeal;
    }
    
    override public function doEffect(display : Bool = true) : Void
    {
        switch (ElementalRace.getElement(player))
        {
            case ElementalRace.ELEMENT_GNOME:if (display)
                {
                    outputText("You gather energy from sunlight into the vines covering your body, converting the nutrients and repairing some of your sustained damage.");
                }
            case ElementalRace.ELEMENT_IGNIS:if (display)
                {
                    outputText("You channel warmth into your wounds soothing the pain and repairing the damages you sustained.");
                }
            case ElementalRace.ELEMENT_SYLPH:if (display)
                {
                    outputText("You soothe your wounds with a calm breeze dulling down the pain.");
                }
            case ElementalRace.ELEMENT_UNDINE:if (display)
                {
                    outputText("You relax and concentrate on your liquid form closing breaches and repairing any damage you sustained.");
                }
            default:throw new Error("Should not be able to call ability when not fused");
        }
        
        var amountToHeal : Float = calcDamage(monster);
        
        amountToHeal = Math.round(amountToHeal);
        
        if (display)
        {
            outputText(" <b>([font-heal]+" + numberFormat(amountToHeal) + "[/font])</b>");
        }
        HPChange(amountToHeal, false);
        
        outputText("\n\n");
    }
}

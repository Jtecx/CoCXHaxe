package classes.items.alchemy;

import classes.items.Consumable;
import classes.stats.IStat;
import classes.stats.RawStat;
import classes.stats.StatUtils;
import classes.internals.EnumValue;

class StatBonusPill extends Consumable
{
    public var residue : Int;
    public var stat : String;
    public var power : Int;
    public var bonus : Float;
    public var isMutagenBonus : Bool;
    
    /**
	 * @param params
	 * @param params.r Alchemy residue used (AlchemyLib.AR_XXX)
	 * @param params.p Pill power (AlchemyLib.PP_XXX)
	 */
    public function new(id : String, params : Dynamic)
    {
        this.residue = params.r;
        this.power = params.p;
        
        var shortName : String;
        var longName : String;
        var description : String;
        var value : Float = 100;
        
        var powerMeta : EnumValue = AlchemyLib.PillPowerTiers[power];
        var residueMeta : EnumValue = AlchemyLib.Residues[residue];
        
        this.stat = residueMeta.stat;
        this.bonus = powerMeta.power * residueMeta.sign;
        
        shortName = powerMeta.short + residueMeta.short + " E.Pill";
        longName = powerMeta.name + " " + residueMeta.name + " enhancer pill";
        isMutagenBonus = StatUtils.isKnownStat(stat + ".mult");
        description =
                "This " + powerMeta.name + " pill permanently " +
                ((residueMeta.sign > 0) ? "increases" : "decreases") +
                " your " + StatUtils.nameOfStat(stat) +
                " by " + Math.abs(bonus) + ((isMutagenBonus) ? "%" : "");
        if (isMutagenBonus)
        {
            description += " up to +{cap}%";
            if (power == AlchemyLib.PP_POTENT)
            {
                description += ", then by 1% up to +{cap+5}%";
            }
            else if (power == AlchemyLib.PP_RADIANT)
            {
                description += ", then by 1% up to +{cap+10}%";
            }
        }
        description += ".";
        
        super(id, shortName, longName, value, description);
    }
    
    
    override private function get_ownIconId() : String
    {
        return "I_" + templateId() + "_" + power;
    }
    override private function get_description() : String
    {
        var cap : Float = player.MutagenBonusCap100();
        return super.description.replace(new as3hx.Compat.Regex('\\{cap}', ""), cap).replace(new as3hx.Compat.Regex('\\{cap\\+5}', ""), cap + 5).replace(new as3hx.Compat.Regex('\\{cap\\+10}', ""), cap + 10);
    }
    override public function useItem() : Bool
    {
        clearOutput();
        outputText("You swallow the " + longNameBase + ". You feel warmth spreading from your stomach...\n\n");
        var dud : Bool = false;
        if (isMutagenBonus)
        {
            var cap : Float = 0.01 * player.MutagenBonusCap100();
            var current : Float = player.GetMutagenBonus(stat);
            if (current < cap)
            {
                player.MutagenBonus(stat, bonus);
            }
            else if (power == AlchemyLib.PP_POTENT && current < cap + 0.05)
            {
                player.MutagenBonus(stat, 1, true, 5);
            }
            else if (power == AlchemyLib.PP_RADIANT && current < cap + 0.10)
            {
                player.MutagenBonus(stat, 1, true, 10);
            }
            else
            {
                dud = true;
            }
        }
        else
        {
            var oldValue : Float = Reflect.field(player, stat);
            var iStat : IStat = player.statStore.findStat(stat);
            if (Std.is(iStat, RawStat))
            {
                (try cast(iStat, RawStat) catch(e:Dynamic) null).value += bonus;
            }
            else
            {
                Reflect.field(player, stat) += bonus;
            }
            dud = oldValue == Reflect.field(player, stat);
        }
        
        if (dud)
        {
            outputText("You don't feel any different.");
        }
        else
        {
            outputText("<b>You feel " + AlchemyLib.Residues[residue].feedback + "!</b>");
        }
        return false;
    }
}


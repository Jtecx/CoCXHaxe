package classes.items.alchemy;

import classes.items.Consumable;
import classes.transformations.PossibleEffect;
import classes.transformations.Transformation;
import classes.internals.EnumValue;

class MutagenPill extends Consumable
{
    public var pillEffect : PossibleEffect;
    public var power : Int;
    
    /**
	 * @param params
	 * @param params.tf TF id ("TF_1_2")
	 * @param params.p Pill power (AlchemyLib.PP_XXX)
	 * */
    public function new(id : String, params : Dynamic)
    {
        var tfId : String = Std.string(params.tf);
        var power : Int = params.p;
        pillEffect = PossibleEffect.findEffect(tfId);
        this.power = power;
        
        var shortName : String;
        var longName : String;
        var description : String;
        var value : Float = 6;
        
        if (pillEffect != null)
        {
            var powerMeta : EnumValue = AlchemyLib.PillPowerTiers[power];
            
            shortName = pillEffect.alchemyShortName + powerMeta.short;
            longName = powerMeta.name + " " + pillEffect.alchemyLongName + " pill";
            description = "This pill will apply " + pillEffect.alchemyLongName + " transformation with " + powerMeta.chance + "% chance.";
        }
        else
        {
            shortName = "ERROR Pill";
            longName = "ERROR Pill " + tfId;
            description = "ERROR: Malformed item " + id;
        }
        
        super(id, shortName, longName, Math.round(value), description);
    }
    
    override private function get_ownIconId() : String
    {
        return "I_" + templateId() + "_" + power;
    }
    override public function canUse() : Bool
    {
        if (player.blockingBodyTransformations())
        {
            outputText("Your body is immune to any and all transformations.");
            return false;
        }
        return true;
    }
    
    override public function useItem() : Bool
    {
        clearOutput();
        outputText("You swallow the " + longNameBase + ". You feel warmth spreading from your stomach...\n\n");
        if (pillEffect != null)
        {
            if (Math.random() * 100 > AlchemyLib.PillPowerTiers[power].chance)
            {
                outputText("However, it's too weak and quickly fades away. ");
            }
            else if (Std.is(pillEffect, Transformation) && (try cast(pillEffect, Transformation) catch(e:Dynamic) null).isPresent())
            
            // already tf'ed{
                
                outputText("The pill's powers resonate with your body and quickly fade away.");
            }
            else if (!pillEffect.isPossible())
            
            // impossible{
                
                outputText("The pill's powers conflict with your body and quickly fade away.");
            }
            else
            {
                pillEffect.applyEffect(true);
            }
        }
        return false;
    }
}


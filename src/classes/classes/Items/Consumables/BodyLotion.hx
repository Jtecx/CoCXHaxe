package classes.items.consumables;

import classes.bodyParts.*;
import classes.EngineCore;
import classes.items.alchemy.AlchemyLib;
import classes.items.Consumable;
import classes.items.ConsumableLib;
import classes.scenes.SceneLib;
import classes.internals.Utils;

/**
	 * Body lotions, courtesy of Foxxling.
	 * @author Kitteh6660
	 */
class BodyLotion extends Consumable
{
    private var _adj : String;
    
    public function new(id : String, adj : String, longAdj : String)
    {
        this._adj = adj.toLowerCase();
        var shortName : String = adj + " Ltn";
        var longName : String = "a flask of " + this._adj + " lotion";
        var value : Int = ConsumableLib.DEFAULT_VALUE;
        var description : String = "A small wooden flask filled with a " + longAdj + " . A label across the front says, \"" + adj + " Lotion.\"";
        super(id, shortName, longName, value, description);
        refineableInto([[1, AlchemyLib.AS_SKIN]], []);
    }
    
    private function liquidDesc() : String
    {
        var liquidDesc : String = "";
        switch (_adj)
        {
            case "smooth":
                switch (Utils.rand(2))
                {  //Nested switch-and-case FTW!  
                    case 0:
                        return "smooth liquid";
                    case 1:
                        return "thick cream";
                    default:
                        return "smooth liquid";
                }
            case "rough":
                switch (Utils.rand(2))
                {
                    case 0:
                        return "abrasive goop";
                    case 1:
                        return "rough textured goop";
                    default:
                        return "abrasive goop";
                }
            case "sexy":
                switch (Utils.rand(3))
                {
                    case 0:
                        return "smooth liquid";
                    case 1:
                        return "attractive cream";
                    case 2:
                        return "beautiful cream";
                    default:
                        return "smooth liquid";
                }
            case "clear":
                switch (Utils.rand(2))
                {
                    case 0:
                        return "smooth liquid";
                    case 1:
                        return "thick cream";
                    default:
                        return "smooth liquid";
                }
            default:  //Failsafe  
                return "cream";
        }
        return liquidDesc;
    }
    
    override public function useItem() : Bool
    {
        if (game.player.skinAdj == _adj || player.blockingBodyTransformations())
        {
            outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the flask of lotion and rubbing", "uncork the flask of lotion and rub") + " the " + liquidDesc() + " across your body. Once you’ve finished you feel reinvigorated. ");
            EngineCore.HPChange(10, true);
        }
        else if (game.player.isGooSkin())
        
        //If skin is goo, don't change{
            
            outputText("You take the lotion and pour the " + liquidDesc() + " into yourself. The concoction dissolves, leaving your gooey epidermis unchanged. As a matter of fact nothing happens at all.");
        }
        else if (game.player.isFurCovered())
        {
            if (_adj != "clear")
            {
                game.player.skin.coat.adj = _adj;
            }
            else
            {
                game.player.skin.coat.adj = "";
            }
            
            outputText("" + game.player.clothedOrNaked("Once you’ve disrobed you take the lotion and", "You take the lotion and") + " begin massaging it into your skin despite yourself being covered with fur. It takes little effort but once you’ve finished... nothing happens. A few moments pass and then your skin begins to tingle. ");
            switch (_adj)
            {
                case "smooth":
                    outputText("Soon you part your fur to reveal smooth skin that still appears natural.");
                case "rough":
                    outputText("Soon you part your fur to reveal rough skin that still appears natural.");
                case "sexy":
                    outputText("Soon you part your fur to reveal sexy skin that makes you want to kiss yourself.");
                case "clear":
                    outputText("Soon you part your fur to reveal the natural beauty of your " + game.player.skinFurScales() + " skin.");
                default:  //Failsafe  
                    outputText("<b>This text should not happen. Please let Ormael/Aimozg know.</b>");
            }
        }
        else if (game.player.isScaleCovered())
        {
            if (_adj != "clear")
            {
                game.player.skin.coat.adj = _adj;
            }
            else
            {
                game.player.skin.coat.adj = "";
            }
            
            outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the flask of lotion and rubbing", "uncork the flask of lotion and rub") + " the " + liquidDesc() + " across your body. As you rub the mixture into your arms and [chest], your whole body begins to tingle pleasantly. ");
            if (game.player.skin.coverage > Skin.COVERAGE_MEDIUM)
            {
                switch (_adj)
                {
                    case "smooth":
                        outputText("Soon your scales feel much smoother to the touch.");
                    case "rough":
                        outputText("Soon your scales feel much rougher to the touch.");
                    case "sexy":
                        outputText("Soon your scales feel much sexier, to the point you want to kiss yourself.");
                    case "clear":
                        outputText("Soon your scales look perfectly natural.");
                    default:  //Failsafe  
                        outputText("<b>This text should not happen. Please let Ormael/Aimozg know.</b>");
                }
            }
            else
            {
                switch (_adj)
                {
                    case "smooth":
                        outputText("Soon both your skin and your scales feel much smoother to the touch.");
                    case "rough":
                        outputText("Soon both your skin and your scales feel much rougher to the touch.");
                    case "sexy":
                        outputText("Soon both your skin and your scales feel much sexier, to the point you want to kiss yourself.");
                    case "clear":
                        outputText("Soon both your skin and your scales look perfectly natural.");
                    default:  //Failsafe  
                        outputText("<b>This text should not happen. Please let Ormael/Aimozg know.</b>");
                }
            }
        }
        else
        {
            if (_adj != "clear")
            {
                game.player.skin.base.adj = _adj;
            }
            else
            {
                game.player.skin.base.adj = "";
            }
            
            outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the flask of lotion and rubbing", "uncork the flask of lotion and rub") + " the " + liquidDesc() + " across your body. As you rub the mixture into your arms and [chest], your whole body begins to tingle pleasantly. ");
            switch (_adj)
            {
                case "smooth":
                    outputText("Soon your skin is smoother but in a natural healthy way.");
                case "rough":
                    outputText("Soon your skin is rougher as if you’ve just finished a long day’s work.");
                case "sexy":
                    outputText("Soon your skin is so sexy you find it hard to keep your hands off yourself.");
                case "clear":
                    outputText("Soon the natural beauty of your " + game.player.skinFurScales() + " is revealed without anything extra or unnecessary.");
                default:  //Failsafe  
                    outputText("<b>This text should not happen. Please let Ormael/Aimozg know.</b>");
            }
        }
        SceneLib.inventory.itemGoNext();
        return true;
    }
}



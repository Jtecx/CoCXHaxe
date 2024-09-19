package classes.items.alchemy;

import classes.items.Useable;
import classes.scenes.SceneLib;

class AlembicCatalyst extends Useable
{
    public var reagentType : Int;
    public var power : Int;
    public var chanceFactor : Float;
    public function new(id : String, reagentType : Int, power : Int)
    {
        this.reagentType = reagentType;
        this.power = power;
        var shortName : String;
        var longName : String;
        var compName : String;
        switch (reagentType)
        {
            case AlchemyLib.RT_SUBSTANCE:
                shortName = "Sub.";
                longName = "substantial";
                compName = "substance";
            case AlchemyLib.RT_ESSENCE:
                shortName = "Ess.";
                longName = "essential";
                compName = "essence";
            case AlchemyLib.RT_RESIDUE:
                shortName = "Res.";
                longName = "residual";
                compName = "residue";
            case AlchemyLib.RT_PIGMENT:
                shortName = "Pig.";
                longName = "colorful";
                compName = "pigment";
        }
        var value : Float;
        var powerName : String;
        switch (power)
        {
            case 1:
                shortName = "Min." + shortName;
                longName = "minor " + longName + " catalyst";
                powerName = "slightly increases";
                value = 1000;
                chanceFactor = 1.5;
            case 2:
                shortName = "Cmn." + shortName;
                longName = "common " + longName + " catalyst";
                powerName = "increases";
                value = 5000;
                chanceFactor = 2;
            case 3:
                shortName = "Maj." + shortName;
                longName = "major " + longName + " catalyst";
                powerName = "greatly increases";
                value = 10000;
                chanceFactor = 3;
            default:
                shortName = "Maj." + shortName;
                longName = "major " + longName + " catalyst";
                powerName = "greatly increases";
                value = 10000;
                chanceFactor = 3;
        }
        shortName += "ACat";
        var description : String = "This magical crystal, when placed inside alchemical alembic, " + powerName + " chances to extract " + compName + ". It is not consumed in the process and can be used muliple times.";
        super(id, shortName, longName, value, description);
    }
    
    override public function useItem() : Bool
    {
        outputText(description);
        outputText("You examine the magical crystal.");
        outputText("\n\n");
        outputText("<i>This item is used in 'Crafting - Extract' menu.</i>");
        SceneLib.inventory.returnItemToInventory(this);
        return false;
    }
}


package classes.scenes.crafting;

import classes.BaseContent;
import classes.globalFlags.KFLAGS;
import classes.items.alchemy.AlchemyLib;
import classes.items.alchemy.AlchemyReagent;
import classes.scenes.Crafting;
import classes.scenes.SceneLib;
import classes.internals.EnumValue;

class AbstractPillCraftingContent extends BaseContent
{
    private var crafting(get, never) : Crafting;

    // Runtime state variables - not saved, must be cleared when you leave the scene
    private var furnaceStones : Int = 0;
    
    public function new()
    {
        super();
    }
    private function get_crafting() : Crafting
    {
        return SceneLib.crafting;
    }
    public function furnaceName() : String
    {
        return crafting.alchemyFurnaceObject().name;
    }
    private function furnaceObject() : EnumValue
    {
        return crafting.alchemyFurnaceObject();
    }
    private function stoneSafeLimit() : Int
    {
        return SceneLib.crafting.alchemyFurnaceStoneSafeLimit();
    }
    private function stoneLimit() : Int
    {
        return 20;
    }
    public function craftingMenu() : Void
    {  // implement in subclass  
        
    }
    
    private function calcPillChances() : Array<Dynamic>
    {
        var result : Array<Dynamic> = furnaceObject().refineChances.slice();
        normalizeArray(result, 100);
        // +25% to raise a level per spirit stone
        var raiseChance : Float = 0.25;
        raiseChance += 0.005 * player.alchemySkillLevel;
        for (i in 0...furnaceStones)
        {
            result = [
                    /*                     */result[0] * (1 - raiseChance), 
                    result[0] * raiseChance + result[1] * (1 - raiseChance), 
                    result[1] * raiseChance + result[2] * (1 - raiseChance), 
                    result[2] * raiseChance + result[3] * (1 - raiseChance), 
                    result[3] * raiseChance + result[4] * (1 - raiseChance), 
                    result[4] * raiseChance + result[5]
            ];
        }
        // +20 chance to explode per extra SS
        if (furnaceStones > stoneSafeLimit())
        {
            result[0] += 20 * (furnaceStones - stoneSafeLimit());
        }
        return normalizeArray(result, 100);
    }
    
    private function printRefinementChances() : Void
    {
        outputText("\n<b>Refinement chances</b>:");
        outputText("<ul>");
        var chances : Array<Dynamic> = calcPillChances();
        for (i in 0...chances.length)
        {
            if (chances[i] <= 0)
            {
                continue;
            }
            outputText("<li>");
            if (i == 0)
            {
                outputText("<b>Explosion</b>");
            }
            else
            {
                outputText(capitalizeFirstLetter(AlchemyLib.PillPowerTiers[i].name + " pill"));
            }
            outputText(": " + floor(chances[i]) + "%");
            outputText("</li>");
        }
        outputText("</ul>");
        if (furnaceStones == stoneLimit())
        {
            outputText("\n\nYou can't fit more spirit stones in the furnace!");
            if (silly())
            {
                outputText(" The pile emits an eerie blue glow and you hear a chaotic, intermittent clicking noise.");
            }
        }
    }
    
    private function setAddSSButton(btn : Int) : Void
    {
        button(btn).show("Add S.Stone", addSpiritStoneToFurnace).hint("Put spirit stone into furnace to improve the pill quality.\n\nShift+click to add maximum.").disableIf(flags[kFLAGS.SPIRIT_STONES] <= 0).disableIf(furnaceStones >= stoneLimit());
    }
    private function setTakeSSButton(btn : Int) : Void
    {
        button(btn).show("Take S.Stone", takeSpiritStoneFromFurnace).hint("Take spirit stone from.\n\nShift+click to take all.").disableIf(furnaceStones == 0);
    }
    private function printStonesInFurnace() : Void
    {
        outputText("\n<b>Spirit Stones</b>: " + furnaceStones + "/" + stoneSafeLimit() + ". ");
        if (silly() && furnaceStones == stoneLimit())
        {
            outputText("<b>WARNING: Prepare for unforeseen consequences. </b>");
        }
        else if (furnaceStones == stoneSafeLimit())
        {
            outputText("This is maximum safe value.");
        }
        else if (furnaceStones > stoneSafeLimit())
        {
            outputText("<b>WARNING: Too many spirit stones. </b>");
        }
    }
    
    private function addSpiritStoneToFurnace() : Void
    {
        var n : Int = 1;
        if (shiftKeyDown)
        {
            n = Math.min(flags[kFLAGS.SPIRIT_STONES], stoneSafeLimit());
        }
        flags[kFLAGS.SPIRIT_STONES] -= n;
        furnaceStones += n;
        statScreenRefresh();
        craftingMenu();
    }
    
    private function takeSpiritStoneFromFurnace() : Void
    {
        var n : Int = (shiftKeyDown) ? furnaceStones : 1;
        flags[kFLAGS.SPIRIT_STONES] += n;
        furnaceStones -= n;
        statScreenRefresh();
        craftingMenu();
    }
    private function cleanTheFurnace() : Void
    {
        if (furnaceStones > 0)
        {
            outputText("\nYou take " + numberOfThings(furnaceStones, "spirit stone", "spirit stones") + " out and store them back in your pocket.");
            flags[kFLAGS.SPIRIT_STONES] += furnaceStones;
            furnaceStones = 0;
        }
        
        statScreenRefresh();
        doNext(craftingMenu);
    }
}


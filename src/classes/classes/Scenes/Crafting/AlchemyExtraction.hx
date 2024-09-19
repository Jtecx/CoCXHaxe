package classes.scenes.crafting;

import haxe.Constraints.Function;
import classes.BaseContent;
import classes.ItemSlotClass;
import classes.items.alchemy.AlchemyLib;
import classes.items.alchemy.AlchemyReagent;
import classes.items.alchemy.AlembicCatalyst;
import classes.items.Consumable;
import classes.scenes.Crafting;
import classes.scenes.SceneLib;
import classes.internals.EnumValue;
import coc.view.CoCButton;
import flash.utils.Dictionary;

class AlchemyExtraction extends BaseContent
{
    private var alembicLevel(get, never) : Int;
    private var alembicCatalyst(get, set) : AlembicCatalyst;

    
    public function new()
    {
        super();
    }
    private function get_alembicLevel() : Int
    {
        return Crafting.alembicLevel;
    }
    private function get_alembicCatalyst() : AlembicCatalyst
    {
        return Crafting.alembicCatalyst;
    }
    private function set_alembicCatalyst(value : AlembicCatalyst) : AlembicCatalyst
    {
        Crafting.alembicCatalyst = value;
        return value;
    }
    
    
    public function alembicName() : String
    {
        return alembicObject().name;
    }
    public function alembicObject() : EnumValue
    {
        return Crafting.ALEMBIC_LEVELS[alembicLevel];
    }
    
    private var alembicItem : Consumable = null;
    private var alembicItemCount : Int = 0;
    public function alembicCapacity() : Int
    {
        return 10;
    }
    // Number of reagent rolls per ingredient
    public function alembicYield() : Float
    {
        return 2 + 0.1 * player.alchemySkillLevel;
    }
    
    // [failureChance, substanceChance, essenceChance, residueChance, pigmentChance]
    private function calcChances() : Array<Dynamic>
    {
        var result : Array<Dynamic> = [100, 0, 0, 0, 0];
        var successChance : Float = alembicObject().successChance;
        successChance += 0.5 * player.alchemySkillLevel;
        successChance = boundFloat(0, successChance, 100);
        result[0] = 100 - successChance;
        var n : Int = 4;
        if (alembicItem != null && !alembicItem.substances)
        {
            n--;
        }
        if (alembicItem != null && !alembicItem.essences)
        {
            n--;
        }
        if (alembicItem != null && !alembicItem.residues)
        {
            n--;
        }
        if (alembicItem != null && !alembicItem.pigments)
        {
            n--;
        }
        result[1] = successChance / n;
        result[2] = successChance / n;
        result[3] = successChance / n;
        result[4] = successChance / n;
        if (alembicCatalyst != null)
        {
            result[alembicCatalyst.reagentType] *= alembicCatalyst.chanceFactor;
        }
        if (alembicItem != null)
        {
            if (!alembicItem.substances)
            {
                result[AlchemyLib.RT_SUBSTANCE] = 0;
            }
            if (!alembicItem.essences)
            {
                result[AlchemyLib.RT_ESSENCE] = 0;
            }
            if (!alembicItem.residues)
            {
                result[AlchemyLib.RT_RESIDUE] = 0;
            }
            if (!alembicItem.pigments)
            {
                result[AlchemyLib.RT_PIGMENT] = 0;
            }
        }
        return normalizeArray(result, 100);
    }
    
    private var inventoryPage : Int = 0;
    private var usePearl : Bool = false;
    private function goBack() : Void
    {
        inventoryPage = 0;
        usePearl = false;
        SceneLib.crafting.craftingMain();
    }
    private function extractionMenuPage(inventoryPage : Int, usePearl : Bool) : Void
    {
        this.inventoryPage = inventoryPage;
        this.usePearl = usePearl;
        extractionMenu();
    }
    public function extractionMenu() : Void
    {
        clearOutput();
        if (alembicItemCount > 0)
        {
            outputText("You have " + alembicItemCount + " x " + alembicItem.longNameBase);
            if (alembicCatalyst != null)
            {
                outputText(" and " + alembicCatalyst.longName);
            }
            outputText(" in your " + alembicName() + ". ");
        }
        else if (alembicCatalyst != null)
        {
            outputText("Your " + alembicName() + " is empowered by " + alembicCatalyst.longName + ", but doesn't contain any processable material. ");
        }
        else
        {
            outputText("Your " + alembicName() + " is empty. ");
        }
        outputText("\n\n");
        
        var chances : Array<Dynamic> = calcChances();
        outputText("<b>Tool quality</b>: " + alembicName());
        outputText("\n<b>Catalyst</b>: " + ((alembicCatalyst != null) ? alembicCatalyst.longName : "<i>none</i>"));
        outputText("\n<b>Ingredient</b>: " + ((alembicItem != null) ? alembicItemCount + " x " + alembicItem.longNameBase : "<i>none</i>"));
        outputText("\n<b>Skill</b>: " + player.alchemySkillLevel);
        outputText("\n<b>Refinement chances</b>:");
        outputText("<ul>");
        if (chances[0] > 0)
        {
            outputText("<li>Failure: " + floor(chances[0]) + "%</li>");
        }
        if (chances[1] > 0)
        {
            outputText("<li>Substance: " + floor(chances[1]) + "%</li>");
        }
        if (chances[2] > 0)
        {
            outputText("<li>Essence: " + floor(chances[2]) + "%</li>");
        }
        if (chances[3] > 0)
        {
            outputText("<li>Residue: " + floor(chances[3]) + "%</li>");
        }
        if (chances[4] > 0)
        {
            outputText("<li>Pigment: " + floor(chances[4]) + "%</li>");
        }
        outputText("</ul>");
        var y : Float = alembicYield();
        outputText("<b>Yield</b>: ");
        outputText("x" + Math.floor(y));
        if (y != Math.floor(y))
        {
            outputText(" (" + Math.round((y - Math.floor(y)) * 100) + "% for x" + (Math.floor(y) + 1) + ")");
        }
        if (alembicItem != null)
        {
            outputText("\n<b>Output:</b><ul>");
            for (ar/* AS3HX WARNING could not determine type for var: ar exp: ECall(EField(EIdent(alembicItem),getAllRefineReagents),[]) type: null */ in alembicItem.getAllRefineReagents())
            {
                outputText("<li>");
                if (debug || SceneLib.crafting.isReagentKnown(alembicItem.id, ar.type, ar.key()))
                {
                    outputText(ar.name());
                }
                else
                {
                    outputText("???");
                }
                outputText("</li>");
            }
            outputText("</ul>");
        }
        outputText("\n\n");
        
        // [Extract!] [        ] [TakeItem] [Take Cat] [        ]
        // [ item1  ] [ item2  ] [ item3  ] [ item4  ] [ item5  ]
        // [ < prev ] [Inv/Pear] [ next > ] [        ] [ Back   ]
        menu();
        
        button(0).show("Extract!", doExtract).hint("Perform the extraction. " +
                        "The ingredient" + ((alembicItemCount > 1) ? "s" : "") + " will be destroyed.").disableIf(alembicItem == null, "You need to put an ingredient into the alembic!");
        button(2).show("Take Ingred.", takeIngredient).hint("Put " + ((alembicItem != null) ? alembicItem.longName : "the ingredient") + " back into inventory.\n\nHold Shift to take all.").disableIf(alembicItem == null);
        button(3).show("Take Catalyst", takeCatalyst).hint("Put " + ((alembicCatalyst != null) ? alembicCatalyst.longName : "the alembic catalyst") + " back into inventory.").disableIf(alembicCatalyst == null);
        
        var storage : Array<Dynamic>;
        if (usePearl)
        {
            storage = inventory.pearlStorageSlice();
        }
        else
        {
            storage = player.itemSlots.slice(0, player.itemSlotCount());
        }
        var i : Int;
        var offset : Int = as3hx.Compat.parseInt(inventoryPage * 5);
        for (i in 0...5)
        {
            var slot : ItemSlotClass = storage[offset + i];
            if (slot == null)
            {
                continue;
            }
            var isIngredient : Bool = (Std.is(slot.itype, Consumable)) && (try cast(slot.itype, Consumable) catch(e:Dynamic) null).isRefinable;
            var btn : CoCButton = button(5 + i).showForItemSlot(slot, curry(putItem, slot));
            if (Std.is(slot.itype, AlembicCatalyst))
            {
                if (alembicCatalyst != null)
                {
                    btn.disable("Only one catalyst is allowed!");
                }
            }
            else if (isIngredient)
            {
                if (alembicItem != null && alembicItem != slot.itype)
                {
                    btn.disable("You cannot mix ingredients!");
                }
                else if (alembicItemCount >= alembicCapacity())
                {
                    btn.disable("You cannot refine more ingredients at once!");
                }
            }
            else
            {
                btn.disable("This item cannot be refined and is not a catalyst.");
            }
        }
        button(10).show("Prev", curry(extractionMenuPage, inventoryPage - 1, usePearl)).icon("Left").disableIf(inventoryPage == 0);
        if (inventory.pearlStorageSize() > 0)
        {
            button(11).show("Inv/Pearl", curry(extractionMenuPage, 0, !usePearl));
        }
        
        button(12).show("Next", curry(extractionMenuPage, inventoryPage + 1, usePearl)).icon("Right").disableIf(inventoryPage >= Math.ceil(storage.length / 5) - 1);
        
        button(14).show("Back", goBack).icon("Back").disableIf(alembicItem != null, "Empty the alembic first!");
    }
    private function doExtract() : Void
    {
        clearOutput();
        outputText("You dissolve the " + alembicItem.longNameBase + " in the mixture and start the fire. You calmly watch the fumes raise and condense...\n\n");
        
        var chances : Array<Dynamic> = calcChances();
        // AlchemicReagent -> quantity
        var results : Dictionary = new Dictionary();
        var failures : Int = 0;
        var successes : Int = 0;
        var ac : AlchemyReagent;
        
        for (i in 0...randomIncrement(alembicYield() * alembicItemCount))
        {
            ac = alembicItem.refine(chances);
            if (ac != null)
            {
                successes++;
                SceneLib.crafting.setReagentKnown(alembicItem.id, ac.type, ac.key());
                if (Lambda.has(results, ac))
                {
                    Reflect.field(results, Std.string(ac))++;
                }
                else
                {
                    Reflect.setField(results, Std.string(ac), 1);
                }
            }
            else
            {
                failures++;
            }
        }
        Crafting.gooProduced += failures;
        if (successes == 0)
        {
            outputText("Unfortunately, the refining process resulted in a <b>complete failure</b>!\n");
            outputText("You've 'refined' " +
                    ((alembicItemCount > 1) ? alembicItemCount + " x " + alembicItem.longNameBase : alembicItem.longName) +
                    " into " + numberOfThings(failures, "blob", "blobs") + " of stinky goo...");
        }
        else
        {
            player.giveAlchemyXP(successes);  // 1 alchemy XP per extracted reagent  
            if (failures == 0)
            {
                outputText("The refining process was a <b>complete success</b>!\n");
            }
            outputText("You've refined " + alembicItemCount + " x " + alembicItem.longNameBase + " into");
            var list : Array<Dynamic> = objectEntries(results);
            if (list.length == 1)
            {
                ac = list[0][0];
                outputText(" " + numberOfThings(list[0][1], ac.name()));
                var n : Int = SceneLib.crafting.addAlchemyReagent(ac, list[0][1]);
                if (n >= SceneLib.crafting.maxReagentCount())
                {
                    outputText(" (MAX)");
                }
            }
            else
            {
                outputText(":<ul>");
                for (i in 0...list.length)
                {
                    ac = list[i][0];
                    outputText("<li>" + numberOfThings(list[i][1], ac.name()));
                    n = SceneLib.crafting.addAlchemyReagent(ac, list[i][1]);
                    if (n >= SceneLib.crafting.maxReagentCount())
                    {
                        outputText(" (MAX)");
                    }
                    outputText("</li>");
                }
                outputText("</ul>");
            }
            if (failures > 0)
            {
                if (list.length == 1)
                {
                    outputText(" ");
                }
                else
                {
                    outputText("...");
                }
                outputText("and " + numberOfThings(failures, "blob", "blobs") + " of stinky goo");
            }
            if (list.length == 1)
            {
                outputText(".");
            }
        }
        
        // TODO @aimozg passage of time?
        alembicItem = null;
        alembicItemCount = 0;
        doNext(extractionMenu);
    }
    private function putItem(slot : ItemSlotClass) : Void
    {
        if (Std.is(slot.itype, AlembicCatalyst))
        {
            alembicCatalyst = try cast(slot.itype, AlembicCatalyst) catch(e:Dynamic) null;
            slot.removeOneItem();
        }
        else if (Std.is(slot.itype, Consumable))
        {
            alembicItem = try cast(slot.itype, Consumable) catch(e:Dynamic) null;
            var n : Int = (shiftKeyDown) ? Math.min(slot.quantity, alembicCapacity() - alembicItemCount) : 1;
            slot.removeMany(n);
            alembicItemCount += n;
        }
        extractionMenu();
    }
    private function takeIngredient() : Void
    {
        var n : Int = (shiftKeyDown) ? alembicItemCount : 1;
        var menuFn : Function = extractionMenu;
        while (n-- > 0 && alembicItemCount > 0)
        {
            alembicItemCount--;
            if (inventory.tryAddItemToPlayer(alembicItem) == 0)
            {
                inventory.takeItem(alembicItem, menuFn);
                menuFn = null;
                break;
            }
        }
        if (alembicItemCount == 0)
        {
            alembicItem = null;
        }
        if (menuFn != null)
        {
            menuFn();
        }
    }
    private function takeCatalyst() : Void
    {
        if (inventory.tryAddItemToPlayer(alembicCatalyst) == 0)
        {
            inventory.takeItem(alembicCatalyst, extractionMenu);
            alembicCatalyst = null;
        }
        else
        {
            alembicCatalyst = null;
            extractionMenu();
        }
    }
}


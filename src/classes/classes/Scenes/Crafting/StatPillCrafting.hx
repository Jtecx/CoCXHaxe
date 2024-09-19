package classes.scenes.crafting;

import classes.ItemSlotClass;
import classes.ItemType;
import classes.items.alchemy.AlchemyLib;
import coc.view.CoCButton;

class StatPillCrafting extends AbstractPillCraftingContent
{
    // [ ingredient1, ingredient2, residue, pill type ]
    public var PillRecipes(default, never) : Array<Dynamic> = [
        [useables.D_E_ICHOR, consumables.IRONWEED, AlchemyLib.AR_STR, "StatBonus"], 
        [useables.D_E_ICHOR, consumables.HEALHERB, AlchemyLib.AR_TOU, "StatBonus"], 
        [useables.D_E_ICHOR, consumables.BLADEFERN, AlchemyLib.AR_SPE, "StatBonus"], 
        [useables.D_E_ICHOR, consumables.SNAKEBANE, AlchemyLib.AR_INT, "StatBonus"], 
        [useables.D_E_ICHOR, consumables.MOONGRASS, AlchemyLib.AR_WIS, "StatBonus"], 
        [useables.D_E_ICHOR, consumables.RAUNENECT, AlchemyLib.AR_LIB, "StatBonus"]
    ];
    public var ValidIngredients1(default, never) : Dynamic = mapPropToSet(mapOneProp(PillRecipes, "0"), "id");
    public var ValidIngredients2(default, never) : Dynamic = mapPropToSet(mapOneProp(PillRecipes, "1"), "id");
    public var ValidIngredients(default, never) : Dynamic = toSet(keys(ValidIngredients1).concat(keys(ValidIngredients2)));
    
    public function new()
    {
        super();
    }
    
    // Runtime state variables - not saved, must be cleared when you leave the scene
    private var furnaceIngredient1 : ItemType = null;
    private var furnaceIngredient2 : ItemType = null;
    private var furnaceResidue : Int = 0;
    private var inventoryPage : Int = 0;
    private var usePearl : Bool = false;
    
    private function currentRecipe() : String
    {
        if (furnaceIngredient1 == null || furnaceIngredient2 == null || furnaceResidue == 0)
        {
            return "";
        }
        var i : Int;
        for (i in 0...PillRecipes.length)
        {
            if (furnaceIngredient1 == PillRecipes[i][0] && furnaceIngredient2 == PillRecipes[i][1] && furnaceResidue == PillRecipes[i][2])
            {
                return PillRecipes[i][3];
            }
        }
        return "";
    }
    
    private function setInventoryPage(page : Int, pearl : Bool) : Void
    {
        inventoryPage = page;
        usePearl = pearl;
        craftingMenu();
    }
    override public function craftingMenu() : Void
    {
        clearOutput();
        
        outputText("<b>Tool quality</b>: " + furnaceName());
        outputText("\n<b>Ingredient 1</b>: " + ((furnaceIngredient1 != null) ? furnaceIngredient1.longNameBase : "<i>none</i>"));
        outputText("\n<b>Ingredient 2</b>: " + ((furnaceIngredient2 != null) ? furnaceIngredient2.longNameBase : "<i>none</i>"));
        outputText("\n<b>Residue</b>: " + ((furnaceResidue != 0) ? AlchemyLib.Residues[furnaceResidue].name : "<i>none</i>"));
        printStonesInFurnace();
        outputText("\n<b>Skill</b>: " + player.alchemySkillLevel);
        
        var i : Int;
        outputText("\n<b>Result</b>: ");
        switch (currentRecipe())
        {
            case "StatBonus":
                outputText(AlchemyLib.Residues[furnaceResidue].name + " enhancing pill");
            default:
                outputText("Stinky goo");
        }
        
        printRefinementChances();
        
        // [ Refine!] [ Residue] [        ] [ Add SS ] [ Take SS]
        // [ Item1  ] [ Item2  ] [ Item3  ] [ Item4  ] [ Item5  ]
        // [ < Prev ] [InvPearl] [ Next > ] [ Clean  ] [ Back   ]
        menu();
        button(0).show("Refine!", doRefinePill).hint("Refine the pill.").disableIf(!furnaceIngredient1 || !furnaceIngredient2 || furnaceResidue != 0, "Select 2 ingredients and a residue.");
        button(1).show("Residue", curry(crafting.selectReagent, AlchemyLib.RT_RESIDUE, selectResidue, craftingMenu, furnaceResidue));
        setAddSSButton(3);
        setTakeSSButton(4);
        
        var storage : Array<Dynamic>;
        if (usePearl)
        {
            storage = inventory.pearlStorageSlice();
        }
        else
        {
            storage = player.itemSlots.slice(0, player.itemSlotCount());
        }
        var offset : Int = as3hx.Compat.parseInt(inventoryPage * 5);
        for (i in 0...5)
        {
            var slot : ItemSlotClass = storage[offset + i];
            if (slot == null)
            {
                continue;
            }
            var isIngredient : Bool = Reflect.field(ValidIngredients1, Std.string(slot.itype.id)) || Reflect.field(ValidIngredients2, Std.string(slot.itype.id));
            var btn : CoCButton = button(5 + i).showForItemSlot(slot, curry(putItem, slot)).disableIf(!isIngredient, "Not a valid ingredient");
        }
        button(10).show("Prev", curry(setInventoryPage, inventoryPage - 1, usePearl)).icon("Left").disableIf(inventoryPage == 0);
        if (inventory.pearlStorageSize() > 0)
        {
            button(11).show("Inv/Pearl", curry(setInventoryPage, 0, !usePearl));
        }
        
        button(12).show("Next", curry(setInventoryPage, inventoryPage + 1, usePearl)).icon("Right").disableIf(inventoryPage >= Math.ceil(storage.length / 5) - 1);
        
        button(13).show("Cancel", cleanTheFurnace).hint("Cancel refinement and take back the resources.").disableIf(!furnaceIngredient1 && !furnaceIngredient2 && furnaceResidue == 0 && furnaceStones == 0);
        button(14).show("Back", doReturn).icon("Back").disableIf(furnaceIngredient1 || furnaceIngredient2 || furnaceResidue > 0 || furnaceStones > 0, "Empty the furnace first!");
    }
    private function doRefinePill() : Void
    {
        clearOutput();
        
        outputText("The soulforce-powered furnace roars and dissolves the ingredients into tiny particles. They circle in complicated orbits, intertwine and recombine in seemingly chaotic ways until forming a turbulent cloud. ");
        if (furnaceStones > 0)
        {
            outputText("The " + ((furnaceStones > 1) ? "spirit stones" : "spirit stone") + " crumble and release the soulforce, fueling the process and empowering the mixture. ");
        }
        var chances : Array<Dynamic> = calcPillChances();
        var pillPower : Int;
        if (crafting.isLuckyXianxiaMC())
        {
            crafting.useXianxiaMCLuck();
            pillPower = AlchemyLib.PP_RADIANT;
        }
        else
        {
            pillPower = weightedRandom([
                            [chances[0], 0], 
                            [chances[1], 1], 
                            [chances[2], 2], 
                            [chances[3], 3], 
                            [chances[4], 4], 
                            [chances[5], 5]
                ]);
        }
        outputText("[pg]");
        
        var pill : ItemType = null;
        if (pillPower > 0)
        {
            switch (currentRecipe())
            {
                case "StatBonus":
                    pill = itemTemplates.createStatBonusPill(furnaceResidue, pillPower);
            }
        }
        furnaceIngredient1 = null;
        furnaceIngredient2 = null;
        furnaceResidue = 0;
        furnaceStones = 0;
        if (pill == null)
        {
            outputText("The cloud slows down then suddenly <b>collapses in violent implosion</b>, covering the area in smoke and soot. Unfortunately, the refining had failed.");
            outputText("\n\nCleaning this mess would take some time...");
            player.giveAlchemyXP(AlchemyLib.PillPowerTiers[0].xp);
            doNext(camp.returnToCampUseOneHour);
        }
        // TODO @aimozg can craft multiple, depending on skill or other factors
        else
        {
            
            var npills : Int = 1;
            outputText("The whirling cloud slows down, then shrinks into " +
                    numberOfThings(npills, "cherry-sized orb", "cherry-sized orbs") +
                    " at the bottom of the furnace.\n\n");
            outputText("<b>You've successfully refined " + ((npills > 1) ? npills + " x " : "a ") + pill.longNameBase + "!</b>");
            // TODO @aimozg support transfering multiple items
            player.giveAlchemyXP(AlchemyLib.PillPowerTiers[pillPower].xp);
            inventory.takeItem(pill, craftingMenu);
        }
    }
    private function putItem(slot : ItemSlotClass) : Void
    {
        if (Lambda.has(ValidIngredients1, slot.itype.id))
        {
            if (furnaceIngredient1 != null)
            {
                if (inventory.tryAddItemToPlayer(furnaceIngredient1) == 0)
                {
                    inventory.takeItem(furnaceIngredient1, curry(putItem, slot));
                    furnaceIngredient1 = null;
                    return;
                }
            }
            furnaceIngredient1 = slot.itype;
            slot.removeOneItem();
        }
        else if (Lambda.has(ValidIngredients2, slot.itype.id))
        {
            if (furnaceIngredient2 != null)
            {
                if (inventory.tryAddItemToPlayer(furnaceIngredient2) == 0)
                {
                    inventory.takeItem(furnaceIngredient2, curry(putItem, slot));
                    furnaceIngredient2 = null;
                    return;
                }
            }
            furnaceIngredient2 = slot.itype;
            slot.removeOneItem();
        }
        craftingMenu();
    }
    private function selectResidue(residue : Int) : Void
    {
        if (furnaceResidue != 0)
        {
            crafting.addResidue(furnaceResidue);
        }
        furnaceResidue = residue;
        craftingMenu();
    }
    override private function cleanTheFurnace() : Void
    {
        if (furnaceIngredient1 != null)
        {
            if (inventory.tryAddItemToPlayer(furnaceIngredient1) > 0)
            {
                outputText("\nYou carefully collect the " + furnaceIngredient1.longNameBase + " and put it back into your inventory");
                furnaceIngredient1 = null;
            }
            else
            {
                inventory.takeItem(furnaceIngredient1, cleanTheFurnace);
                furnaceIngredient1 = null;
                return;
            }
        }
        if (furnaceIngredient2 != null)
        {
            if (inventory.tryAddItemToPlayer(furnaceIngredient2) > 0)
            {
                outputText("\nYou carefully collect the " + furnaceIngredient2.longNameBase + " and put it back into your inventory");
                furnaceIngredient2 = null;
            }
            else
            {
                inventory.takeItem(furnaceIngredient2, cleanTheFurnace);
                furnaceIngredient2 = null;
                return;
            }
        }
        if (furnaceResidue != 0)
        {
            outputText("\nYou carefully collect the " + AlchemyLib.Substances[furnaceResidue].name + " substance and put it back in into your alchemical storage.");
            crafting.addResidue(furnaceResidue);
            furnaceResidue = 0;
        }
        super.cleanTheFurnace();
    }
    private function doReturn() : Void
    {
        inventoryPage = 0;
        usePearl = false;
        crafting.craftingMain();
    }
}


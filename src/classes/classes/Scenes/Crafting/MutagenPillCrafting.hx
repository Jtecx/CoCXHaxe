package classes.scenes.crafting;

import classes.globalFlags.KFLAGS;
import classes.ItemType;
import classes.items.alchemy.AlchemyLib;
import classes.scenes.Crafting;
import classes.scenes.SceneLib;
import classes.transformations.PossibleEffect;
import classes.transformations.Transformation;

class MutagenPillCrafting extends AbstractPillCraftingContent
{
    public var furnaceLevel(get, never) : Int;

    private function get_furnaceLevel() : Int
    {
        return Crafting.furnaceLevel;
    }
    
    public function new()
    {
        super();
    }
    
    // Runtime state variables - not saved, must be cleared when you leave the scene
    private var furnaceSubstance : Int = AlchemyLib.AE_NONE;
    private var furnaceEssence : Int = AlchemyLib.AS_NONE;
    
    override public function craftingMenu() : Void
    {
        clearOutput();
        
        outputText("<b>Tool quality</b>: " + furnaceName());
        outputText("\n<b>Substance</b>: " + ((furnaceSubstance != 0) ? AlchemyLib.Substances[furnaceSubstance].name : "<i>none</i>"));
        outputText("\n<b>Essence</b>: " + ((furnaceEssence != 0) ? AlchemyLib.Essences[furnaceEssence].name : "<i>none</i>"));
        printStonesInFurnace();
        
        outputText("\n<b>Skill</b>: " + player.alchemySkillLevel);
        outputText("\n<b>Result</b>: ");
        if (debug || crafting.isTfPillKnown(furnaceSubstance, furnaceEssence))
        {
            var tf : PossibleEffect = Transformation.findSETf(furnaceSubstance, furnaceEssence);
            if (tf != null)
            {
                outputText(tf.alchemyLongName);
            }
            else
            {
                outputText("<b>Impossible combination!</b>");
            }
        }
        else
        {
            outputText("???");
        }
        printRefinementChances();
        
        // [ Refine!] [Substanc] [Essence ] [        ] [        ]
        // [Add SS  ] [Take SS ] [        ] [        ] [        ]
        // [        ] [        ] [        ] [ Clean  ] [ Back   ]
        menu();
        button(0).show("Refine!", doRefinePill).hint("Refine the pill.").disableIf(furnaceSubstance == 0, "Select an alchemical substance.").disableIf(furnaceEssence == 0, "Select an alchemical essence.");
        button(1).show("Substance", curry(crafting.selectReagent, AlchemyLib.RT_SUBSTANCE, selectSubstance, craftingMenu, furnaceSubstance));
        button(2).show("Essence", curry(crafting.selectReagent, AlchemyLib.RT_ESSENCE, selectEssence, craftingMenu, furnaceEssence));
        setAddSSButton(5);
        setTakeSSButton(6);
        button(13).show("Cancel", cleanTheFurnace).hint("Cancel refinement and take back the resources.").disableIf(furnaceSubstance == 0 && furnaceEssence == 0 && furnaceStones == 0);
        button(14).show("Back", crafting.craftingMain).icon("Back").disableIf(furnaceSubstance > 0 || furnaceEssence != 0 || furnaceStones != 0, 
                "Empty the furnace first!"
        );
    }
    private function selectSubstance(i : Int) : Void
    {
        if (furnaceSubstance != 0)
        {
            crafting.addSubstance(furnaceSubstance);
        }
        furnaceSubstance = i;
        craftingMenu();
    }
    private function selectEssence(i : Int) : Void
    {
        if (furnaceEssence != 0)
        {
            crafting.addEssence(furnaceEssence);
        }
        furnaceEssence = i;
        craftingMenu();
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
        if (pillPower == 0)
        {
            outputText("The cloud slows down then suddenly <b>collapses in violent implosion</b>, covering the area in smoke and soot. Unfortunately, the refining had failed.");
            outputText("\n\nCleaning this mess would take some time...");
            furnaceSubstance = 0;
            furnaceEssence = 0;
            furnaceStones = 0;
            player.giveAlchemyXP(AlchemyLib.PillPowerTiers[0].xp);
            doNext(camp.returnToCampUseOneHour);
        }
        else
        {
            crafting.setTfPillKnown(furnaceSubstance, furnaceEssence);
            // TODO @aimozg can craft multiple, depending on skill or other factors
            var npills : Int = 1;
            outputText("The whirling cloud slows down, then shrinks into " +
                    numberOfThings(npills, "cherry-sized orb", "cherry-sized orbs") +
                    " at the bottom of the furnace.\n\n");
            if (Transformation.findSETf(furnaceSubstance, furnaceEssence))
            {
                var pill : ItemType = itemTemplates.createMutagenPill(furnaceSubstance, furnaceEssence, pillPower);
                furnaceSubstance = 0;
                furnaceEssence = 0;
                furnaceStones = 0;
                outputText("<b>You've successfully refined " + ((npills > 1) ? npills + " x " : "a ") + pill.longNameBase + "!</b>");
                // TODO @aimozg support transfering multiple items
                player.giveAlchemyXP(AlchemyLib.PillPowerTiers[pillPower].xp);
                inventory.takeItem(pill, craftingMenu);
            }
            else
            {
                outputText("However, " + ((npills > 1) ? "they crumble" : "it crumbles") + " into gray dust due to incompatibility. <b>It seems that you can't refine " +
                        AlchemyLib.Essences[furnaceEssence].name +
                        " essence with " +
                        AlchemyLib.Substances[furnaceSubstance].name + " substance!</b>");
                furnaceSubstance = 0;
                furnaceEssence = 0;
                furnaceStones = 0;
                player.giveAlchemyXP(AlchemyLib.PillPowerTiers[0].xp);
                doNext(craftingMenu);
            }
        }
    }
    override private function cleanTheFurnace() : Void
    {
        if (furnaceSubstance != 0)
        {
            outputText("\nYou carefully collect the " + AlchemyLib.Substances[furnaceSubstance].name + " substance and put it back in into your alchemical storage.");
            crafting.addSubstance(furnaceSubstance);
            furnaceSubstance = 0;
        }
        if (furnaceEssence != 0)
        {
            outputText("\nYou carefully collect the " + AlchemyLib.Essences[furnaceEssence].name + " essence and put it back in into your alchemical storage.");
            crafting.addEssence(furnaceEssence);
            furnaceEssence = 0;
        }
        super.cleanTheFurnace();
    }
}


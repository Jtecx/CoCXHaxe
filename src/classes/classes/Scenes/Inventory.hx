/**
 * Created by aimozg on 12.01.14.
 */
package classes.scenes;

import haxe.Constraints.Function;
import classes.*;
import classes.globalFlags.KFLAGS;
import classes.items.Armor;
import classes.items.Consumable;
import classes.items.Equipable;
import classes.items.FlyingSwordsLib;
import classes.items.ItemConstants;
import classes.items.Jewelry;
import classes.items.Shield;
import classes.items.Undergarment;
import classes.items.Useable;
import classes.items.VehiclesLib;
import classes.items.Weapon;
import classes.items.WeaponRange;
import classes.scenes.camp.Garden;
import classes.scenes.camp.UniqueCampScenes;
import classes.scenes.areas.forest.TamaniScene;
import classes.scenes.nPCs.HolliPureScene;
import classes.scenes.nPCs.MagnoliaFollower;
import classes.scenes.places.heXinDao.AdventurerGuild;
import coc.view.ButtonDataList;
import coc.view.charview.DragButton;

class Inventory extends BaseContent
{
    private static var inventorySlotName : Array<Dynamic> = ["first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "eighteenth", "nineteenth", "twentieth", 
        "21th", "22th", "23th", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31th", "32th", "33th", "34th", "35th", "36th", "37th", "38th", "39th", "40th", "41th", "42th", "43th", "44th", "45th", "46th", "47th", "48th", "49th", "50th"
    ];
    
    private var itemStorage : Array<Dynamic>;
    private var pearlStorage : Array<Dynamic>;
    private var gearStorage : Array<Dynamic>;
    private static inline var GEAR_WEAPON_FROM : Int = 0;
    private static inline var GEAR_WEAPON_TO : Int = 9;
    private static inline var GEAR_ARMOR_FROM : Int = 9;
    private static inline var GEAR_ARMOR_TO : Int = 18;
    private static inline var GEAR_JEWELRY_FROM : Int = 18;
    private static inline var GEAR_JEWELRY_TO : Int = 27;
    private static inline var GEAR_DRESSER_FROM : Int = 27;
    private static inline var GEAR_DRESSER_TO : Int = 36;
    private static inline var GEAR_SHIELD_FROM : Int = 36;
    private static inline var GEAR_SHIELD_TO : Int = 45;
    private static inline var GEAR_BOC_FROM : Int = 45;
    private static inline var GEAR_BOC_TO : Int = 57;
    private static inline var GEAR_WAREHOUSE1_FROM : Int = 57;
    private static inline var GEAR_WAREHOUSE1_TO : Int = 69;
    private static inline var GEAR_GRANARY_FROM : Int = 69;
    private static inline var GEAR_GRANARY_TO : Int = 78;
    private static inline var GEAR_WAREHOUSE2_FROM : Int = 78;
    private static inline var GEAR_WAREHOUSE2_TO : Int = 90;
    private var callNext : Function;  //These are used so that we know what has to happen once the player finishes with an item  
    private var callOnAbandon : Function;  //They simplify dealing with items that have a sub menu. Set in inventoryMenu and in takeItem  
    private var currentItemSlot : ItemSlotClass;  //The slot previously occupied by the current item - only needed for stashes and items with a sub menu.  
    private var maxSFCapacity : Float = 0;
    public var HolliPure : HolliPureScene = new HolliPureScene();
    public var Gardening : UniqueCampScenes = new UniqueCampScenes();
    public var Magnolia : MagnoliaFollower = new MagnoliaFollower();
    public var tamaniScene : TamaniScene = new TamaniScene();
    
    public function new(saveSystem : Saves)
    {
        super();
        itemStorage = [];
        pearlStorage = [];
        gearStorage = [];
        saveSystem.linkToInventory(itemStorageDirectGet, pearlStorageDirectGet, gearStorageDirectGet);
    }
    
    public function pearlStorageSize() : Int
    {
        if (player.hasKeyItem("Sky Poison Pearl") < 0 && player.hasKeyItem("Dimensional Pocket") < 0)
        {
            return 0;
        }
        var x : Int = 14;
        var y : Float = 0;
        if (player.hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX))
        {
            y += (6 * player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX));
        }
        if (player.level >= (6 - y))
        {
            x += 14;
        }
        if (player.level >= (12 - y))
        {
            x += 14;
        }
        if (player.level >= (18 - y))
        {
            x += 14;
        }
        if (player.level >= (24 - y))
        {
            x += 14;
        }  //129  
        if (player.level >= (30 - y))
        {
            x += 14;
        }  //78 + 87 (165)  
        if (player.level >= (36 - y))
        {
            x += 14;
        }  //96 + 105 (201)  
        return Math.min(98, x);
    }
    
    public function showStash() : Bool
    {
        return player.hasKeyItem("Equipment Rack - Weapons") >= 0 || player.hasKeyItem("Equipment Rack - Armor") >= 0 || player.hasKeyItem("Equipment Rack - Shields") >= 0 || itemStorage.length > 0 || player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0 || flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] > 0;
    }
    
    public function itemStorageDirectGet() : Array<Dynamic>
    {
        return itemStorage;
    }
    
    public function pearlStorageDirectGet() : Array<Dynamic>
    {
        return pearlStorage;
    }
    
    public function pearlStorageSlice() : Array<Dynamic>
    {
        return pearlStorage.slice(0, pearlStorageSize());
    }
    
    public function gearStorageDirectGet() : Array<Dynamic>
    {
        return gearStorage;
    }
    
    //		public function currentCallNext():Function { return callNext; }
    
    public function itemGoNext() : Void
    {
        if (callNext != null)
        {
            doNext(callNext);
        }
    }
    
    public var returnFn : Function = null;
    public function showInventoryMenu(returnFn : Function = null) : Void
    {
        this.returnFn = returnFn;
        inventoryMenu();
    }
    public function inventoryMenu(page : Int = 1) : Void
    {
        DragButton.setup(mainView, mainView.toolTipView);
        var x : Int;
        //var foundItem:Boolean = false;
        if (CoC.instance.inCombat)
        
        //Player will return to combat after item use{
            
            callNext = function() : Void
                    {
                        returnFn = null;
                        inventoryCombatHandler();
                    };
        }
        else
        {
            spriteSelect(null);
            callNext = inventoryMenu;
        }
        hideMenus();
        hideUpDown();
        clearOutput();
        mainView.linkHandler = showItemTooltipLinkHandler;
        EngineCore.displayHeader("Inventory");
        outputText("<b><u>Equipment:</u></b>\n");
        outputText("<b>Weapon (Melee main hand):</b> " + mkLink(player.weapon.name, player.weapon.id) + " (Attack: " + player.weaponAttack + ")");
        if (player.isGauntletWeapon())
        {
            outputText(" (Gauntlet-type weapon)");
            outputText("\n");
            outputText("<b>Weapon (Melee off hand):</b> " + mkLink(player.weapon.name, player.weapon.id) + " (Attack: " + player.weaponAttack + ") (Gauntlet-type weapon)");
        }
        if (player.weapon.isSwordType())
        {
            outputText(" (Sword-type weapon)");
        }
        if (player.weapon.isAxeType())
        {
            outputText(" (Axe-type weapon)");
        }
        if (player.weapon.isMaceHammerType())
        {
            outputText(" (Mace/Hammer-type weapon)");
        }
        if (player.weapon.isDuelingType())
        {
            outputText(" (Dueling Sword-type weapon)");
        }
        if (player.weapon.isSpearType())
        {
            outputText(" (Spear-type weapon)");
        }
        if (player.weapon.isScytheType())
        {
            outputText(" (Scythe-type weapon)");
        }
        if (player.weapon.isDaggerType())
        {
            outputText(" (Dagger-type weapon)");
        }
        if (player.weapon.isStaffType())
        {
            outputText(" (Staff-type weapon)");
        }
        if (player.weapon.isWandType())
        {
            outputText(" (Wand-type weapon)");
        }
        if (player.weapon.isWhipType())
        {
            outputText(" (Whip-type weapon)");
        }
        if (player.weapon.isRibbonType())
        {
            outputText(" (Ribbon-type weapon)");
        }
        if (player.weapon.isExoticType())
        {
            outputText(" (Exotic-type weapon)");
        }
        if (!player.weaponOff.isNothing)
        {
            outputText("\n");
            outputText("<b>Weapon (Melee off hand):</b> " + mkLink(player.weaponOff.name, player.weaponOff.id) + " (Attack: " + player.weaponOffhandAttack + ")");
            if (player.weaponOff.isSwordType())
            {
                outputText(" (Sword-type weapon)");
            }
            if (player.weaponOff.isAxeType())
            {
                outputText(" (Axe-type weapon)");
            }
            if (player.weaponOff.isMaceHammerType())
            {
                outputText(" (Mace/Hammer-type weapon)");
            }
            if (player.weaponOff.isDuelingType())
            {
                outputText(" (Dueling Sword-type weapon)");
            }
            if (player.weaponOff.isSpearType())
            {
                outputText(" (Spear-type weapon)");
            }
            if (player.weaponOff.isScytheType())
            {
                outputText(" (Scythe-type weapon)");
            }
            if (player.weaponOff.isDaggerType())
            {
                outputText(" (Dagger-type weapon)");
            }
            if (player.weaponOff.isStaffType())
            {
                outputText(" (Staff-type weapon)");
            }
            if (player.weaponOff.isWandType())
            {
                outputText(" (Wand-type weapon)");
            }
            if (player.weaponOff.isWhipType())
            {
                outputText(" (Whip-type weapon)");
            }
            if (player.weaponOff.isRibbonType())
            {
                outputText(" (Ribbon-type weapon)");
            }
            if (player.weaponOff.isExoticType())
            {
                outputText(" (Exotic-type weapon)");
            }
        }
        else
        {
            outputText("\n");
            outputText("<b>Shield:</b> " + mkLink(player.shield.name, player.shield.id) + " (Block Rating: " + player.shieldBlock + ")");
            if (player.shieldPerk == "Large")
            {
                outputText(" (Large)");
            }
            if (player.shieldPerk == "Massive")
            {
                outputText(" (Massive)");
            }
        }
        outputText("\n");
        outputText("<b>Weapon (Range):</b> " + mkLink(player.weaponRange.name, player.weaponRange.id) + " (Attack: " + player.weaponRangeAttack + ")");
        if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow")
        {
            outputText(" (Bow/Crosbow-type weapon)");
        }
        if (player.weaponRangePerk == "Throwing")
        {
            outputText(" (Throwing weapon-type weapon)");
        }
        if (player.isFirearmTypeWeapon())
        {
            outputText(" (Firearms-type weapon)");
        }
        outputText("\n");
        outputText("<b>Armour:</b> " + mkLink(player.armor.name, player.armor.id) + " (Physical / Magical Defense: " + player.armorDef + " / " + player.armorMDef + ")\n");
        outputText("<b>Upper underwear:</b> " + mkLink(player.upperGarment.name, player.upperGarment.id) + "\n");
        outputText("<b>Lower underwear:</b> " + mkLink(player.lowerGarment.name, player.lowerGarment.id) + "\n");
        outputText("<b>Head Accessory/Helm:</b> " + mkLink(player.headJewelry.name, player.headJewelry.id) + "\n");
        outputText("<b>Necklace:</b> " + mkLink(player.necklace.name, player.necklace.id) + "\n");
        outputText("<b>Ring (1st):</b> " + mkLink(player.jewelry1.name, player.jewelry1.id) + "\n");
        if (player.hasPerk(PerkLib.SecondRing))
        {
            outputText("<b>Ring (2nd):</b> " + mkLink(player.jewelry2.name, player.jewelry2.id) + "\n");
        }
        else
        {
            outputText("<b>Ring (2nd):</b> <i>LOCKED</i> (req. Second Ring perk)\n");
        }
        if (player.hasPerk(PerkLib.ThirdRing))
        {
            outputText("<b>Ring (3rd):</b> " + mkLink(player.jewelry3.name, player.jewelry3.id) + "\n");
        }
        else
        {
            outputText("<b>Ring (3rd):</b> <i>LOCKED</i> (req. Third Ring perk)\n");
        }
        if (player.hasPerk(PerkLib.FourthRing))
        {
            outputText("<b>Ring (4th):</b> " + mkLink(player.jewelry4.name, player.jewelry4.id) + "\n");
        }
        else
        {
            outputText("<b>Ring (4th):</b> <i>LOCKED</i> (req. Fourth Ring perk)\n");
        }
        outputText("<b>Accessory (1st):</b> " + mkLink(player.miscJewelry1.name, player.miscJewelry1.id) + "\n");
        outputText("<b>Accessory (2nd):</b> " + mkLink(player.miscJewelry2.name, player.miscJewelry2.id) + "\n");
        if (player.hasPerk(PerkLib.FlyingSwordPath))
        {
            outputText("<b>Flying Sword:</b> " + mkLink(player.weaponFlyingSwords.name, player.weaponFlyingSwords.id) + "\n");
        }
        else
        {
            outputText("<b>Flying Sword:</b> <i>LOCKED</i> (req. Flying Swords Control perk)\n");
        }
        outputText("<b>Vehicle:</b> " + mkLink(player.vehicles.name, player.vehicles.id) + "\n");
        if (player.hasKeyItem("Bag of Cosmos") >= 0 || player.hasKeyItem("Sky Poison Pearl") >= 0)
        {
            outputText("\n");
            if (player.hasKeyItem("Bag of Cosmos") >= 0)
            {
                outputText("<i>At your belt hangs bag of cosmos.</i>\n");
            }
            if (player.hasKeyItem("Sky Poison Pearl") >= 0)
            {
                outputText("<i>There is a circular green imprint at the palm of your left hand.</i>\n");
            }
        }
        outputText("\nWhich item will you use? (To discard unwanted items, hold Shift then click the item.)");
        outputText("\n<b>Capacity:</b> " + getOccupiedSlots() + " / " + getMaxSlots() + "\n");
        if (player.keyItems.length > 0)
        {
            outputText("\n<b><u>Key Items:</u></b>\n");
        }
        for (x in 0...player.keyItems.length)
        {
            outputText(player.keyItems[x].keyName + "\n");
        }
        menu();
        if (page == 1)
        {
            for (x in 0...10)
            {
                if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0)
                {
                    button(x).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
                }
            }
            if (getMaxSlots() > 10)
            {
                addButton(13, "Next", inventoryMenu, page + 1);
            }
        }
        if (page == 2)
        {
            for (x in 10...20)
            {
                if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0)
                {
                    button(x - 10).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
                }
            }
            //addButton(12, "Prev", inventoryMenu, page - 1);
            if (getMaxSlots() > 20)
            {
                addButton(13, "Next", inventoryMenu, page + 1);
            }
            else
            {
                addButton(13, "Next", inventoryMenu, page - 1);
            }
        }
        if (page == 3)
        {
            for (x in 20...30)
            {
                if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0)
                {
                    button(x - 20).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
                }
            }
            //addButton(12, "Prev", inventoryMenu, page - 1);
            if (getMaxSlots() > 30)
            {
                addButton(13, "Next", inventoryMenu, page + 1);
            }
            else
            {
                addButton(13, "Next", inventoryMenu, page - 2);
            }
        }
        if (page == 4)
        {
            for (x in 30...40)
            {
                if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0)
                {
                    button(x - 30).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
                }
            }
            //addButton(12, "Prev", inventoryMenu, page - 1);
            if (getMaxSlots() > 40)
            {
                addButton(13, "Next", inventoryMenu, page + 1);
            }
            else
            {
                addButton(13, "Next", inventoryMenu, page - 3);
            }
        }
        if (page == 5)
        {
            for (x in 40...50)
            {
                if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0)
                {
                    button(x - 40).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
                }
            }
            //addButton(12, "Prev", inventoryMenu, page - 1);
            addButton(13, "Next", inventoryMenu, page - 4);
        }
        if (!CoC.instance.inCombat)
        {
            addButton(10, "Unequip/Misc", manageEquipmentmiscitemsMenu);
            if (player.hasKeyItem("Bag of Cosmos") >= 0)
            {
                if (player.hasPerk(PerkLib.Soulless))
                {
                    addButtonDisabled(11, "Bag of Cosmos", "Without soul nor SF you can't open Bag of Cosmos.");
                }
                else
                {
                    addButton(11, "Bag of Cosmos", BagOfCosmosMenuv2);
                }
            }
            if (player.hasKeyItem("Sky Poison Pearl") >= 0)
            {
                addButton(12, "Sky P. Pearl", SkyPoisonPearlMenuv2);
            }
            if (player.hasKeyItem("Dimensional Pocket") >= 0)
            {
                addButton(12, "Dimensional P.", DimensionalPocketMenuv2);
            }
        }
        //Button for alchemical items during combat
        if (CoC.instance.inCombat)
        {
            addButton(11, "Potions", SceneLib.garden.PotionMenu).disableIf(Garden.PotionsBagSlot01Cap == 0, "You not have any potions bag.");
        }
        if (CoC.instance.inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv1(StatusEffects.Sealed) == 3)
        {
            outputText("\nYou reach for your items, but you just can't get your pouches open.  <b>Your ability to use items was sealed, and now you've wasted a chance to attack!</b>\n\n");
            SceneLib.combat.enemyAIImpl();
            return;
        }
        addButton(14, "Back", returnFromInventory);
    }
    private function returnFromInventory() : Void
    {
        var returnFn : Function = this.returnFn;
        if (returnFn != null)
        {
            this.returnFn = null;
            returnFn();
            return;
        }
        if (CoC.instance.inCombat)
        {
            SceneLib.combat.combatMenu(false);
        }
        else
        {
            playerMenu();
        }
    }
    
    public function showItemTooltipLinkHandler(itemid : String) : Void
    {
        var item : ItemType = ItemType.lookupItem(itemid);
        if (item != null)
        {
            mainView.toolTipView.header = item.longName;
            mainView.toolTipView.text = item.description;
            mainView.toolTipView.show(mainView.mouseX, mainView.mouseY, 0, 0);
        }
    }
    
    public function manageEquipmentmiscitemsMenu() : Void
    {
        menu();
        if (!inDungeon && !inRoomedDungeon && flags[kFLAGS.IN_INGNAM] == null)
        {
            var miscNieve : Bool = Holidays.nieveHoliday() && flags[kFLAGS.NIEVE_STAGE] > 0 && flags[kFLAGS.NIEVE_STAGE] < 5;
            var miscHolli : Bool = flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 1 && flags[kFLAGS.FUCK_FLOWER_LEVEL] < 4 || flags[kFLAGS.FLOWER_LEVEL] >= 1 && flags[kFLAGS.FLOWER_LEVEL] < 4);
            if (miscNieve || miscHolli || player.hasKeyItem("Dragon Egg") >= 0 || (player.hasKeyItem("Rathazul's Purity Elixir") >= 0 && player.perkv1(PerkLib.PurityElixir) < 5) || player.hasKeyItem("Tamani's Satchel") >= 0 || flags[kFLAGS.ANEMONE_KID] > 0 || flags[kFLAGS.ALRAUNE_SEEDS] > 0 || (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 0 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 8))
            {
                if (miscNieve)
                {
                    if (flags[kFLAGS.NIEVE_STAGE] == 1)
                    {
                        outputText("\nThere's some odd snow here that you could do something with...\n");
                    }
                    else
                    {
                        outputText("\nYou have a snow" + Holidays.nieveMF("man", "woman") + " here that seems like it could use a little something...\n");
                    }
                }
                if (player.hasKeyItem("Dragon Egg") >= 0)
                {
                    SceneLib.emberScene.emberCampDesc();
                    addButton(3, "Egg", SceneLib.emberScene.emberEggInteraction);
                }
                if (player.hasKeyItem("Tamani's Satchel") >= 0)
                {
                    addButton(5, "Satchel", tamaniScene.openTamanisSatchel);
                }
                if (flags[kFLAGS.ANEMONE_KID] > 0)
                {
                    SceneLib.kidAScene.anemoneBarrelDescription();
                    if (model.time.hours >= 6)
                    {
                        addButton(4, "Anemone", SceneLib.kidAScene.approachAnemoneBarrel);
                    }
                }
                if (flags[kFLAGS.ALRAUNE_SEEDS] > 0)
                {
                    outputText("\nYou have " + flags[kFLAGS.ALRAUNE_SEEDS] + " alraune seeds planted in your garden.");
                    if (flags[kFLAGS.ALRAUNE_GROWING] > 14)
                    {
                        outputText(" Some have already grown to adulthood.");
                    }
                    outputText("\n");
                }
                if (Holidays.nieveHoliday())
                {
                    if (flags[kFLAGS.NIEVE_STAGE] > 0 && flags[kFLAGS.NIEVE_STAGE] < 5)
                    {
                        addButton(1, "Snow", SceneLib.holidays.nieveBuilding);
                    }
                    if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 1 && player.hasKeyItem("Mysterious Seed") >= 0)
                    {
                        addButton(7, "Mysterious Seed", Magnolia.treeMenu);
                    }
                    if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 2 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 9)
                    {
                        if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 7 && player.hasKeyItem("Decorations") >= 0)
                        {
                            addButton(7, "Decorate Tree", Magnolia.treeMenu);
                        }
                        else
                        {
                            addButton(7, (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] >= 8) ? "Ch. Tree" : "Green Tree", Magnolia.treeMenu);
                        }
                    }
                }
                if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 1 && flags[kFLAGS.FUCK_FLOWER_LEVEL] < 4)
                {
                    addButton(2, (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 3) ? "Tree" : "Plant", SceneLib.holliScene.treeMenu);
                }
                if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.FLOWER_LEVEL] >= 1 && flags[kFLAGS.FLOWER_LEVEL] < 4)
                {
                    addButton(2, (flags[kFLAGS.FLOWER_LEVEL] >= 3) ? "Tree" : "Plant", HolliPure.treeMenu);
                }
                if (flags[kFLAGS.ALRAUNE_SEEDS] > 0 && model.time.hours >= 6)
                {
                    addButton(0, "Garden", Gardening.manageyourgarden).hint("Visit your plant offspring");
                }
                if (player.hasKeyItem("Rathazul's Purity Elixir") >= 0 && player.perkv1(PerkLib.PurityElixir) < 5)
                {
                    addButton(9, "PurityElixir", PurityElixir);
                }
            }
        }
        addButton(10, "Unequip", manageEquipment);
        if (player.isInAyoArmor())
        {
            addButton(11, "Ayo Armors", AyoArmorsMaintance);
        }
        else
        {
            addButtonDisabled(11, "Ayo Armors", "You need to wear any type of Ayo Armor to use this option.");
        }
        addButton(14, "Back", inventoryMenu);
    }
    
    private function PurityElixir() : Void
    {
        clearOutput();
        if (player.getAllMinStats().cor == 0)
        {
            outputText("You take out the elixir, but reconsider. ");
            if (player.cor > 0)
            {
                outputText("All of your corruption can be removed using simpler methods.");
            }
            else
            {
                outputText("You're completely pure!");
            }
            outputText("\n\nYou decide to leave the elixir for worse times.");
        }
        else
        {
            outputText("You feel something unlock within you as you drink the elixir, some of the veil of corruption being washed out of you as the liquid undo and counteract some of the vile demonic changes your body was afflicted with.");
            outputText("\n\n<b>Minimum corruption lowered!</b>");
            if (player.keyItemvX("Rathazul's Purity Elixir", 1) > 1)
            {
                player.addKeyValue("Rathazul's Purity Elixir", 1, -1);
            }
            else
            {
                player.removeKeyItem("Rathazul's Purity Elixir");
            }
            if (player.hasPerk(PerkLib.PurityElixir))
            {
                player.addPerkValue(PerkLib.PurityElixir, 1, 1);
            }
            else
            {
                player.createPerk(PerkLib.PurityElixir, 1, 0, 0, 0);
            }
        }
        doNext(inventoryMenu);
    }
    
    public function AyoArmorsMaintance() : Void
    {
        clearOutput();
        var currentArmorSFDrainrate : Float = 0;
        if (player.armor == armors.LAYOARM)
        {
            currentArmorSFDrainrate += 60;
        }
        if (player.armor == armors.HAYOARM)
        {
            currentArmorSFDrainrate += 120;
        }
        if (player.armor == armors.UHAYOARM)
        {
            currentArmorSFDrainrate += 240;
        }
        if (player.armor == armors.HBARMOR)
        {
            currentArmorSFDrainrate += 180;
        }
        if (player.vehicles == vehicles.HB_MECH)
        {
            if (player.hasKeyItem("HB Internal Systems") >= 0)
            {
                if (player.keyItemvX("HB Internal Systems", 1) == 2)
                {
                    currentArmorSFDrainrate += 40;
                }
                else
                {
                    currentArmorSFDrainrate += 50;
                }
            }
            else
            {
                currentArmorSFDrainrate += 60;
            }
        }
        maxSFCapacity = 0;
        if (player.armor == armors.LAYOARM)
        {
            maxSFCapacity += 1500;
        }
        if (player.armor == armors.HAYOARM)
        {
            maxSFCapacity += 3000;
        }
        if (player.armor == armors.UHAYOARM)
        {
            maxSFCapacity += 6000;
        }
        if (player.armor == armors.HBARMOR)
        {
            maxSFCapacity += 4500;
            if (player.headJewelry == headjewelries.HBHELM)
            {
                maxSFCapacity += 900;
            }
        }
        if (player.upperGarment == undergarments.HBSHIRT)
        {
            maxSFCapacity += 350;
        }
        if (player.lowerGarment == undergarments.HBSHORT)
        {
            maxSFCapacity += 350;
        }
        if (player.vehicles == vehicles.HB_MECH)
        {
            maxSFCapacity += 1000;
            if (player.hasKeyItem("HB Internal Systems") >= 0)
            {
                if (player.keyItemvX("HB Internal Systems", 1) == 2)
                {
                    maxSFCapacity += 5000;
                }
                else
                {
                    maxSFCapacity += 2000;
                }
            }
        }
        //if (player.vehicles == vehicles.HB_MECH) maxSFCapacity += 1000;
        outputText("Currently used Ayo Armor name: " + player.armorName + "\n\n");
        outputText("Currently used Ayo Armor soulforce drain rate (per hour): " + currentArmorSFDrainrate + "\n\n");
        outputText("Soulforce reserves in armor: " + flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] + " / " + maxSFCapacity + "\n\n");
        menu();
        var btn : Int = 0;
        for (amnt in [50, 100, 200, 500])
        {
            addButton(btn++, "Charge " + amnt, AyoArmorRecharge, amnt).disableIf(player.soulforce < amnt, "Your current soulforce is too low.");
        }
        addButton(btn++, "Full Charge", AyoArmorRecharge, -1).disableIf(player.soulforce <= 0, "You don't have any soulforce at all!");
        addButton(10, "Power UP", AyoArmorPowerUP).hint("Activate Ayo Armor (increases strength and speed)").disableIf(flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] == 0, 
                "You need to charge your Ayo Armor with Soulforce before using Power UP function."
        );
        addButton(14, "Back", inventoryMenu);
    }
    
    public function AyoArmorRecharge(amnt : Int) : Void
    {
        clearOutput();
        if (amnt < 0)
        {
            amnt = player.soulforce;
        }
        amnt = Math.min(amnt, maxSFCapacity - flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR]);
        outputText("You focus on your spiritual power and guide it to armor energy storages recharging it for " + amnt + " soulforce.");
        flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] += amnt;
        EngineCore.SoulforceChange(-amnt);
        doNext(AyoArmorsMaintance);
    }
    
    public function AyoArmorPowerUP() : Void
    {
        clearOutput();
        var oldHPratio : Float = player.hp100 / 100;
        player.buff("Ayo Armor").remove();
        outputText("You pressing button placed on side of chest part of armor, activating it. With a silent hiss armor activate making you feel faster and stronger." + ((silly()) ? " You have come here to chew bubblegum and kick ass...and you're all out of bubblegum." : "") + "");
        if (player.armor == armors.LAYOARM)
        {
            player.buff("Ayo Armor").addStats({
                        str.mult : 0.10,
                        spe.mult : 0.10
                    });
        }
        if (player.armor == armors.HAYOARM)
        {
            player.buff("Ayo Armor").addStats({
                        str.mult : 0.20,
                        spe.mult : 0.20
                    });
        }
        if (player.armor == armors.UHAYOARM)
        {
            player.buff("Ayo Armor").addStats({
                        str.mult : 0.40,
                        spe.mult : 0.30,
                        tou.mult : 0.10
                    });
        }
        if (player.armor == armors.HBARMOR)
        {
            player.buff("Ayo Armor").addStats({
                        str.mult : 0.18,
                        spe.mult : 0.60
                    });
        }
        player.HP = oldHPratio * player.maxHP();
        statScreenRefresh();
        doNext(AyoArmorsMaintance);
    }
    
    public function BagOfCosmosMenuv2() : Void
    {
        transferMenu(gearStorage, GEAR_BOC_FROM, GEAR_BOC_TO, inventoryMenu, "BagofCosmos");
    }
    
    public function SkyPoisonPearlMenuv2() : Void
    {
        transferMenu(pearlStorage, 0, pearlStorageSize(), inventoryMenu, "S. P. Pearl");
    }
    
    public function DimensionalPocketMenuv2() : Void
    {
        transferMenu(pearlStorage, 0, pearlStorageSize(), inventoryMenu, "DimensionalP.");
    }
    
    public function transferMenu(
            storage : Array<Dynamic>,
            startInclusive : Int,
            endExclusive : Int,
            backFn : Function,
            storageName : String = "Storage",
            itemTypeFilter : Function = null,
            canTake : Bool = true,
            canStore : Bool = true) : Void
    {
        DragButton.setup(mainView, mainView.toolTipView);
        var fromStorage : Int->Void = function(i : Int) : Void
        {
            var storageSlot : ItemSlotClass = storage[i];
            if (storageSlot.isEmpty())
            {
                return;
            }
            if (transferOneItemToPlayer(storageSlot))
            {
                if (shiftKeyDown && storageSlot.quantity > 0)
                {
                    fromStorage(i);
                }
                else
                {
                    show();
                }
            }
        }
        var toStorage : Int->Void = function(i : Int) : Void
        {
            var playerSlot : ItemSlotClass = player.itemSlots[i];
            if (playerSlot.isEmpty() || itemTypeFilter != null && !itemTypeFilter(playerSlot.itype))
            {
                return;
            }
            if (transferOneItemToStorage(playerSlot, storage, startInclusive, endExclusive, storageName))
            {
                if (shiftKeyDown && playerSlot.quantity > 0)
                {
                    toStorage(i);
                }
                else
                {
                    show();
                }
            }
        }
        var storeAll : Void->Void = function() : Void
        {
            for (playerSlot/* AS3HX WARNING could not determine type for var: playerSlot exp: EField(EIdent(player),itemSlots) type: null */ in player.itemSlots)
            {
                if (itemTypeFilter != null && !itemTypeFilter(playerSlot.itype))
                {
                    return;
                }
                while (playerSlot.quantity > 0)
                {
                    if (!transferOneItemToStorage(playerSlot, storage, startInclusive, endExclusive, storageName))
                    {
                        break;
                    }
                }
            }
            show();
        }
        var takeAll : Void->Void = function() : Void
        {
            for (i in startInclusive...endExclusive)
            {
                var storageSlot : ItemSlotClass = storage[i];
                while (storageSlot.quantity > 0)
                {
                    if (!transferOneItemToPlayer(storageSlot))
                    {
                        break;
                    }
                }
            }
            show();
        }
        var findSameInStorage : ItemSlotClass->ItemSlotClass = function(playerSlot : ItemSlotClass) : ItemSlotClass
        {
            for (i in startInclusive...endExclusive)
            {
                var storageSlot : ItemSlotClass = storage[i];
                if (storageSlot.quantity > 0 && storageSlot.itype == playerSlot.itype)
                {
                    return storageSlot;
                }
            }
            return null;
        }
        var restock : Void->Void = function() : Void
        {
            for (playerSlot/* AS3HX WARNING could not determine type for var: playerSlot exp: EField(EIdent(player),itemSlots) type: null */ in player.itemSlots)
            {
                if (!playerSlot.unlocked || playerSlot.quantity == 0)
                {
                    continue;
                }
                while (playerSlot.quantity < playerSlot.itype.stackSize)
                {
                    var storageSlot : ItemSlotClass = findSameInStorage(playerSlot);
                    if (storageSlot == null)
                    {
                        break;
                    }
                    storageSlot.removeOneItem();
                    playerSlot.quantity++;
                }
            }
            show();
        }
        var drop : Void->Void = function() : Void
        {
            for (playerSlot/* AS3HX WARNING could not determine type for var: playerSlot exp: EField(EIdent(player),itemSlots) type: null */ in player.itemSlots)
            {
                if (!playerSlot.unlocked || playerSlot.quantity == 0)
                {
                    continue;
                }
                if (!findSameInStorage(playerSlot))
                {
                    continue;
                }
                while (playerSlot.quantity > 0)
                {
                    if (!transferOneItemToStorage(playerSlot, storage, startInclusive, endExclusive, storageName))
                    {
                        break;
                    }
                }
            }
            show();
        }
        function sortStorage() : Void
        // Sort
        {
            
            var temp : Array<Dynamic> = sortedBy(storage.slice(startInclusive, endExclusive), 
                            function(e : ItemSlotClass) : String
                            {
                                return (e.quantity > 0) ? e.itype.shortName : "\uffff";
                            }
                ).map(varargify(function(e : ItemSlotClass) : ItemSlotClass
                            {
                                return e.clone();
                            }));
            var i : Int;
            for (i in 0...temp.length)
            {
                storage[startInclusive + i].setItemAndQty(temp[i].itype, temp[i].quantity);
            }
            
            // Compact neighbouring cells, moving everything to the left
            var ref : Int = startInclusive;
            for (i in startInclusive + 1...endExclusive)
            {
                var slot : ItemSlotClass = storage[i];
                var refslot : ItemSlotClass = storage[ref];
                var itype : ItemType = slot.itype;
                var room : Int = as3hx.Compat.parseInt(itype.stackSize - refslot.quantity);
                if (refslot.isEmpty() || itype != refslot.itype)
                {
                    ref = i;
                    continue;
                }
                // refslot and slot contain same item, and refslot has free space
                var n : Int = Math.min(room, slot.quantity);
                if (n > 0)
                {
                    refslot.quantity += n;
                    slot.quantity -= n;
                }
                if (!refslot.hasRoom() && slot.quantity > 0)
                
                // refslot is full but there's more items in slot{
                    
                    // ex. ref=[4] [1] slot=[3] -> ref=[5] [1] slot=[2]
                    // try move refslot to next
                    if (ref + 1 < i)
                    {
                        ref++;
                        i--;
                    }
                }
            }
            
            // Fill empty cells
            var d : Int = 0;  // number of empty cells, move all non-empty <d> cells to the left  
            for (i in startInclusive + 1...endExclusive)
            {
                slot = storage[i];
                if (slot.isEmpty())
                {
                    d++;
                }
                else if (d > 0)
                {
                    storage[i - d].setItemAndQty(slot.itype, slot.quantity);
                    slot.emptySlot();
                }
            }
            
            show();
        }  // 1 row : storage pages    // 5 rows: storage    // 1 row : spacer    // 1 row : player inventory pages    // 5 rows: player inventory  ;
        
        
        
        
        
        
        
        
        
        
        
        var playerItemCount : Int = player.itemSlotCount();
        var storageItemCount : Int = as3hx.Compat.parseInt(endExclusive - startInclusive);
        var N : Int = 25;
        var playerPage : Int = 0;
        var storagePage : Int = 0;
        var freeRows : Int;
        if (storageItemCount < N && playerItemCount > N)
        
        // add more rows for player using storage rows{
            
            freeRows = as3hx.Compat.parseInt(6 - (storageItemCount + 4) / 5);
            N += as3hx.Compat.parseInt(freeRows * 5);
        }
        if (playerItemCount < N && storageItemCount > N)
        
        // add more rows for storage using player rows{
            
            freeRows = as3hx.Compat.parseInt(6 - (playerItemCount + 4) / 5);
            N += as3hx.Compat.parseInt(freeRows * 5);
        }
        var playerPageMax : Int = Math.max(0, Math.ceil(playerItemCount / N));
        var storagePageMax : Int = Math.max(0, Math.ceil(storageItemCount / N));
        
        var show : Void->Void = function() : Void
        {
            var i : Int;
            var n : Int;
            hideMenus();
            clearOutput();
            outputText("<i>(Shift+click to transfer full stack)</i>\n");
            outputText("Inventory: ");
            menu();
            var bd : ButtonDataList = new ButtonDataList();
            
            // Player inventory
            n = Math.min((playerPage + 1) * N, playerItemCount);
            for (i in playerPage * N...n)
            {
                var playerSlot : ItemSlotClass = player.itemSlots[i];
                bd.add("Put", curry(toStorage, i)).forItemSlot(playerSlot).drag(playerSlot, itemTypeFilter).disableIf(itemTypeFilter != null && !itemTypeFilter(playerSlot.itype)).disableIf(playerSlot.isEmpty()).disableIf(!canStore);
            }
            while (bd.length % 5 > 0)
            {
                bd.add("");
            }  // Padding  
            if (playerPageMax > 0)
            {
                bd.add("Prev", function() : Void
                                                {
                                                    playerPage--;
                                                    show();
                                                }).hint("Prev inventory page").disableIf(playerPage == 0).icon("Left");
                bd.add("");
                bd.add("");
                bd.add("");
                bd.add("Next", function() : Void
                                                {
                                                    playerPage++;
                                                    show();
                                                }).hint("Next inventory page").disableIf(playerPage == playerPageMax - 1).icon("Right");
            }
            
            // Spacer
            bd.add(storageName + ":").extra("text");
            for (i in 1...5)
            {
                bd.add("");
            }
            
            // Storage
            n = Math.min(startInclusive + (storagePage + 1) * N, endExclusive);
            for (i in startInclusive + storagePage * N...n)
            {
                var storageSlot : ItemSlotClass = storage[i];
                bd.add("Take", curry(fromStorage, i)).forItemSlot(storageSlot).drag(storageSlot, itemTypeFilter).disableIf(storageSlot.isEmpty()).disableIf(!canTake);
            }
            while (bd.length % 5 > 0)
            {
                bd.add("");
            }  // Padding  
            if (storagePageMax > 0)
            {
                bd.add("Prev", function() : Void
                                                {
                                                    storagePage--;
                                                    show();
                                                }).hint("Prev storage page").disableIf(storagePage == 0).icon("Left");
                bd.add("");
                bd.add("");
                bd.add("");
                bd.add("Next", function() : Void
                                                {
                                                    storagePage++;
                                                    show();
                                                }).hint("Next storage page").disableIf(storagePage == storagePageMax - 1).icon("Right");
            }
            
            bigButtonGrid(bd);
            if (canStore)
            {
                addButton(0, "Store All", storeAll).hint("Move all items from your inventory to the storage");
            }
            if (canTake)
            {
                addButton(1, "Take All", takeAll).hint("Take all items from the storage to your inventory");
            }
            if (canStore)
            {
                addButton(4, "Sort storage", sortStorage).hint("Sort and compact the storage");
            }
            if (canStore)
            {
                addButton(5, "Drop", drop).hint("Move from your inventory items of types that are already in storage");
            }
            if (canTake)
            {
                addButton(6, "Restock", restock).hint("Refill items in your inventory from the storage to max. stack size");
            }
            
            addButton(14, "Back", backFn).icon("Back");
        }
        
        show();
    }
    
    public function stash() : Void
    {
        hideMenus();
        clearOutput();
        spriteSelect(null);
        menu();
        
        if (player.hasKeyItem("Camp - Chest") >= 0 || player.hasKeyItem("Camp - Murky Chest") >= 0 || player.hasKeyItem("Camp - Ornate Chest") >= 0)
        {
            var chestArray : Array<Dynamic> = [];
            if (player.hasKeyItem("Camp - Chest") >= 0)
            {
                chestArray.push("a large wood and iron chest");
            }
            if (player.hasKeyItem("Camp - Murky Chest") >= 0)
            {
                chestArray.push("a medium damp chest");
            }
            if (player.hasKeyItem("Camp - Ornate Chest") >= 0)
            {
                chestArray.push("a medium gilded chest");
            }
            outputText("You have " + formatStringArray(chestArray) + " to help store excess items located ");
            if (camp.homeDesc() == "cabin")
            {
                outputText("inside your cabin");
            }
            else
            {
                outputText("near the portal entrance");
            }
            outputText(".\n\n");
            addButton(0, "Chest", curry(transferMenu, itemStorage, 0, itemStorage.length, stash, "Chest"));
        }
        //Jewelry box
        if (player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0)
        {
            outputText("Your jewelry box is located ");
            if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] != null)
            {
                if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] != null)
                {
                    outputText("on your dresser inside your cabin.");
                }
                else if (flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] != null)
                {
                    outputText("on your nightstand inside your cabin.");
                }
                else
                {
                    outputText("under your bed inside your cabin.");
                }
            }
            else
            {
                outputText("next to your bedroll.");
            }
            addButton(1, "J.Box", curry(transferMenu, gearStorage, GEAR_JEWELRY_FROM, GEAR_JEWELRY_TO, stash, "Jewelry box", jewelryAcceptable));
            outputText("\n\n");
        }
        //Dresser
        if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] > 0)
        {
            outputText("You have a dresser inside your cabin to store nine different types of undergarments.\n\n");
            addButton(2, "Dresser", curry(transferMenu, gearStorage, GEAR_DRESSER_FROM, GEAR_DRESSER_TO, stash, "Dresser", undergarmentAcceptable));
        }
        if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] < 2)
        
        //Weapon Rack{
            
            if (player.hasKeyItem("Equipment Rack - Weapons") >= 0)
            {
                outputText("There's a weapon rack set up here, able to hold up to nine various weapons.\n\n");
                addButton(3, "W.Rack", curry(transferMenu, gearStorage, GEAR_WEAPON_FROM, GEAR_WEAPON_TO, stash, "Weapon rack", weaponAcceptable));
            }
            //Armor Rack
            if (player.hasKeyItem("Equipment Rack - Armor") >= 0)
            {
                outputText("Your camp has an armor rack set up to hold your various sets of gear.  It appears to be able to hold nine different types of armor.\n\n");
                addButton(4, "A.Rack", curry(transferMenu, gearStorage, GEAR_ARMOR_FROM, GEAR_ARMOR_TO, stash, "Armor rack", armorAcceptable));
            }
            //Shield Rack
            if (player.hasKeyItem("Equipment Rack - Shields") >= 0)
            {
                outputText("There's a shield rack set up here, set up to hold up to nine various shields.\n\n");
                addButton(5, "S.Rack", curry(transferMenu, gearStorage, GEAR_SHIELD_FROM, GEAR_SHIELD_TO, stash, "Shield rack", shieldAcceptable));
            }
        }
        addButton(14, "Back", playerMenu);
    }
    
    public function warehouse() : Void
    {
        hideMenus();
        clearOutput();
        spriteSelect(null);
        menu();
        outputText("You walk inside your warehouse");
        if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2 && flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] < 4)
        {
            outputText(", looking at the goods stored inside.");
        }
        else if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 4 && flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] < 6)
        {
            outputText(" and connected to it medium-sized granary looking at the goods and food stored inside.");
        }
        else if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 6)
        {
            outputText("s and connecting them medium-sized granary looking at the goods and food stored inside.");
        }
        outputText("\n\n");
        //Warehouse part 1 and 2
        if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2)
        {
            addButton(0, "Warehouse 1", curry(transferMenu, gearStorage, GEAR_WAREHOUSE1_FROM, GEAR_WAREHOUSE1_TO, warehouse, "Warehouse 1"));
        }
        if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 6)
        {
            addButton(1, "Warehouse 2", curry(transferMenu, gearStorage, GEAR_WAREHOUSE2_FROM, GEAR_WAREHOUSE2_TO, warehouse, "Warehouse 2"));
        }
        //Granary
        if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 4)
        {
            addButton(2, "Granary", curry(transferMenu, gearStorage, GEAR_GRANARY_FROM, GEAR_GRANARY_TO, warehouse, "Granary", consumableAcceptable));
        }
        //Weapon Rack
        if (player.hasKeyItem("Equipment Rack - Weapons") >= 0)
        {
            outputText("There's a weapon rack set up here, able to hold up to nine various weapons.\n\n");
            addButton(3, "W.Rack", curry(transferMenu, gearStorage, GEAR_WEAPON_FROM, GEAR_WEAPON_TO, warehouse, "Weapon rack", weaponAcceptable));
        }
        //Armor Rack
        if (player.hasKeyItem("Equipment Rack - Armor") >= 0)
        {
            outputText("Your camp has an armor rack set up to hold your various sets of gear.  It appears to be able to hold nine different types of armor.\n\n");
            addButton(4, "A.Rack", curry(transferMenu, gearStorage, GEAR_ARMOR_FROM, GEAR_ARMOR_TO, warehouse, "Armor rack", armorAcceptable));
        }
        //Shield Rack
        if (player.hasKeyItem("Equipment Rack - Shields") >= 0)
        {
            outputText("There's a shield rack set up here, set up to hold up to nine various shields.\n\n");
            addButton(5, "S.Rack", curry(transferMenu, gearStorage, GEAR_SHIELD_FROM, GEAR_SHIELD_TO, warehouse, "Shield rack", shieldAcceptable));
        }
        addButton(14, "Back", playerMenu);
    }
    /**
		 * Tries to add 1 item to player. Does not produce any output.
		 * @param itype
		 * @return 0: not transfered, 1: added to existing stack, 2: added to empty stack
		 */
    public function tryAddItemToPlayer(itype : ItemType) : Int
    {
        var i : Int = player.roomInExistingStack(itype);
        if (i >= 0)
        {
            player.itemSlots[i].quantity++;
            return 1;
        }
        i = player.emptySlot();
        if (i >= 0)
        {
            player.itemSlots[i].setItemAndQty(itype, 1);
            return 2;
        }
        return 0;
    }
    /**
		 * Tries to add `qty` items to player. Does not produce any output. Halts when out of inventory space
		 * @return Number of items added
		 */
    public function tryAddMultipleItemsToPlayer(itype : ItemType, qty : Int) : Int
    {
        var n : Int = 0;
        while (qty-- > 0)
        {
            if (tryAddItemToPlayer(itype) == 0)
            {
                break;
            }
            n++;
        }
        return n;
    }
    /**
		 * Tries to transfer 1 item from [source], reducing its quantity, to player.
		 * Does not produce any output.
		 * @param source
		 * @return 0: not transfered, 1: added to existing stack, 2: added to empty stack
		 */
    public function transferOneItemToPlayer(source : ItemSlotClass) : Int
    {
        var i : Int = tryAddItemToPlayer(source.itype);
        if (i > 0)
        {
            source.removeOneItem();
        }
        return i;
    }
    public function tryAddOneItemToPearl(itype : ItemType) : Int
    {
        return tryAddOneItemToStorage(itype, pearlStorage, 0, pearlStorageSize(), "S.P.Pearl");
    }
    /**
		 * Tries to add 1 item to storage.
		 * Does not produce any output.
		 * @param source
		 * @return 0: not transfered, 1: added to existing stack, 2: added to empty stack
		 */
    public function tryAddOneItemToStorage(itype : ItemType, storage : Array<Dynamic>, startInclusive : Int, endExclusive : Int, storageName : String) : Int
    {
        var empty : Int = -1;
        var existing : Int = -1;
        for (i in startInclusive...endExclusive)
        {
            var slot : ItemSlotClass = storage[i];
            //if (!slot.unlocked) continue;
            if (empty < 0 && slot.quantity == 0)
            {
                empty = i;
            }
            if (existing < 0 && slot.itype == itype && slot.hasRoom())
            {
                existing = i;
                break;
            }
        }
        if (existing >= 0)
        {
            storage[existing].quantity++;
            return 1;
        }
        if (empty >= 0)
        {
            storage[empty].setItemAndQty(itype, 1);
            return 2;
        }
        return 0;
    }
    /**
		 * Tries to transfer 1 item from [source], reducing its quantity, to storage.
		 * Does not produce any output.
		 * @param source
		 * @return 0: not transfered, 1: added to existing stack, 2: added to empty stack
		 */
    public function transferOneItemToStorage(source : ItemSlotClass, storage : Array<Dynamic>, startInclusive : Int, endExclusive : Int, storageName : String) : Int
    {
        var i : Int = tryAddOneItemToStorage(source.itype, storage, startInclusive, endExclusive, storageName);
        if (i > 0)
        {
            source.removeOneItem();
        }
        return i;
    }
    
    public function takeItem(itype : ItemType,
            nextAction : Function,
            overrideAbandon : Function = null,
            source : ItemSlotClass = null) : Void
    {
        if (itype == null)
        {
            CoC_Settings.error("takeItem(null)");
            return;
        }
        if (nextAction != null)
        {
            if (nextAction != callNext)
            {
                callNext = nextAction;
            }
        }
        else
        {
            callNext = playerMenu;
        }
        if (itype.isNothing)
        {
            itemGoNext();
            return;
        }
        //Check for an existing stack with room in the inventory and return the value for it.
        var temp : Int = player.roomInExistingStack(itype);
        if (temp >= 0)
        
        //First slot go!{
            
            player.itemSlots[temp].quantity++;
            outputText("You place " + itype.longName + " in your " + inventorySlotName[temp] + " pouch, giving you " + player.itemSlots[temp].quantity + " of them.");
            itemGoNext();
            return;
        }
        //Check for room in Ore bag and return the itemcount for it.
        if (InCollection(itype, useables.COP_ORE, useables.TIN_ORE, useables.BRONZEB, useables.IRONORE, useables.EBONING, useables.MOONSTO) && nextAction != SceneLib.crafting.accessCraftingMaterialsBag)
        {
            temp = SceneLib.crafting.roomForMaterial(itype);
            if (temp >= 0)
            {
                SceneLib.crafting.placeMaterialInBag(itype);
                outputText("You place " + itype.longName + " in your Ore bag, giving you " + (temp + 1) + " of them.");
                itemGoNext();
                return;
            }
        }
        //Check for room in Guild quest bag and return the itemcount for it.
        if (nextAction != SceneLib.adventureGuild.questItemsBag)
        {
            if (AdventurerGuild.lootBag.addItem(itype, 1) == 1)
            {
                outputText("You place " + itype.longName + " in your quest materials pouch, giving you " + AdventurerGuild.lootBag.itemCount(itype) + " of them.");
                itemGoNext();
                return;
            }
        }
        //Check for room in Guild quest bag and return the itemcount for it.
        if (InCollection(itype, useables.GOLCORE) && nextAction != SceneLib.campMakeWinions.accessMakeWinionsMainMenu)
        {
            temp = ((flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < SceneLib.campMakeWinions.maxReusableGolemCoresBagSize()) ? flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] : -1);
            if (temp >= 0)
            {
                flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]++;
                outputText("You place " + itype.longName + " in your Golem Core bag, giving you " + (temp + 1) + " of them.");
                itemGoNext();
                return;
            }
        }
        //If not done, then put it in an empty spot!
        //Throw in slot 1 if there is room
        temp = player.emptySlot();
        if (temp >= 0)
        {
            player.itemSlots[temp].setItemAndQty(itype, 1);
            outputText("You place " + itype.longName + " in your " + inventorySlotName[temp] + " pouch.");
            itemGoNext();
            return;
        }
        if (overrideAbandon != null)
        
        //callOnAbandon only becomes important if the inventory is full{
            
            callOnAbandon = overrideAbandon;
        }
        else
        {
            callOnAbandon = callNext;
        }
        //OH NOES! No room! Call replacer functions!
        takeItemFull(itype, true, source);
    }
    
    public function returnItemToInventory(item : Useable, showNext : Bool = true) : Void
    //Used only by items that have a sub menu if the player cancels
    {
        
        if (!debug)
        {
            if (currentItemSlot == null)
            {
                takeItem(item, callNext, callNext, null);
            }
            else if (currentItemSlot.quantity > 0)
            
            //Add it back to the existing stack{
                
                currentItemSlot.quantity++;
            }
            //Put it back in the slot it came from
            else
            {
                
                currentItemSlot.setItemAndQty(item, 1);
            }
        }
        if (CoC.instance.inCombat)
        {
            enemyAI();
            return;
        }
        if (showNext)
        {
            doNext(callNext);
        }
        //Items with sub menus should return to the inventory screen if the player decides not to use them
        else
        {
            callNext();
        }
    }
    
    //Check to see if anything is stored
    public function hasItemsInStorage() : Bool
    {
        return itemAnyInStorage(itemStorage, 0, itemStorage.length);
    }
    
    public function hasItemInStorage(itype : ItemType) : Bool
    {
        return itemTypeInStorage(itemStorage, 0, itemStorage.length, itype);
    }
    
    public function consumeItemInStorage(itype : ItemType) : Bool
    {
        var index : Int = itemStorage.length;
        while (index > 0)
        {
            index--;
            if (itemStorage[index].itype == itype && itemStorage[index].quantity > 0)
            {
                itemStorage[index].quantity--;
                return true;
            }
        }
        return false;
    }
    
    public function hasItemsInBagStorage() : Bool
    {
        return itemAnyInStorage(gearStorage, 45, 57);
    }
    
    public function hasItemInBagStorage(itype : ItemType) : Bool
    {
        return itemTypeInStorage(gearStorage, 45, 57, itype);
    }
    
    public function hasItemsInPearlStorage() : Bool
    {
        return itemAnyInStorage(pearlStorage, 0, 98);
    }
    
    public function hasItemInPearlStorage(itype : ItemType) : Bool
    {
        return itemTypeInStorage(pearlStorage, 0, 98, itype);
    }
    
    public function giveHumanizer() : Void
    {
        clearOutput();
        if (flags[kFLAGS.TIMES_CHEATED_COUNTER] > 0)
        {
            outputText("<b>I was a cheater until I took an arrow to the knee...</b>");
            EventParser.gameOver();
            return;
        }
        outputText("I AM NOT A CROOK.  BUT YOU ARE!  <b>CHEATER</b>!\n\n");
        inventory.takeItem(consumables.HUMMUS_, playerMenu);
        flags[kFLAGS.TIMES_CHEATED_COUNTER]++;
    }
    
    public function getMaxSlots() : Int
    {
        var slots : Int = 6;
        if (player.hasKeyItem("Backpack") >= 0)
        {
            slots += player.keyItemvX("Backpack", 1);
        }
        if (player.hasPerk(PerkLib.StrongBack))
        {
            var bonus : Float = slots * 0.5;
            slots += as3hx.Compat.parseInt(bonus);
            if (player.hasPerk(PerkLib.StrongBack2))
            {
                slots += as3hx.Compat.parseInt(bonus);
            }
            if (player.hasPerk(PerkLib.StrongBack3))
            {
                slots += as3hx.Compat.parseInt(bonus);
            }
        }
        //Constrain slots to between 6 and 50.
        if (slots < 6)
        {
            slots = 6;
        }
        if (slots > 50)
        {
            slots = 50;
        }
        return slots;
    }
    public function getOccupiedSlots() : Int
    {
        var occupiedSlots : Int = 0;
        for (i in 0...player.itemSlots.length)
        {
            if (!player.itemSlot(i).isEmpty() && player.itemSlot(i).unlocked)
            {
                occupiedSlots++;
            }
        }
        return occupiedSlots;
    }
    
    //Create a storage slot
    public function createStorage() : Bool
    {
        if (itemStorage.length >= 16)
        {
            return false;
        }
        var newSlot : ItemSlotClass = new ItemSlotClass();
        itemStorage.push(newSlot);
        return true;
    }
    
    //Clear storage slots
    public function clearStorage() : Void
    //Various Errors preventing action
    {
        
        if (itemStorage == null)
        {
            CoC_Settings.error("Cannot clear storage because storage does not exist.");
        }
        else
        {
            trace("Attempted to remove " + itemStorage.length + " storage slots.");
            itemStorage.splice(0, itemStorage.length);
        }
    }
    
    public function clearGearStorage() : Void
    //Various Errors preventing action
    {
        
        if (gearStorage == null)
        {
            CoC_Settings.error("Cannot clear storage because storage does not exist.");
        }
        else
        {
            trace("Attempted to remove " + gearStorage.length + " storage slots.");
            gearStorage.splice(0, gearStorage.length);
        }
    }
    
    public function clearPearlStorage() : Void
    //Various Errors preventing action
    {
        
        if (pearlStorage == null)
        {
            CoC_Settings.error("Cannot clear storage because storage does not exist.");
        }
        else
        {
            trace("Attempted to remove " + pearlStorage.length + " storage slots.");
            pearlStorage.splice(0, pearlStorage.length);
        }
    }
    
    public function initializeGearStorage() : Void
    //Completely empty storage array
    {
        
        if (gearStorage == null)
        {
            CoC_Settings.error("Cannot clear gearStorage because storage does not exist.");
        }
        else
        {
            trace("Attempted to remove " + gearStorage.length + " gearStorage slots.");
            gearStorage.splice(0, gearStorage.length);
        }
        //Rebuild a new one!
        var newSlot : ItemSlotClass;
        while (gearStorage.length < 90)
        {
            newSlot = new ItemSlotClass();
            gearStorage.push(newSlot);
        }
    }
    
    public function initializePearlStorage() : Void
    //Completely empty storage array
    {
        
        if (pearlStorage == null)
        {
            CoC_Settings.error("Cannot clear pearlStorage because storage does not exist.");
        }
        else
        {
            trace("Attempted to remove " + pearlStorage.length + " pearlStorage slots.");
            pearlStorage.splice(0, pearlStorage.length);
        }
        //Rebuild a new one!
        var newSlot : ItemSlotClass;
        while (pearlStorage.length < 98)
        {
            newSlot = new ItemSlotClass();
            pearlStorage.push(newSlot);
        }
    }
    private function doWhatWithItem(slotNum : Int) : Void
    {
        clearOutput();
        if (Std.is(player.itemSlots[slotNum].itype, Useable))
        {
            var item : Useable = try cast(player.itemSlots[slotNum].itype, Useable) catch(e:Dynamic) null;
            if (flags[kFLAGS.INVT_MGMT_TYPE] == 0)
            {
                if (shiftKeyDown)
                {
                    deleteItemPrompt(item, slotNum);
                    return;
                }
                if (item.canUse())
                
                //If an item cannot be used then canUse should provide a description of why the item cannot be used{
                    
                    if (!debug)
                    {
                        player.itemSlots[slotNum].removeOneItem();
                    }
                    useItem(item, player.itemSlots[slotNum]);
                    return;
                }
                itemGoNext();
            }
            else if (item.canUse())
            {
                outputText("You grab " + player.itemSlots[slotNum].itype.longName + " and consider what you will do with it.\n\n" + "Do you use it, or destroy it?\n\n");
                menu();  //Can't get the menu to pop up...  
                addButton(0, "Use it", handleItemInInventory, 0, item, slotNum);
                addButton(1, "Discard it", deleteItemPrompt, item, slotNum);
            }
            else
            {
                menu();
                addButton(0, "Next", itemGoNext);
            }
        }
        else
        {
            outputText("You cannot use " + player.itemSlots[slotNum].itype.longName + "!\n\n");
            itemGoNext();
        }
    }
    
    
    private function handleItemInInventory(x : Int, item : Useable, slotNum : Int) : Void
    {
        if (!debug)
        {
            player.itemSlots[slotNum].removeOneItem();
        }
        useItem(item, player.itemSlots[slotNum]);
    }
    
    
    private function inventoryCombatHandler() : Void
    //Check if the battle is over. If not then go to the enemy's action.
    {
        
        if (combat.combatIsOver())
        {
            return;
        }
        outputText("\n\n");
        enemyAI();
    }
    private function deleteItemPrompt(item : Useable, slotNum : Int) : Void
    {
        clearOutput();
        outputText("Are you sure you want to destroy " + player.itemSlots[slotNum].quantity + "x " + item.shortName + "?  You won't be able to retrieve " + ((player.itemSlots[slotNum].quantity == 1) ? "it" : "them") + "!");
        menu();
        addButton(0, "Yes", deleteItem, item, slotNum);
        addButton(1, "No", inventoryMenu);
    }
    
    private function deleteItem(item : Useable, slotNum : Int) : Void
    {
        clearOutput();
        outputText(player.itemSlots[slotNum].quantity + "x " + item.shortName + " " + ((player.itemSlots[slotNum].quantity == 1) ? "has" : "have") + " been destroyed.");
        player.destroyItems(item, player.itemSlots[slotNum].quantity);
        doNext(inventoryMenu);
    }
    
    private function useItem(item : Useable, fromSlot : ItemSlotClass) : Void
    {
        var originalItem : Useable = item;
        item.useText();
        if (Std.is(item, Equipable))
        {
            var e : Equipable = try cast(item, Equipable) catch(e:Dynamic) null;
            var slot : Int = player.slotForItem(e);
            if (slot < 0)
            {
                slot = e.slots()[0];
            }  // not found suitable slot, try to fit into first - will fail but display a message why  
            var returnItem : ItemType = player.internalEquipItem(slot, e);
            if (returnItem == null)
            {
                takeItem(originalItem, callNext);
            }
            // failed to equip, return original item
            else if (returnItem.isNothing)
            {
                itemGoNext();
            }
            else
            {
                takeItem(returnItem, callNext);
            }
        }
        else
        {
            currentItemSlot = fromSlot;
            if (!item.useItem())
            {
                itemGoNext();
            }
        }
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        statScreenRefresh();
    }
    
    private function takeItemFull(itype : ItemType, showUseNow : Bool, source : ItemSlotClass, page : Int = 1) : Void
    {
        var x : Int;
        mainView.linkHandler = showItemTooltipLinkHandler;
        outputText("There is no room for " + mkLink(itype.longName, itype.id) + " in your inventory.  You may replace the contents of a pouch with " + itype.longName + " or abandon it.");
        menu();
        if (showUseNow && Std.is(itype, Useable))
        {
            addButton(11, "Use Now", createCallBackFunction2(useItemNow, try cast(itype, Useable) catch(e:Dynamic) null, source));
        }  /*
			for (var x:int = 0; x < 10; x++) {
				if (player.itemSlots[x].unlocked)
					addButton(x, (player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity), createCallBackFunction2(replaceItem, itype, x));
			}*/  
        if (source != null)
        {
            currentItemSlot = source;
            addButton(11, "Put Back", createCallBackFunction2(returnItemToInventory, itype, false));
        }
        if (page == 1)
        {
            for (x in 0...10)
            {
                if (player.itemSlots[x].unlocked)
                {
                    button(x).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
                }
            }
            if (getMaxSlots() > 10)
            {
                addButton(13, "Next", curry(takeItemFull, itype, showUseNow, source, page + 1));
            }
        }
        if (page == 2)
        {
            for (x in 10...20)
            {
                if (player.itemSlots[x].unlocked)
                {
                    button(x - 10).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
                }
            }
            addButton(12, "Prev", curry(takeItemFull, itype, showUseNow, source, page - 1));
            if (getMaxSlots() > 20)
            {
                addButton(13, "Next", curry(takeItemFull, itype, showUseNow, source, page + 1));
            }
        }
        if (page == 3)
        {
            for (x in 20...30)
            {
                if (player.itemSlots[x].unlocked)
                {
                    button(x - 20).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
                }
            }
            addButton(12, "Prev", curry(takeItemFull, itype, showUseNow, source, page - 1));
            if (getMaxSlots() > 30)
            {
                addButton(13, "Next", curry(takeItemFull, itype, showUseNow, source, page + 1));
            }
        }
        if (page == 4)
        {
            for (x in 30...40)
            {
                if (player.itemSlots[x].unlocked)
                {
                    button(x - 30).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
                }
            }
            addButton(12, "Prev", curry(takeItemFull, itype, showUseNow, source, page - 1));
            if (getMaxSlots() > 40)
            {
                addButton(13, "Next", curry(takeItemFull, itype, showUseNow, source, page + 1));
            }
        }
        if (page == 5)
        {
            for (x in 40...50)
            {
                if (player.itemSlots[x].unlocked)
                {
                    button(x - 40).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
                }
            }
            addButton(12, "Prev", curry(takeItemFull, itype, showUseNow, source, page - 1));
        }
        addButton(14, "Abandon", callOnAbandon);
    }
    
    public function UseItemNow(item : Useable, nextAction : Function, source : ItemSlotClass = null) : Void
    {
        clearOutput();
        
        if (nextAction != null)
        {
            if (nextAction != callNext)
            {
                callNext = nextAction;
            }
        }
        else
        {
            callNext = playerMenu;
        }
        if (item.canUse())
        
        //If an item cannot be used then canUse should provide a description of why the item cannot be used{
            
            useItem(item, source);
        }
        else
        {
            takeItemFull(item, false, source);
        }
    }
    
    private function useItemNow(item : Useable, source : ItemSlotClass) : Void
    {
        clearOutput();
        if (item.canUse())
        
        //If an item cannot be used then canUse should provide a description of why the item cannot be used{
            
            useItem(item, source);
        }
        else
        {
            takeItemFull(item, false, source);
        }
    }
    
    private function replaceItem(itype : ItemType, slotNum : Int) : Void
    {
        clearOutput();
        if (player.itemSlots[slotNum].itype == itype)
        
        //If it is the same as what's in the slot...just throw away the new item{
            
            outputText("You discard " + itype.longName + " from the stack to make room for the new one.");
        }
        //If they are different...
        else
        {
            
            if (player.itemSlots[slotNum].quantity == 1)
            {
                outputText("You throw away " + player.itemSlots[slotNum].itype.longName + " and replace it with " + itype.longName + ".");
            }
            else
            {
                outputText("You throw away " + player.itemSlots[slotNum].itype.longName + "(x" + player.itemSlots[slotNum].quantity + ") and replace it with " + itype.longName + ".");
            }
            player.itemSlots[slotNum].setItemAndQty(itype, 1);
        }
        itemGoNext();
    }
    
    private function itemAnyInStorage(storage : Array<Dynamic>, startSlot : Int, endSlot : Int) : Bool
    {
        for (x in startSlot...endSlot)
        {
            if (storage[x] != null)
            {
                if (storage[x].quantity > 0)
                {
                    return true;
                }
            }
        }
        return false;
    }
    
    private function itemTypeInStorage(storage : Array<Dynamic>, startSlot : Int, endSlot : Int, itype : ItemType) : Bool
    {
        for (x in startSlot...endSlot)
        {
            if (storage[x] != null)
            {
                if (storage[x].quantity > 0 && storage[x].itype == itype)
                {
                    return true;
                }
            }
        }
        return false;
    }
    
    public function removeItemFromStorage(storage : Array<Dynamic>, itype : ItemType) : Void
    {
        for (x in 0...storage.length)
        {
            if (storage[x] != null)
            {
                if (storage[x].quantity > 0 && storage[x].itype == itype)
                {
                    storage[x].quantity--;
                    return;
                }
            }
        }
    }
    
    public function manageEquipment(page : Int = 1) : Void
    {
        clearOutput();
        outputText("Which would you like to unequip?\n\n");
        menu();
        if (page == 1)
        {
            addButton(0, "Weapon (MH)", unequipWeapon).itemHints(player.weapon).disableIf(!player.weapon.canUnequip(false)).disableIf(player.weapon.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have melee main hand weapon equipped.");
            addButton(1, "Weapon (MO)", unequipWeaponOff).itemHints(player.weaponOff).disableIf(!player.weaponOff.canUnequip(false)).disableIf(player.weaponOff.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have melee off hand weapon equipped.");
            addButton(2, "Weapon (R)", unequipWeaponRange).itemHints(player.weaponRange).disableIf(!player.weaponRange.canUnequip(false)).disableIf(player.weaponRange.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have range weapon equipped.");
            addButton(3, "Flying Sword", unequipFlyingSwords).itemHints(player.weaponFlyingSwords).disableIf(!player.weaponFlyingSwords.canUnequip(false)).disableIf(player.weaponFlyingSwords == FlyingSwordsLib.NOTHING, "You don't have shield equipped.").disableIf(!player.hasPerk(PerkLib.FlyingSwordPath), "You don't have flying sword equipped. (Req. perk: Flying Swords Control)");
            addButton(5, "Armour", unequipArmor).itemHints(player.armor).disableIf(!player.armor.canUnequip(false)).disableIf(player.hasPerk(PerkLib.Rigidity), "Your body stiffness prevents you from unequipping this armor.").disableIf(player.armor.isNothing, "You don't have armor equipped.");
            //6? - lower body armor slot
            addButton(6, "Shield", unequipShield).itemHints(player.shield).disableIf(!player.shield.canUnequip(false)).disableIf(player.shield.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have shield equipped.");
            addButton(10, "Upperwear", unequipUpperwear).itemHints(player.upperGarment).disableIf(!player.upperGarment.canUnequip(false)).disableIf(player.upperGarment.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have upperwear equipped.");
            addButton(11, "Lowerwear", unequipLowerwear).itemHints(player.lowerGarment).disableIf(!player.lowerGarment.canUnequip(false)).disableIf(player.lowerGarment.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have lowerwear equipped.");
            addButton(12, "Vehicle", unequipVehicle).itemHints(player.vehicles).disableIf(!player.vehicles.canUnequip(false)).disableIf(player.vehicles == VehiclesLib.NOTHING || player.hasPerk(PerkLib.Rigidity), "You not using currently any vehicle.");
            addButton(13, "-2-", manageEquipment, page + 1);
        }
        if (page == 2)
        {
            addButton(0, "Head Acc", unequipHeadJewel).itemHints(player.headJewelry).disableIf(!player.headJewelry.canUnequip(false)).disableIf(player.hasPerk(PerkLib.Rigidity), "Your body stiffness prevents you from unequipping this head accessory.").disableIf(player.headJewelry.isNothing, "You don't have equipped any head accessory.");
            addButton(1, "Necklace", unequipNecklace).itemHints(player.necklace).disableIf(!player.necklace.canUnequip(false)).disableIf(player.necklace.isNothing, "You don't have equipped any necklace.");
            addButton(3, "Acc 1", unequipMiscJewel1).itemHints(player.miscJewelry1).disableIf(!player.miscJewelry1.canUnequip(false)).disableIf(player.miscJewelry1.isNothing, "You don't have equipped any accessory.");
            addButton(8, "Acc 2", unequipMiscJewel2).itemHints(player.miscJewelry2).disableIf(!player.miscJewelry2.canUnequip(false)).disableIf(player.miscJewelry2.isNothing, "You don't have equipped any accessory.");
            addButton(5, "Ring 1", unequipJewel1).itemHints(player.jewelry1).disableIf(!player.jewelry1.canUnequip(false)).disableIf(player.jewelry1.isNothing, "You don't have equipped any ring.");
            addButton(6, "Ring 3", unequipJewel3).itemHints(player.jewelry3).disableIf(!player.jewelry3.canUnequip(false)).disableIf(player.jewelry3.isNothing, "You don't have equipped any ring.").disableIf(!player.hasPerk(PerkLib.ThirdRing), "You don't have equipped any ring. (Req. lvl 60+ perk: Third Ring)");
            addButton(10, "Ring 2", unequipJewel2).itemHints(player.jewelry2).disableIf(!player.jewelry2.canUnequip(false)).disableIf(player.jewelry2.isNothing, "You don't have equipped any ring.").disableIf(!player.hasPerk(PerkLib.SecondRing), "You don't have equipped any ring. (Req. lvl 30+ perk: Second Ring)");
            addButton(11, "Ring 4", unequipJewel4).itemHints(player.jewelry4).disableIf(!player.jewelry4.canUnequip(false)).disableIf(player.jewelry4.isNothing, "You don't have equipped any ring.").disableIf(!player.hasPerk(PerkLib.FourthRing), "You don't have equipped any ring. (Req. lvl 90+ perk: Fourth Ring)");
            addButton(13, "-1-", manageEquipment, page - 1);
        }
        /*if (player.jewelry != JewelryLib.NOTHING) {
				addButton(3, "Accessory", unequipJewel).hint(player.jewelry.description, capitalizeFirstLetter(player.jewelry.name));
			}
			zrobić sloty:
			na pas/belt?
			2 bransolety/bracelets(on arm wrists)?
			przy dodawaniu tych slotow popatrzec czy ktorys nie bedzie musial uzywac tego fragmentu kodu:
			else if (item is Shield) {
				player.shield.removeText();
				item = player.setShield(item as Shield); //Item is now the player's old shield
			*/
        addButton(14, "Back", inventoryMenu);
    }
    //Unequip!
    /**
		 * Unequip item from slot, placing it into inventory.
		 * @param nextFn Next scene
		 * @param slot
		 * @param doOutput Print 'you unequip' text
		 * @param force Ignore canUnequip check
		 */
    public function unequipSlotToInventory(nextFn : Function, slot : Int, doOutput : Bool = true, force : Bool = false) : Void
    {
        var oldItem : ItemType = player.internalUnequipItem(slot, doOutput, force);
        if (oldItem != null && !oldItem.isNothing)
        {
            takeItem(oldItem, nextFn);
        }
        else if (oldItem == null)
        
        // failed to unequip, text was displayed, add [Next] before proceeding{
            
            doNext(nextFn);
        }
        else
        {
            nextFn();
        }
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        statScreenRefresh();
    }
    public function unequipWeapon() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_WEAPON_MELEE);
    }
    public function unequipWeaponOff() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_WEAPON_MELEE_OFF);
    }
    public function unequipWeaponRange() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_WEAPON_RANGED);
    }
    private function unequipFlyingSwords() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_FLYING_SWORD);
    }
    public function unequipShield() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_SHIELD);
    }
    public function unequipArmor() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_ARMOR);
    }
    public function unequipUpperwear() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_UNDER_TOP);
    }
    public function unequipLowerwear() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_UNDER_BOTTOM);
    }
    public function unequipHeadJewel() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_HEAD);
    }
    public function unequipNecklace() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_NECK);
    }
    public function unequipMiscJewel1() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_JEWELRY_MISC_1);
    }
    public function unequipMiscJewel2() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_JEWELRY_MISC_2);
    }
    public function unequipJewel1() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_RING_1);
    }
    public function unequipJewel2() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_RING_2);
    }
    public function unequipJewel3() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_RING_3);
    }
    public function unequipJewel4() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_RING_4);
    }
    public function unequipVehicle() : Void
    {
        unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_VEHICLE);
    }
    
    //Acceptable types of items
    public function allAcceptable(itype : ItemType) : Bool
    {
        return true;
    }
    public function consumableAcceptable(itype : ItemType) : Bool
    {
        return Std.is(itype, Consumable);
    }
    public function armorAcceptable(itype : ItemType) : Bool
    {
        return Std.is(itype, Armor);
    }
    public function weaponAcceptable(itype : ItemType) : Bool
    {
        return (Std.is(itype, Weapon)) || (Std.is(itype, WeaponRange));
    }
    public function shieldAcceptable(itype : ItemType) : Bool
    {
        return Std.is(itype, Shield);
    }
    public function jewelryAcceptable(itype : ItemType) : Bool
    {
        return Std.is(itype, Jewelry);
    }
    public function undergarmentAcceptable(itype : ItemType) : Bool
    {
        return Std.is(itype, Undergarment);
    }
}


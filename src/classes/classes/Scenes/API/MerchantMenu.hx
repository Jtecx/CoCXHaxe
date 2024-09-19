package classes.scenes.aPI;

import haxe.Constraints.Function;
import classes.BaseContent;
import classes.CoCSettings;
import classes.ItemSlotClass;
import classes.ItemType;
import classes.PerkLib;
import classes.internals.Utils;
import coc.view.Block;
import coc.view.CoCButton;
import coc.view.MainView;

class MerchantMenu extends BaseContent
{
    public var items : Array<Dynamic> = [];
    /**
	 * Player can sell items to this merchant
	 */
    public var playerCanSell : Bool = false;
    /**
	 * Buy items from player for (item value) * (sell factor) gems
	 */
    public var playerSellFactor : Float = 0.5;
    /**
	 * Function `function(itype:ItemType):Boolean` to check if player can sell item.
	 *
	 * null - player can sell any item (if playerCanSell is true).
	 */
    public var playerSellFilter : Function = null;
    /**
	 * Default price = item value * price factor
	 */
    public var priceFactor : Float = 1.0;
    /**
	 * `function(itype:ItemType, quantity:int, next:Function):void`
	 *
	 * Called after player purchases an item.
	 *
	 * To return to merchant interface, this function should call `next();`
	 */
    public var afterPurchase : Function = null;
    /**
	 * `function(itype:ItemType, quantity:int, slot:ItemSlotClass, next:Function):void`.
	 *
	 * Called after player sells an item.
	 *
	 * To return to merchant interface, this function should call `next();`
	 */
    public var afterPlayerSell : Function = null;
    /**
	 * `function(delta:int):void`
	 */
    public var modCurrencyFn : Function;
    /**
	 * Floating popup text, `function(delta:int):String`
	 */
    public var displayCurrencyFn : Function;
    /**
	 * `function():int`
	 */
    public var getCurrencyFn : Function;
    /**
	 * `function():void`
	 *
	 * Called after merchant interface is displayed. Can be used to add extra buttons.
	 */
    public var onShow : Function = null;
    /**
	 * Show [Inventory] button.
	 */
    public var canInventory : Bool = true;
    /**
	 * Can buy to/sell from S.P.Pearl
	 */
    public var canPearl : Bool = true;
    public var prompt : String = "";
    
    private var grid : Block;
    private var backButton : Function = camp.returnToCampUseOneHour;
    private var playerInvButtons : Array<Dynamic> = [];
    private var playerPage : Int = 0;
    private var playerItemsPerPage : Int = 25;
    private var playerPageCount : Int = 0;
    private var playerPagePrev : CoCButton;
    private var playerPageNext : CoCButton;
    private var merchantInvButtons : Array<Dynamic> = [];
    private var merchantPage : Int = 0;
    private var merchantItemsPerPage : Int = 25;
    private var merchantPageCount : Int = 0;
    private var merchantPagePrev : CoCButton;
    private var merchantPageNext : CoCButton;
    private var toggleStorageButton : CoCButton;
    private var storageModes : Array<Dynamic>;
    private var storageMode : Int = STORAGE_MODE_INVENTORY;
    private var playerStorage : Array<Dynamic>;
    
    private static inline var STORAGE_MODE_INVENTORY : Int = 0;
    private static inline var STORAGE_MODE_PEARL : Int = 1;
    
    public function new()
    {
        super();
        useGemCurrency();
    }
    
    public function useGemCurrency() : Void
    {
        modCurrencyFn = function(delta : Int) : Void
                {
                    player.gems += delta;
                    statScreenRefresh();
                };
        displayCurrencyFn = function(delta : Int) : String
                {
                    return ((delta > 0) ? "+" : "") + formatNumber(delta) + " g";
                };
        getCurrencyFn = function() : Int
                {
                    return player.gems;
                };
    }
    
    /**
	 * Add item to merchant inventory
	 * @param item Item to sell
	 * @param price Price, -1 is to use default value = value * priceFactor
	 * @param amount Amount in stock, -1 for infinite
	 * @return MerchantItem instance to configure
	 */
    public function addItem(
            item : ItemType,
            price : Int = -1,
            amount : Int = -1) : MerchantItem
    {
        if (price == -1)
        {
            price = Math.ceil(item.value * priceFactor);
        }
        var mi : MerchantItem = new MerchantItem(this, item, price, amount);
        this.items.push(mi);
        return mi;
    }
    /**
	 * Add an empty (invisible) slot
	 */
    public function addSpacer() : Void
    {
        addItem(ItemType.NOTHING);
    }
    /**
	 * Add empty slots to ensure that next item will start on new line
	 */
    public function addLineBreak() : Void
    {
        while (items.length % 5 > 0)
        {
            addSpacer();
        }
    }
    
    public function merchantItemClick(mi : MerchantItem) : Void
    {
        var amount : Int = 1;
        if (shiftKeyDown)
        
        // Purchase max = min of: stack size, inv room, affordable, store stock{
            
            amount = Math.min(Math.min(
                                    mi._item.stackSize, 
                                    Math.max(1, player.roomForItem(mi._item))
                    ), 
                            Math.floor(getCurrencyFn() / mi._price)
                );
            if (mi._amount >= 0)
            {
                amount = Math.min(amount, mi._amount);
            }
        }
        var value : Int = as3hx.Compat.parseInt(-mi._price * amount);
        modCurrencyFn(value);
        showCurrencyFloatingText(value);
        if (mi._amount >= 0)
        {
            mi._amount -= amount;
        }
        var n : Int = amount;
        var redraw : Bool = false;
        
        var addOneItem : Void->Void = function() : Void
        {
            while (n-- > 0)
            {
                var added : Bool = false;
                if (storageMode == STORAGE_MODE_PEARL)
                {
                    added = inventory.tryAddOneItemToPearl(mi._item) > 0;
                }
                else if (storageMode == STORAGE_MODE_INVENTORY)
                {
                    added = inventory.tryAddItemToPlayer(mi._item) > 0;
                }
                if (!added)
                {
                    redraw = true;
                    clearOutput();
                    inventory.takeItem(mi._item, addOneItem);
                    return;
                }
            }
            if (afterPurchase != null)
            {
                redraw = true;
                afterPurchase(mi._item, amount, showScreen);
            }
            else if (redraw)
            {
                showScreen();
            }
            else
            {
                update();
            }
        }
        
        addOneItem();
    }
    private function showCurrencyFloatingText(value : Int) : Void
    {
        mainViewManager.createFloatingTextAtCursor(displayCurrencyFn(value), "#fc0", "#222");
    }
    public function playerItemClick(i : Int) : Void
    {
        sellPlayerItem(i, (shiftKeyDown) ? -1 : 1, true);
    }
    public function sellPlayerItem(slotIndex : Int, quantity : Int, popup : Bool) : Int
    {
        var itemSlot : ItemSlotClass = playerStorage[slotIndex];
        var itype : ItemType = itemSlot.itype;
        if (itemSlot.isEmpty() || !canSell(itype))
        {
            return 0;
        }
        if (quantity < 0)
        {
            quantity = itemSlot.quantity;
        }
        if (quantity > itemSlot.quantity)
        {
            quantity = itemSlot.quantity;
        }
        if (quantity == 0)
        {
            return 0;
        }
        var value : Float = sellPrice(itype) * quantity;
        modCurrencyFn(+value);
        if (popup)
        {
            showCurrencyFloatingText(value);
        }
        itemSlot.quantity -= quantity;
        update();
        if (afterPlayerSell != null)
        {
            afterPlayerSell(itype, quantity, itemSlot, showScreen);
        }
        return value;
    }
    public function sellAllClick() : Void
    {
        var total : Int = 0;
        for (i in 0...playerStorage.length)
        {
            total += sellPlayerItem(i, -1, false);
            if (mainView.getCustomElement() != grid)
            {
                if (total != 0)
                {
                    showCurrencyFloatingText(total);
                }
                // If afterPlayerSell callback displayed own interface, halt
                return;
            }
        }
        if (total != 0)
        {
            showCurrencyFloatingText(total);
        }
    }
    public function canSell(itype : ItemType) : Bool
    {
        return playerCanSell && !itype.isNothing && (playerSellFilter == null || playerSellFilter(itype));
    }
    public function sellPrice(itype : ItemType) : Int
    {
        return Math.floor(itype.value * playerSellFactor);
    }
    
    public function update() : Void
    {
        var i : Int;
        var j : Int;
        var n : Int;
        j = as3hx.Compat.parseInt(playerPage * playerItemsPerPage);
        n = playerStorage.length;
        i = 0;
        while (i < playerInvButtons.length)
        {
            if (j < n)
            {
                var itemSlot : ItemSlotClass = playerStorage[j];
                playerInvButtons[i].showForItemSlot(itemSlot, curry(playerItemClick, j)).disableIf(!playerCanSell);
                if (canSell(itemSlot.itype))
                {
                    playerInvButtons[i].toolTipText += "\nSell price: " + sellPrice(itemSlot.itype);
                }
            }
            else
            {
                playerInvButtons[i].hide();
            }
            i++;
            j++;
        }
        j = as3hx.Compat.parseInt(merchantPage * merchantItemsPerPage);
        i = 0;
        while (i < merchantInvButtons.length)
        {
            if (items[j] != null)
            {
                items[j].applyToButton(merchantInvButtons[i]);
            }
            else
            {
                merchantInvButtons[i].hide();
            }
            i++;
            j++;
        }
        if (playerPagePrev != null)
        {
            playerPagePrev.enabled = playerPage > 0;
            playerPageNext.enabled = playerPage < playerPageCount - 1;
        }
        if (merchantPagePrev != null)
        {
            merchantPagePrev.enabled = merchantPage > 0;
            merchantPageNext.enabled = merchantPage < merchantPageCount - 1;
        }
        statScreenRefresh();
    }
    private function modPlayerPage(d : Int) : Void
    {
        playerPage += d;
        update();
    }
    private function modMerchantPage(d : Int) : Void
    {
        merchantPage += d;
        update();
    }
    private function toggleStorage() : Void
    {
        storageMode = storageModes[(storageMode + 1) % storageModes.length];
        showScreen();
    }
    public function show(backButton : Function) : Void
    {
        this.backButton = backButton;
        storageModes = [STORAGE_MODE_INVENTORY];
        if (canPearl)
        {
            storageModes.push(STORAGE_MODE_PEARL);
        }
        flushOutputTextToGUI();
        show0();
    }
    private function showScreen() : Void
    {
        clearOutput();
        show0();
    }
    private function show0() : Void
    {
        if (storageMode == STORAGE_MODE_INVENTORY)
        {
            playerStorage = player.itemSlots.slice(0, player.itemSlotCount());
        }
        else if (storageMode == STORAGE_MODE_PEARL)
        {
            playerStorage = inventory.pearlStorageSlice();
        }
        grid = new Block({
                    layoutConfig : {
                        type : "grid",
                        cols : 5
                    }
                });
        var i : Int;
        var n : Int;
        var btn : CoCButton;
        // 5 rows: player inventory
        // 1 row : player inventory pages
        // 1 row : spacer
        // 5 rows: merchant
        // 1 row : merchant pages
        n = 0;
        var playerItemCount : Int = playerStorage.length;
        var playerItemRows : Int = Math.min(5, Math.ceil(playerItemCount / 5));
        playerPage = 0;
        playerPageCount = Math.ceil(playerItemCount / playerItemRows / 5);
        playerItemsPerPage = as3hx.Compat.parseInt(playerItemRows * 5);
        playerInvButtons = [];
        if (playerItemCount > 0)
        {
            grid.addTextField({
                        htmlText : "Your " +
                        ["inventory", "pearl storage"][storageMode] +
                        ": " +
                        ((playerCanSell) ? " <i>(Click to sell, Shift+click to sell all)</i>" : ""),
                        defaultTextFormat : mainView.mainText.defaultTextFormat
                    }, {
                        colspan : 5
                    });
        }
        for (i in 0...playerItemRows * 5)
        {
            btn = new CoCButton();
            grid.addElement(btn);
            playerInvButtons.push(btn);
        }
        if (playerPageCount > 1 || canPearl)
        {
            playerPagePrev = new CoCButton().show("Prev", curry(modPlayerPage, -1)).icon("Left");
            playerPageNext = new CoCButton().show("Next", curry(modPlayerPage, +1)).icon("Right");
            grid.addElement(playerPagePrev);
            grid.addElement(new Block({ }));
            if (canPearl && inventory.pearlStorageSize() > 0)
            {
                var label : String = "Inv/Pearl";
                if (storageMode == STORAGE_MODE_INVENTORY)
                {
                    label = "(Inv)/Pearl";
                }
                else if (storageMode == STORAGE_MODE_PEARL)
                {
                    label = "Inv/(Pearl)";
                }
                toggleStorageButton = new CoCButton().show(label, toggleStorage).hint("Switch between trading to/from Inventory and Sky Poison Pearl");
                grid.addElement(toggleStorageButton);
            }
            else
            {
                grid.addElement(new Block({ }));
            }
            grid.addElement(new Block({ }));
            grid.addElement(playerPageNext);
        }
        var merchantItemCount : Int = items.length;
        var merchantItemRows : Int = Math.min(5, Math.ceil(merchantItemCount / 5));
        merchantPage = 0;
        merchantPageCount = Math.ceil(merchantItemCount / merchantItemRows / 5);
        merchantItemsPerPage = as3hx.Compat.parseInt(merchantItemRows * 5);
        merchantInvButtons = [];
        if (merchantItemCount > 1)
        {
            grid.addTextField({
                        htmlText : "Merchant inventory: <i>(Click to buy, Shift+click to buy max)</i>",
                        defaultTextFormat : mainView.mainText.defaultTextFormat
                    }, {
                        colspan : 5
                    });
        }
        for (i in 0...merchantItemRows * 5)
        {
            btn = new CoCButton();
            grid.addElement(btn);
            merchantInvButtons.push(btn);
        }
        if (merchantPageCount > 1)
        {
            merchantPagePrev = new CoCButton().show("Prev", curry(modMerchantPage, -1)).icon("Left");
            merchantPageNext = new CoCButton().show("Next", curry(modMerchantPage, +1)).icon("Right");
            grid.addElement(merchantPagePrev);
            grid.addElement(new Block({
                        width : MainView.BTN_W,
                        height : MainView.BTN_H
                    }), {
                        colspan : 3
                    });
            grid.addElement(merchantPageNext);
        }
        update();
        
        outputText(prompt);
        mainView.setCustomElement(grid, true, true);
        grid.doLayout();
        menu();
        if (playerCanSell)
        {
            button(0).show("Sell All", sellAllClick);
        }
        if (canInventory)
        {
            button(2).show("Inventory", curry(inventory.showInventoryMenu, showScreen));
        }
        if (CoC_Settings.mobileBuild)
        {
            button(4).show("Buy/Sell: 1", function() : Void
                    {
                        shiftKeyDown = !shiftKeyDown;
                        button(4).text((shiftKeyDown) ? "Buy/Sell: Max" : "Buy/Sell: 1");
                    });
        }
        button(14).show("Back", backButton).icon("Back");
        if (onShow != null)
        {
            onShow();
        }
    }
    
    public function greedCheck() : Bool
    {
        return player.hasPerk(PerkLib.Greedy) || player.hasPerk(PerkLib.TravelingMerchantOutfit);
    }
}




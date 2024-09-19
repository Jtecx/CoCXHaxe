package classes.scenes.quests;

import classes.ItemType;
import classes.scenes.aPI.AbstractQuest;
import classes.scenes.places.heXinDao.AdventurerGuild;
import classes.scenes.QuestLib;
import classes.StatusEffectType;

/**
 * Adventure guild delivery quest
 */
class SimpleGuildQuest extends AbstractQuest
{
    private var statusValue(get, never) : Float;
    public var guildLevel(get, never) : Int;
    public var item(get, never) : ItemType;
    public var quantity(get, never) : Int;
    public var tier(get, never) : Int;

    // Status effect codes
    private static inline var SE_T1_NOT_STARTED : Int = 0;
    private static inline var SE_T1_STARTED : Int = 1;
    private static inline var SE_T1_COMPLETED : Int = 2;
    private static inline var SE_T2_STARTED : Int = 3;
    private static inline var SE_T2_COMPLETED : Int = 4;
    private static inline var SE_T3_STARTED : Int = 6;
    private static inline var SE_T3_COMPLETED : Int = 7;
    
    private var _guildLevel : Int;
    private var _item : ItemType;
    private var _numbers : Array<Dynamic>;
    private var _setype : StatusEffectType;
    private var _valueIndex : Int;
    
    public function new(
            id : String,
            title : String,
            /** 1: copper, 2: iron, ... */
            guildLevel : Int,
            item : ItemType,
            /** [ t1number, t2number, t3number ] */
            numberByTier : Array<Dynamic>,
            statusEffectType : StatusEffectType,
            valueIndex : Int)
    {
        super(id, QuestLib.QGRP_AGUILD, title);
        this._guildLevel = guildLevel;
        this._item = item;
        this._numbers = numberByTier;
        this._setype = statusEffectType;
        this._valueIndex = valueIndex;
    }
    
    private function get_statusValue() : Float
    {
        return player.getStatusValue(_setype, _valueIndex);
    }
    
    override private function get_description() : String
    {
        var s : String = "Bring " + item.longName + " x " + quantity + ". ";
        if (status == STATUS_COMPLETED)
        {
            s += "You can repeat this quest tomorrow. ";
        }
        return s;
    }
    
    override private function get_hintToUnlock() : String
    {
        var playerGuildLevel : Int = AdventurerGuild.playerGuildLevel;
        if (playerGuildLevel == 0)
        {
            return "Join the Adventurers Guild";
        }
        if (playerGuildLevel < guildLevel)
        {
            return "Reach  Adventurers Guild " + AdventurerGuild.GuildRanks[guildLevel].name + "rank";
        }
        return "Visit Yang";
    }
    override public function objectives() : Array<Dynamic>
    {
        var status : Int = this.status;
        //		if (status == STATUS_NOT_STARTED)
        //			return [[STATUS_IN_PROGRESS, "Visit Yang"]];
        if (status != STATUS_IN_PROGRESS)
        {
            return [];
        }
        var pcount : Int = player.itemCount(item, true);
        var need : Int = quantity;
        var obj1 : String = item.shortName + " " + pcount + "/" + need;
        var obj2 : String = "Return to Yang";
        if (pcount < need)
        {
            return [
            [STATUS_IN_PROGRESS, obj1], 
            [STATUS_NOT_STARTED, obj2]
        ];
        }
        else
        {
            return [
            [STATUS_COMPLETED, obj1], 
            [STATUS_IN_PROGRESS, obj2]
        ];
        }
    }
    
    private function get_guildLevel() : Int
    {
        return _guildLevel;
    }
    private function get_item() : ItemType
    {
        return _item;
    }
    private function get_quantity() : Int
    {
        return tierQuantity(tier);
    }
    private function get_tier() : Int
    {
        var value : Float = statusValue;
        if (value == SE_T1_NOT_STARTED || value == SE_T1_STARTED || value == SE_T1_COMPLETED)
        {
            return 1;
        }
        if (value == SE_T2_STARTED || value == SE_T2_COMPLETED)
        {
            return 2;
        }
        if (value == SE_T3_STARTED || value == SE_T3_COMPLETED)
        {
            return 3;
        }
        return 0;
    }
    public function tierQuantity(tier : Int) : Int
    {
        if (tier <= 0 || tier > 3)
        {
            return -1;
        }
        return _numbers[tier - 1];
    }
    override private function get_status() : Int
    {
        if (AdventurerGuild.playerGuildLevel < guildLevel)
        {
            return STATUS_UNKNOWN;
        }
        if (!player.hasStatusEffect(_setype))
        {
            return STATUS_UNKNOWN;
        }
        var value : Float = statusValue;
        if (value == SE_T1_NOT_STARTED)
        {
            return STATUS_NOT_STARTED;
        }
        if (value == SE_T1_STARTED || value == SE_T2_STARTED || value == SE_T3_STARTED)
        {
            return STATUS_IN_PROGRESS;
        }
        // Because you can start next quest tier right away, completed II = not started III
        if (value == SE_T1_COMPLETED || value == SE_T2_COMPLETED && _numbers.length > 2)
        {
            return STATUS_NOT_STARTED;
        }
        if (value == SE_T3_COMPLETED || value == SE_T2_COMPLETED && _numbers.length == 2)
        {
            return STATUS_COMPLETED;
        }
        return STATUS_INVALID;
    }
}


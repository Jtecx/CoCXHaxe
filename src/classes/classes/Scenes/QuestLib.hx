package classes.scenes;

import classes.BaseContent;
import classes.scenes.aPI.AbstractQuest;
import classes.scenes.places.heXinDao.AdventurerGuild;
import classes.scenes.quests.FactoryQuest;
import classes.scenes.quests.SimpleGuildQuest;
import classes.scenes.quests.ZetazQuest;
import classes.StatusEffects;

class QuestLib extends BaseContent
{
    
    // Quest groups
    public static inline var QGRP_MAIN : String = "Main";
    public static inline var QGRP_SIDE : String = "Side";
    public static inline var QGRP_AGUILD : String = "Adv. Guild";
    public static inline var QGRP_OTHER : String = "Other";
    
    // Main quets
    public var MQ_Factory(default, never) : FactoryQuest = new FactoryQuest();
    public var MQ_Zetaz(default, never) : ZetazQuest = new ZetazQuest();
    
    // Adv. Guild quests
    
    public var AGQ_Imps(default, never) : SimpleGuildQuest = 
        new SimpleGuildQuest(
        "AGQ_Imps", 
        "Imps Hunt", 
        AdventurerGuild.RANK_COPPER, 
        useables.IMPSKLL, [3, 4, 5], 
        StatusEffects.AdventureGuildQuests1, 1);
    public var AGQ_Demons(default, never) : SimpleGuildQuest = 
        new SimpleGuildQuest(
        "AGQ_Demons", 
        "Demons Hunt", 
        AdventurerGuild.RANK_IRON, 
        useables.DEMSKLL, [1, 2, 3], 
        StatusEffects.AdventureGuildQuests1, 2);
    public var AGQ_Minotaurs(default, never) : SimpleGuildQuest = 
        new SimpleGuildQuest(
        "AGQ_Minotaurs", 
        "Minotaurs Hunt", 
        AdventurerGuild.RANK_COPPER, 
        useables.MINOHOR, [2, 3, 4], 
        StatusEffects.AdventureGuildQuests1, 3);
    public var AGQ_FeralImps(default, never) : SimpleGuildQuest = 
        new SimpleGuildQuest(
        "AGQ_FeralImps", 
        "Feral Imps Hunt", 
        AdventurerGuild.RANK_COPPER, 
        useables.FIMPSKL, [3, 4, 5], 
        StatusEffects.AdventureGuildQuests2, 2);
    public var AGQ_FeralTB(default, never) : SimpleGuildQuest = 
        new SimpleGuildQuest(
        "AGQ_FeralTB", 
        "Feral Tentacle Beasts Hunt", 
        AdventurerGuild.RANK_COPPER, 
        useables.SEVTENT, [1, 2, 3], 
        StatusEffects.AdventureGuildQuests2, 1);
    public var AGQ_Gel(default, never) : SimpleGuildQuest = 
        new SimpleGuildQuest(
        "AGQ_Gel", 
        "Green Gel Gathering", 
        AdventurerGuild.RANK_COPPER, 
        useables.GREENGL, [5, 5], 
        StatusEffects.AdventureGuildQuests4, 2);
    public var AGQ_Chitin(default, never) : SimpleGuildQuest = 
        new SimpleGuildQuest(
        "AGQ_Chitin", 
        "Black Chitin Gathering", 
        AdventurerGuild.RANK_COPPER, 
        useables.B_CHITN, [5, 5], 
        StatusEffects.AdventureGuildQuests4, 1);
    
    public function allQuests(group : String = null) : Array<Dynamic>
    {
        if (group != null)
        {
            return AbstractQuest.ALL_QUESTS_LIST.filter(function(q : AbstractQuest, i : Dynamic, j : Dynamic) : Bool
                    {
                        return q.group == group;
                    });
        }
        else
        {
            return AbstractQuest.ALL_QUESTS_LIST.slice();
        }
    }
    public function allKnownQuests(group : String = null) : Array<Dynamic>
    {
        if (group != null)
        {
            return AbstractQuest.ALL_QUESTS_LIST.filter(function(q : AbstractQuest, i : Dynamic, j : Dynamic) : Bool
                    {
                        return q.group == group && q.isKnown;
                    });
        }
        else
        {
            return AbstractQuest.ALL_QUESTS_LIST.filter(function(q : AbstractQuest, i : Dynamic, j : Dynamic) : Bool
                    {
                        return q.isKnown;
                    });
        }
    }
    
    public function new()
    {
        super();
    }
}


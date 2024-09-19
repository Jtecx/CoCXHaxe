package classes.scenes.quests;

import classes.globalFlags.KFLAGS;
import classes.scenes.aPI.AbstractQuest;
import classes.scenes.QuestLib;
import classes.scenes.SceneLib;

class ZetazQuest extends AbstractQuest
{
    public var canStart(get, never) : Bool;
    public var dungeonFound(get, never) : Bool;
    public var bossDefeated(get, never) : Bool;
    public var dungeonCleared(get, never) : Bool;
    public var perkRewardTaken(get, never) : Bool;

    public function new()
    {
        super("MQZetaz", QuestLib.QGRP_MAIN, "You're in Deep");
    }
    
    private function get_canStart() : Bool
    {
        return SceneLib.dungeons.canFindDeepCave();
    }
    private function get_dungeonFound() : Bool
    {
        return flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0;
    }
    private function get_bossDefeated() : Bool
    {
        return flags[kFLAGS.DEFEATED_ZETAZ] > 0;
    }
    private function get_dungeonCleared() : Bool
    {
        return SceneLib.dungeons.checkDeepCaveClear();
    }
    private function get_perkRewardTaken() : Bool
    {
        return flags[kFLAGS.DEFEATED_ZETAZ] > 1;
    }
    override private function get_description() : String
    {
        return "";
    }
    
    override public function objectives() : Array<Dynamic>
    {
        if (status == STATUS_NOT_STARTED)
        {
            return [
            [STATUS_NOT_STARTED, "Search the Deepwoods."]
        ];
        }
        if (status != STATUS_IN_PROGRESS)
        {
            return [];
        }
        var obj1 : Array<Dynamic> = [STATUS_IN_PROGRESS, "Search the Deepwoods."];
        var obj2 : Array<Dynamic> = [STATUS_NOT_STARTED, "Defeat Zetaz."];
        var obj3 : Array<Dynamic> = [STATUS_NOT_STARTED, "Clear the Deep Cave."];
        var obj4 : Array<Dynamic> = [STATUS_NOT_STARTED, "Take rewards from camp menu."];
        if (dungeonFound)
        {
            obj1[0] = STATUS_COMPLETED;
            obj2[0] = STATUS_IN_PROGRESS;
            obj3[0] = STATUS_IN_PROGRESS;
            if (bossDefeated)
            {
                obj2[0] = STATUS_COMPLETED;
                if (dungeonCleared)
                {
                    obj3[0] = STATUS_COMPLETED;
                    obj4[0] = STATUS_IN_PROGRESS;
                    if (perkRewardTaken)
                    {
                        obj4[0] = STATUS_COMPLETED;
                    }
                }
            }
        }
        return [
        obj1, 
        obj2, 
        obj3
    ];
    }
    
    override private function get_status() : Int
    {
        if (perkRewardTaken)
        {
            return STATUS_COMPLETED;
        }
        if (dungeonFound)
        {
            return STATUS_IN_PROGRESS;
        }
        if (canStart)
        {
            return STATUS_NOT_STARTED;
        }
        return STATUS_UNKNOWN;
    }
    
    override private function get_hintToUnlock() : String
    {
        return "Complete previous quest";
    }
}


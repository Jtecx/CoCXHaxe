package classes.scenes.quests;

import classes.globalFlags.KFLAGS;
import classes.scenes.aPI.AbstractQuest;
import classes.scenes.QuestLib;
import classes.scenes.SceneLib;

class FactoryQuest extends AbstractQuest
{
    public var questStarted(get, never) : Bool;
    public var factoryFound(get, never) : Bool;
    public var bossDefeated(get, never) : Bool;
    public var factoryShutdownOrDestroyed(get, never) : Bool;
    public var factoryShutdown(get, never) : Bool;
    public var factoryDestroyed(get, never) : Bool;
    public var maraeReportedPure(get, never) : Bool;
    public var maraeReportedCorrupt(get, never) : Bool;
    public var factoryCleared(get, never) : Bool;
    public var perkRewardTaken(get, never) : Bool;

    public function new()
    {
        super("MQFactory", QuestLib.QGRP_MAIN, "Shut Down Everything");
    }
    
    override private function get_description() : String
    {
        return "";
    }
    private function get_questStarted() : Bool
    {
        return flags[kFLAGS.MARAE_QUEST_START] >= 0.5;
    }
    private function get_factoryFound() : Bool
    {
        return flags[kFLAGS.FACTORY_FOUND] > 0;
    }
    private function get_bossDefeated() : Bool
    {
        return flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] > 0;
    }
    private function get_factoryShutdownOrDestroyed() : Bool
    {
        return flags[kFLAGS.FACTORY_SHUTDOWN] > 0;
    }
    private function get_factoryShutdown() : Bool
    {
        return flags[kFLAGS.FACTORY_SHUTDOWN] == 1;
    }
    private function get_factoryDestroyed() : Bool
    {
        return flags[kFLAGS.FACTORY_SHUTDOWN] == 2;
    }
    private function get_maraeReportedPure() : Bool
    {
        return flags[kFLAGS.MARAE_QUEST_COMPLETE] > 0;
    }
    private function get_maraeReportedCorrupt() : Bool
    {
        return flags[kFLAGS.MET_MARAE_CORRUPTED] > 0;
    }
    private function get_factoryCleared() : Bool
    {
        return SceneLib.dungeons.checkFactoryClear();
    }
    private function get_perkRewardTaken() : Bool
    {
        return flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] == 2;
    }
    override public function objectives() : Array<Dynamic>
    {
        if (status != STATUS_IN_PROGRESS)
        {
            return [];
        }
        var obj1 : Array<Dynamic> = [STATUS_IN_PROGRESS, "Find the factory at the hills."];
        var obj2 : Array<Dynamic> = [STATUS_NOT_STARTED, "Defeat the factory boss."];
        var obj3 : Array<Dynamic> = [STATUS_NOT_STARTED, "Clear the factory."];
        var obj4a : Array<Dynamic> = [STATUS_UNKNOWN, "Option A: Shut down the factory."];
        var obj4b : Array<Dynamic> = [STATUS_UNKNOWN, "Option B: Destroy the factory."];
        var obj6 : Array<Dynamic> = [STATUS_NOT_STARTED, "Report to Marae."];
        var obj7 : Array<Dynamic> = [STATUS_NOT_STARTED, "Take rewards from camp menu."];
        if (factoryFound)
        {
            obj1[0] = STATUS_COMPLETED;
            obj2[0] = STATUS_IN_PROGRESS;
            obj3[0] = STATUS_IN_PROGRESS;
            if (bossDefeated)
            {
                obj2[0] = STATUS_COMPLETED;
                obj4a[0] = STATUS_IN_PROGRESS;
                obj4b[0] = STATUS_IN_PROGRESS;
                if (factoryShutdown)
                {
                    obj4a[0] = STATUS_COMPLETED;
                    obj4b[0] = STATUS_FAILED;
                    obj6[0] = STATUS_IN_PROGRESS;
                    if (maraeReportedPure)
                    {
                        obj6[0] = STATUS_COMPLETED;
                    }
                }
                else if (factoryDestroyed)
                {
                    obj4a[0] = STATUS_FAILED;
                    obj4b[0] = STATUS_COMPLETED;
                    obj6[0] = STATUS_IN_PROGRESS;
                    if (maraeReportedCorrupt)
                    {
                        obj6[0] = STATUS_COMPLETED;
                    }
                }
                if (factoryCleared)
                {
                    obj3[0] = STATUS_COMPLETED;
                    obj7[0] = STATUS_IN_PROGRESS;
                    if (perkRewardTaken)
                    {
                        obj7[0] = STATUS_COMPLETED;
                    }
                }
            }
        }
        return [
        obj1, 
        obj2, 
        obj4a, 
        obj4b, 
        obj6, 
        obj3, 
        obj7
    ];
    }
    override private function get_status() : Int
    {
        if (perkRewardTaken && (maraeReportedPure || maraeReportedCorrupt))
        {
            return STATUS_COMPLETED;
        }
        if (questStarted)
        {
            return STATUS_IN_PROGRESS;
        }
        return STATUS_UNKNOWN;
    }
    override private function get_hintToUnlock() : String
    {
        if (flags[kFLAGS.MET_MARAE] > 0)
        {
            return "Visit Marae. Don't be too corrupt, or be a corrupted race.";
        }
        return "Visit the lake island.";
    }
}


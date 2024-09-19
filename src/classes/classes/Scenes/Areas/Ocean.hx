/**
 * @author Stadler (mostly) and Ormael (choice of enemies encounters and other events)
 * Area with lvl 30-45 enemies.
 * Currently a Work in Progress.
 */

package classes.scenes.areas;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.scenes.aPI.Encounters;
import classes.scenes.aPI.ExplorationEntry;
import classes.scenes.aPI.GroupEncounter;
import classes.scenes.areas.deepSea.AbyssalSharkScene;
import classes.scenes.areas.ocean.*;
import classes.scenes.nPCs.CeaniScene;
import classes.scenes.places.boat.SharkGirlScene;
import classes.scenes.SceneLib;

class Ocean extends BaseContent
{
    public var oceanEncounter(get, never) : GroupEncounter;

    public var ceaniScene : CeaniScene = new CeaniScene();
    public var sharkGirlScene : SharkGirlScene = new SharkGirlScene();
    public var scyllaScene : ScyllaScene = new ScyllaScene();
    public var abyssalsharkScene : AbyssalSharkScene = new AbyssalSharkScene();
    
    public var areaLevel(default, never) : Int = 25;
    public function isDiscovered() : Bool
    {
        return SceneLib.exploration.counters.ocean > 0;
    }
    public function canDiscover() : Bool
    {
        return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
    }
    public function timesExplored() : Int
    {
        return SceneLib.exploration.counters.ocean;
    }
    
    public function discover() : Void
    {
        SceneLib.exploration.counters.ocean = 1;
        clearOutput();
        outputText("You journey around the beach, seeking demons to fight");
        if (player.cor > 60)
        {
            outputText(" or fuck");
        }
        outputText(".  The air is fresh, and the sand is cool under your feet.   Soft waves lap against the muddy sand of the sea-shore.   You pass around a few dunes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n");
        outputText("<b>You have discovered the sea boat!</b>");
        endEncounter(120);
    }
    
    
    public function new()
    {
        super();
        onGameInit(init);
    }
    
    private var _oceanEncounter : GroupEncounter = null;
    private function get_oceanEncounter() : GroupEncounter
    {
        return _oceanEncounter;
    }
    
    private function init() : Void
    {
        _oceanEncounter = Encounters.group("ocean", {
                            name : "fishing",
                            label : "Fishing",
                            kind : "event",
                            unique : true,
                            when : function() : Bool
                            {
                                return player.hasKeyItem("Fishing Pole") >= 0;
                            },
                            call : fishing
                        }, {
                            name : "nothing",
                            chance : 0.25,
                            call : findNothing,
                            label : "Walk",
                            kind : "walk"
                        }, {
                            name : "ceani",
                            label : "Ceani",
                            kind : "npc",
                            unique : true,
                            when : function() : Bool
                            {
                                return (model.time.hours >= 12 && model.time.hours <= 22) && flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] >= 4;
                            },
                            chance : oceanChance,
                            call : ceaniScene.oceanInteractionsAfterArcheryTraining
                        }, {
                            name : "seaanemone",
                            label : "Sea Anemone",
                            kind : "monster",
                            call : function() : Void
                            {
                                flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] = 2;
                                player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
                                player.createStatusEffect(StatusEffects.InWater, 0, 0, 0, 0);
                                SceneLib.boat.anemoneScene.mortalAnemoneeeeee();
                            }
                        }, {
                            name : "scylla",
                            label : "Scylla",
                            kind : "monster",
                            call : function() : Void
                            {
                                player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
                                player.createStatusEffect(StatusEffects.InWater, 0, 0, 0, 0);
                                scyllaScene.oceanScyllaEncounter();
                            }
                        }, {
                            name : "sharkgirl",
                            label : "Shark girl",
                            kind : "monster",
                            call : function() : Void
                            {
                                flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 1;
                                player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
                                player.createStatusEffect(StatusEffects.InWater, 0, 0, 0, 0);
                                sharkGirlScene.oceanSharkGirlEncounter();
                            }
                        }, {
                            name : "tigersharkgirl",
                            label : "Tigershark girl",
                            kind : "monster",
                            call : function() : Void
                            {
                                flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 2;
                                player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
                                player.createStatusEffect(StatusEffects.InWater, 0, 0, 0, 0);
                                sharkGirlScene.oceanTigersharkGirlEncounter();
                            }
                        }, {
                            name : "sharkgirlpack",
                            label : "Shark girls pack",
                            kind : "monster",
                            call : function() : Void
                            {
                                flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 1;
                                player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
                                player.createStatusEffect(StatusEffects.InWater, 0, 0, 0, 0);
                                sharkGirlScene.oceanSharkGirlsPackEncounter();
                            }
                        }, {
                            name : "juvenileabyssalshark",
                            label : "Juvenile A. Shark",
                            kind : "monster",
                            chance : 0.75,
                            call : function() : Void
                            {
                                player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
                                player.createStatusEffect(StatusEffects.InWater, 0, 0, 0, 0);
                                abyssalsharkScene.oceanJuvenileAbyssalSharkEncounter();
                            }
                        }, {
                            name : "arigean",
                            label : "Arigean",
                            kind : "monster",
                            when : function() : Bool
                            {
                                return flags[kFLAGS.THE_TRENCH_ENTERED] == 0;
                            },
                            call : SceneLib.graydaScene.graydaEncounter
                        }, {
                            name : "weresharkMale",
                            label : "Wereshark (M)",
                            kind : "monster",
                            day : false,
                            call : SceneLib.weresharkScene.weresharkEncounter,
                            chance : 0.50
                        });
    }
    
    public function exploreOcean() : Void
    {
        explorer.prepareArea(oceanEncounter);
        explorer.setTags("ocean", "water");
        explorer.prompt = "You explore the ocean surface.";
        explorer.onEncounter = function(e : ExplorationEntry) : Void
                {
                    SceneLib.exploration.counters.ocean++;
                };
        explorer.leave.hint("Leave the ocean");
        explorer.skillBasedReveal(areaLevel, timesExplored());
        explorer.doExplore();
    }
    
    public function oceanChance() : Float
    {
        var temp : Float = 0.5;
        temp *= player.npcChanceToEncounter();
        return temp;
    }
    
    private function findNothing() : Void
    {
        clearOutput();
        outputText("You row for over an hour, until your arms practically burn with exhaustion from all the rowing.\n\n");
        if (rand(2) == 0)
        
        //50/50 strength/speed{
            
            if (rand(2) == 0 && player.str < 150)
            {
                outputText("Despite the exaustion, you feel like you have become stronger.");
                dynStats("str", .5);
            }
            //Toughness
            else if (player.spe < 150)
            {
                outputText("Despite the exaustion, you feel like you have become faster.");
                dynStats("spe", .5);
            }
        }
        endEncounter();
    }
    
    private function fishing() : Void
    {
        clearOutput();
        outputText("This is a calm day on the ocean, you managed to hold your boat just a mile or two away from the brewing storm that constantly rage over the area and, while you found nothing of note, couldn’t help yourself but to enjoy a few hour using your newly acquired fishing pole.\n\n");
        outputText("<b>You got a fish!</b>");
        inventory.takeItem(consumables.FREFISH, explorer.done);
    }
}



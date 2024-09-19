/**
 * Created by aimozg on 06.01.14.
 */
package classes.scenes.places;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.scenes.aPI.Encounters;
import classes.scenes.aPI.ExplorationEntry;
import classes.scenes.aPI.GroupEncounter;
import classes.scenes.areas.lake.*;
import classes.scenes.nPCs.BelisaFollower;
import classes.scenes.nPCs.EtnaFollower;
import classes.scenes.places.boat.*;
import classes.scenes.SceneLib;

class Boat extends AbstractLakeContent
{
    public var boatEncounter(get, never) : GroupEncounter;

    public var sharkGirlScene : SharkGirlScene = new SharkGirlScene();
    public var marae : MaraeScene = new MaraeScene();
    public var kaiju : Kaiju = new Kaiju();
    public var anemoneScene : AnemoneScene = new AnemoneScene();
    public function new()
    {
        super();
        onGameInit(init);
    }
    
    public var discoverLevel(default, never) : Int = 10;
    public var areaLevel(default, never) : Int = 1;
    public function isDiscovered() : Bool
    {
        return SceneLib.exploration.counters.boat > 0;
    }
    public function canDiscover() : Bool
    {
        return !isDiscovered() && adjustedPlayerLevel() >= discoverLevel;
    }
    public function timesExplored() : Int
    {
        return SceneLib.exploration.counters.boat;
    }
    
    public function discoverBoat() : Void
    {
        SceneLib.exploration.counters.boat = 1;
        clearOutput();
        outputText("You journey around the lake, seeking demons to fight");
        if (player.cor > 60)
        {
            outputText(" or fuck");
        }
        outputText(".  The air is fresh, and the grass is cool and soft under your feet.   Soft waves lap against the muddy sand of the lake-shore, as if radiating outward from the lake.   You pass around a few bushes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n");
        outputText("<b>You have discovered the lake boat!</b>\n(You may return and use the boat to explore the lake's interior by using the 'places' menu.)");
        explorer.stopExploring();
        doNext(camp.returnToCampUseOneHour);
    }
    private var _boatEncounter : GroupEncounter = null;
    private function get_boatEncounter() : GroupEncounter
    {
        return _boatEncounter;
    }
    private function init() : Void
    {
        _boatEncounter = Encounters.group("boat", {
                            name : "Belisa",
                            label : "Belisa",
                            kind : "npc",
                            unique : true,
                            when : function() : Bool
                            {
                                return BelisaFollower.BelisaInGame && BelisaFollower.BelisaEncounternum == 1;
                            },
                            call : SceneLib.belisa.secondEncounter,
                            chance : 20
                        }, {
                            name : "Etna",
                            label : "Etna",
                            kind : "npc",
                            unique : true,
                            when : function() : Bool
                            {
                                return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2) && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && (player.level >= 20 || flags[kFLAGS.HARDCORE_MODE] == 1);
                            },
                            call : SceneLib.etnaScene.repeatYandereEnc
                        }, {
                            name : "izmaKids",
                            label : "Lost daughter",
                            kind : "event",
                            unique : true,
                            chance : 0.3,
                            when : function() : Bool
                            {
                                return flags[kFLAGS.IZMA_KIDS_IN_THE_WILD] > 0 && SceneLib.izmaScene.izmaFollower();
                            },
                            call : SceneLib.izmaScene.findLostIzmaKids
                        }, {
                            name : "Marae",
                            label : "Marae",
                            kind : "npc",
                            unique : true,
                            chance : 3,
                            when : function() : Bool
                            {
                                return flags[kFLAGS.MARAE_ISLAND] < 1;
                            },
                            night : false,
                            call : marae.encounterMarae
                        }, {
                            name : "Walk",
                            label : "Row",
                            kind : "walk",
                            chance : 0.25,
                            call : rowBoat
                        }, {
                            name : "sharkgirl",
                            label : "Shark girl",
                            kind : "monster",
                            call : sharkGirlScene.sharkGirlEncounter
                        }, {
                            name : "anemone",
                            label : "Anemone",
                            kind : "monster",
                            call : function() : Void
                            {
                                flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] = 1;
                                anemoneScene.mortalAnemoneeeeee();
                            }
                        }, {
                            name : "zealot",
                            label : "Fetish Zealot",
                            kind : "monster",
                            night : false,
                            when : function() : Bool
                            {
                                return (player.level > 2 || flags[kFLAGS.HARDCORE_MODE] == 1) && player.hasStatusEffect(StatusEffects.FetishOn);
                            },
                            call : lake.fetishZealotScene.zealotBoat
                        }, {
                            name : "Fishing",
                            label : "Fishing",
                            kind : "event",
                            unique : true,
                            when : function() : Bool
                            {
                                return player.hasKeyItem("Fishing Pole") >= 0;
                            },
                            call : fishing
                        }, {
                            name : "Venus",
                            label : "Venus",
                            kind : "npc",
                            unique : true,
                            when : function() : Bool
                            {
                                return (player.level >= 5 || flags[kFLAGS.HARDCORE_MODE] == 1) && flags[kFLAGS.KAIJU_DISABLED] == 0 && !player.hasStatusEffect(StatusEffects.VenusOff);
                            },
                            call : kaiju.kaijuMeeting
                        });
    }
    
    public function boatExplore() : Void
    {
        explorer.prepareArea(boatEncounter);
        explorer.setTags("boat", "lakeBoat", "water");
        explorer.prompt = "You explore the lake.";
        if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2)
        {
            explorer.prompt += "The water appears somewhat muddy and has a faint pungent odor.  ";
            if (player.inte > 40)
            {
                explorer.prompt += "You realize what it smells like – sex.  ";
            }
        }
        explorer.onEncounter = function(e : ExplorationEntry) : Void
                {
                    SceneLib.exploration.counters.boat++;
                };
        explorer.leave.hint("Return to the shore");
        explorer.skillBasedReveal(areaLevel, timesExplored());
        explorer.doExplore();
    }
    
    private function fishing() : Void
    {
        outputText("This is a calm day at the lake, you managed to hold your boat in place and, while you found nothing of note, couldn’t help yourself but to enjoy a few hour using your newly acquired fishing pole. You even spotted Calu in the distance doing the same thing from her usual sitting spot.\n\n");
        outputText("<b>You got a fish!</b>");
        inventory.takeItem(consumables.FREFISH, explorer.done);
    }
    
    private function rowBoat() : Void
    {
        if (rand(2) == 0)
        {
            outputText("You row for nearly an hour, until your arms practically burn with exhaustion from all the rowing.");
        }
        else
        {
            outputText("You give up on finding anything interesting, and decide to go check up on your camp.");
        }
        endEncounter(60);
    }
}


/**
 * ...
 * @author Ormael
 */
package classes.scenes;

import haxe.Constraints.Function;
import classes.*;
import classes.bodyParts.*;
import classes.geneticMemories.*;
import classes.globalFlags.KFLAGS;
import classes.iMutations.*;
import classes.items.*;
import classes.items.dynamic.DynamicWeapon;
import classes.scenes.areas.deepSea.Kraken;
import classes.scenes.areas.mountain.Minotaur;
import classes.scenes.camp.CampStatsAndResources;
import classes.scenes.dungeons.d3.Lethice;
import classes.scenes.dungeons.d3.SuccubusGardener;
import classes.scenes.dungeons.desertCave.SandMother;
import classes.scenes.dungeons.ebonLabyrinth.*;
import classes.scenes.explore.Pierce;
import classes.scenes.monsters.Malikore;
import classes.scenes.nPCs.Alvina;
import classes.scenes.nPCs.Aria;
import classes.scenes.nPCs.Belisa;
import classes.scenes.nPCs.BelisaFollower;
import classes.scenes.nPCs.Carrera;
import classes.scenes.nPCs.DivaScene;
import classes.scenes.nPCs.DriderTown;
import classes.scenes.nPCs.EvangelineFollower;
import classes.scenes.nPCs.Galia;
import classes.scenes.nPCs.Lilith;
import classes.scenes.nPCs.LilyFollower;
import classes.scenes.nPCs.RyuBiDragon;
import classes.scenes.nPCs.Sonya;
import classes.scenes.nPCs.TyrantiaFollower;
import classes.scenes.nPCs.WaizAbi;
import classes.scenes.places.boat.Marae;
import classes.scenes.places.heXinDao.AdventurerGuild;
import classes.scenes.dungeons.deepCave.Zetaz;
import classes.scenes.dungeons.factory.OmnibusOverseer;
import classes.scenes.dungeons.demonLab.Incels;
import classes.scenes.dungeons.ebonLabyrinth.Draculina;
import classes.stats.Buff;
import coc.view.ButtonDataList;

class TestMenu extends BaseContent
{
    public function SoulforceCheats() : Void
    {
        clearOutput();
        outputText("Collection of different cheats that can be used by the players.");
        outputText("\n\nAscension points: " + player.ascensionPerkPoints + "");
        var bd : ButtonDataList = new ButtonDataList();
        bd.add("StatsAdj/Ascen", StatsAscensionMenu, "For more precisely adjusting each of the 8 main stats and Ascension related stuff.");
        bd.add("P/G/XP", PerksGemsEXP, "Adding/Removing perk points and adding gems/exp.");
        bd.add("LvL/DLvL", LevelDeLevel, "Adding/Substracting levels.");
        bd.add("Quick Flags", modFlagsMenu, "Menu to edit some some flags quickly for debugging");
        bd.add("Equip", EquipmentMenu, "For creating various equipment items for tests.");
        bd.add("NonEquip", NonEquipmentMenu, "For creating various non-equipment items for tests.");
        bd.add("Materials", MaterialMenu, "For creating various materials for tests.");
        bd.add("Enemies", enemiesMenu, "For spawning various enemies to test fight them.");
        bd.add("Camp NPC's", FasterOrInstantCampNPCRecruitment, "Menu to speed up recruitment of camp npc's due to testing needs.");
        bd.add("Body State", BodyStateMenu, "For more precisely adjusting a few other body values or parts than Stats Adj option.");
        bd.add("MetamorphFull", AllMetamorphOptionsUnlock, "Unlock all Metamorph options.").disableIf(!player.hasPerk(PerkLib.Metamorph));
        bd.add("BodyPartEditor", curry(SceneLib.debugMenu.bodyPartEditorRoot, SoulforceCheats), "");
        bd.add("Insta-house", instaHouse, "Instant-house + bed. No Mutant here.");
        bd.add("Learn Hexes", learnHexes, "Learn Prestige Job - Warlock and different hex spells");
        bd.add("WendigoTrigger", wendigoTrigger, "Trigger Wendigo transformation. (Without active Wendigo Psychosis will do nothing ;) )");
        bd.add("ChimeraBodyUlt", ChimeraBodyUltimateStage, "Ultimate Stage of Chimera Body for tests and lulz. Now with on/off switch for more lulz.");
        bd.add("All4HiddenPrestige", hiddenPJ, "A11 th4t H1dd3n Prestige is Y0urs to T4ke!!!");
        bd.add("PerkGalore1", PerkGalore1, "");
        bd.add("PerkGalore2", PerkGalore2, "");
        bd.add("RemoveRP", cheatRemoveRP, "Remove Racial Paragon perk");
        bd.add("Fix Shards", cheatFixShards, "Check the player's quests and give the deserved shards.");
        bd.add("Add Shard", cheatAddShard, "Add 1 radiant shard");
        bd.add("Remove Shard", cheatRemoveShard, "Remove 1 radiant shard");
        bd.add("Refill SF", refillSoulforce, "Refill your Soulforce.");
        bd.add("EvaMutateReq", mutateReqNope, "Turns on/off mutation requirements");
        bd.add("IdentifyAll", identifyAll, "Identify all items");
        bd.add("UncurseAll", uncurseAll, "Uncurse all items");
        bd.add("Gren Mag perks", FaeDragTest1, "Add gren magic boosting perks.").disableIf(player.hasPerk(PerkLib.ArcaneVenom));
        bd.add("FaeDragBParts", FaeDragTest2, "Add missing fairy dragon bodyparts.");
        bd.add("Handmaiden stripes", FaeDragTest3, "Add chitin and stripes to handmaiden.").disableIf(!player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden));
        bd.add("FixFJiasngshi", fixFormerJiangshi, "Removig leftover effects of cursed tag after curginh Jiangshi state.");
        //bd.add("DinCheatShop", curry(SceneLib.dinahScene.openShop, true), "Open Dinah shop with everything unlocked. Normally, you have to defeat a boss to unlock its TF; and all 'Roulette' items appear randomly.")
        bd.add("DebugMenu", SceneLib.debugMenu.accessDebugMenu, "The older debug menu. Who knows what it hides?");
        bd.add("Bugfixes", cheatBugfixes, "Buttons or fixing some rare old bugs that can't be fixd with save-updater.");
        bd.add("Testing", cheatTesting, "Buttons for testing some new stuff. May break your game if something is outdated.");
        bd.add("Bags expansion", SceneLib.garden.justForTestBuildsAdjustingBagsCapacityCuzINotWannaWasteSaveUpdateForThat, "Expand the bags. (If you not own any of them will not have any effect)");
        bd.add("Amily Re:Fit", AddJabbyShit1, "Amily Re:Fit.").disableIf(player.hasPerk(PerkLib.Soulless));
        bd.add("X-Uni 2", MightyOrNot, "Adding status effect needed for gifts and yuri scene unlock in demon lair.");
        bd.add("RuinedTown", SceneLib.ruinedTown.enterVillage, "Test the Mousetown");
        submenu(bd, playerMenu, 0, false);
    }
    
    private function cheatBugfixes() : Void
    {
        clearOutput();
        outputText("Cheats made for fixing some rare bugs that can't be fixed with save-updates. Do we even have them yet? Probably 90% of this stuff is outdated.");
        var bd : ButtonDataList = new ButtonDataList();
        bd.add("TyrantPF", FairyTest5, "Patching Tyrantia corrupted legendaries unlock").disableIf(TyrantiaFollower.TyrantiaFollowerStage == 5 && TyrantiaFollower.TyraniaCorrupteedLegendaries == 0);
        bd.add("LilyPregF", FairyTest3, "Curing Lily Infertility ^^").disableIf(DriderTown.LilyKidsPCPregnancy != 0 && LilyFollower.LilyFollowerState);
        bd.add("TheHangover4", hangoverS4, "Removes Hangover from the player (by leaving you on the roof of the hotel. Hope you brought a mattress and water!)");
        bd.add("QuestItBag", AddMaxBackpack2, "Giving missing Quest Items Bag as part of Adventure Guild welcome/promotion package.");
        bd.add("ClickItOnce", AddMaxBackpack3, "Fixing Lover Zenji missing one status effect needed for his sex scenes menu.").disableIf(!player.hasStatusEffect(StatusEffects.ZenjiZList));
        bd.add("BeliConfFix", belisatest2, "Belisa Confession Fix").disableIf(TyrantiaFollower.isLover() && BelisaFollower.BelisaFollowerStage >= 5 && BelisaFollower.BelisaEncounternum >= 5 && BelisaFollower.BelisaAffectionMeter >= 80 && !BelisaFollower.BelisaConfessed);
        bd.add("FixJiangshi", jiangshiBuggedItemsCleanUpCrew0, "Shit! Here we go Again! Fixing Jiangshi! (better use it only once or may be some bugs i not plan to account for in case of using this more than once - i not blocked using it more than once so belive ppl will be reasonable to not click like mad this)");
        bd.add("ClickItTwice", golemArmy, "Golem Army and Ascension: Additional Organ Mutation/Prestige perks correction pre global save upgrade on new public build.");
        bd.add("FixClones", fixClones, "If you have messed up clones or negative levels or related outdated data this will clear it all away.");
        submenu(bd, SoulforceCheats, 0, false);
    }
    
    private function cheatTesting() : Void
    {
        clearOutput();
        outputText("Cheats made specifically for the testing needs. Use only if you're sure what you're doing - outdated test-cheats may break something and nobody will look into such bugs.");
        var bd : ButtonDataList = new ButtonDataList();
        bd.add("LilyTest", lilytest, "Lily Trigger").disableIf(!LilyFollower.LilyFollowerState);
        bd.add("NY(S/NS)MA-D", anTrigger, "Now you see or not see me.\n\n<i><b>(Anty-Dexterity)</b></i>");
        bd.add("NewSoulCult", applyHangover, "Cripple your cultivation base to start anew (with a bit more milf fluff in your life).");
        bd.add("LustBreath", FairyTest, "Replacing 1 perk with another").disableIf(player.hasPerk(PerkLib.DragonPoisonBreath));
        bd.add(":Re", AddMaxBackpack5, "Rewind Evangeline.").disableIf(flags[kFLAGS.EVANGELINE_LVL_UP] > 0);
        bd.add("RevertCabin", RevertCabinProgress, "Revert cabin flag back to value 2 (for bug fix test)");
        bd.add("Gargoyle", GargoyleMenu, "To Be or Not To Be Gargoyle that is a question.");
        bd.add("BelisaTest", belisatest3, "Belisa Trigger").disableIf(BelisaFollower.BelisaInGame && BelisaFollower.BelisaFollowerStage < 3);
        bd.add("Test dynamic stat", TestDynamicStats, "Test Dynamic stats.");
        bd.add("Neko Items", giveNekoItems, "All new neko items from Nekobake Inn doc");
        bd.add("DantianPhylactery", dantianPhylacteryTest, "Getting or loosing Dantian Phylactery.");
        submenu(bd, SoulforceCheats, 0, false);
    }
    
    public function MightyOrNot() : Void
    {
        if (player.hasStatusEffect(StatusEffects.MeetXuviel) && !player.hasStatusEffect(StatusEffects.MeetXuviel2))
        {
            player.createStatusEffect(StatusEffects.MeetXuviel2, 0, 0, 0, 0);
        }
        doNext(SoulforceCheats);
    }
    
    public function AddJabbyShit1() : Void
    {
        outputText("\n\n<b>Amilly have been Re:Fit'd.</b>\n\n");
        flags[kFLAGS.AMILY_CORRUPT_FLIPOUT] = 0;
        flags[kFLAGS.AMILY_FOLLOWER] = 1;
        flags[kFLAGS.AMILY_WARNING] = 0;
        flags[kFLAGS.AMILY_VILLAGE_ENCOUNTERS_DISABLED] = 1;
        doNext(SoulforceCheats);
    }
    
    private function FaeDragTest2() : Void
    {
        clearOutput();
        player.tailType = Tail.FEY_DRACONIC;
        player.arms.type = Arms.FEY_DRACONIC;
        player.lowerBody = LowerBody.FEY_DRAGON;
        outputText("Faerie dragon bodyparts gained.");
        doNext(SoulforceCheats);
    }
    
    private function FaeDragTest1() : Void
    {
        clearOutput();
        if (!player.hasPerk(PerkLib.GreenMagic))
        {
            player.createPerk(PerkLib.GreenMagic, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.VerdantLeech))
        {
            player.createPerk(PerkLib.VerdantLeech, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.ArcaneVenom))
        {
            player.createPerk(PerkLib.ArcaneVenom, 0, 0, 0, 0);
        }
        outputText("Green magic boosting perks gained.");
        doNext(SoulforceCheats);
    }
    
    private function FaeDragTest3() : Void
    {
        clearOutput();
        transformations.SkinPatternBeeStripes.applyEffect();
        outputText("Handmaiden chitin and bee stripes operationa...just fixed.");
        doNext(SoulforceCheats);
    }
    
    private function hangoverS4() : Void
    {
        clearOutput();
        if (player.statStore.hasBuff("Hangover"))
        {
            player.statStore.removeBuffs("Hangover");
            outputText("IVs have been inserted and fluids replenished.");
        }
        else
        {
            outputText("Stop messing about in the ICU and go away.");
        }
        doNext(SoulforceCheats);
    }
    
    private function identifyAll() : Void
    {
        clearOutput();
        if (Std.is(player.weapon, DynamicWeapon) && !(try cast(player.weapon, DynamicWeapon) catch(e:Dynamic) null).identified)
        {
            player.setWeapon(try cast((try cast(player.weapon, DynamicWeapon) catch(e:Dynamic) null).identifiedCopy(), DynamicWeapon) catch(e:Dynamic) null);
            outputText("\nIdentified " + player.weapon.longName);
        }
        for (i in 0...player.itemSlots.length)
        {
            var item : ItemSlotClass = player.itemSlots[i];
            if (item.unlocked && item.quantity > 0)
            {
                if (Std.is(item.itype, DynamicWeapon) && !(try cast(item.itype, DynamicWeapon) catch(e:Dynamic) null).identified)
                {
                    player.itemSlots[i].setItemAndQty(
                            (try cast(item.itype, DynamicWeapon) catch(e:Dynamic) null).identifiedCopy(), 
                            item.quantity
                );
                    outputText("\nIdentified " + item.itype.longName);
                }
            }
        }
        doNext(SoulforceCheats);
    }
    private function uncurseAll() : Void
    {
        clearOutput();
        if (player.weapon.cursed && Std.is(player.weapon, DynamicWeapon))
        {
            player.setWeapon(try cast((try cast(player.weapon, DynamicWeapon) catch(e:Dynamic) null).uncursedCopy(), DynamicWeapon) catch(e:Dynamic) null);
            outputText("\nUncursed " + player.weapon.longName);
        }
        for (i in 0...player.itemSlots.length)
        {
            var item : ItemSlotClass = player.itemSlots[i];
            if (item.unlocked && item.quantity > 0 && item.itype.cursed)
            {
                if (Std.is(item.itype, DynamicWeapon))
                {
                    player.itemSlots[i].setItemAndQty(
                            (try cast(item.itype, DynamicWeapon) catch(e:Dynamic) null).uncursedCopy(), 
                            item.quantity
                );
                    outputText("\nUncursed " + item.itype.longName);
                }
            }
        }
        doNext(SoulforceCheats);
    }
    
    private function fixFormerJiangshi() : Void
    {
        if (!player.hasPerk(PerkLib.CursedTag))
        {
            if (player.hasStatusEffect(StatusEffects.AlterBindScroll1))
            {
                player.removeStatusEffect(StatusEffects.AlterBindScroll1);
            }
            if (player.hasStatusEffect(StatusEffects.AlterBindScroll2))
            {
                player.removeStatusEffect(StatusEffects.AlterBindScroll2);
            }
            if (player.hasStatusEffect(StatusEffects.AlterBindScroll3))
            {
                player.removeStatusEffect(StatusEffects.AlterBindScroll3);
            }
            if (player.hasStatusEffect(StatusEffects.AlterBindScroll4))
            {
                player.removeStatusEffect(StatusEffects.AlterBindScroll4);
            }
            if (player.hasStatusEffect(StatusEffects.AlterBindScroll5))
            {
                player.removeStatusEffect(StatusEffects.AlterBindScroll5);
            }
        }
        doNext(SoulforceCheats);
    }
    
    private function anTrigger() : Void
    {
        clearOutput();
        if (player.hasPerk(PerkLib.AntyDexterity))
        {
            player.removePerk(PerkLib.AntyDexterity);
            outputText("Now you don't see me.\n\n<i><b>(Anty-Dexterity)</b></i>");
        }
        else
        {
            player.createPerk(PerkLib.AntyDexterity, 0, 0, 0, 0);
            outputText("Now you see me.\n\n<i><b>(Anty-Dexterity)</b></i>");
        }
        doNext(SoulforceCheats);
    }
    
    private function mutateReqNope() : Void
    {
        clearOutput();
        flags[kFLAGS.EVA_MUTATIONS_BYPASS] = !flags[kFLAGS.EVA_MUTATIONS_BYPASS];
        outputText("Mutation requirements are now " + ((flags[kFLAGS.EVA_MUTATIONS_BYPASS] != null) ? "off" : "on") + ".");
        doNext(SoulforceCheats);
    }
    
    private function refillSoulforce() : Void
    {
        clearOutput();
        player.soulforce = player.maxOverSoulforce();
        outputText("Soulforce filled up.");
        statScreenRefresh();
        doNext(SoulforceCheats);
    }
    
    private function applyHangover() : Void
    {
        if (player.hasPerk(PerkLib.JobSoulCultivator))
        {
            player.removePerk(PerkLib.JobSoulCultivator);
        }
        if (player.hasKeyItem("Cultivation Manual: Duality") >= 0)
        {
            player.removeKeyItem("Cultivation Manual: Duality");
        }
        if (player.hasPerk(PerkLib.SoulApprentice))
        {
            player.removePerk(PerkLib.SoulApprentice);
        }
        if (player.hasPerk(PerkLib.Dantain))
        {
            player.removePerk(PerkLib.Dantain);
        }
        if (player.hasKeyItem("Cultivation Manual: My Dao Sticks are better than Yours") >= 0)
        {
            player.removeKeyItem("Cultivation Manual: My Dao Sticks are better than Yours");
        }
        if (player.hasPerk(PerkLib.DaoistCultivator))
        {
            player.removePerk(PerkLib.DaoistCultivator);
        }
        if (player.hasPerk(PerkLib.DaoistApprenticeStage))
        {
            player.removePerk(PerkLib.DaoistApprenticeStage);
        }
        if (player.hasPerk(PerkLib.DaoistWarriorStage))
        {
            player.removePerk(PerkLib.DaoistWarriorStage);
        }
        if (player.hasPerk(PerkLib.DaoistElderStage))
        {
            player.removePerk(PerkLib.DaoistElderStage);
        }
        if (player.hasPerk(PerkLib.DaoistOverlordStage))
        {
            player.removePerk(PerkLib.DaoistOverlordStage);
        }
        if (player.hasKeyItem("Cultivation Manual: Body like a Coke Fiend") >= 0)
        {
            player.removeKeyItem("Cultivation Manual: Body like a Coke Fiend");
        }
        if (player.hasPerk(PerkLib.BodyCultivator))
        {
            player.removePerk(PerkLib.BodyCultivator);
        }
        if (player.hasPerk(PerkLib.FleshBodyApprenticeStage))
        {
            player.removePerk(PerkLib.FleshBodyApprenticeStage);
        }
        if (player.hasPerk(PerkLib.FleshBodyWarriorStage))
        {
            player.removePerk(PerkLib.FleshBodyWarriorStage);
        }
        if (player.hasPerk(PerkLib.FleshBodyElderStage))
        {
            player.removePerk(PerkLib.FleshBodyElderStage);
        }
        if (player.hasPerk(PerkLib.FleshBodyOverlordStage))
        {
            player.removePerk(PerkLib.FleshBodyOverlordStage);
        }
        if (player.hasKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil") >= 0)
        {
            player.removeKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil");
        }
        if (player.hasPerk(PerkLib.SoulPersonage))
        {
            player.removePerk(PerkLib.SoulPersonage);
        }
        if (player.hasKeyItem("'Soul Sense and You' Manual") >= 0)
        {
            player.removeKeyItem("'Soul Sense and You' Manual");
        }
        if (player.hasPerk(PerkLib.SoulSense))
        {
            player.removePerk(PerkLib.SoulSense);
        }
        if (player.hasPerk(PerkLib.SoulWarrior))
        {
            player.removePerk(PerkLib.SoulWarrior);
        }
        if (player.hasKeyItem("Heavenly Tribulation: Myths and Facts") >= 0)
        {
            player.removeKeyItem("Heavenly Tribulation: Myths and Facts");
        }
        if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor))
        {
            player.removePerk(PerkLib.HclassHeavenTribulationSurvivor);
        }
        if (player.hasPerk(PerkLib.SoulSprite))
        {
            player.removePerk(PerkLib.SoulSprite);
        }
        if (player.hasPerk(PerkLib.SoulScholar))
        {
            player.removePerk(PerkLib.SoulScholar);
        }
        if (player.hasPerk(PerkLib.SoulGrandmaster))
        {
            player.removePerk(PerkLib.SoulGrandmaster);
        }
        if (player.hasKeyItem("A summary of Marethian Sects") >= 0)
        {
            player.removeKeyItem("A summary of Marethian Sects");
        }
        if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor))
        {
            player.removePerk(PerkLib.GclassHeavenTribulationSurvivor);
        }
        if (player.hasPerk(PerkLib.SoulElder))
        {
            player.removePerk(PerkLib.SoulElder);
        }
        if (player.hasPerk(PerkLib.SoulExalt))
        {
            player.removePerk(PerkLib.SoulExalt);
        }
        if (player.hasPerk(PerkLib.SoulOverlord))
        {
            player.removePerk(PerkLib.SoulOverlord);
        }
        if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor))
        {
            player.removePerk(PerkLib.FclassHeavenTribulationSurvivor);
        }
        if (player.hasPerk(PerkLib.SoulTyrant))
        {
            player.removePerk(PerkLib.SoulTyrant);
        }
        if (player.hasPerk(PerkLib.SoulKing))
        {
            player.removePerk(PerkLib.SoulKing);
        }
        if (player.hasPerk(PerkLib.SoulEmperor))
        {
            player.removePerk(PerkLib.SoulEmperor);
        }
        if (player.hasPerk(PerkLib.SoulAncestor))
        {
            player.removePerk(PerkLib.SoulAncestor);
        }
        if (player.hasPerk(PerkLib.BodyTempering))
        {
            player.removePerk(PerkLib.BodyTempering);
        }
        if (player.hasPerk(PerkLib.SoulTempering))
        {
            player.removePerk(PerkLib.SoulTempering);
        }
        if (flags[kFLAGS.SOUL_CULTIVATION] > 0)
        {
            flags[kFLAGS.SOUL_CULTIVATION] = 0;
        }
        doNext(SoulforceCheats);
    }
    public function FairyTest4() : Void
    //player.removePerk(PerkLib.);
    {
        
        player.perkPoints += 1;
        doNext(SoulforceCheats);
    }
    public function FairyTest3() : Void
    {
        DriderTown.LilyKidsPCPregnancy = 0;
        doNext(SoulforceCheats);
    }
    public function FairyTest5() : Void
    {
        TyrantiaFollower.TyrantiaFollowerStage = 4;
        TyrantiaFollower.TyraniaCorrupteedLegendaries = 1;
        doNext(SoulforceCheats);
    }
    public function FairyTest() : Void
    {
        player.removePerk(PerkLib.DragonPoisonBreath);
        player.createPerk(PerkLib.DragonLustPoisonBreath, 0, 0, 0, 0);
        doNext(SoulforceCheats);
    }
    public function belisatest2() : Void
    {
        BelisaFollower.BelisaConfessed = true;
        doNext(SoulforceCheats);
    }
    public function belisatest3() : Void
    {
        if (BelisaFollower.BelisaEncounternum >= 1)
        {
            SceneLib.belisa.subsequentEncounters();
        }
        else
        {
            SceneLib.belisa.firstEncounter();
        }
    }
    public function cheatFixShards() : Void
    //wrapper for fixShards to use it in cheat menu
    {
        
        clearOutput();
        fixShards();
        doNext(SoulforceCheats);
    }
    public function giveNekoItems() : Void
    {
        outputText("\n\n<b>(Gained " + weapons.CATGLOV.longName + "!)</b>\n\n");
        outputText("\n\n<b>(Gained " + shields.NEKONOM.longName + "!)</b>\n\n");
        outputText("\n\n<b>(Gained " + armors.FCLOAK.longName + "!)</b>\n\n");
        outputText("\n\n<b>(Gained " + undergarments.BN_TOP.longName + "!)</b>\n\n");
        outputText("\n\n<b>(Gained " + undergarments.BN_SKIRT.longName + "!)</b>\n\n");
        outputText("\n\n<b>(Gained " + necklaces.CATBELL.longName + "!)</b>\n\n");
        inventory.takeItem(weapons.CATGLOV, curry(NonEquipmentMenu, 2));
        inventory.takeItem(shields.NEKONOM, curry(NonEquipmentMenu, 2));
        inventory.takeItem(armors.FCLOAK, curry(NonEquipmentMenu, 2));
        inventory.takeItem(undergarments.BN_TOP, curry(NonEquipmentMenu, 2));
        inventory.takeItem(undergarments.BN_SKIRT, curry(NonEquipmentMenu, 2));
        inventory.takeItem(necklaces.CATBELL, curry(NonEquipmentMenu, 2));
    }
    public function dantianPhylacteryTest() : Void
    {
        if (player.hasPerk(PerkLib.DantianPhylactery))
        {
            player.removePerk(PerkLib.DantianPhylactery);
        }
        else
        {
            player.createPerk(PerkLib.DantianPhylactery, 0, 0, 0, 0);
        }
        doNext(SoulforceCheats);
    }
    public function fixShards() : Void
    {
        var cnt : Int = 0;
        player.removeKeyItem("Radiant shard");
        outputText("Received shards for: ");
        if (flags[kFLAGS.AYANE_FOLLOWER] == 2)
        {
            ++cnt;
            outputText("\nP.Ayane");
        }
        if (flags[kFLAGS.AMILY_FOLLOWER] == 1)
        {
            ++cnt;
            outputText("\nP.Amily");
        }
        if (flags[kFLAGS.AMILY_FOLLOWER] == 2)
        {
            ++cnt;
            outputText("\nC.Amily");
        }
        if (DivaScene.instance.status == -1)
        {
            ++cnt;
            outputText("\nDiva");
        }
        if (flags[kFLAGS.ELECTRA_FOLLOWER] == 2)
        {
            ++cnt;
            outputText("\nElectra");
        }
        if (flags[kFLAGS.ETNA_FOLLOWER] == 2)
        {
            ++cnt;
            outputText("\nEtna");
        }
        if (flags[kFLAGS.KIHA_FOLLOWER] == 1)
        {
            ++cnt;
            outputText("\nKiha");
        }
        if (flags[kFLAGS.CERAPH_FOLLOWER_PIERCING] == 1 || flags[kFLAGS.CERAPH_FOLLOWER_CARRY] == 1)
        {
            ++cnt;
            outputText("\nCeraph");
        }
        if (flags[kFLAGS.VAPULA_FOLLOWER] == 1)
        {
            ++cnt;
            outputText("\nVapula");
        }
        if (cnt != 0)
        {
            outputText("\nReceived " + cnt + " shards.");
            cheatAddShard(cnt);
        }
        else
        {
            outputText("\nNo shards, go complete quests :(");
        }
    }
    public function fixShards2nd() : Void
    {
        var cnt2 : Int = 0;
        outputText("Received shards for: ");
        if (flags[kFLAGS.ARIAN_FOLLOWER] == 1)
        {
            ++cnt2;
            outputText("\nArian");
        }
        if (BelisaFollower.BelisaInCamp)
        {
            ++cnt2;
            outputText("\nBelisa");
        }
        if (flags[kFLAGS.CEANI_FOLLOWER] > 0)
        {
            ++cnt2;
            outputText("\nCeani");
        }
        if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5)
        {
            ++cnt2;
            outputText("\nChi Chi");
        }
        if (flags[kFLAGS.NADIA_FOLLOWER] >= 6)
        {
            ++cnt2;
            outputText("\nNadia");
        }
        if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1)
        {
            ++cnt2;
            outputText("\nIzma");
        }
        if (LilyFollower.LilyFollowerState)
        {
            ++cnt2;
            outputText("\nLily");
        }
        if (player.hasStatusEffect(StatusEffects.CampMarble))
        {
            ++cnt2;
            outputText("\nMarble");
        }
        if (flags[kFLAGS.ANT_WAIFU] > 0)
        {
            ++cnt2;
            outputText("\nPhylla");
        }
        if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9)
        {
            ++cnt2;
            outputText("\nSamirah");
        }
        if (TyrantiaFollower.isLover())
        {
            ++cnt2;
            outputText("\nTyrantia");
        }
        if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 5)
        {
            ++cnt2;
            outputText("\nPatchouli");
        }
        if (flags[kFLAGS.AURORA_LVL] >= 1)
        {
            ++cnt2;
            outputText("\nAurora");
        }
        if (flags[kFLAGS.DINAH_LVL_UP] >= 1)
        {
            ++cnt2;
            outputText("\nDinah");
        }
        if (flags[kFLAGS.EMBER_HATCHED] > 0)
        {
            ++cnt2;
            outputText("\nEmber");
        }
        if (EvangelineFollower.EvangelineFollowerStage >= 1)
        {
            ++cnt2;
            outputText("\nEvangeline");
        }
        if (flags[kFLAGS.LUNA_FOLLOWER] >= 4)
        {
            ++cnt2;
            outputText("\nLuna");
        }
        if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1)
        {
            ++cnt2;
            outputText("\nKindra");
        }
        if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2)
        {
            ++cnt2;
            outputText("\nKonstantin");
        }
        if (flags[kFLAGS.MICHIKO_FOLLOWER] >= 1)
        {
            ++cnt2;
            outputText("\nMichiko");
        }
        if (flags[kFLAGS.SIDONIE_FOLLOWER] >= 1)
        {
            ++cnt2;
            outputText("\nSidonie");
        }
        if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3)
        {
            ++cnt2;
            outputText("\nSiegweird");
        }
        if (cnt2 != 0)
        {
            outputText("\nReceived " + cnt2 + " shards.");
            if (player.hasKeyItem("Radiant shard") >= 0)
            {
                player.addKeyValue("Radiant shard", 1, cnt2);
            }
            else
            {
                player.createKeyItem("Radiant shard", cnt2, 0, 0, 0);
            }
            outputText("\n\n<b>You currently have " + player.keyItemvX("Radiant shard", 1) + " radiant shards.</b>");
        }
        else
        {
            outputText("\nNo shards, go complete quests :(");
        }
    }
    public function cheatRemoveRP() : Void
    {
        clearOutput();
        if (player.removePerk(PerkLib.RacialParagon))
        {
            ++player.perkPoints;
            outputText("Done!");
        }
        else
        {
            outputText("No such perk.");
        }
        doNext(camp.doCamp);
    }
    public function cheatRemoveShard() : Void
    {
        if (player.keyItemvX("Radiant shard", 1) == 1)
        {
            player.removeKeyItem("Radiant shard");
        }
        else
        {
            player.addKeyValue("Radiant shard", 1, -1);
        }
        outputText("\n\n<b>You currently have " + player.keyItemvX("Radiant shard", 1) + " radiant shards.</b>");
        doNext(SoulforceCheats);
    }
    public function cheatAddShard(cnt : Int = 1) : Void
    {
        if (player.hasKeyItem("Radiant shard") >= 0)
        {
            player.addKeyValue("Radiant shard", 1, cnt);
        }
        else
        {
            player.createKeyItem("Radiant shard", cnt, 0, 0, 0);
        }
        outputText("\n\n<b>You currently have " + player.keyItemvX("Radiant shard", 1) + " radiant shards.</b>");
        doNext(SoulforceCheats);
    }
    private function jiangshiBuggedItemsCleanUpCrew0() : Void
    {
        if (!player.weapon.isNothing)
        {
            if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2)
            {
                flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
                player.unequipWeapon(false, true);
                jiangshiBuggedItemsCleanUpCrew1();
            }
            else
            {
                inventory.takeItem(player.unequipWeapon(false, true), jiangshiBuggedItemsCleanUpCrew1);
            }
        }
        else
        {
            doNext(jiangshiBuggedItemsCleanUpCrew1);
        }
    }
    private function jiangshiBuggedItemsCleanUpCrew1() : Void
    {
        if (!player.weaponRange.isNothing)
        {
            inventory.takeItem(player.unequipWeaponRange(false, true), jiangshiBuggedItemsCleanUpCrew2);
        }
        else
        {
            doNext(jiangshiBuggedItemsCleanUpCrew2);
        }
    }
    private function jiangshiBuggedItemsCleanUpCrew2() : Void
    {
        if (!player.shield.isNothing)
        {
            if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2)
            {
                flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
                player.unequipShield(false, true);
                jiangshiBuggedItemsCleanUpCrew3();
            }
            else
            {
                inventory.takeItem(player.unequipShield(false, true), jiangshiBuggedItemsCleanUpCrew3);
            }
        }
        else
        {
            doNext(jiangshiBuggedItemsCleanUpCrew3);
        }
    }
    private function jiangshiBuggedItemsCleanUpCrew3() : Void
    {
        if (!player.armor.isNothing)
        {
            inventory.takeItem(player.setArmor(armors.TRADITC, false, true), jiangshiBuggedItemsCleanUpCrew4);
        }
        else
        {
            doNext(jiangshiBuggedItemsCleanUpCrew4);
        }
    }
    private function jiangshiBuggedItemsCleanUpCrew4() : Void
    {
        if (!player.lowerGarment.isNothing)
        {
            inventory.takeItem(player.unequipUnderBottom(false, true), jiangshiBuggedItemsCleanUpCrew5);
        }
        else
        {
            doNext(jiangshiBuggedItemsCleanUpCrew5);
        }
    }
    private function jiangshiBuggedItemsCleanUpCrew5() : Void
    {
        if (!player.upperGarment.isNothing)
        {
            inventory.takeItem(player.unequipUnderTop(false, true), jiangshiBuggedItemsCleanUpCrew6);
        }
        else
        {
            doNext(jiangshiBuggedItemsCleanUpCrew6);
        }
    }
    private function jiangshiBuggedItemsCleanUpCrew6() : Void
    {
        if (!player.headJewelry.isNothing)
        {
            flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] = player.headJewelry.id;
        }
        player.setHeadJewelry(headjewelries.JIANGCT, false, true);
        player.statStore.replaceBuffObject({
                    str.mult : 0.2,
                    tou.mult : 0.2,
                    lib.mult : 0.2,
                    sens : 80
                }, "Jiangshi Curse Tag", {
                    text : "Jiangshi Curse Tag"
                });
        doNext(SoulforceCheats);
    }
    public function golemArmy() : Void
    {
        outputText("\n\nFix completed");
        if (player.hasPerk(PerkLib.GolemArmyLieutenant) && !player.hasPerk(PerkLib.GolemArmyJuniorLieutenant))
        {
            if (player.hasPerk(PerkLib.GolemArmyLieutenant))
            {
                player.removePerk(PerkLib.GolemArmyLieutenant);
                player.createPerk(PerkLib.GolemArmyJuniorLieutenant, 0, 0, 0, 0);
            }
            if (player.hasPerk(PerkLib.GolemArmyCaptain))
            {
                player.removePerk(PerkLib.GolemArmyCaptain);
                player.createPerk(PerkLib.GolemArmyLieutenant, 0, 0, 0, 0);
            }
            if (player.hasPerk(PerkLib.GolemArmyMajor))
            {
                player.removePerk(PerkLib.GolemArmyMajor);
                player.createPerk(PerkLib.GolemArmyCaptain, 0, 0, 0, 0);
            }
            if (player.hasPerk(PerkLib.GolemArmyColonel))
            {
                player.removePerk(PerkLib.GolemArmyColonel);
                player.createPerk(PerkLib.GolemArmyMajor, 0, 0, 0, 0);
            }
            if (player.hasPerk(PerkLib.GolemArmyGeneral))
            {
                player.removePerk(PerkLib.GolemArmyGeneral);
                player.createPerk(PerkLib.GolemArmyLieutenantColonel, 0, 0, 0, 0);
            }
        }
        if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation01))
        {
            if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX))
            {
                player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1, 1);
            }
            else
            {
                player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 1, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionAdditionalOrganMutation01);
        }
        if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation02))
        {
            if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX))
            {
                player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1, 2);
            }
            else
            {
                player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 2, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionAdditionalOrganMutation02);
        }
        if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation03))
        {
            if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX))
            {
                player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1, 3);
            }
            else
            {
                player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 3, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionAdditionalOrganMutation03);
        }
        if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation04))
        {
            if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX))
            {
                player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1, 4);
            }
            else
            {
                player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 4, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionAdditionalOrganMutation04);
        }
        if (player.hasPerk(PerkLib.AscensionBuildingPrestige01))
        {
            if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX))
            {
                player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 1);
            }
            else
            {
                player.createPerk(PerkLib.AscensionBuildingPrestigeX, 1, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionBuildingPrestige01);
        }
        if (player.hasPerk(PerkLib.AscensionBuildingPrestige02))
        {
            if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX))
            {
                player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 2);
            }
            else
            {
                player.createPerk(PerkLib.AscensionBuildingPrestigeX, 2, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionBuildingPrestige02);
        }
        if (player.hasPerk(PerkLib.AscensionBuildingPrestige03))
        {
            if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX))
            {
                player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 3);
            }
            else
            {
                player.createPerk(PerkLib.AscensionBuildingPrestigeX, 3, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionBuildingPrestige03);
        }
        if (player.hasPerk(PerkLib.AscensionBuildingPrestige04))
        {
            if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX))
            {
                player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 4);
            }
            else
            {
                player.createPerk(PerkLib.AscensionBuildingPrestigeX, 4, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionBuildingPrestige04);
        }
        if (player.hasPerk(PerkLib.AscensionBuildingPrestige05))
        {
            if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX))
            {
                player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 5);
            }
            else
            {
                player.createPerk(PerkLib.AscensionBuildingPrestigeX, 5, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionBuildingPrestige05);
        }
        if (player.hasPerk(PerkLib.AscensionBuildingPrestige06))
        {
            if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX))
            {
                player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 6);
            }
            else
            {
                player.createPerk(PerkLib.AscensionBuildingPrestigeX, 6, 0, 0, 1);
            }
            player.removePerk(PerkLib.AscensionBuildingPrestige06);
        }
        if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 0)
        {
            flags[kFLAGS.CHRISTMAS_TREE_LEVEL]++;
        }
        doNext(SoulforceCheats);
    }
    public function fixClones() : Void
    {
        if (camp.gcc(true))
        {
            player.removeStatusEffect(StatusEffects.PCClone);
        }
        if (player.hasStatusEffect(StatusEffects.NegativeLevel))
        {
            player.removeStatusEffect(StatusEffects.NegativeLevel);
        }
        if (player.negativeLevel > 0)
        {
            player.negativeLevel = 0;
        }
        if (player.hasStatusEffect(StatusEffects.PCClone1st))
        {
            player.removeStatusEffect(StatusEffects.PCClone1st);
        }
        if (player.hasStatusEffect(StatusEffects.PCClone2nd))
        {
            player.removeStatusEffect(StatusEffects.PCClone2nd);
        }
        if (player.hasStatusEffect(StatusEffects.PCClone3rd))
        {
            player.removeStatusEffect(StatusEffects.PCClone3rd);
        }
        if (player.hasStatusEffect(StatusEffects.PCClone4th))
        {
            player.removeStatusEffect(StatusEffects.PCClone4th);
        }
    }
    public function hiddenPJ() : Void
    {
        outputText("\n\nA11 th4t H1dd3n Prestige is Y0urs to T4ke!!!");
        if (!player.hasPerk(PerkLib.PrestigeJobArcaneArcher))
        {
            player.createPerk(PerkLib.PrestigeJobArcaneArcher, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobArchpriest))
        {
            player.createPerk(PerkLib.PrestigeJobArchpriest, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobBard))
        {
            player.createPerk(PerkLib.PrestigeJobBard, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobBerserker))
        {
            player.createPerk(PerkLib.PrestigeJobBerserker, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobDruid))
        {
            player.createPerk(PerkLib.PrestigeJobDruid, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobNecromancer))
        {
            player.createPerk(PerkLib.PrestigeJobNecromancer, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobSentinel))
        {
            player.createPerk(PerkLib.PrestigeJobSentinel, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobSoulArtMaster))
        {
            player.createPerk(PerkLib.PrestigeJobSoulArtMaster, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobSpellKnight))
        {
            player.createPerk(PerkLib.PrestigeJobSpellKnight, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobStalker))
        {
            player.createPerk(PerkLib.PrestigeJobStalker, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobTempest))
        {
            player.createPerk(PerkLib.PrestigeJobTempest, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobWarlock))
        {
            player.createPerk(PerkLib.PrestigeJobWarlock, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.HiddenJobAsura))
        {
            player.createPerk(PerkLib.HiddenJobAsura, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.HiddenJobBloodDemon))
        {
            player.createPerk(PerkLib.HiddenJobBloodDemon, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.PrestigeJobGreySage))
        {
            player.createPerk(PerkLib.PrestigeJobGreySage, 0, 0, 0, 0);
        }
        if (!player.hasPerk(PerkLib.HiddenJobSwordImmortal))
        {
            player.createPerk(PerkLib.HiddenJobSwordImmortal, 0, 0, 0, 0);
        }
        doNext(SoulforceCheats);
    }
    public function learnHexes() : Void
    {
        if (!player.hasPerk(PerkLib.JobSorcerer))
        {
            player.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
        }
        player.createPerk(PerkLib.PrestigeJobWarlock, 0, 0, 0, 0);
        player.createPerk(PerkLib.HexKnowledge, 0, 0, 0, 0);
        player.createPerk(PerkLib.DarkRitual, 0, 0, 0, 0);
        player.createStatusEffect(StatusEffects.KnowsConsumingDarkness, 0, 0, 0, 0);
        player.createStatusEffect(StatusEffects.KnowsCurseOfDesire, 0, 0, 0, 0);
        player.createStatusEffect(StatusEffects.KnowsCurseOfWeeping, 0, 0, 0, 0);
        player.createStatusEffect(StatusEffects.KnowsLifeSiphon, 0, 0, 0, 0);
        player.createStatusEffect(StatusEffects.KnowsLifetap, 0, 0, 0, 0);
        doNext(SoulforceCheats);
    }
    public function instaHouse() : Void
    {
        flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
        flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] = 1;
        doNext(SoulforceCheats);
    }
    public function AddMaxBackpack2() : Void
    {
        if (AdventurerGuild.playerGuildLevel > AdventurerGuild.RANK_COPPER && AdventurerGuild.lootBag.SlotCaps[0] < 10)
        {
            AdventurerGuild.unlockSlotsForRank(AdventurerGuild.RANK_IRON, 10);
        }
        if (AdventurerGuild.playerGuildLevel > AdventurerGuild.RANK_COPPER && AdventurerGuild.lootBag.SlotCaps[2] < 10)
        {
            AdventurerGuild.unlockSlotsForRank(AdventurerGuild.RANK_COPPER, 10);
            AdventurerGuild.unlockSlotsForRank(AdventurerGuild.RANK_IRON, 10);
        }
        doNext(SoulforceCheats);
    }
    public function AddMaxBackpack3() : Void
    {
        player.createStatusEffect(StatusEffects.ZenjiZList, 0, 0, 0, 0);
        doNext(SoulforceCheats);
    }
    public function wendigoTrigger() : Void
    {
        if (player.hasStatusEffect(StatusEffects.WendigoPsychosis))
        {
            SceneLib.glacialRift.wendigoScene.becomeWendigo();
        }
        else
        {
            outputText("Get a Life... i mean Wendigo Psychosis...");
            doNext(SoulforceCheats);
        }
    }
    public function AddMaxBackpack5() : Void
    {
        if (flags[kFLAGS.EVANGELINE_LVL_UP] > 0)
        {
            flags[kFLAGS.EVANGELINE_LVL_UP] = 0;
        }
        if (flags[kFLAGS.EVANGELINE_DEFEATS_COUNTER] > 0)
        {
            flags[kFLAGS.EVANGELINE_DEFEATS_COUNTER] = 0;
        }
        if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] > 0)
        {
            flags[kFLAGS.EVANGELINE_SPELLS_CASTED] = 0;
        }
        if (flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] > 0)
        {
            flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 0;
        }
        if (flags[kFLAGS.EVANGELINE_02330] > 0)
        {
            flags[kFLAGS.EVANGELINE_02330] = 0;
        }
        if (flags[kFLAGS.EVANGELINE_02331] > 0)
        {
            flags[kFLAGS.EVANGELINE_02331] = 0;
        }
        if (flags[kFLAGS.EVANGELINE_02332] > 0)
        {
            flags[kFLAGS.EVANGELINE_02332] = 0;
        }
        if (flags[kFLAGS.EVANGELINE_02333] > 0)
        {
            flags[kFLAGS.EVANGELINE_02333] = 0;
        }
        outputText("Rewind Evangeline ^^");
        doNext(SoulforceCheats);
    }
    public function TestDynamicStats() : Void
    {
        player.statStore.addBuff("sens", +10, "tag", {
                    text : "Debug buff!",
                    rate : Buff.RATE_HOURS,
                    tick : 1
                });
        statScreenRefresh();
        trace("Stop for debugging");
        doNext(SoulforceCheats);
    }
    public function FightAria() : Void
    {
        clearOutput();
        outputText("Entering battle with Melkie! Enjoy ^^");
        startCombat(new Aria());
    }
    public function FightLethice() : Void
    {
        clearOutput();
        outputText("Entering battle with Lethice! Enjoy ^^");
        startCombat(new Lethice());
    }
    public function FightGalia() : Void
    {
        clearOutput();
        outputText("Entering battle with Galia! Enjoy ^^");
        startCombat(new Galia());
    }
    public function FightChaosChimera() : Void
    {
        clearOutput();
        outputText("Entering battle with Chaos Chimera! Enjoy ^^");
        startCombat(new ChaosChimera());
    }
    public function ChimeraBodyUltimateStage() : Void
    {
        if (player.hasPerk(PerkLib.ChimericalBodyUltimateStage))
        {
            player.removePerk(PerkLib.ChimericalBodyUltimateStage);
            outputText("\n\n<b>(Lost Perk: Chimerical Body: Ultimate Stage!)</b>");
        }
        else
        {
            player.createPerk(PerkLib.ChimericalBodyUltimateStage, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Chimerical Body: Ultimate Stage!)</b>");
        }
        doNext(SoulforceCheats);
    }
    public function AllMetamorphOptionsUnlock() : Void
    {
        for (raceMem/* AS3HX WARNING could not determine type for var: raceMem exp: EField(EIdent(RaceMem),Memories) type: null */ in RaceMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[raceMem.id] = true;
        }
        for (hairMem/* AS3HX WARNING could not determine type for var: hairMem exp: EField(EIdent(HairMem),Memories) type: null */ in HairMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[hairMem.id] = true;
        }
        for (faceMem/* AS3HX WARNING could not determine type for var: faceMem exp: EField(EIdent(FaceMem),Memories) type: null */ in FaceMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[faceMem.id] = true;
        }
        for (eyesMem/* AS3HX WARNING could not determine type for var: eyesMem exp: EField(EIdent(EyesMem),Memories) type: null */ in EyesMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[eyesMem.id] = true;
        }
        for (earsMem/* AS3HX WARNING could not determine type for var: earsMem exp: EField(EIdent(EarsMem),Memories) type: null */ in EarsMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[earsMem.id] = true;
        }
        for (armsMem/* AS3HX WARNING could not determine type for var: armsMem exp: EField(EIdent(ArmsMem),Memories) type: null */ in ArmsMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[armsMem.id] = true;
        }
        for (hornsMem/* AS3HX WARNING could not determine type for var: hornsMem exp: EField(EIdent(HornsMem),Memories) type: null */ in HornsMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[hornsMem.id] = true;
        }
        for (skinMem/* AS3HX WARNING could not determine type for var: skinMem exp: EField(EIdent(SkinMem),Memories) type: null */ in SkinMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[skinMem.id] = true;
        }
        for (skinPatternMem/* AS3HX WARNING could not determine type for var: skinPatternMem exp: EField(EIdent(SkinPatternMem),Memories) type: null */ in SkinPatternMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[skinPatternMem.id] = true;
        }
        for (tongueMem/* AS3HX WARNING could not determine type for var: tongueMem exp: EField(EIdent(TongueMem),Memories) type: null */ in TongueMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[tongueMem.id] = true;
        }
        for (wingsMem/* AS3HX WARNING could not determine type for var: wingsMem exp: EField(EIdent(WingsMem),Memories) type: null */ in WingsMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[wingsMem.id] = true;
        }
        for (antennaeMem/* AS3HX WARNING could not determine type for var: antennaeMem exp: EField(EIdent(AntennaeMem),Memories) type: null */ in AntennaeMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[antennaeMem.id] = true;
        }
        for (gillsMem/* AS3HX WARNING could not determine type for var: gillsMem exp: EField(EIdent(GillsMem),Memories) type: null */ in GillsMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[gillsMem.id] = true;
        }
        for (rearBodyMem/* AS3HX WARNING could not determine type for var: rearBodyMem exp: EField(EIdent(RearBodyMem),Memories) type: null */ in RearBodyMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[rearBodyMem.id] = true;
        }
        for (lowerBodyMem/* AS3HX WARNING could not determine type for var: lowerBodyMem exp: EField(EIdent(LowerBodyMem),Memories) type: null */ in LowerBodyMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[lowerBodyMem.id] = true;
        }
        for (tailMem/* AS3HX WARNING could not determine type for var: tailMem exp: EField(EIdent(TailMem),Memories) type: null */ in TailMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[tailMem.id] = true;
        }
        for (cockMem/* AS3HX WARNING could not determine type for var: cockMem exp: EField(EIdent(CockMem),Memories) type: null */ in CockMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[cockMem.id] = true;
        }
        for (cockCountMem/* AS3HX WARNING could not determine type for var: cockCountMem exp: EField(EIdent(CockCountMem),Memories) type: null */ in CockCountMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[cockCountMem.id] = true;
        }
        for (vaginaMem/* AS3HX WARNING could not determine type for var: vaginaMem exp: EField(EIdent(VaginaMem),Memories) type: null */ in VaginaMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[vaginaMem.id] = true;
        }
        for (vaginaCountMem/* AS3HX WARNING could not determine type for var: vaginaCountMem exp: EField(EIdent(VaginaCountMem),Memories) type: null */ in VaginaCountMem.Memories)
        
        //Filter out vagina after 1 //TODO:multiVag support? Will this break if 2nd vag unlocked?{
            
            if (vaginaCountMem.id == "One Vagina")
            {
                Metamorph.GeneticMemoryStorage["One Vagina"] = true;
            }
        }
        for (ballsMem/* AS3HX WARNING could not determine type for var: ballsMem exp: EField(EIdent(BallsMem),Memories) type: null */ in BallsMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[ballsMem.id] = true;
        }
        for (breastMem/* AS3HX WARNING could not determine type for var: breastMem exp: EField(EIdent(BreastMem),Memories) type: null */ in BreastMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[breastMem.id] = true;
        }
        for (specialMem/* AS3HX WARNING could not determine type for var: specialMem exp: EField(EIdent(SpecialsMem),Memories) type: null */ in SpecialsMem.Memories)
        {
            Metamorph.GeneticMemoryStorage[specialMem.id] = true;
        }
        Metamorph.GeneticMemoryStorage["Taur Lower Body"] = true;
        clearOutput();
        outputText("All metamorph options unlocked.");
        doNext(SoulforceCheats);
    }
    public function PerkGalore1() : Void
    {
        if (!player.hasPerk(PerkLib.CorruptedKitsune))
        {
            player.createPerk(PerkLib.CorruptedKitsune, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Corrupted Kitsune!)</b>");
        }
        if (!player.hasPerk(PerkLib.CorruptedNinetails))
        {
            player.createPerk(PerkLib.CorruptedNinetails, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Corrupted Ninetails!)</b>");
        }
        if (!player.hasPerk(PerkLib.EnlightenedKitsune))
        {
            player.createPerk(PerkLib.EnlightenedKitsune, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Enlightened Kitsune!)</b>");
        }
        if (!player.hasPerk(PerkLib.EnlightenedNinetails))
        {
            player.createPerk(PerkLib.EnlightenedNinetails, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Enlightened Ninetails!)</b>");
        }
        if (!player.hasPerk(PerkLib.FerasBoonAlpha))
        {
            player.createPerk(PerkLib.FerasBoonAlpha, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Feras Boon Alpha!)</b>");
        }
        if (!player.hasPerk(PerkLib.FerasBoonBreedingBitch))
        {
            player.createPerk(PerkLib.FerasBoonBreedingBitch, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Feras Boon Breeding Bitch!)</b>");
        }
        if (!player.hasPerk(PerkLib.FerasBoonMilkingTwat))
        {
            player.createPerk(PerkLib.FerasBoonMilkingTwat, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Feras Boon Milking Twat!)</b>");
        }
        if (!player.hasPerk(PerkLib.FerasBoonSeeder))
        {
            player.createPerk(PerkLib.FerasBoonSeeder, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Feras Boon Seeder!)</b>");
        }
        if (!player.hasPerk(PerkLib.FireLord))
        {
            player.createPerk(PerkLib.FireLord, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: FireLord!)</b>");
        }
        if (!player.hasPerk(PerkLib.Hellfire))
        {
            player.createPerk(PerkLib.Hellfire, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Hellfire!)</b>");
        }
        if (!player.hasPerk(PerkLib.MagicalFertility))
        {
            player.createPerk(PerkLib.MagicalFertility, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Magical Fertility!)</b>");
        }
        if (!player.hasPerk(PerkLib.MagicalVirility))
        {
            player.createPerk(PerkLib.MagicalVirility, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Magical Virility!)</b>");
        }
        if (!player.hasPerk(PerkLib.MaraesGiftButtslut))
        {
            player.createPerk(PerkLib.MaraesGiftButtslut, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Maraes Gift Buttslut!)</b>");
        }
        if (!player.hasPerk(PerkLib.MaraesGiftFertility))
        {
            player.createPerk(PerkLib.MaraesGiftFertility, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Maraes Gift Fertility!)</b>");
        }
        if (!player.hasPerk(PerkLib.MaraesGiftProfractory))
        {
            player.createPerk(PerkLib.MaraesGiftProfractory, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Maraes Gift Profractory!)</b>");
        }
        if (!player.hasPerk(PerkLib.MaraesGiftStud))
        {
            player.createPerk(PerkLib.MaraesGiftStud, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Maraes Gift Stud!)</b>");
        }
        if (!player.hasPerk(PerkLib.NinetailsKitsuneOfBalance))
        {
            player.createPerk(PerkLib.NinetailsKitsuneOfBalance, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: 9T Kitsune Of Balance!)</b>");
        }
        if (!player.hasPerk(PerkLib.MilkMaid))
        {
            player.createPerk(PerkLib.MilkMaid, 1, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: MilkMaid!)</b>");
        }
        if (!player.hasPerk(PerkLib.OneTrackMind))
        {
            player.createPerk(PerkLib.OneTrackMind, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: One Track Mind!)</b>");
        }
        if (!player.hasPerk(PerkLib.PureAndLoving))
        {
            player.createPerk(PerkLib.PureAndLoving, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Pure And Loving!)</b>");
        }
        if (!player.hasPerk(PerkLib.PurityBlessing))
        {
            player.createPerk(PerkLib.PurityBlessing, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Purity Blessing!)</b>");
        }
        if (!player.hasPerk(PerkLib.SensualLover))
        {
            player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Sensual Lover!)</b>");
        }
        if (!player.hasPerk(PerkLib.ThickSkin))
        {
            player.createPerk(PerkLib.ThickSkin, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Thick Skin!)</b>");
        }
        if (player.hasPerk(PerkLib.Perfection) && !player.hasPerk(PerkLib.Creationism))
        {
            player.createPerk(PerkLib.Creationism, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Creationism!)</b>");
        }
        if (player.hasPerk(PerkLib.SoulPowered) && !player.hasPerk(PerkLib.AllSeeing))
        {
            player.createPerk(PerkLib.AllSeeing, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: All-Seeing!)</b>");
        }
        if (player.hasPerk(PerkLib.SoulOfSteel) && !player.hasPerk(PerkLib.GodOfSteel))
        {
            player.createPerk(PerkLib.GodOfSteel, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: God of Steel!)</b>");
        }
        if (player.hasPerk(PerkLib.BlessedByLadyGodiva) && !player.hasPerk(PerkLib.LadyGodivasFavoriteChild))
        {
            player.createPerk(PerkLib.LadyGodivasFavoriteChild, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Lady Godiva's favorite Child!)</b>");
        }
        if (player.hasPerk(PerkLib.Surgeon) && !player.hasPerk(PerkLib.Medic))
        {
            player.createPerk(PerkLib.Medic, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: MEDIC!!!!)</b>");
        }
        if (player.hasPerk(PerkLib.Cardinal) && !player.hasPerk(PerkLib.Pope))
        {
            player.createPerk(PerkLib.Pope, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Pope!)</b>");
        }
        if (player.hasPerk(PerkLib.President) && !player.hasPerk(PerkLib.Nerd))
        {
            player.createPerk(PerkLib.Nerd, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: NERD!!!!)</b>");
        }
        if (player.hasPerk(PerkLib.SpysEnemy) && !player.hasPerk(PerkLib.ShitYouTouchedSasha))
        {
            player.createPerk(PerkLib.ShitYouTouchedSasha, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: SHIT YOU TOUCHED SASHA!!!)</b>");
        }
        if (player.hasPerk(PerkLib.ZZZ) && !player.hasPerk(PerkLib.Lazy))
        {
            player.createPerk(PerkLib.Lazy, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: LAZY!!!!)</b>");
        }  /*if (player.hasPerk(PerkLib.) && !player.hasPerk(PerkLib.)) {
			player.createPerk(PerkLib., 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: !)</b>");
		}*/  
        if (player.hasPerk(PerkLib.PartyBoyGirl) && !player.hasPerk(PerkLib.MattressActressActor))
        {
            player.createPerk(PerkLib.MattressActressActor, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Mattress Actress/Actor!)</b>");
        }
        if (player.hasPerk(PerkLib.Weap0n) && !player.hasPerk(PerkLib.Arm0r))
        {
            player.createPerk(PerkLib.Arm0r, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Armor!)</b>");
        }
        if (player.hasPerk(PerkLib.Fellowship) && !player.hasPerk(PerkLib.Alliance))
        {
            player.createPerk(PerkLib.Alliance, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Alliance!)</b>");
        }
        if (player.hasPerk(PerkLib.SexChampion) && !player.hasPerk(PerkLib.SexDeity))
        {
            player.createPerk(PerkLib.SexDeity, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Sex Deity!)</b>");
        }
        if (flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] == 0)
        {
            flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] = date.fullYear;
        }
        doNext(SoulforceCheats);
    }
    public function PerkGalore2() : Void
    {
        if (!player.hasPerk(PerkLib.PrestigeJobSeer))
        {
            player.createPerk(PerkLib.PrestigeJobSeer, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Prestige Job: Seer!)</b>");
        }
        if (!player.hasPerk(PerkLib.PrestigeJobSoulArcher))
        {
            player.createPerk(PerkLib.PrestigeJobSoulArcher, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Prestige Job: Soul Archer!)</b>");
        }
        if (!player.hasPerk(PerkLib.PiercedCrimstone))
        {
            player.createPerk(PerkLib.PiercedCrimstone, 5, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Pierced: Crimstone!)</b>");
        }
        if (!player.hasPerk(PerkLib.PiercedFertite))
        {
            player.createPerk(PerkLib.PiercedFertite, 5, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Pierced: Fertite!)</b>");
        }
        if (!player.hasPerk(PerkLib.PiercedFurrite))
        {
            player.createPerk(PerkLib.PiercedFurrite, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Pierced: Furrite!)</b>");
        }
        if (!player.hasPerk(PerkLib.PiercedLethite))
        {
            player.createPerk(PerkLib.PiercedLethite, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Pierced: Lethite!)</b>");
        }
        if (!player.hasPerk(PerkLib.BroodMother))
        {
            player.createPerk(PerkLib.BroodMother, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Brood Mother!)</b>");
        }
        if (!player.hasPerk(PerkLib.Androgyny))
        {
            player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Androgyny!)</b>");
        }
        if (!player.hasPerk(PerkLib.BasiliskWomb))
        {
            player.createPerk(PerkLib.BasiliskWomb, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Basilisk Womb!)</b>");
        }
        if (!player.hasPerk(PerkLib.BunnyEggs))
        {
            player.createPerk(PerkLib.BunnyEggs, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Bunny Eggs!)</b>");
        }
        if (!player.hasPerk(PerkLib.DeityJobMunchkin))
        {
            player.createPerk(PerkLib.DeityJobMunchkin, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Deity Job: Munchkin!)</b>");
        }
        if (!player.hasPerk(PerkLib.Diapause))
        {
            player.createPerk(PerkLib.Diapause, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Diapause!)</b>");
        }
        if (!player.hasPerk(PerkLib.Feeder))
        {
            player.createPerk(PerkLib.Feeder, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Feeder!)</b>");
        }
        if (!player.hasPerk(PerkLib.HarpyWomb))
        {
            player.createPerk(PerkLib.HarpyWomb, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Harpy Womb!)</b>");
        }
        if (!player.hasPerk(PerkLib.ImprovedVenomGland))
        {
            player.createPerk(PerkLib.ImprovedVenomGland, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Improved Venom Gland!)</b>");
        }
        if (!player.hasPerk(PerkLib.MinotaurCumResistance))
        {
            player.createPerk(PerkLib.MinotaurCumResistance, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Minotaur Cum Resistance!)</b>");
        }
        if (!player.hasPerk(PerkLib.BasiliskResistance))
        {
            player.createPerk(PerkLib.BasiliskResistance, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Basilisk Resistance!)</b>");
        }
        if (!player.hasPerk(PerkLib.Cornucopia))
        {
            player.createPerk(PerkLib.Cornucopia, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Cornucopia!)</b>");
        }
        if (!player.hasPerk(PerkLib.DemonicLethicite))
        {
            player.createPerk(PerkLib.DemonicLethicite, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Demonic Lethicite!)</b>");
        }
        if (!player.hasPerk(PerkLib.DemonSlayer))
        {
            player.createPerk(PerkLib.DemonSlayer, 0.1, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Demon Slayer!)</b>");
        }
        if (!player.hasPerk(PerkLib.ElvenBounty))
        {
            player.createPerk(PerkLib.ElvenBounty, 0, 15, 0, 0);
            outputText("\n\n<b>(Gained Perk: Elven Bounty!)</b>");
        }
        if (!player.hasPerk(PerkLib.FeralHunter))
        {
            player.createPerk(PerkLib.FeralHunter, 0.1, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Feral Hunter!)</b>");
        }
        if (!player.hasPerk(PerkLib.MarbleResistant))
        {
            player.createPerk(PerkLib.MarbleResistant, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Marble Resistant!)</b>");
        }
        if (!player.hasPerk(PerkLib.Misdirection))
        {
            player.createPerk(PerkLib.Misdirection, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Misdirection!)</b>");
        }
        if (!player.hasPerk(PerkLib.OmnibusGift))
        {
            player.createPerk(PerkLib.OmnibusGift, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Omnibus Gift!)</b>");
        }
        if (!player.hasPerk(PerkLib.PilgrimsBounty))
        {
            player.createPerk(PerkLib.PilgrimsBounty, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Pilgrims Bounty!)</b>");
        }
        if (!player.hasPerk(PerkLib.ProductivityDrugs))
        {
            player.createPerk(PerkLib.ProductivityDrugs, player.cor, 10, player.lib, 0);
            outputText("\n\n<b>(Gained Perk: Productivity Drugs!)</b>");
        }
        if (!player.hasPerk(PerkLib.SenseCorruption))
        {
            player.createPerk(PerkLib.SenseCorruption, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Sense Corruption!)</b>");
        }
        if (!player.hasPerk(PerkLib.SenseWrath))
        {
            player.createPerk(PerkLib.SenseWrath, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Sense Wrath!)</b>");
        }
        if (!player.hasPerk(PerkLib.Whispered))
        {
            player.createPerk(PerkLib.Whispered, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Whispered!)</b>");
        }
        if (!player.hasPerk(PerkLib.ControlledBreath))
        {
            player.createPerk(PerkLib.ControlledBreath, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Controlled Breath!)</b>");
        }
        if (!player.hasPerk(PerkLib.CleansingPalm))
        {
            player.createPerk(PerkLib.CleansingPalm, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Cleansing Palm!)</b>");
        }
        if (!player.hasPerk(PerkLib.Enlightened))
        {
            player.createPerk(PerkLib.Enlightened, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: Enlightened!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryAlchemist) && !player.hasPerk(PerkLib.PastLifeAlchemist))
        {
            player.createPerk(PerkLib.HistoryAlchemist, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Alchemist!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryCultivator) && !player.hasPerk(PerkLib.PastLifeCultivator))
        {
            player.createPerk(PerkLib.HistoryCultivator, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Cultivator!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryFighter) && !player.hasPerk(PerkLib.PastLifeFighter))
        {
            player.createPerk(PerkLib.HistoryFighter, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Fighter!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryFortune) && !player.hasPerk(PerkLib.PastLifeFortune))
        {
            player.createPerk(PerkLib.HistoryFortune, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Fortune!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryHealer) && !player.hasPerk(PerkLib.PastLifeHealer))
        {
            player.createPerk(PerkLib.HistoryHealer, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Healer!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryReligious) && !player.hasPerk(PerkLib.PastLifeReligious))
        {
            player.createPerk(PerkLib.HistoryReligious, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Religious!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryScholar) && !player.hasPerk(PerkLib.PastLifeScholar))
        {
            player.createPerk(PerkLib.HistoryScholar, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Scholar!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryScout) && !player.hasPerk(PerkLib.PastLifeScout))
        {
            player.createPerk(PerkLib.HistoryScout, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Scout!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistorySlacker) && !player.hasPerk(PerkLib.PastLifeSlacker))
        {
            player.createPerk(PerkLib.HistorySlacker, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Slacker!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistorySlut) && !player.hasPerk(PerkLib.PastLifeSlut))
        {
            player.createPerk(PerkLib.HistorySlut, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Slut!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistorySmith) && !player.hasPerk(PerkLib.PastLifeSmith))
        {
            player.createPerk(PerkLib.HistorySmith, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Smith!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryTactician) && !player.hasPerk(PerkLib.PastLifeTactician))
        {
            player.createPerk(PerkLib.HistoryTactician, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Tactician!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryWhore) && !player.hasPerk(PerkLib.PastLifeWhore))
        {
            player.createPerk(PerkLib.HistoryWhore, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Whore!)</b>");
        }
        if (!player.hasPerk(PerkLib.HistoryFeral) && !player.hasPerk(PerkLib.PastLifeFeral))
        {
            player.createPerk(PerkLib.HistoryFeral, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: History: Feral!)</b>");
        }
        doNext(SoulforceCheats);
    }
    public function StatsAscensionMenu() : Void
    {
        menu();
        addButton(0, "Ascension", StatsAscensionMenu2);
        addButton(5, "Str", StatsMenuCore, "Str").hint("Adj Str.");
        addButton(6, "Tou", StatsMenuCore, "Tou").hint("Adj Tou.");
        addButton(7, "Spe", StatsMenuCore, "Spe").hint("Adj Spe.");
        addButton(8, "Int", StatsMenuCore, "Int").hint("Adj Int.");
        addButton(9, "Wis", StatsMenuCore, "Wis").hint("Adj Wis.");
        addButton(10, "Tone/Thicc/Fem", StatsMenuToneThicknessFeminity).hint("Adj Tone/Thickness/Feminity.");
        addButton(11, "Lib", StatsMenuCore, "Lib").hint("Adj Lib.");
        addButton(12, "Sen", StatsMenuCore, "Sen").hint("Adj Sens.");
        addButton(13, "Cor", StatsMenuCore, "Cor").hint("Adj Cor.");
        addButton(14, "Back", SoulforceCheats);
    }
    public function StatsAscensionMenu2() : Void
    {
        menu();
        addButton(0, "EarlyAscension", EarlyAscension).hint("Allowing to premature ascension.");
        addButton(1, "NG tier ++", IncreaseAscensionCounter).hint("Allowing to increase ascension counter.");
        if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0)
        {
            addButton(2, "NG tier --", DecreaseAscensionCounter).hint("Allowing to decrease ascension counter.");
        }
        addButton(5, "AscenPerks01", AddAscenionPerkPoints, 1).hint("Add 1 ascension perk point for use during ascending to the next NG+ tier.");
        addButton(6, "AscenPerks05", AddAscenionPerkPoints, 5).hint("Add 5 ascension perk points for use during ascending to the next NG+ tier.");
        addButton(7, "AscenPerks10", AddAscenionPerkPoints, 10).hint("Add 10 ascension perk points for use during ascending to the next NG+ tier.");
        addButton(8, "AscenPerks50", AddAscenionPerkPoints, 50).hint("Add 50 ascension perk points for use during ascending to the next NG+ tier.");
        addButton(9, "AscenPerks100", AddAscenionPerkPoints, 100).hint("Add 100 ascension perk points for use during ascending to the next NG+ tier.");
        addButton(14, "Back", StatsAscensionMenu);
    }
    public function modFlagsMenu() : Void
    {
        menu();
        clearOutput();
        outputText("A menu where you can edit some flags that are useful for debugging.");
        outputText("\n\nTotal Times Transformed: " + flags[kFLAGS.TIMES_TRANSFORMED] + "");
        addButton(0, "T Add 1", modStatFlags, "timesTransformed", 1).hint("Add 1 to times transformed");
        addButton(1, "T Add 10", modStatFlags, "timesTransformed", 10).hint("Add 10 to times transformed");
        addButton(5, "T Sub 1", modStatFlags, "timesTransformed", -1).hint("Subtract 1 from times transformed");
        addButton(6, "T Sub 10", modStatFlags, "timesTransformed", -10).hint("Subtract 10 from times transformed");
        addButton(14, "Back", SoulforceCheats);
    }
    public function StatsMenuCore(type : String = "Str") : Void
    {
        menu();
        addButton(0, "Inc +1", ModCoreStats, type, 1).hint("Add 1 to " + type + ".");
        addButton(5, "Dec -1", ModCoreStats, type, -1).hint("Substract 1 from " + type + ".");
        addButton(1, "Inc +10", ModCoreStats, type, 10).hint("Add 10 to " + type + ".");
        addButton(6, "Dec -10", ModCoreStats, type, -10).hint("Substract 10 from " + type + ".");
        if (type != "Tone" || type != "Thicc" || type != "Fem")
        {
            addButton(2, "Inc +50", ModCoreStats, type, 50).hint("Add 50 to " + type + ".");
            addButton(7, "Dec -50", ModCoreStats, type, -50).hint("Substract 50 from " + type + ".");
            addButton(3, "Inc +200", ModCoreStats, type, 200).hint("Add 200 to " + type + ".");
            addButton(8, "Dec -200", ModCoreStats, type, -200).hint("Substract 200 from " + type + ".");
            addButton(4, "Inc +1000", ModCoreStats, type, 1000).hint("Add 1000 to " + type + ".");
            addButton(9, "Dec -1000", ModCoreStats, type, -1000).hint("Substract 1000 from " + type + ".");
        }
        addButton(14, "Back", StatsAscensionMenu);
    }
    
    public function StatsMenuToneThicknessFeminity() : Void
    {
        menu();
        addButton(0, "Tone +1", ModCoreStats, "Tone", 1).hint("Add 1 to Tone.");
        addButton(1, "Tone +10", ModCoreStats, "Tone", 10).hint("Add 10 to Tone.");
        addButton(2, "Tone -1", ModCoreStats, "Tone", -1).hint("Substract 1 from Tone.");
        addButton(3, "Tone -10", ModCoreStats, "Tone", -10).hint("Substract 10 from Tone.");
        addButton(5, "Thicc +1", ModCoreStats, "Thickness", 1).hint("Add 1 to Thicc.");
        addButton(6, "Thicc +10", ModCoreStats, "Thickness", 10).hint("Add 10 to Thicc.");
        addButton(7, "Thicc -1", ModCoreStats, "Thickness", -1).hint("Substract 1 from Thicc.");
        addButton(8, "Thicc -10", ModCoreStats, "Thickness", -10).hint("Substract 10 from Thicc.");
        addButton(10, "Fem +1", ModCoreStats, "Feminity", 1).hint("Add 1 to Feminity.");
        addButton(11, "Fem +10", ModCoreStats, "Feminity", 10).hint("Add 10 to Feminity.");
        addButton(12, "Fem -1", ModCoreStats, "Feminity", -1).hint("Substract 1 from Feminity.");
        addButton(13, "Fem -10", ModCoreStats, "Feminity", -10).hint("Substract 10 from Feminity.");
        addButton(14, "Back", StatsAscensionMenu);
    }
    
    public function PerksGemsEXP() : Void
    {
        statScreenRefresh();
        menu();
        addButton(0, "Add 1 PerkP", perkPointsCheat, 1).hint("Add 1 perk point.");
        addButton(1, "Add 5 PerkP", perkPointsCheat, 5).hint("Add 5 perk points.");
        addButton(2, "Sub 10 PerkP", perkPointsCheat, -10).hint("Substract 10 perk points.");
        addButton(5, "Add Gems 1", addGemsXP, "Gems", 100).hint("Add 100 gems.");
        addButton(6, "Add Gems 2", addGemsXP, "Gems", 1000).hint("Add 1,000 gems.");
        addButton(7, "Add Gems 3", addGemsXP, "Gems", 10000).hint("Add 10,000 gems.");
        addButton(10, "Add EXP 1", addGemsXP, "XP", 100).hint("Add 100 EXP.");
        addButton(11, "Add EXP 2", addGemsXP, "XP", 1000).hint("Add 1,000 EXP.");
        addButton(12, "Add EXP 3", addGemsXP, "XP", 10000).hint("Add 10,000 EXP.");
        addButton(13, "Add EXP 4", addGemsXP, "XP", 100000).hint("Add 100,000 EXP.");
        if (player.hasPerk(PerkLib.SoulAncestor))
        {
            addButton(3, "10-12 St.", Stage10to12SoulPerks).hint("Remove all soul cultivator related perks for stages 10-12 of cultivation to keep save compatibility with public build saves.");
        }
        if (!player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor))
        {
            addButton(8, "Trib Perk", TribulationPerks).hint("Add E class Tribulation survivor perk.");
        }
        addButton(14, "Back", SoulforceCheats);
    }
    public function LevelDeLevel() : Void
    {
        statScreenRefresh();
        menu();
        if (player.level < CoC.instance.levelCap)
        {
            addButton(0, "Add 1 LvL", addsubLvl, "Lvl", 1).hint("Add 1 Level (with stat and perk points).");
        }
        if (player.level < CoC.instance.levelCap - 9)
        {
            addButton(1, "Add 10 LvL's", addsubLvl, "Lvl", 10).hint("Add 10 Levels (with stat and perk points).");
        }
        if (player.level < CoC.instance.levelCap - 19)
        {
            addButton(2, "Add 20 LvL's", addsubLvl, "Lvl", 20).hint("Add 20 Levels (with stat and perk points).");
        }
        if (player.level < CoC.instance.levelCap - 49)
        {
            addButton(3, "Add 50 LvL's", addsubLvl, "Lvl", 50).hint("Add 50 Levels (with stat and perk points).");
        }
        if (player.level < CoC.instance.levelCap - 99)
        {
            addButton(4, "Add 100 LvL's", addsubLvl, "Lvl", 100).hint("Add 100 Levels (with stat and perk points).");
        }
        if (player.level > 0)
        {
            addButton(5, "Sub 1 LvL", addsubLvl, "DLvl", 1).hint("Substract 1 Level (keeping stat and perk points).");
        }
        if (player.level > 9)
        {
            addButton(6, "Sub 10 LvL's", addsubLvl, "DLvl", 10).hint("Substract 10 Levels (keeping stat and perk points).");
        }
        if (player.level > 19)
        {
            addButton(7, "Sub 20 LvL's", addsubLvl, "DLvl", 20).hint("Substract 20 Levels (keeping stat and perk points).");
        }
        if (player.level > 49)
        {
            addButton(8, "Sub 50 LvL's", addsubLvl, "DLvl", 50).hint("Substract 50 Levels (keeping stat and perk points).");
        }
        if (player.level > 99)
        {
            addButton(9, "Sub 100 LvL's", addsubLvl, "DLvl", 100).hint("Substract 100 Levels (keeping stat and perk points).");
        }
        if (player.negativeLevel > 0)
        {
            addButton(10, "-1 Neg LvL (" + player.negativeLevel + ")", function _() : Void
                            {
                                player.negativeLevel -= 1;LevelDeLevel();
                            }).hint("Recover 1 negative level.");
        }
        addButton(14, "Back", SoulforceCheats);
    }
    public function BodyStateMenu() : Void
    {
        menu();
        addButton(0, "Height U1", AddTallness1).hint("Add 2 to Height.");
        addButton(2, "Height D1", SubTallness1).hint("Substract 2 from Height.");
        addButton(1, "Height U2", AddTallness2).hint("Add 12 to Height.");
        addButton(3, "Height D2", SubTallness2).hint("Substract 12 from Height.");
        addButton(4, "Hair L. Up", AddHairLength).hint("Add 2 to Hair Length.");
        addButton(9, "Hair L. Down", SubHairLength).hint("Substract 2 from Hair Length.");
        addButton(5, "Cup Up", AddCupSize).hint("Add 1 to Cup Size.");
        addButton(6, "Cup Down", SubCupSize).hint("Substract 1 from Cup Size.");
        addButton(7, "Cock Up", AddCockLength).hint("Add 1 to Cock Length.");
        addButton(8, "Cock Down", SubCockLength).hint("Substract 1 from Cock Length.");
        addButton(10, "Add Pussy", AddPussy).hint("Add Vagina.");
        addButton(11, "Rem Pussy", RemovePussy).hint("Remove Vagina.");
        addButton(12, "Add C+B", AddCockBalls).hint("Add Cock+Balls.");
        addButton(13, "Rem C+B", RemoveCockBalls).hint("Remove Cock+Balls.");
        addButton(14, "Back", SoulforceCheats);
    }
    public function AddTallness1() : Void
    {
        player.tallness += 2;
        if (player.basetallness >= 132)
        {
            player.tallness = 132;
        }
        BodyStateMenu();
    }
    public function AddTallness2() : Void
    {
        player.tallness += 12;
        if (player.basetallness >= 132)
        {
            player.tallness = 132;
        }
        BodyStateMenu();
    }
    public function AddHairLength() : Void
    {
        player.hairLength += 2;
        BodyStateMenu();
    }
    public function AddCupSize() : Void
    {
        var growth : Int = 1;
        if (player.breastRows[0].breastRating < 2)
        {
            growth++;
        }
        player.growTits(growth, player.breastRows.length, true, 3);
        BodyStateMenu();
    }
    public function AddCockLength() : Void
    {
        outputText("\n\n");
        player.cocks[0].cockLength += 1;
        player.lengthChange(1, 1);
        BodyStateMenu();
    }
    public function AddPussy() : Void
    {
        player.createVagina();
        player.clitLength = .25;
        if (player.fertility <= 5)
        {
            player.fertility = 6;
        }
        BodyStateMenu();
    }
    public function AddCockBalls() : Void
    {
        player.createCock(4);
        if (player.balls <= 1)
        {
            player.balls = 2;
            player.ballSize = 1;
        }
        BodyStateMenu();
    }
    public function SubTallness1() : Void
    {
        player.tallness -= 2;
        if (player.basetallness < 42)
        {
            player.tallness = 42;
        }
        BodyStateMenu();
    }
    public function SubTallness2() : Void
    {
        player.tallness -= 12;
        if (player.basetallness < 42)
        {
            player.tallness = 42;
        }
        BodyStateMenu();
    }
    public function SubHairLength() : Void
    {
        player.hairLength -= 2;
        if (player.hairLength < 0)
        {
            player.hairLength = 0;
        }
        BodyStateMenu();
    }
    public function SubCupSize() : Void
    {
        if (player.breastRows[0].breastRating >= 1)
        {
            player.breastRows[0].breastRating--;
        }
        BodyStateMenu();
    }
    public function SubCockLength() : Void
    {
        var index : Int = 0;
        outputText("\n\n");
        player.cocks[0].cockLength -= 1;
        player.lengthChange(-1, 1);
        if (player.cocks[index].cockLength < 2)
        {
            outputText("  ");
            player.killCocks(1);
        }
        BodyStateMenu();
    }
    public function RemovePussy() : Void
    {
        player.clitLength = .25;
        player.removeVagina(0, 1);
        BodyStateMenu();
    }
    public function RemoveCockBalls() : Void
    {
        player.killCocks(1);
        if (player.balls > 1)
        {
            player.balls = 0;
            player.ballSize = 0;
        }
        BodyStateMenu();
    }
    
    /*if (player.breastRows.length == 0) {
					outputText("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					//player.breastRows[0].breastsPerRow = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 2;
					outputText("\n");
				}
			}*/
    public function FasterOrInstantCampNPCRecruitment() : Void
    {
        menu();
        addButton(0, "E.I.K.", EmberIsabellaKiha).hint("Ember / Isabella / Kiha (If PC have all 3 nothing will happen after choosing this option.)");
        if (flags[kFLAGS.ETNA_FOLLOWER] < 2)
        {
            addButton(1, "Etna", SuccubusishMantioreOnLeash);
        }
        if (flags[kFLAGS.KINDRA_FOLLOWER] < 1)
        {
            addButton(2, "Kindra", KindraMemory5);
        }
        if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 6)
        {
            addButton(3, "Kindra 1UP", Kindra1stLvLUp);
        }
        if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 7)
        {
            addButton(3, "Kindra 2UP", Kindra2ndLvLUp);
        }
        if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 8)
        {
            addButton(3, "Kindra 3UP", Kindra3rdLvLUp);
        }
        if (flags[kFLAGS.KINDRA_LVL_UP] >= 7)
        {
            addButton(4, "Kindra DeLvL", KindraTestDeLvL);
        }
        if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] < 1)
        {
            addButton(5, "Ember 1UP", Ember1stLvLUp);
        }
        if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 1)
        {
            addButton(5, "Ember 2UP", Ember2ndLvLUp);
        }
        if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 2)
        {
            addButton(5, "Ember 3UP", Ember3rdLvLUp);
        }
        if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 3)
        {
            addButton(5, "Ember 4UP", Ember4thLvLUp);
        }
        if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 4)
        {
            addButton(5, "Ember 5UP", Ember5thLvLUp);
        }
        if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 5)
        {
            addButton(5, "Ember 6UP", Ember6thLvLUp);
        }
        if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 6)
        {
            addButton(5, "Ember 7UP", Ember7thLvLUp);
        }
        if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] < 1)
        {
            addButton(6, "Isabella 1UP", Isabella1stLvLUp);
        }
        if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 1)
        {
            addButton(6, "Isabella 2UP", Isabella2ndLvLUp);
        }
        if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 2)
        {
            addButton(6, "Isabella 3UP", Isabella3rdLvLUp);
        }
        if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 3)
        {
            addButton(6, "Isabella 4UP", Isabella4thLvLUp);
        }
        if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 4)
        {
            addButton(6, "Isabella 5UP", Isabella5thLvLUp);
        }
        if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 5)
        {
            addButton(6, "Isabella 6UP", Isabella6thLvLUp);
        }
        if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 6)
        {
            addButton(6, "Isabella 7UP", Isabella7thLvLUp);
        }
        if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] < 1)
        {
            addButton(7, "Kiha 1UP", Kiha1stLvLUp);
        }
        if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 1)
        {
            addButton(7, "Kiha 2UP", Kiha2ndLvLUp);
        }
        if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 2)
        {
            addButton(7, "Kiha 3UP", Kiha3rdLvLUp);
        }
        if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 3)
        {
            addButton(7, "Kiha 4UP", Kiha4thLvLUp);
        }
        if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 4)
        {
            addButton(7, "Kiha 5UP", Kiha5thLvLUp);
        }
        if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 5)
        {
            addButton(7, "Kiha 6UP", Kiha6thLvLUp);
        }
        if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 6)
        {
            addButton(7, "Kiha 7UP", Kiha7thLvLUp);
        }
        if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] < 1)
        {
            addButton(8, "Etna 1UP", Etna1stLvLUp);
        }
        if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 1)
        {
            addButton(8, "Etna 2UP", Etna2ndLvLUp);
        }
        if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 2)
        {
            addButton(8, "Etna 3UP", Etna3rdLvLUp);
        }
        if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 3)
        {
            addButton(8, "Etna 4UP", Etna4thLvLUp);
        }
        if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 4)
        {
            addButton(8, "Etna 5UP", Etna5thLvLUp);
        }
        if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 5)
        {
            addButton(8, "Etna 6UP", Etna6thLvLUp);
        }
        if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 6)
        {
            addButton(8, "Etna 7UP", Etna7thLvLUp);
        }
        if (flags[kFLAGS.EMBER_LVL_UP] >= 1)
        {
            addButton(10, "Ember DeLvL", EmberTestDeLvL);
        }
        if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1)
        {
            addButton(11, "Isabella DeLvL", IsabellaTestDeLvL);
        }
        if (flags[kFLAGS.KIHA_LVL_UP] >= 1)
        {
            addButton(12, "Kiha DeLvL", KihaTestDeLvL);
        }
        if (flags[kFLAGS.ETNA_LVL_UP] >= 1)
        {
            addButton(13, "Etna DeLvL", EtnaTestDeLvL);
        }
        addButton(14, "Back", SoulforceCheats);
    }
    public function EmberIsabellaKiha() : Void
    {
        if (flags[kFLAGS.EMBER_HATCHED] < 1 && flags[kFLAGS.TOOK_EMBER_EGG] < 1)
        {
            InstaEmberEggInCamp();
        }
        if (flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] < 1)
        {
            LilCocksLoverSummoning();
        }
        if (flags[kFLAGS.KIHA_FOLLOWER] < 1)
        {
            ResidentCampDragonishTsundere();
        }
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function InstaEmberEggInCamp() : Void
    {
        player.createKeyItem("Dragon Egg", 0, 0, 0, 0);
        flags[kFLAGS.TOOK_EMBER_EGG] = 1;
        flags[kFLAGS.EMBER_COR] = 50;
        outputText("\n\n<b>Ember Egg put in camp.</b>");
    }
    public function LilCocksLoverSummoning() : Void
    {
        flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS] = 240;
        flags[kFLAGS.ISABELLA_AFFECTION] = 100;
        flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] = 1;
        flags[kFLAGS.ISABELLA_PLAINS_DISABLED] = 1;
        outputText("\n\n<b>I heard you love cows loving small cocks...so here you will get Isabella *wink wink*</b>");
    }
    public function ResidentCampDragonishTsundere() : Void
    {
        flags[kFLAGS.KIHA_AFFECTION_LEVEL] = 2;
        flags[kFLAGS.KIHA_AFFECTION] = 100;
        flags[kFLAGS.KIHA_MOVE_IN_OFFER] = 1;
        flags[kFLAGS.KIHA_FOLLOWER] = 1;
        outputText("\n\n<b>We need more...yandered dragon-like waifu. Or was it only more of Kiha?</b>");
    }
    public function KindraMemory5() : Void
    {
        flags[kFLAGS.KINDRA_LVL_UP] = 6;
        flags[kFLAGS.KINDRA_FOLLOWER] = 1;
        flags[kFLAGS.KINDRA_AFFECTION] = 5;
        outputText("\n\n<b>Kindra... and everything is clear.</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function SuccubusishMantioreOnLeash() : Void
    {
        flags[kFLAGS.ETNA_AFFECTION] = 80;
        flags[kFLAGS.ETNA_FOLLOWER] = 2;
        flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] = 0;
        outputText("\n\n<b>Watch for Etna is in da hous... err camp.</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Ember1stLvLUp() : Void
    {
        flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.EMBER_LVL_UP] = 1;
        outputText("\n\n<b>Ember 1st LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Ember2ndLvLUp() : Void
    {
        flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.EMBER_LVL_UP] = 2;
        outputText("\n\n<b>Ember 2nd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Ember3rdLvLUp() : Void
    {
        flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.EMBER_LVL_UP] = 3;
        outputText("\n\n<b>Ember 3rd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Ember4thLvLUp() : Void
    {
        flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.EMBER_LVL_UP] = 4;
        outputText("\n\n<b>Ember 4th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Ember5thLvLUp() : Void
    {
        flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.EMBER_LVL_UP] = 5;
        outputText("\n\n<b>Ember 5th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Ember6thLvLUp() : Void
    {
        flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.EMBER_LVL_UP] = 6;
        outputText("\n\n<b>Ember 6th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Ember7thLvLUp() : Void
    {
        flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.EMBER_LVL_UP] = 7;
        outputText("\n\n<b>Ember 7th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function EmberTestDeLvL() : Void
    {
        flags[kFLAGS.EMBER_LVL_UP]--;
        outputText("\n\n<b>Ember been De-LvL'd!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Isabella1stLvLUp() : Void
    {
        flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ISABELLA_LVL_UP] = 1;
        outputText("\n\n<b>Isabella 1st LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Isabella2ndLvLUp() : Void
    {
        flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ISABELLA_LVL_UP] = 2;
        outputText("\n\n<b>Isabella 2nd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Isabella3rdLvLUp() : Void
    {
        flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ISABELLA_LVL_UP] = 3;
        outputText("\n\n<b>Isabella 3rd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Isabella4thLvLUp() : Void
    {
        flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ISABELLA_LVL_UP] = 4;
        outputText("\n\n<b>Isabella 4th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Isabella5thLvLUp() : Void
    {
        flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ISABELLA_LVL_UP] = 5;
        outputText("\n\n<b>Isabella 5th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Isabella6thLvLUp() : Void
    {
        flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ISABELLA_LVL_UP] = 6;
        outputText("\n\n<b>Isabella 6th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Isabella7thLvLUp() : Void
    {
        flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ISABELLA_LVL_UP] = 7;
        outputText("\n\n<b>Isabella 7th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function IsabellaTestDeLvL() : Void
    {
        flags[kFLAGS.ISABELLA_LVL_UP]--;
        outputText("\n\n<b>Isabella been De-LvL'd!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kiha1stLvLUp() : Void
    {
        flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KIHA_LVL_UP] = 1;
        outputText("\n\n<b>Kiha 1st LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kiha2ndLvLUp() : Void
    {
        flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KIHA_LVL_UP] = 2;
        outputText("\n\n<b>Kiha 2nd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kiha3rdLvLUp() : Void
    {
        flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KIHA_LVL_UP] = 3;
        outputText("\n\n<b>Kiha 3rd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kiha4thLvLUp() : Void
    {
        flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KIHA_LVL_UP] = 4;
        outputText("\n\n<b>Kiha 4th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kiha5thLvLUp() : Void
    {
        flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KIHA_LVL_UP] = 5;
        outputText("\n\n<b>Kiha 5th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kiha6thLvLUp() : Void
    {
        flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KIHA_LVL_UP] = 6;
        outputText("\n\n<b>Kiha 6th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kiha7thLvLUp() : Void
    {
        flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KIHA_LVL_UP] = 7;
        outputText("\n\n<b>Kiha 7th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function KihaTestDeLvL() : Void
    {
        flags[kFLAGS.KIHA_LVL_UP]--;
        outputText("\n\n<b>Kiha been De-LvL'd!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kindra1stLvLUp() : Void
    {
        flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KINDRA_LVL_UP] = 7;
        outputText("\n\n<b>Kindra 1st LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kindra2ndLvLUp() : Void
    {
        flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KINDRA_LVL_UP] = 8;
        outputText("\n\n<b>Kindra 2nd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Kindra3rdLvLUp() : Void
    {
        flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.KINDRA_LVL_UP] = 9;
        outputText("\n\n<b>Kindra 3rd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function KindraTestDeLvL() : Void
    {
        flags[kFLAGS.KINDRA_LVL_UP]--;
        outputText("\n\n<b>Kindra been De-LvL'd!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Etna1stLvLUp() : Void
    {
        flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ETNA_LVL_UP] = 1;
        outputText("\n\n<b>Etna 1st LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Etna2ndLvLUp() : Void
    {
        flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ETNA_LVL_UP] = 2;
        outputText("\n\n<b>Etna 2nd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Etna3rdLvLUp() : Void
    {
        flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ETNA_LVL_UP] = 3;
        outputText("\n\n<b>Etna 3rd LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Etna4thLvLUp() : Void
    {
        flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ETNA_LVL_UP] = 4;
        outputText("\n\n<b>Etna 4th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Etna5thLvLUp() : Void
    {
        flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ETNA_LVL_UP] = 5;
        outputText("\n\n<b>Etna 5th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Etna6thLvLUp() : Void
    {
        flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ETNA_LVL_UP] = 6;
        outputText("\n\n<b>Etna 6th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function Etna7thLvLUp() : Void
    {
        flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
        flags[kFLAGS.ETNA_LVL_UP] = 7;
        outputText("\n\n<b>Etna 7th LvL-Up!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function EtnaTestDeLvL() : Void
    {
        flags[kFLAGS.ETNA_LVL_UP]--;
        outputText("\n\n<b>Etna been De-LvL'd!!!</b>");
        doNext(FasterOrInstantCampNPCRecruitment);
    }
    public function EquipmentMenu(page : Int = 1) : Void
    {
        menu();
        if (page == 1)
        {
            addButton(0, "Rap. Perk", AddRapPerk).hint("Add Raphael Rapier Perk and 1 Dragon Rapier.  USE only ONCE to not break the game!");
            addButton(1, "Sky Pearl", AddSkyPoisonPearl).hint("Add 1 Sky Poison Pearl.");
            addButton(2, "CatONIneTWhip", AddCatONineTailWhip).hint("Add 1 Bastet Whip.");
            addButton(3, "NineTailWhip", AddNineTailWhip).hint("Add 1 Nine Tail Whip.");
            addButton(4, "DualLAxes", AddDualMinoAxes).hint("Add 1 pair of Large Axes.");
            addButton(5, "UH Ayo Arm", AddUltraHeavyAyoArmor).hint("Add 1 Ultra heavy Ayo Armor for testing purposes.");
            addButton(6, "AncientConduit", AddAncientConduit).hint("Add 1 Ancient Conduit.");
            addButton(7, "HB Mech", AddHBMech).hint("Add 1 Howling Banshee Mech for testing purposes.");
            addButton(8, "GobMechPrime", AddGoblinMechPrime).hint("Add 1 Goblin Mech Prime for testing purposes.");
            addButton(9, "GiantSlayerMech", AddGiantSlayerMech).hint("Add 1 Giant Slayer Mech for testing purposes.");
            addButton(10, "E. Tome", AddTheElementalistsTome).hint("Add 1 Elementalist’s Tome.");
            addButton(11, "Evelyn", AddTheEvelyn).hint("Add 1 Evelyn Crossbow.");
            addButton(12, "InqTome", AddTheInquisitorsTome).hint("Add 1 Inquisitor's Tome.");
            addButton(13, "-2-", EquipmentMenu, page + 1);
            addButton(14, "Back", SoulforceCheats);
        }
        if (page == 2)
        
        //0{
            
            //1
            //2
            //3
            //4
            //5
            //6
            addButton(7, "BerserkerSet", AddTheBBS).hint("Add set of items for Berserker set.");  //7  
            addButton(8, "CheckWeapon", TestWeaponType).hint("Detect Weapon Type Equiped for sprite and battle testing.");
            addButton(9, "Ascensus", AddTheStaffs).hint("Add set of items for Ascensus.");
            addButton(10, "YODrops", AddYukiOnnaStuff).hint("Add both Yuki Onna equipment drops for testing purposes.");
            addButton(11, "SpikeShields", AddSpikedShields).hint("Add set of two spiked shields of various sizes and weight for testing purposes.");
            addButton(12, "MatrixArmory1", AddTheSeerHairpinAndCo).hint("Adds: 1 Eldritch Staff, 1 master Gloves, 1 Gnoll Throwing Axes, 1 Hodr's Bow, 1 Truestrike Sword, 1 Sceptre of Command, 1 Demonic Scythe, 1 Seer's Hairpin, Sakura Petal Kimono, Oni bead necklace");
            addButton(13, "-1-", EquipmentMenu, page - 1);
            addButton(14, "Back", SoulforceCheats);
        }
    }
    public function AddTheBBS() : Void
    {
        outputText("\n\n<b>(Gained set of items to make berseker set!)</b>\n\n");
        inventory.takeItem(armors.BESTBLA, AddTheBBS1);
    }
    public function AddTheBBS1() : Void
    {
        outputText("\n\n");
        inventory.takeItem(headjewelries.BESTBLAA, curry(EquipmentMenu, 2));
    }
    public function NonEquipmentMenu(page : Int = 1) : Void
    {
        menu();
        if (page == 1)
        {
            addButton(0, "Fox Jewel", AddFoxJewel).hint("Add 1 Fox Jewel.");
            addButton(1, "CDI", AddCurrentDebugItem).hint("Add 1 Gun.");
            addButton(2, "TrollFig", AddTrollFig).hint("Add 1 Troll Fig.");
            addButton(3, "CyclopTF", AddEyedrop).hint("Add 1 cyclop TF.");
            //addButton(4, "", ).hint("Add 1  .");
            addButton(5, "ALICORN", AddAlicornium).hint("Add 1 Alicornium.");
            addButton(6, "D.Fruit", AddDisplacerFruit).hint("Add 1 Displacer Fruit.");
            addButton(7, "AbyssalSTooth", AddAbyssalSharkTooth).hint("Add 1 Abyssal Shark Tooth.");
            //addButton(8, "", ).hint("Add 1 .");
            addButton(9, "Lethicite", AddLethicite);
            addButton(10, "SBMan", AddSoulBlastManual).hint("Add 1 Soul Blast manual.");
            addButton(11, "E.Ichor", AddEIchor).hint("Add 1 E.Ichor.");
            addButton(12, "-2-", NonEquipmentMenu, page + 1);
            addButton(13, "-3-", NonEquipmentMenu, page + 2);
            addButton(14, "Back", SoulforceCheats);
        }
        if (page == 2)
        {
            addButton(0, "SkybornSeed", AddSkybornSeed).hint("Add 1 Skyborn Seed.");
            addButton(1, "F.Fish", AddFreshFish).hint("Add 1 Fresh Fish.");
            addButton(2, "BehemothCum", AddBehemothCum).hint("Add 1 bottle of Behemoth Cum.");
            addButton(3, "TGOGossamer", AddThickGreenOnnaGossamer).hint("Add 1 Thick Green Onna Gossamer.");
            addButton(4, "Desert Berry", AddDesertBerry).hint("Add 1 werefox TF.");
            addButton(5, "Enigmanium", AddEnigmanium).hint("Add 1 vial of Enigmanium.");
            addButton(6, "dragonshit", AddDragonShit).hint("Add dragon stuff for jabberwocky test.");
            addButton(7, "Naga Oils", AddGorgonOil).hint("Add 1 vial of Gorgon, Vouivre and Couatl Oil.");
            addButton(8, "VT RV WF", AddVoltageTopaz).hint("Add 1 Voltage Topaz, 1 vial of Red Blood (Bat TF) and 1 Wonder Fruit.");
            addButton(9, "DSJ HS FSS", AddDarkSlimeJelly).hint("Add 1 Dark Slime Jelly, 1 Hydra Scale and 1 Fire Snail Saliva.");
            addButton(10, "Fafnir tear", AddFTear).hint("Add 1 Fafnir tear (Frost wyrm TF).");
            addButton(11, "Midnight gossamer", AddGossa).hint("Add 1 Midnight Gossamer.");
            addButton(12, "-1-", NonEquipmentMenu, page - 1);
            addButton(13, "-3-", NonEquipmentMenu, page + 1);
            addButton(14, "Back", SoulforceCheats);
        }
        if (page == 3)
        {
            addButton(0, "CrimsonJade", AddCrimsonJade).hint("Add 1 Crimson Jade.");
            addButton(1, "R.Manuscript", AddRedManuscript).hint("Add 1 Red Manuscript.");
            addButton(2, "White B.", AddWhiteBook).hint("Add 1 White Book.");
            addButton(3, "Black B.", AddBlackBook).hint("Add 1 Black Book.");
            addButton(4, "Grey B.", AddGreyBook).hint("Add 1 Grey Book.");
            addButton(5, "V.D.ARC", AddVeryDilutedArcaneRegenConcotion).hint("Add 1 very diluted Arcane Regen Concotion.");
            addButton(6, "D.ARC", AddDilutedArcaneRegenConcotion).hint("Add 1 diluted Arcane Regen Concotion.");
            addButton(7, "A.R.CON", AddArcaneRegenConcotion).hint("Add 1 Arcane Regen Concotion.");
            addButton(8, consumables.METHIRC.shortName, addConsumable, consumables.METHIRC).hint("Add 1 " + consumables.METHIRC.longName + ".");
            addButton(9, consumables.P_M_CUM.shortName, addConsumable, consumables.P_M_CUM).hint("Add 1 " + consumables.P_M_CUM.longName + ".");
            addButton(10, "E.Pearls", AddThePearls).hint("Add all three Elemental Pearls.");
            addButton(11, consumables.VAMPBLD.shortName, addConsumable, consumables.VAMPBLD).hint("Add 1 " + consumables.VAMPBLD.longName + ".");
            addButton(12, "-1-", NonEquipmentMenu, page - 2);
            addButton(13, "-2-", NonEquipmentMenu, page - 1);
            addButton(14, "Back", SoulforceCheats);
        }
    }
    
    public function AddLethicite() : Void
    {
        menu();
        addButton(0, "Lethicite1", AddLethicite1).hint("Add 1 (light coooked) Lethicite.");
        addButton(1, "Lethicite2", AddLethicite2).hint("Add 1 (medium coooked) Lethicite.");
        addButton(2, "Lethicite3", AddLethicite3).hint("Add 1 (heavy coooked) Lethicite.");
        addButton(3, "Lethicite4", AddLethicite4).hint("Add 1 (super heavy coooked) Lethicite.");
        addButton(14, "Back", NonEquipmentMenu);
    }
    
    private function addConsumable(consumable : Consumable) : Void
    {
        outputText("\n\n<b>(Gained 1 " + consumable.longName + "!)</b>\n\n");
        inventory.takeItem(consumable, curry(NonEquipmentMenu, 3));
    }
    
    public function MaterialMenu(page : Int = 1) : Void
    {
        menu();
        if (page == 1)
        {
            addButton(0, "Wood", AddWood).hint("Add 100 Wood (game not check for limits so not go overboard with using this cheat).");
            addButton(1, "Nails", AddNail).hint("Add 50 Nails (game not check for limits so not go overboard with using this cheat).");
            addButton(2, "Stone", AddStone).hint("Add 100 Stone (game not check for limits so not go overboard with using this cheat).");
            addButton(3, "MetalPieces", AddMetalPieces).hint("Add 50 Metal Pieces (game not check for limits so not go overboard with using this cheat).");
            addButton(4, "SpiderSilk", AddSpiderSilk).hint("Add 1 Spider Silk.");
            addButton(5, "Ebonbloom", AddEbonbloom).hint("Add 1 Ebonbloom.");
            addButton(6, "WorldTreeB.", AddWorldTreeBranch).hint("Add 1 World Tree Branch.");
            addButton(7, "ChitinShard", AddBeeChitin).hint("Add 1 Chitin shard.");
            addButton(8, "GreenGel", AddGreenGel).hint("Add 1 Green Gel.");
            addButton(9, "DragonScale", AddDragonscale).hint("Add 1 Dragonscale.");
            addButton(10, "S.Shard", AddShard).hint("Add 1 S.Shard.");  //addButton(10, "", ).hint("Add 1 .");  
            addButton(11, "HEALHERB", AddHerb).hint("Add 1 HEALHERB.");
            addButton(12, "Copp/Tin/Iron", AddCooperTinIronOre).hint("Add 1 Cooper, Tin and Iron ore.");
            addButton(13, "-2-", MaterialMenu, page + 1);
            addButton(14, "Back", SoulforceCheats);
        }
        if (page == 2)
        {
            addButton(0, "Skymetal", AddSkymetalOre).hint("Add 1 Skymetal Ore.");
            addButton(1, "Moonstone", AddMoonstone).hint("Add 1 Moonstone.");
            //addButton(2, "", ).hint("Add 1 .");
            //addButton(3, "", ).hint("Add 1 .");
            //addButton(4, "", ).hint("Add 1 .");
            addButton(5, "E.Shard", AddElementalShard).hint("Add 1 E.Shard.");  //addButton(5, "", ).hint("Add 1 .");  
            addButton(6, "UnicornHair", AddUnicornHair).hint("Add 1 Unicorn Hair.");
            addButton(7, "GolemCore", AddGolemCore).hint("Add 1 Golem Core.");
            addButton(8, "Mechanism", AddMechanism).hint("Add 1 Mechanism.");
            addButton(9, "EnergyCore", AddEnergyCore).hint("Add 1 Energy Core.");
            addButton(10, "F.Imp S.", AddFeralImpSkull).hint("Add 1 Feral Imp Skull.");
            addButton(11, "MetShoTom", AddMeteorShowerTome).hint("Add 1 Meteor Shower tome.");
            addButton(12, "PolMidScr", AddPolarMidnightScroll).hint("Add 1 Polar Midnight scroll.");
            addButton(13, "-1-", MaterialMenu, page - 1);
            addButton(14, "Back", SoulforceCheats);
        }
    }
    public function enemiesMenu() : Void
    {
        var buttons : ButtonDataList = new ButtonDataList();
        menu();
        
        buttons.add("Overseer", curry(fightMonster, OmnibusOverseer), "Test Fight against Omnibus Overseer");
        buttons.add("Sand Mother", FightSandMother, "Test Fight against Sand Mother");
        buttons.add("Zetaz", curry(fightMonster, Zetaz), "Test Fight against Zetaz");
        buttons.add("Incels", curry(fightMonster, Incels), "Test Fight against Incels");
        buttons.add("SuccGard", FightSuccubusGardener, "Test fight with Succubus Gardener. (Also it will glitch right after fight so not start this fight if you got unsaved progress that you not wanna loose as only way to handle post fight glitch is restarting game)");
        buttons.add("Lethice", FightLethice, "Test Fight against Lethice");
        buttons.add("Marae", FightMarae, "Test fight with Marae (depending on game stage she can be buffed or unbuffed).");
        buttons.add("The Dummy", FightTheDummy, "Test Fight against The Dummy");
        buttons.add("FightForPearl", FightForPearl, "Test fight to get Sky Poison Pearl legally (aside we cheat to start fight)");
        buttons.add("B.Monke", FightWaizAbi, "You not even want to let the innocent bimbo monke free? <i>*sigh*</i>");
        if (player.level >= 45)
        {
            buttons.add("Oculicorn", FightIridesian, "Test fight with Oculicorn.");
        }
        buttons.add("Draculina", curry(fightMonster, Draculina), "Test Fight against Draculina");
        buttons.add("GothGirl", FightLilith, "Fight with devilish cute goth girl.");
        buttons.add("Sonya", FightSonya, "Test fight with Sonya.");
        buttons.add("RyuBi", FightRyuBi, "Test fight with RyuBi.");
        buttons.add("Galia", FightGalia, "Test fight with Galia.");
        buttons.add("ChaosChimera", FightChaosChimera, "Test fight with Chaos Chimera.");
        buttons.add("AnotSucc", FightCarrera, "Fight with probably another succubus out there...");
        buttons.add("Aria", FightAria, "Test fight with melkie huntress Aria.");
        buttons.add("SomeMalikore", FightRandomnMalikore, "Test fight with some malikore.");
        buttons.add("Pierce", FightPierce, "Test fight with Pierce.");
        buttons.add("LvLUP Eva", LvLUPEva, "LvL UP forcefully Evangeline for testing purpose up to the limit.");
        buttons.add("DELvL Eva", DELvLEva, "DE LvL forcefully Evangeline for testing purpose down toward the lvl 12.");
        buttons.add("LvLUP Aurora", LvLUPAurora, "LvL UP forcefully Aurora for testing purpose up to the limit.");
        buttons.add("DELvL Aurora", DELvLAurora, "DE LvL forcefully Aurora for testing purpose down toward the lvl 1.");
        submenu(buttons, SoulforceCheats, 0, false);
    }
    
    public function AddRapPerk() : Void
    {
        flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 4;
        player.createPerk(PerkLib.RapierTraining, 0, 0, 0, 0);
        outputText("\n\n<b>(Gained Perk: Rapier Training and 1 Dragon Rapier!)</b>\n\n");
        inventory.takeItem(weapons.DRAPIER, curry(EquipmentMenu, 1));
    }
    public function AddSkyPoisonPearl() : Void
    {
        outputText("\n\n<b>(Gained 1 Sky Poison Pearl!)</b>\n\n");
        inventory.takeItem(consumables.SPPEARL, curry(EquipmentMenu, 1));
    }
    public function AddCatONineTailWhip() : Void
    {
        outputText("\n\n<b>(Gained 1 Bastet Whip!)</b>\n\n");
        inventory.takeItem(weapons.CNTWHIP, curry(EquipmentMenu, 1));
    }
    public function AddNineTailWhip() : Void
    {
        outputText("\n\n<b>(Gained 1 Nine Tail Whip!)</b>\n\n");
        inventory.takeItem(weapons.NTWHIP, curry(EquipmentMenu, 1));
    }
    public function AddDualMinoAxes() : Void
    {
        outputText("\n\n<b>(Gained 1 pair of Large Axes!)</b>\n\n");
        inventory.takeItem(weapons.DL_AXE_, curry(EquipmentMenu, 1));
    }
    public function AddAncientConduit() : Void
    {
        outputText("\n\n<b>(Gained 1 Ancient Conduit!)</b>\n\n");
        inventory.takeItem(shields.ANC_CON, curry(EquipmentMenu, 1));
    }
    public function AddUltraHeavyAyoArmor() : Void
    {
        outputText("\n\n<b>(Gained 1 Ultra Heavy Ayo Armor!)</b>\n\n");
        inventory.takeItem(armors.UHAYOARM, curry(EquipmentMenu, 1));
    }
    public function AddHBMech() : Void
    {
        outputText("\n\n<b>(Gained 1 Howling Banshee Mech!)</b>\n\n");
        inventory.takeItem(vehicles.HB_MECH, curry(EquipmentMenu, 1));
    }
    public function AddGoblinMechPrime() : Void
    {
        outputText("\n\n<b>(Gained 1 Goblin Mech Prime!)</b>\n\n");
        inventory.takeItem(vehicles.GOBMPRI, curry(EquipmentMenu, 1));
    }
    public function AddGiantSlayerMech() : Void
    {
        outputText("\n\n<b>(Gained 1 Giant Slayer Mech!)</b>\n\n");
        inventory.takeItem(vehicles.GS_MECH, curry(EquipmentMenu, 1));
    }
    public function AddTheElementalistsTome() : Void
    {
        outputText("\n\n<b>(Gained 1 Elementalist’s Tome!)</b>\n\n");
        inventory.takeItem(weaponsrange.E_TOME_, curry(EquipmentMenu, 1));
    }
    public function AddTheEvelyn() : Void
    {
        outputText("\n\n<b>(Gained 1 Evelyn Crossbow!)</b>\n\n");
        inventory.takeItem(weaponsrange.EVELYN_, curry(EquipmentMenu, 1));
    }
    public function AddTheInquisitorsTome() : Void
    {
        outputText("\n\n<b>(Gained 1 Inquisitor's Tome!)</b>\n\n");
        inventory.takeItem(weaponsrange.I_TOME_, curry(EquipmentMenu, 1));
    }
    public function AddTheStaffs() : Void
    {
        outputText("\n\n<b>(Gained set of items to make Ascensus!)</b>\n\n");
        inventory.takeItem(useables.TBAPLAT, AddTheStaffs1);
    }
    public function AddTheStaffs1() : Void
    {
        outputText("\n\n");
        inventory.takeItem(useables.DBAPLAT, AddTheStaffs2);
    }
    public function AddTheStaffs2() : Void
    {
        outputText("\n\n");
        inventory.takeItem(weapons.W_STAFF, curry(EquipmentMenu, 2));
    }
    public function AddYukiOnnaStuff() : Void
    {
        outputText("\n\n<b>(Gained 1st Yuki Onna item!)</b>\n\n");
        inventory.takeItem(armors.BLIZZ_K, AddYukiOnnaStuff2);
    }
    public function AddYukiOnnaStuff2() : Void
    {
        outputText("\n\n<b>(Gained 2nd Yuki Onna item!)</b>\n\n");
        inventory.takeItem(headjewelries.SNOWFH, curry(EquipmentMenu, 2));
    }
    public function AddSpikedShields() : Void
    {
        outputText("\n\n<b>(Gained Heavy Spiked Shield!)</b>\n\n");
        inventory.takeItem(shields.SPIH_SH, AddSpikedShields2);
    }
    public function AddSpikedShields2() : Void
    {
        outputText("\n\n<b>(Gained Massive Spiked Shield!)</b>\n\n");
        inventory.takeItem(shields.SPIM_SH, curry(EquipmentMenu, 2));
    }
    public function AddTheSeerHairpinAndCo() : Void
    {
        outputText("\n\n<b>(Gained 1 Eldritch Staff!)</b>\n\n");
        inventory.takeItem(weapons.E_STAFF, AddTheSeerHairpinAndCo1);
    }
    public function AddTheSeerHairpinAndCo1() : Void
    {
        outputText("\n\n<b>(Gained 1 Master Gloves!)</b>\n\n");
        inventory.takeItem(weapons.MASTGLO, AddTheSeerHairpinAndCo2);
    }
    public function AddTheSeerHairpinAndCo2() : Void
    {
        outputText("\n\n<b>(Gained 1 Gnoll Throwing Axes!)</b>\n\n");
        inventory.takeItem(weaponsrange.GTHRAXE, AddTheSeerHairpinAndCo3);
    }
    public function AddTheSeerHairpinAndCo3() : Void
    {
        outputText("\n\n<b>(Gained 1 Hodr's Bow!)</b>\n\n");
        inventory.takeItem(weaponsrange.BOWHODR, AddTheSeerHairpinAndCo4);
    }
    public function AddTheSeerHairpinAndCo4() : Void
    {
        outputText("\n\n<b>(Gained 1 Sceptre of Command!)</b>\n\n");
        inventory.takeItem(weapons.SCECOMM, AddTheSeerHairpinAndCo5);
    }
    public function AddTheSeerHairpinAndCo5() : Void
    {
        outputText("\n\n<b>(Gained 1 Truestrike Sword!)</b>\n\n");
        inventory.takeItem(weapons.TRSTSWO, AddTheSeerHairpinAndCo6);
    }
    public function AddTheSeerHairpinAndCo6() : Void
    {
        outputText("\n\n<b>(Gained 1 Demonic Scythe!)</b>\n\n");
        inventory.takeItem(weapons.DEMSCYT, AddTheSeerHairpinAndCo7);
    }
    public function AddTheSeerHairpinAndCo7() : Void
    {
        outputText("\n\n<b>(Gained 1 Seer's Hairpin!)</b>\n\n");
        inventory.takeItem(headjewelries.SEERPIN, AddTheSeerHairpinAndCo8);
    }
    public function AddTheSeerHairpinAndCo8() : Void
    {
        outputText("\n\n<b>(Gained 1 Sakura Petal Kimono!)</b>\n\n");
        inventory.takeItem(armors.SPKIMO, AddTheSeerHairpinAndCo9);
    }
    public function AddTheSeerHairpinAndCo9() : Void
    {
        outputText("\n\n<b>(Gained 1 Oni bead necklace!)</b>\n\n");
        inventory.takeItem(necklaces.OBNECK, curry(EquipmentMenu, 2));
    }
    
    public function AddFoxJewel() : Void
    {
        outputText("\n\n<b>(Gained 1 Fox Jewel!)</b>\n\n");
        inventory.takeItem(consumables.FOXJEWL, curry(NonEquipmentMenu, 1));
    }
    public function AddFreshFish() : Void
    {
        outputText("\n\n<b>(Gained 1 Fresh Fish!)</b>\n\n");
        inventory.takeItem(consumables.FREFISH, curry(NonEquipmentMenu, 2));
    }
    public function AddTrollFig() : Void
    {
        outputText("\n\n<b>(Gained 1 Troll Fig!)</b>\n\n");
        inventory.takeItem(consumables.TROLFIG, curry(NonEquipmentMenu, 1));
    }
    public function AddEyedrop() : Void
    {
        outputText("\n\n<b>(Gained 1 Cyclop TF)</b>\n\n");
        inventory.takeItem(consumables.EYEDROP, curry(NonEquipmentMenu, 1));
    }
    public function AddDesertBerry() : Void
    {
        outputText("\n\n<b>(Gained 1 Werefox TF)</b>\n\n");
        inventory.takeItem(consumables.DESERTB, curry(NonEquipmentMenu, 2));
    }
    public function AddVoltageTopaz() : Void
    {
        outputText("\n\n<b>(Gained 1 Voltage Topaz!)</b>\n\n");
        inventory.takeItem(consumables.VOLTTOP, AddRedBlood);
    }
    public function AddDragonShit() : Void
    {
        outputText("\n\n<b>(Gained 1 dragon!)</b>\n\n");
        inventory.takeItem(consumables.DRAKHRT, AddJabbyShit);
    }
    public function AddJabbyShit() : Void
    {
        outputText("\n\n<b>(Gained 1 Jabby!)</b>\n\n");
        inventory.takeItem(consumables.JABBERS, curry(NonEquipmentMenu, 2));
    }
    public function AddRedBlood() : Void
    {
        outputText("\n\n<b>(Gained 1 vial of red blood!)</b>\n\n");
        inventory.takeItem(consumables.REDVIAL, AddWonderFruit);
    }
    public function AddWonderFruit() : Void
    {
        outputText("\n\n<b>(Gained 1 Wonder Fruit!)</b>\n\n");
        inventory.takeItem(consumables.WOFRUIT, curry(NonEquipmentMenu, 2));
    }
    public function AddDarkSlimeJelly() : Void
    {
        outputText("\n\n<b>(Gained 1 Dark Slime Jelly!)</b>\n\n");
        inventory.takeItem(consumables.DSLIMEJ, AddHydraScale);
    }
    public function AddHydraScale() : Void
    {
        outputText("\n\n<b>(Gained 1 Hydra Scale!)</b>\n\n");
        inventory.takeItem(consumables.HYDRASC, AddFireSnailSaliva);
    }
    public function AddFireSnailSaliva() : Void
    {
        outputText("\n\n<b>(Gained 1 Fire Snail Saliva!)</b>\n\n");
        inventory.takeItem(consumables.FSNAILS, curry(NonEquipmentMenu, 2));
    }
    public function AddGorgonOil() : Void
    {
        outputText("\n\n<b>(Gained 1 vial of Gorgon Oil!)</b>\n\n");
        inventory.takeItem(consumables.GORGOIL, AddVouivreOil);
    }
    public function AddVouivreOil() : Void
    {
        outputText("\n\n<b>(Gained 1 vial of Vouivre Oil!)</b>\n\n");
        inventory.takeItem(consumables.VOUIOIL, AddCouatlOil);
    }
    public function AddCouatlOil() : Void
    {
        outputText("\n\n<b>(Gained 1 vial of Couatl Oil!)</b>\n\n");
        inventory.takeItem(consumables.COUAOIL, curry(NonEquipmentMenu, 2));
    }
    public function AddEnigmanium() : Void
    {
        outputText("\n\n<b>(Gained 1 vial of Enigmanium!)</b>\n\n");
        inventory.takeItem(consumables.ENIGMANIUM, curry(NonEquipmentMenu, 2));
    }
    public function AddSkelp() : Void
    {
        outputText("\n\n<b>(Gained 1 Skelp!)</b>\n\n");
        inventory.takeItem(consumables.SKELP__, curry(NonEquipmentMenu, 2));
    }
    public function AddFTear() : Void
    {
        outputText("\n\n<b>(Gained 1 Fafnir Tear!)</b>\n\n");
        inventory.takeItem(consumables.F_TEAR, curry(NonEquipmentMenu, 2));
    }
    public function AddBubble() : Void
    {
        outputText("\n\n<b>(Gained 1 Bubblegum!)</b>\n\n");
        inventory.takeItem(consumables.BUBBLEG, curry(NonEquipmentMenu, 2));
    }
    
    public function AddGossa() : Void
    {
        outputText("\n\n<b>(Gained 1 Midnight gossamer!)</b>\n\n");
        inventory.takeItem(consumables.M_GOSSR, curry(NonEquipmentMenu, 2));
    }
    
    public function AddMetalPieces() : Void
    {
        outputText("\n\n<b>(Gained 50 Metal Pieces!)</b>\n\n");
        CampStatsAndResources.MetalPieces += 50;
        statScreenRefresh();
        curry(MaterialMenu, 1);
    }
    public function AddSpiderSilk() : Void
    {
        outputText("\n\n<b>(Gained 1 Spider Silk!)</b>\n\n");
        inventory.takeItem(useables.T_SSILK, curry(MaterialMenu, 1));
    }
    public function AddBeeChitin() : Void
    {
        outputText("\n\n<b>(Gained 1 Chitin Shard!)</b>\n\n");
        inventory.takeItem(useables.B_CHITN, curry(MaterialMenu, 1));
    }
    public function AddGreenGel() : Void
    {
        outputText("\n\n<b>(Gained 1 Green Gel!)</b>\n\n");
        inventory.takeItem(useables.GREENGL, curry(MaterialMenu, 1));
    }
    public function AddDragonscale() : Void
    {
        outputText("\n\n<b>(Gained 1 Dragonscale!)</b>\n\n");
        inventory.takeItem(useables.D_SCALE, curry(MaterialMenu, 1));
    }
    public function AddShard() : Void
    {
        outputText("\n\n<b>(Gained 1 Shard!)</b>\n\n");
        inventory.takeItem(useables.S_SHARD, curry(MaterialMenu, 1));
    }
    public function AddHerb() : Void
    {
        outputText("\n\n<b>(Gained 1 Healing Herb!)</b>\n\n");
        inventory.takeItem(consumables.HEALHERB, curry(MaterialMenu, 1));
    }
    public function AddCooperTinIronOre() : Void
    {
        outputText("\n\n<b>(Gained 1 Copper Ore!)</b>\n\n");
        inventory.takeItem(useables.COP_ORE, AddCooperTinIronOre1);
    }
    public function AddCooperTinIronOre1() : Void
    {
        outputText("\n\n<b>(Gained 1 Tin Ore!)</b>\n\n");
        inventory.takeItem(useables.TIN_ORE, AddCooperTinIronOre2);
    }
    public function AddCooperTinIronOre2() : Void
    {
        outputText("\n\n<b>(Gained 1 Irno Ore!)</b>\n\n");
        inventory.takeItem(useables.IRONORE, curry(MaterialMenu, 1));
    }
    public function AddEnergyCore() : Void
    {
        outputText("\n\n<b>(Gained 1 Energy Core!)</b>\n\n");
        CampStatsAndResources.EnergyCoreResc += 1;
        statScreenRefresh();
        curry(MaterialMenu, 2);
    }
    public function AddMechanism() : Void
    {
        outputText("\n\n<b>(Gained 1 Mechanism!)</b>\n\n");
        CampStatsAndResources.MechanismResc += 1;
        statScreenRefresh();
        curry(MaterialMenu, 2);
    }
    public function AddGolemCore() : Void
    {
        outputText("\n\n<b>(Gained 1 Golem Core!)</b>\n\n");
        inventory.takeItem(useables.GOLCORE, curry(MaterialMenu, 2));
    }
    public function AddSkymetalOre() : Void
    {
        outputText("\n\n<b>(Gained 1 Skymetal Ore!)</b>\n\n");
        inventory.takeItem(useables.SKYMETA, curry(MaterialMenu, 2));
    }
    public function AddMoonstone() : Void
    {
        outputText("\n\n<b>(Gained 1 Moonstone!)</b>\n\n");
        inventory.takeItem(useables.MOONSTO, curry(MaterialMenu, 2));
    }
    public function AddUnicornHair() : Void
    {
        outputText("\n\n<b>(Gained 1 Unicorn Hair!)</b>\n\n");
        inventory.takeItem(useables.UNICORNH, curry(MaterialMenu, 2));
    }
    public function AddElementalShard() : Void
    {
        outputText("\n\n<b>(Gained 1 Elemental Shard!)</b>\n\n");
        inventory.takeItem(useables.ELSHARD, curry(MaterialMenu, 2));
    }
    public function AddPolarMidnightScroll() : Void
    {
        outputText("\n\n<b>(Gained 1 Polar Midnight scroll!)</b>\n\n");
        inventory.takeItem(consumables.POL_MID, curry(MaterialMenu, 2));
    }
    public function AddMeteorShowerTome() : Void
    {
        outputText("\n\n<b>(Gained 1 Meteor Shower tome!)</b>\n\n");
        inventory.takeItem(consumables.MET_SHO, curry(MaterialMenu, 2));
    }
    public function AddFeralImpSkull() : Void
    {
        outputText("\n\n<b>(Gained 1 Feral Imp Skull!)</b>\n\n");
        inventory.takeItem(useables.FIMPSKL, curry(MaterialMenu, 2));
    }
    
    public function TestWeaponType() : Void
    {
        outputText("Weapon types: " + [player.weapon.isStaffType(), player.weapon.isSwordType(), player.weapon.isAxeType(), player.weapon.isMaceHammerType(), player.weapon.isSpearType(), player.weapon.isScytheType(), player.weapon.isDuelingType()].join(","));
    }
    
    public function FightTheDummy() : Void
    {
        clearOutput();
        //outputText("Entering battle with The Dummy! Enjoy ^^");
        //startCombat(new TheDummy());
        outputText("Entering battle with Minotaur! Enjoy ^^");
        startCombat(new Minotaur());
    }
    public function FightSuccubusGardener() : Void
    {
        clearOutput();
        outputText("Entering battle with Succubus Gardener! Enjoy ^^");
        startCombat(new SuccubusGardener());
    }
    
    public function AddThickGreenOnnaGossamer() : Void
    {
        outputText("\n\n<b>(Gained 1 Thick Green Onna Gossamer!)</b>\n\n");
        inventory.takeItem(consumables.WHITEIS, SoulforceCheats);
    }
    public function AddWhiteIceShard() : Void
    {
        outputText("\n\n<b>(Gained 1 White Ice Shard!)</b>\n\n");
        inventory.takeItem(consumables.WHITEIS, SoulforceCheats);
    }
    public function AddLeviathanSunscreen() : Void
    {
        outputText("\n\n<b>(Gained 1 Leviathan Sunscreen!)</b>\n\n");
        inventory.takeItem(consumables.LEVISUN, SoulforceCheats);
    }
    public function AddVeryDilutedArcaneRegenConcotion() : Void
    {
        outputText("\n\n<b>(Gained 1 very diluted Arcane Regen Concotion!)</b>\n\n");
        inventory.takeItem(consumables.VDARCON, curry(NonEquipmentMenu, 3));
    }
    public function AddDilutedArcaneRegenConcotion() : Void
    {
        outputText("\n\n<b>(Gained 1 diluted Arcane Regen Concotion!)</b>\n\n");
        inventory.takeItem(consumables.D_ARCON, curry(NonEquipmentMenu, 3));
    }
    public function AddArcaneRegenConcotion() : Void
    {
        outputText("\n\n<b>(Gained 1 Arcane Regen Concotion!)</b>\n\n");
        inventory.takeItem(consumables.AREGCON, curry(NonEquipmentMenu, 3));
    }
    public function AddSoulBlastManual() : Void
    {
        outputText("\n\n<b>(Gained 1 Soul Blast Manual!)</b>\n\n");
        inventory.takeItem(consumables.SOBLMAN, curry(NonEquipmentMenu, 1));
    }
    public function AddEIchor() : Void
    {
        outputText("\n\n<b>(Gained 1 E.Ichor!)</b>\n\n");
        inventory.takeItem(useables.E_ICHOR, curry(NonEquipmentMenu, 1));
    }
    public function AddLethicite1() : Void
    {
        outputText("\n\n<b>(Gained 1 (light coooked) Lethicite!)</b>\n\n");
        inventory.takeItem(consumables.LETHITE, AddLethicite);
    }
    public function AddLethicite2() : Void
    {
        outputText("\n\n<b>(Gained 1 (medium coooked) Lethicite!)</b>\n\n");
        inventory.takeItem(consumables.LETH1TE, AddLethicite);
    }
    public function AddLethicite3() : Void
    {
        outputText("\n\n<b>(Gained 1 (heavy coooked) Lethicite!)</b>\n\n");
        inventory.takeItem(consumables.LETH2TE, AddLethicite);
    }
    public function AddLethicite4() : Void
    {
        outputText("\n\n<b>(Gained 1 (super heavy coooked) Lethicite!)</b>\n\n");
        inventory.takeItem(consumables.LETH3TE, AddLethicite);
    }
    public function AddDisplacerFruit() : Void
    {
        outputText("\n\n<b>(Gained 1 Displacer Fruit!)</b>\n\n");
        inventory.takeItem(consumables.D_FRUIT, curry(NonEquipmentMenu, 1));
    }
    public function AddAbyssalSharkTooth() : Void
    {
        outputText("\n\n<b>(Gained 1 Abyssal Shark Tooth!)</b>\n\n");
        inventory.takeItem(consumables.ASTOOTH, curry(NonEquipmentMenu, 1));
    }
    public function AddAlicornium() : Void
    {
        outputText("\n\n<b>(Gained 1 Alicornium!)</b>\n\n");
        inventory.takeItem(consumables.ALICORN, curry(NonEquipmentMenu, 1));
    }
    public function AddMethir() : Void
    {
        outputText("\n\n<b>(Gained 1 Methir crystal!)</b>\n\n");
        inventory.takeItem(consumables.METHIRC, curry(NonEquipmentMenu, 1));
    }
    public function AddCurrentDebugItem() : Void
    {
        outputText("\n\n<b>(Gained 1 Testing gun!)</b>\n\n");
        inventory.takeItem(weaponsrange.M1CERBE, curry(NonEquipmentMenu, 1));
    }
    public function AddSkybornSeed() : Void
    {
        outputText("\n\n<b>(Gained 1 Skyborn Seed!)</b>\n\n");
        inventory.takeItem(consumables.SKYSEED, curry(NonEquipmentMenu, 2));
    }
    public function AddBehemothCum() : Void
    {
        outputText("\n\n<b>(Gained 1 vial of Behemoth Cum!)</b>\n\n");
        inventory.takeItem(consumables.BHMTCUM, curry(NonEquipmentMenu, 2));
    }
    public function AddEbonbloom() : Void
    {
        outputText("\n\n<b>(Gained 1 Ebonbloom!)</b>\n\n");
        inventory.takeItem(useables.EBONBLO, curry(MaterialMenu, 1));
    }
    public function AddWorldTreeBranch() : Void
    {
        outputText("\n\n<b>(Gained 1 Wold Tree branch!)</b>\n\n");
        inventory.takeItem(useables.WT_BRAN, curry(MaterialMenu, 1));
    }
    public function EarlyAscension() : Void
    {
        if (flags[kFLAGS.LETHICE_DEFEATED] == 1)
        {
            outputText("\n\n<b>You already used this cheat code!</b>");
        }
        else
        {
            flags[kFLAGS.LETHICE_DEFEATED] = 1;
            outputText("\n\n<b>You can Ascend now even if you not beaten Lethice yet!</b>");
        }
        doNext(StatsAscensionMenu2);
    }
    public function IncreaseAscensionCounter() : Void
    {
        outputText("\n\n<b>Your NG tier increased by 1!</b>");
        flags[kFLAGS.NEW_GAME_PLUS_LEVEL] += 1;
        doNext(StatsAscensionMenu2);
    }
    public function DecreaseAscensionCounter() : Void
    {
        outputText("\n\n<b>Your NG tier decreased by 1!</b>");
        flags[kFLAGS.NEW_GAME_PLUS_LEVEL] -= 1;
        doNext(StatsAscensionMenu2);
    }
    
    public function AddAscenionPerkPoints(incAmt : Int) : Void
    {
        outputText("\n\n<b>You have gained " + incAmt + " Ascension perk points!</b>");
        player.ascensionPerkPoints += incAmt;
        doNext(StatsAscensionMenu2);
    }
    
    public function modStatFlags(flagName : String, changeAmt : Int) : Void
    {
        switch (flagName)
        {
            case "timesTransformed":
                flags[kFLAGS.TIMES_TRANSFORMED] += changeAmt;
        }
        modFlagsMenu();
    }
    
    public function ModCoreStats(core : String, incAmt : Int) : Void
    {
        switch (core)
        {
            case "Str":
                player.strStat.core.value += incAmt;
            case "Tou":
                player.touStat.core.value += incAmt;
            case "Spe":
                player.speStat.core.value += incAmt;
            case "Int":
                player.intStat.core.value += incAmt;
            case "Wis":
                player.wisStat.core.value += incAmt;
            case "Lib":
                player.libStat.core.value += incAmt;
            case "Sen":
                dynStats("sen", incAmt);
            case "Cor":
                dynStats("cor", incAmt);
            case "Tone":
                player.tone += incAmt;
            case "Thickness":
                player.thickness += incAmt;
            case "Feminity":
                player.femininity += incAmt;
        }
        statScreenRefresh();
        StatsAscensionMenu();
    }
    
    public function perkPointsCheat(cAmt : Int) : Void
    {
        clearOutput();
        player.perkPoints += cAmt;
        outputText("\n\n<b>You now have " + player.perkPoints + " perk points!</b>");
        doNext(PerksGemsEXP);
    }
    
    public function addGemsXP(type : String, cAmt : Int) : Void
    {
        clearOutput();
        if (type == "Gems")
        {
            player.gems += cAmt;
            outputText("\n\n<b>You now have " + player.gems + " gems!</b>");
        }
        else if (type == "XP")
        {
            player.XP += cAmt;
            outputText("\n\n<b>You have gained " + cAmt + " XP!</b>");
        }
        doNext(PerksGemsEXP);
    }
    
    public function addsubLvl(type : String, cAmt : Int) : Void
    {
        clearOutput();
        if (type == "Lvl")
        {
            CoC.instance.playerInfo.levelUpMultipleTimes(cAmt);
            outputText("\n\n<b>You now have " + player.level + " levels!</b>");
        }
        else if (type == "DLvl")
        {
            player.level -= cAmt;
            outputText("\n\n<b>You have lost " + cAmt + " levels and are now " + player.level + "!</b>");
        }
        doNext(LevelDeLevel);
    }
    
    public function Stage10to12SoulPerks() : Void
    {
        if (player.hasPerk(PerkLib.FleshBodyOverlordStage))
        {
            player.removePerk(PerkLib.FleshBodyOverlordStage);
            outputText("\n\n<b>(Lost Perk: Flesh Body Overlord Stage!)</b>");
        }
        if (player.hasPerk(PerkLib.DaoistOverlordStage))
        {
            player.removePerk(PerkLib.DaoistOverlordStage);
            outputText("\n\n<b>(Lost Perk: Daoist Overlord Stage!)</b>");
        }
        if (player.hasPerk(PerkLib.SoulKing))
        {
            player.removePerk(PerkLib.SoulKing);
            outputText("\n\n<b>(Lost Perk: Soul King!)</b>");
        }
        if (player.hasPerk(PerkLib.SoulEmperor))
        {
            player.removePerk(PerkLib.SoulEmperor);
            outputText("\n\n<b>(Lost Perk: Soul Emperor!)</b>");
        }
        if (player.hasPerk(PerkLib.SoulAncestor))
        {
            player.removePerk(PerkLib.SoulAncestor);
            outputText("\n\n<b>(Lost Perk: Soul Ancestor!)</b>");
        }
        doNext(SoulforceCheats);
    }
    public function TribulationPerks() : Void
    {
        if (!player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor))
        {
            player.createPerk(PerkLib.EclassHeavenTribulationSurvivor, 0, 0, 0, 0);
            outputText("\n\n<b>(Gained Perk: E class Heaven Tribulation Survivor!)</b>");
        }
        doNext(SoulforceCheats);
    }
    public function AddWhiteBook() : Void
    {
        outputText("\n\n<b>(Gained 1 White Book!)</b>\n\n");
        inventory.takeItem(consumables.W__BOOK, curry(NonEquipmentMenu, 3));
    }
    public function AddBlackBook() : Void
    {
        outputText("\n\n<b>(Gained 1 Black Book!)</b>\n\n");
        inventory.takeItem(consumables.B__BOOK, curry(NonEquipmentMenu, 3));
    }
    public function AddGreyBook() : Void
    {
        outputText("\n\n<b>(Gained 1 Grey Book!)</b>\n\n");
        inventory.takeItem(consumables.G__BOOK, curry(NonEquipmentMenu, 3));
    }
    public function AddRedManuscript() : Void
    {
        outputText("\n\n<b>(Gained 1 Red Manuscript!)</b>\n\n");
        inventory.takeItem(consumables.RMANUSC, curry(NonEquipmentMenu, 3));
    }
    public function AddCrimsonJade() : Void
    {
        outputText("\n\n<b>(Gained 1 Crimson Jade!)</b>\n\n");
        inventory.takeItem(consumables.CRIMS_J, curry(NonEquipmentMenu, 3));
    }
    public function AddThePearls() : Void
    {
        outputText("\n\n<b>(Gained set of items to get all perks countering Elemental Conjuer perks negative effects on stat caps!)</b>\n\n");
        inventory.takeItem(consumables.E3PEARL, AddThePearls1);
    }
    public function AddThePearls1() : Void
    {
        outputText("\n\n");
        inventory.takeItem(consumables.E5PEARL, AddThePearls2);
    }
    public function AddThePearls2() : Void
    {
        outputText("\n\n");
        inventory.takeItem(consumables.E7PEARL, curry(NonEquipmentMenu, 3));
    }
    public function AddWood() : Void
    {
        outputText("\n\n<b>(Gained 100 Wood!)</b>");
        CampStatsAndResources.WoodResc += 100;
        statScreenRefresh();
        curry(MaterialMenu, 1);
    }
    public function AddNail() : Void
    {
        outputText("\n\n<b>(Gained 50 Nails!)</b>");
        CampStatsAndResources.NailsResc += 50;
        statScreenRefresh();
        curry(MaterialMenu, 1);
    }
    public function AddStone() : Void
    {
        outputText("\n\n<b>(Gained 100 Stones!)</b>");
        CampStatsAndResources.StonesResc += 100;
        statScreenRefresh();
        curry(MaterialMenu, 1);
    }
    public function fightMonster(monsterClass : Class<Dynamic>, setupFunc : Function = null) : Void
    {
        clearOutput();
        var monster : Monster = Type.createInstance(monsterClass, []);
        if (setupFunc != null)
        {
            setupFunc(monster);
        }
        outputText("Entering battle with " + monster.short + "! Enjoy ^^");
        startCombat(monster);
    }
    public function FightForPearl() : Void
    {
        clearOutput();
        outputText("Entering battle with Deep Sea Kraken Boss! Enjoy ^^");
        startCombat(new Kraken());
    }
    public function FightMarae() : Void
    {
        clearOutput();
        outputText("Entering battle with Marae Boss! Enjoy ^^");
        startCombat(new Marae());
    }
    public function FightPierce() : Void
    {
        clearOutput();
        outputText("Entering battle with Pierce! Enjoy ^^");
        startCombat(new Pierce());
    }
    public function FightIridesian() : Void
    {
        SceneLib.iridesianFollower.firstMeetingIridesian();
    }
    public function FightLilith() : Void
    {
        clearOutput();
        outputText("Entering battle with devilish cute goth girl! Enjoy ^^");
        startCombat(new Lilith());
    }
    public function FightCarrera() : Void
    {
        clearOutput();
        outputText("Entering battle with another succubus or maybe not your every succubus? Enjoy ^^");
        startCombat(new Carrera());
    }
    public function FightWaizAbi() : Void
    {
        clearOutput();
        outputText("So you cheating and skipping guardian angel gaze to beat poor Bimbo Monke? You're a Sexual Predator... <i>Start to dial local police number</i>");
        menu();
        addButton(1, "LvL18", FightWaizAbi18);
        addButton(2, "LvL24", FightWaizAbi24);
        addButton(3, "LvL30", FightWaizAbi30);
    }
    public function FightWaizAbi18() : Void
    {
        flags[kFLAGS.WAIZABI_LVL_UP] = 0;
        startCombat(new WaizAbi());
    }
    public function FightWaizAbi24() : Void
    {
        flags[kFLAGS.WAIZABI_LVL_UP] = 1;
        startCombat(new WaizAbi());
    }
    public function FightWaizAbi30() : Void
    {
        flags[kFLAGS.WAIZABI_LVL_UP] = 2;
        startCombat(new WaizAbi());
    }
    public function FightSandMother() : Void
    {
        clearOutput();
        outputText("Entering battle with Sand Mother! Enjoy ^^");
        startCombat(new SandMother(), true);
    }
    public function FightSonya() : Void
    {
        clearOutput();
        outputText("Entering battle with Sonya! Enjoy ^^");
        startCombat(new Sonya());
    }
    public function FightRyuBi() : Void
    {
        clearOutput();
        outputText("Entering battle with RyuBi! Enjoy ^^");
        startCombat(new RyuBiDragon());
    }
    public function FightRandomnMalikore() : Void
    {
        clearOutput();
        outputText("Entering battle with some malikore! Enjoy ^^");
        startCombat(new Malikore());
    }
    public function LvLUPAurora() : Void
    {
        outputText("\n\n<b>Aurora get stronger! (cheat stop working when she reach max possible lvl for now (atm it's lvl 73))</b>");
        if (flags[kFLAGS.AURORA_LVL] < 13)
        {
            flags[kFLAGS.AURORA_LVL]++;
        }
        enemiesMenu();
    }
    public function DELvLAurora() : Void
    {
        outputText("\n\n<b>Aurora get weaker! (cheat stop working when she reach lvl 1)</b>");
        if (flags[kFLAGS.AURORA_LVL] > 1)
        {
            flags[kFLAGS.AURORA_LVL]--;
        }
        enemiesMenu();
    }
    public function LvLUPEva() : Void
    {
        outputText("\n\n<b>Evangeline get stronger! (cheat stop working when she reach max possible lvl for now (atm it's lvl 42))</b>");
        if (flags[kFLAGS.EVANGELINE_LVL_UP] < 17)
        {
            flags[kFLAGS.EVANGELINE_LVL_UP]++;
        }
        enemiesMenu();
    }
    public function DELvLEva() : Void
    {
        outputText("\n\n<b>Evangeline get weaker! (cheat stop working when she reach lvl 12)</b>");
        if (flags[kFLAGS.EVANGELINE_LVL_UP] > 6)
        {
            flags[kFLAGS.EVANGELINE_LVL_UP]--;
        }
        enemiesMenu();
    }
    public function RevertCabinProgress() : Void
    {
        flags[kFLAGS.CAMP_CABIN_PROGRESS] = 2;
        doNext(SoulforceCheats);
    }
    public function GargoyleMenu() : Void
    {
        menu();
        addButton(0, "Human", BackToHumanForm).hint("Return to been fully human from gargoyle form test.");
        addButton(1, "Marble", MarbleGargoyleForm).hint("Turn into marble gargoyle form for tests.");
        addButton(2, "Alabaster", AlabasterGargoyleForm).hint("Turn into alabaster gargoyle form for tests.");
        addButton(14, "Back", SoulforceCheats);
    }
    public function BackToHumanForm() : Void
    {
        flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 0;
        player.skin.setBaseOnly({
                    type : Skin.PLAIN
                });
        player.hairType = Hair.NORMAL;
        player.faceType = Face.HUMAN;
        player.tongue.type = Tongue.HUMAN;
        player.horns.type = Horns.NONE;
        player.beardLength = 0;
        player.beardStyle = 0;
        player.arms.type = Arms.HUMAN;
        player.tailType = Tail.NONE;
        player.tailRecharge = 0;
        player.wings.type = Wings.NONE;
        player.lowerBody = LowerBody.HUMAN;
        player.legCount = 2;
        player.eyes.type = Eyes.HUMAN;
        player.antennae.type = Antennae.NONE;
        player.ears.type = Ears.HUMAN;
        player.gills.type = Gills.NONE;
        player.rearBody.type = RearBody.NONE;
        player.skin.restore();
        if (player.hasPerk(PerkLib.GargoylePure))
        {
            player.removePerk(PerkLib.GargoylePure);
        }
        if (player.hasPerk(PerkLib.GargoyleCorrupted))
        {
            player.removePerk(PerkLib.GargoyleCorrupted);
        }
        player.removePerk(PerkLib.TransformationImmunity);
        clearOutput();
        outputText("You have become fully human again.");
        doNext(SoulforceCheats);
    }
    public function MarbleGargoyleForm() : Void
    {
        flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 1;
        player.skinColor = "light grey";
        player.hairColor = "light grey";
        clearOutput();
        outputText("You have become marble gargoyle. Now choose your wings shape.");
        doNext(WingShapeChoices);
    }
    public function AlabasterGargoyleForm() : Void
    {
        flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 2;
        player.skinColor = "quartz white";
        player.hairColor = "quartz white";
        clearOutput();
        outputText("You have become alabaster gargoyle. Now choose your wings shape.");
        doNext(WingShapeChoices);
    }
    public function WingShapeChoices() : Void
    {
        menu();
        addButton(0, "Bird", BirdWings);
        addButton(1, "Bat's", BatsWings);
    }
    public function BirdWings() : Void
    {
        flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 1;
        clearOutput();
        outputText("Now choose your arms shape.");
        doNext(ArmTypeChoices);
    }
    public function BatsWings() : Void
    {
        flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 2;
        clearOutput();
        outputText("Now choose your arms shape.");
        doNext(ArmTypeChoices);
    }
    public function ArmTypeChoices() : Void
    {
        menu();
        addButton(0, "Gargy", BirdArms);
        addButton(1, "Human", BatsWings);
    }
    public function BirdArms() : Void
    {
        player.arms.type = Arms.GARGOYLE;
        clearOutput();
        outputText("Now choose your tail shape.");
        doNext(TailTypeChoices);
    }
    public function BatsArms() : Void
    {
        player.arms.type = Arms.GARGOYLE_2;
        clearOutput();
        outputText("Now choose your tail shape.");
        doNext(TailTypeChoices);
    }
    public function TailTypeChoices() : Void
    {
        menu();
        addButton(0, "Whip-like", BirdTail);
        addButton(1, "Mace-like", BatsTail);
    }
    public function BirdTail() : Void
    {
        player.tailType = Tail.GARGOYLE;
        clearOutput();
        outputText("Now choose your legs shape.");
        doNext(LegsTypeChoices);
    }
    public function BatsTail() : Void
    {
        player.tailType = Tail.GARGOYLE_2;
        clearOutput();
        outputText("Now choose your legs shape.");
        doNext(LegsTypeChoices);
    }
    public function LegsTypeChoices() : Void
    {
        menu();
        addButton(0, "Gargy", BirdLegs);
        addButton(1, "Human", BatsLegs);
    }
    public function BirdLegs() : Void
    {
        player.lowerBody = LowerBody.GARGOYLE;
        clearOutput();
        outputText("Now choose your feeding style.");
        doNext(SustainTypeChoices);
    }
    public function BatsLegs() : Void
    {
        player.lowerBody = LowerBody.GARGOYLE_2;
        clearOutput();
        outputText("Now choose your feeding style.");
        doNext(SustainTypeChoices);
    }
    public function SustainTypeChoices() : Void
    {
        menu();
        addButton(0, "Soulforce", BirdSustain);
        addButton(1, "Milk & Cum", BatsSustain);
    }
    public function BirdSustain() : Void
    {
        player.createPerk(PerkLib.GargoylePure, 0, 0, 0, 0);
        player.createPerk(PerkLib.TransformationImmunity, 0, 0, 0, 0);
        clearOutput();
        outputText("Now your PC will became Prototype Gargoyle ^^");
        doNext(GargoyleBodyChanges);
    }
    public function BatsSustain() : Void
    {
        player.createPerk(PerkLib.GargoyleCorrupted, 0, 0, 0, 0);
        player.createPerk(PerkLib.TransformationImmunity, 0, 0, 0, 0);
        clearOutput();
        outputText("Now your PC will became Prototype Gargoyle ^^");
        doNext(GargoyleBodyChanges);
    }
    public function GargoyleBodyChanges() : Void
    {
        if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1)
        {
            player.skinColor = "light grey";
            player.hairColor = "light grey";
        }
        if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2)
        {
            player.skinColor = "quartz white";
            player.hairColor = "quartz white";
        }
        player.skin.setBaseOnly({
                    type : Skin.STONE
                });
        player.hairType = Hair.NORMAL;
        player.faceType = Face.DEVIL_FANGS;
        player.tongue.type = Tongue.DEMONIC;
        player.horns.type = Horns.GARGOYLE;
        player.horns.count = 12 + rand(4);
        player.beardLength = 0;
        player.beardStyle = 0;
        player.tailRecharge = 0;
        player.wings.type = Wings.GARGOYLE_LIKE_LARGE;
        player.legCount = 2;
        player.eyes.type = Eyes.GEMSTONES;
        player.antennae.type = Antennae.NONE;
        player.tongue.type = Tongue.DEMONIC;
        player.ears.type = Ears.ELFIN;
        player.gills.type = Gills.NONE;
        player.rearBody.type = RearBody.NONE;
        if (player.hasStatusEffect(StatusEffects.BlackNipples))
        {
            player.removeStatusEffect(StatusEffects.BlackNipples);
        }
        //	if (player.averageNipplesPerBreast() > 1) player.breastRows[x].nipplesPerBreast = 1;
        if (player.hasStatusEffect(StatusEffects.Feeder))
        {
            player.removeStatusEffect(StatusEffects.Feeder);
            player.removePerk(PerkLib.Feeder);
        }
        doNext(SoulforceCheats);
    }
    public function lilytest() : Void
    {
        SceneLib.lily.lilyEncounter();
    }

    public function new()
    {
        super();
    }
}

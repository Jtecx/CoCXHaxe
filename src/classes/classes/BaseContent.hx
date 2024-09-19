package classes;

import haxe.Constraints.Function;
import classes.globalFlags.KFLAGS;
import classes.items.*;
import classes.parser.Parser;
import classes.scenes.aPI.ExplorationEngine;
import classes.scenes.Camp;
import classes.scenes.combat.Combat;
import classes.scenes.dungeons.d3.D3;
import classes.scenes.dungeons.DungeonAbstractContent;
import classes.scenes.Holidays;
import classes.scenes.Inventory;
import classes.scenes.places.Ingnam;
import classes.scenes.QuestLib;
import classes.scenes.SceneLib;
import classes.transformations.TransformationLib;
import classes.internals.Utils;
import coc.model.GameModel;
import coc.model.TimeModel;
import coc.view.Block;
import coc.view.ButtonData;
import coc.view.ButtonDataList;
import coc.view.CoCButton;
import coc.view.MainView;
import coc.view.NotificationView;
import coc.view.charview.DragButton;
import coc.xxc.StoryContext;

/**
	 * Quick hacky method to wrap new content in a class-based structure
	 * BaseContent acts as an access wrapper around CoC, enabling children of BaseContent to interact with
	 * function instances/properties of CoC in the same manner older content does with the minimal amount
	 * of modification.
	 * Also this means we might start being able to get IDE autocomplete shit working again! Huzzah!
	 * @author Gedan
	 */
class BaseContent extends Utils
{
    private static var timeQ(get, never) : Float;
    private static var timeQueued(get, never) : Bool;
    public static var isNightTime(get, never) : Bool;
    private var camp(get, never) : Camp;
    private var ingnam(get, never) : Ingnam;
    private var d3(get, never) : D3;
    private static var date(get, never) : Date;
    private var inDungeon(get, set) : Bool;
    private var inRoomedDungeon(get, set) : Bool;
    private var inRoomedDungeonResume(get, set) : Function;
    private var combat(get, never) : Combat;
    private static var player(get, set) : Player;
    private var player2(get, set) : Player;
    private var debug(get, set) : Bool;
    private var ver(get, set) : String;
    private var images(get, set) : ImageManager;
    private var monster(get, set) : Monster;
    private var transformations(get, never) : TransformationLib;
    private var itemTemplates(get, never) : ItemTemplateLib;
    private static var consumables(get, never) : ConsumableLib;
    private static var useables(get, never) : UseableLib;
    private var weapons(get, never) : WeaponLib;
    private var weaponsrange(get, never) : WeaponRangeLib;
    private var weaponsflyingswords(get, never) : FlyingSwordsLib;
    private static var armors(get, never) : ArmorLib;
    private var miscjewelries(get, never) : MiscJewelryLib;
    private var headjewelries(get, never) : HeadJewelryLib;
    private var necklaces(get, never) : NecklaceLib;
    private var jewelries(get, never) : JewelryLib;
    private var shields(get, never) : ShieldLib;
    private var undergarments(get, never) : UndergarmentLib;
    private var vehicles(get, never) : VehiclesLib;
    private static var questLib(get, never) : QuestLib;
    private var inventory(get, never) : Inventory;
    private var time(get, set) : TimeModel;
    private static var mainView(get, never) : MainView;
    private var mainViewManager(get, never) : MainViewManager;
    private static var notificationView(get, never) : NotificationView;
    private static var model(get, set) : GameModel;
    private static var flags(get, never) : DefaultDict;
    private var achievements(get, set) : DefaultDict;
    private var sceneHunter(get, never) : SceneHunter;
    private var recalling(get, set) : Bool;
    private var mocking(get, set) : Bool;
    private static var shiftKeyDown(get, set) : Bool;
    private var context(get, never) : StoryContext;
    private static var explorer(get, never) : ExplorationEngine;

    private function cheatTime(time : Float, needNext : Bool = false) : Void
    {
        EventParser.cheatTime(time, needNext);
    }
    
    /**
		 * Advance time by `time` minutes. If overflows into next hour, delay this until next EngineCode.goNext call
		 * @param time
		 */
    private function advanceMinutes(time : Float) : Void
    {
        EventParser.advanceMinutes(time);
    }
    private static function get_timeQ() : Float
    {
        return CoC.instance.timeQ + Math.floor(CoC.instance.timeQmin / 60);
    }
    
    /**
		 * Time advancement is planned
		 */
    private static function get_timeQueued() : Bool
    {
        return CoC.instance.timeQ > 0 || CoC.instance.timeQmin > 0;
    }
    
    private static function get_isNightTime() : Bool
    {
        return (model.time.hours + timeQ <= 5 || model.time.hours + timeQ >= 22);
    }
    
    /**
		 * Examples:
		 * - isTimeBetween(12, 16) - 12:00..15:59
		 * - isTimeBetween(0, 6) - 0:00..5:59
		 * - isTimeBetween(18, 24) - 18:00..23:59
		 * */
    public static function isTimeBetween(startHour : Float, endHour : Float) : Bool
    {
        return (model.time.hours + timeQ >= startHour && model.time.hours + timeQ < endHour);
    }
    
    private function get_camp() : Camp
    {
        return SceneLib.camp;
    }
    
    private function get_ingnam() : Ingnam
    {
        return SceneLib.ingnam;
    }
    
    private function get_d3() : D3
    {
        return SceneLib.d3;
    }
    
    /**
		 * Advance queued time and execute scheduled events. Then go to playerMenu (camp/Ingnam)
		 * @param defNext Require [Next] button, otherwise can display the playerMenu right away
		 * @return {Boolean} true if some menu was displayed, false if no display or text only
		 */
    public function goNext(defNext : Bool) : Bool
    {
        return EventParser.goNext(defNext);
    }
    
    private function awardAchievement(title : String, achievement : Dynamic, display : Bool = true, nl : Bool = false, nl2 : Bool = true) : Void
    {
        return EngineCore.awardAchievement(title, achievement, display, nl, nl2);
    }
    
    private function isLunarNewYear() : Bool
    {
        return Holidays.isLunarNewYear();
    }
    
    private function isHalloween() : Bool
    {
        return Holidays.isHalloween();
    }
    
    private function isValentine() : Bool
    {
        return Holidays.isValentine();
    }
    
    private function isChristmas() : Bool
    {
        return Holidays.isChristmas();
    }
    
    public function isEaster() : Bool
    {
        return Holidays.isEaster();
    }
    
    private function isThanksgiving() : Bool
    {
        return Holidays.isThanksgiving();
    }
    
    private function isAprilFools() : Bool
    {
        return Holidays.isAprilFools();
    }
    
    private static function get_date() : Date
    {
        return CoC.instance.model.time.date;
    }
    
    private function get_inDungeon() : Bool
    {
        return DungeonAbstractContent.inDungeon;
    }
    
    private function set_inDungeon(v : Bool) : Bool
    {
        DungeonAbstractContent.inDungeon = v;
        return v;
    }
    
    private function get_inRoomedDungeon() : Bool
    {
        return DungeonAbstractContent.inRoomedDungeon;
    }
    private function set_inRoomedDungeon(v : Bool) : Bool
    {
        DungeonAbstractContent.inRoomedDungeon = v;
        return v;
    }
    
    private function get_inRoomedDungeonResume() : Function
    {
        return DungeonAbstractContent.inRoomedDungeonResume;
    }
    private function set_inRoomedDungeonResume(v : Function) : Function
    {
        DungeonAbstractContent.inRoomedDungeonResume = v;
        return v;
    }
    
    private function showStats() : Void
    {
        EngineCore.showStats();
    }
    
    private function statScreenRefresh() : Void
    {
        EngineCore.statScreenRefresh();
    }
    
    private function get_combat() : Combat
    {
        return SceneLib.combat;
    }
    
    private function cleanupAfterCombat(nextFunc : Function = null) : Void
    {
        SceneLib.combat.cleanupAfterCombatImpl(nextFunc);
    }
    
    private function cleanupAfterCombatTFEvent(nextFunc : Function = null, ThisIsNotATFScene : Bool = false) : Void
    {
        SceneLib.combat.cleanupAfterCombatImpl(nextFunc, ThisIsNotATFScene);
    }
    
    private function recoveryOfResources() : Void
    {
        SceneLib.combat.recoveryOfResourcesImpl();
    }
    
    private function enemyAI() : Void
    {
        SceneLib.combat.enemyAIImpl();
    }
    
    private function clearStatuses(visibility : Bool) : Void
    {
        player.clearStatuses(visibility);
    }
    
    private function spriteSelect(choice : Class<Dynamic> = null) : Void
    {
        CoC.instance.spriteSelect(choice);
    }
    
    private function hideStats() : Void
    {
        EngineCore.hideStats();
    }
    private function hideUpDown() : Void
    {
        EngineCore.hideUpDown();
    }
    
    private function createCallBackFunction(func : Function, arg : Dynamic) : Function
    {
        return EngineCore.createCallBackFunction(func, arg);
    }
    
    private function createCallBackFunction2(func : Function, args : Array<Dynamic> = null) : Function
    {
        return EngineCore.createCallBackFunction2.apply(null, [func].concat(args));
    }
    
    private function startCombat(monster_ : Monster, plotFight_ : Bool = false) : Void
    {
        if (player.hasStatusEffect(StatusEffects.HumanForm) && player.statusEffectv1(StatusEffects.HumanForm) >= 1)
        {
            player.addStatusValue(StatusEffects.HumanForm, 1, -1);
        }
        SceneLib.combat.startCombatImpl(monster_, plotFight_);
    }
    
    
    private function startCombatImmediate(monster : Monster, _plotFight : Bool = false) : Void
    {
        if (player.hasStatusEffect(StatusEffects.HumanForm) && player.statusEffectv1(StatusEffects.HumanForm) >= 1)
        {
            player.addStatusValue(StatusEffects.HumanForm, 1, -1);
        }
        SceneLib.combat.startCombatImmediateImpl(monster, _plotFight);
    }
    
    // Needed in a few rare cases for dumping text coming from a source that can't properly escape it's brackets
    // (Mostly traceback printing, etc...)
    private static function rawOutputText(output : String, purgeText : Bool = false) : Void
    {
        EngineCore.rawOutputText(output, purgeText);
    }
    
    private static function printLink(linkText : String, eventArgument : String) : Void
    {
        outputText(mkLink(linkText, eventArgument));
    }
    private static function mkLink(linkText : String, eventArgument : String) : String
    {
        return "<u><a href=\"event:" + encodeURI(eventArgument) + "\">" + linkText + "</a></u>";
    }
    
    private static function outputText(output : String) : Void
    {
        EngineCore.outputText(output);
    }
    
    private static function clearOutput() : Void
    {
        EngineCore.clearOutputTextOnly();
    }
    private function displayHeader(string : String) : Void
    {
        EngineCore.displayHeader(string);
    }
    
    private static function flushOutputTextToGUI() : Void
    {
        CoC.instance.flushOutputTextToGUI();
    }
    
    private function doNext(func : Function, args : Array<Dynamic> = null) : Void  //Now typesafe  
    {
        EngineCore.doNext.apply(null, [func].concat(args));
    }
    
    private static function menu() : Void
    {
        EngineCore.menu();
    }
    
    private function hideMenus() : Void
    {
        EngineCore.hideMenus();
    }
    
    //To be phased out
    private function choices(text1 : String, butt1 : Function,
            text2 : String, butt2 : Function,
            text3 : String, butt3 : Function,
            text4 : String, butt4 : Function,
            text5 : String, butt5 : Function,
            text6 : String, butt6 : Function,
            text7 : String, butt7 : Function,
            text8 : String, butt8 : Function,
            text9 : String, butt9 : Function,
            text0 : String, butt0 : Function) : Void
    //Now typesafe
    {
        
        EngineCore.choices(
                text1, butt1, 
                text2, butt2, 
                text3, butt3, 
                text4, butt4, 
                text5, butt5, 
                text6, butt6, 
                text7, butt7, 
                text8, butt8, 
                text9, butt9, 
                text0, butt0
        );
    }
    
    //To be phased out
    private function simpleChoices(text1 : String, butt1 : Function,
            text2 : String, butt2 : Function,
            text3 : String, butt3 : Function,
            text4 : String, butt4 : Function,
            text5 : String, butt5 : Function) : Void
    //Now typesafe
    {
        
        EngineCore.simpleChoices(text1, butt1, 
                text2, butt2, 
                text3, butt3, 
                text4, butt4, 
                text5, butt5
        );
    }
    
    private function doYesNo(eventYes : Function, eventNo : Function) : Void
    //Now typesafe
    {
        
        EngineCore.doYesNo(eventYes, eventNo);
    }
    
    private function addButton(pos : Int, text : String = "", func1 : Function = null, arg1 : Dynamic = -9000, arg2 : Dynamic = -9000, arg3 : Dynamic = -9000, toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        return EngineCore.addButton(pos, text, func1, arg1, arg2, arg3, toolTipText, toolTipHeader);
    }
    private function addFiveArgButton(pos : Int, text : String = "", func1 : Function = null, arg1 : Dynamic = -9000, arg2 : Dynamic = -9000, arg3 : Dynamic = -9000, arg4 : Dynamic = -9000, arg5 : Dynamic = -9000, toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        return EngineCore.fiveArgButton(pos, text, func1, arg1, arg2, arg3, arg4, arg5, toolTipText, toolTipHeader);
    }
    
    private function addButtonDisabled(pos : Int, text : String = "", toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        return EngineCore.addButtonDisabled(pos, text, toolTipText, toolTipHeader);
    }
    //This function is completely useless, but I'm too lazy to properly replace all its mentions. - SH
    private function addButtonIfTrue(pos : Int, text : String, func1 : Function, toolTipDisabled : String, condition : Bool, tooltipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        return EngineCore.addButton(pos, text, func1, null, null, null, tooltipText, toolTipHeader).disableIf(!condition, toolTipDisabled);
    }
    private static function button(pos : Int) : CoCButton
    {
        return EngineCore.button(pos);
    }
    
    private function removeButton(arg : Dynamic) : Void
    {
        EngineCore.removeButton(arg);
    }
    
    private function hasButton(arg : Dynamic) : Bool
    {
        return EngineCore.hasButton(arg);
    }
    
    private function openURL(url : String) : Void
    {
        return EngineCore.openURL(url);
    }
    
    private function sackDescript() : String
    {
        return Appearance.sackDescript(player);
    }
    
    private function cockClit(value : Int = 0) : String
    {
        if (player.hasCock() && value >= 0 && value < player.cockTotal())
        {
            return player.cockDescript(value);
        }
        else
        {
            return clitDescript();
        }
    }
    
    private function sheathDesc() : String
    {
        return CoC.instance.player.sheathDescription();
    }
    
    private function chestDesc() : String
    {
        return player.chestDesc();
    }
    
    private function allChestDesc() : String
    {
        return player.allChestDesc();
    }
    
    private function allBreastsDescript() : String
    {
        return Appearance.allBreastsDescript(player);
    }
    
    private function sMultiCockDesc() : String
    {
        return CoC.instance.player.sMultiCockDesc();
    }
    
    private function SMultiCockDesc() : String
    {
        return CoC.instance.player.SMultiCockDesc();
    }
    
    private function oMultiCockDesc() : String
    {
        return CoC.instance.player.oMultiCockDesc();
    }
    
    private function OMultiCockDesc() : String
    {
        return CoC.instance.player.OMultiCockDesc();
    }
    
    private function tongueDescript() : String
    {
        return Appearance.tongueDescription(player);
    }
    
    private function ballsDescriptLight(forcedSize : Bool = true) : String
    {
        return Appearance.ballsDescription(forcedSize, true, player);
    }
    
    private function ballDescript() : String
    {
        return Appearance.ballsDescription(false, false, player);
    }
    
    private function ballsDescript() : String
    {
        return Appearance.ballsDescription(false, true, player, true);
    }
    
    private function simpleBallsDescript() : String
    {
        return Appearance.ballsDescription(false, true, player);
    }
    
    private function assholeDescript() : String
    {
        return Appearance.assholeDescript(player);
    }
    
    private function eAssholeDescript() : String
    {
        return Appearance.assholeDescript(monster);
    }
    
    private function hipDescript() : String
    {
        return Appearance.hipDescription(player);
    }
    
    private function assDescript() : String
    {
        return Appearance.buttDescription(player);
    }
    
    private function buttDescript() : String
    {
        return Appearance.buttDescription(player);
    }
    
    private function assholeOrPussy() : String
    {
        return Appearance.assholeOrPussy(player);
    }
    
    private function nippleDescript(rowNum : Float) : String
    {
        return Appearance.nippleDescription(player, rowNum);
    }
    
    private function cockDescript(cockNum : Int = 0) : String
    {
        return CoC.instance.player.cockDescript(cockNum);
    }
    
    private function multiCockDescript() : String
    {
        return CoC.instance.player.multiCockDescript();
    }
    
    private function multiCockDescriptLight() : String
    {
        return CoC.instance.player.multiCockDescriptLight();
    }
    
    private function breastDescript(rowNum : Float) : String
    {
        return player.breastDescript(rowNum);
    }
    
    private function breastSize(val : Float) : String
    {
        return Appearance.breastSize(val);
    }
    
    private function biggestBreastSizeDescript() : String
    {
        return Appearance.biggestBreastSizeDescript(player);
    }
    
    private function hairDescript() : String
    {
        return Appearance.hairDescription(player);
    }
    
    private function beardDescript() : String
    {
        return Appearance.beardDescription(player);
    }
    
    private function hairOrFur() : String
    {
        return Appearance.hairOrFur(player);
    }
    
    private function clitDescript() : String
    {
        return Appearance.clitDescription(player);
    }
    
    private function vaginaDescript(vaginaNum : Float = 0) : String
    {
        return Appearance.vaginaDescript(player, vaginaNum);
    }
    
    //useless until multivaginas are added
    /*
		protected function allVaginaDescript():String
		{
    if (player.vaginas.length == 1) return vaginaDescript(rand(player.vaginas.length - 1));
    if (player.vaginas.length > 1) return (vaginaDescript(rand(player.vaginas.length - 1)) + "s");

    CoC_Settings.error("ERROR: allVaginaDescript called with no vaginas.");
    return "ERROR: allVaginaDescript called with no vaginas.";
		}
		*/
    
    /**
		 * Apply statmods to the player. dynStats wraps the regular stats call, but supports "named" arguments of the form:
		 * 		"statname", value.
		 * Exclusively supports either long or short stat names with a single call.
		 * "str", "lib" "lus", "cor" etc
		 * "strength, "libido", lust", "corruption"
		 * Specify the stat you wish to modify and follow it with the value.
		 * Separate each stat and value with a comma, and each stat/value pair, again, with a comma.
		 * eg: dynStats("str", 10, "lust" -100); will add 10 to str and subtract 100 from lust
		 * Also support operators could be appended with + - * /=
		 * eg: dynStats("str+", 1, "tou-", 2, "spe*", 1.1, "int/", 2, "cor=", 0)
		 *     will add 1 to str, subtract 2 from tou, increase spe by 10%, decrease int by 50%, and set cor to 0
		 *
		 * @param	... args
		 */
    private function dynStats(args : Array<Dynamic> = null) : Void
    // Bullshit to unroll the incoming array
    {
        
        player.dynStats.apply(player, args);
    }
    
    private function MutagenBonus(statName : String, bonus : Float, applyEffect : Bool = true) : Bool
    {
        return player.MutagenBonus(statName, bonus, applyEffect);
    }
    
    private function alchemyBonus(statName : String, bonus : Float) : Void
    {
        return player.alchemyBonus(statName, bonus);
    }
    
    private function KnowledgeBonus(statName : String, bonus : Float) : Void
    {
        return player.KnowledgeBonus(statName, bonus);
    }
    
    private function silly() : Bool
    {
        return EngineCore.silly();
    }
    
    private function HPChange(changeNum : Float, display : Bool) : Void
    {
        EngineCore.HPChange(changeNum, display);
    }
    
    // For fatigue(mod,type) calls
    public static inline var USEFATG_NORMAL : Int = 0;
    public static inline var USEFATG_MAGIC : Int = 1;
    public static inline var USEFATG_PHYSICAL : Int = 2;
    public static inline var USEFATG_MAGIC_NOBM : Int = 3;
    public static inline var USEFATG_BOW : Int = 4;
    public static inline var USEFATG_WHITE : Int = 5;
    public static inline var USEFATG_BLACK : Int = 6;
    public static inline var USEFATG_WHITE_NOBM : Int = 7;
    public static inline var USEFATG_BLACK_NOBM : Int = 8;
    
    private function fatigue(mod : Float, type : Float = USEFATG_NORMAL) : Void
    {
        EngineCore.fatigue(mod, type);
    }
    
    public static inline var USEMANA_NORMAL : Int = 0;
    private function useMana(mod : Float, type : Float = USEMANA_NORMAL) : Void
    {
        SceneLib.combat.useManaImpl(mod, type);
    }
    
    private static function playerMenu() : Void
    {
        EventParser.playerMenu();
    }
    private static function get_player() : Player
    {
        return CoC.instance.player;
    }
    
    private function set_player(val : Player) : Player
    {
        CoC.instance.player = val;
        return val;
    }
    
    private function get_player2() : Player
    {
        return CoC.instance.player2;
    }
    
    private function set_player2(val : Player) : Player
    {
        CoC.instance.player2 = val;
        return val;
    }
    
    private function get_debug() : Bool
    {
        return CoC.instance.debug;
    }
    
    private function set_debug(val : Bool) : Bool
    {
        CoC.instance.debug = val;
        return val;
    }
    
    private function get_ver() : String
    {
        return CoC.instance.ver;
    }
    
    private function set_ver(val : String) : String
    {
        CoC.instance.ver = val;
        return val;
    }
    
    private function get_images() : ImageManager
    {
        return CoC.instance.images;
    }
    
    private function set_images(val : ImageManager) : ImageManager
    {
        CoC.instance.images = val;
        return val;
    }
    
    private function get_monster() : Monster
    {
        return CoC.instance.monster;
    }
    
    private function set_monster(val : Monster) : Monster
    {
        CoC.instance.monster = val;
        return val;
    }
    
    private function get_transformations() : TransformationLib
    {
        return CoC.instance.transformations;
    }
    private function get_itemTemplates() : ItemTemplateLib
    {
        return ItemTemplateLib.instance;
    }
    private static function get_consumables() : ConsumableLib
    {
        return CoC.instance.consumables;
    }
    private static function get_useables() : UseableLib
    {
        return CoC.instance.useables;
    }
    private function get_weapons() : WeaponLib
    {
        return CoC.instance.weapons;
    }
    private function get_weaponsrange() : WeaponRangeLib
    {
        return CoC.instance.weaponsrange;
    }
    private function get_weaponsflyingswords() : FlyingSwordsLib
    {
        return CoC.instance.weaponsflyingswords;
    }
    private static function get_armors() : ArmorLib
    {
        return CoC.instance.armors;
    }
    private function get_miscjewelries() : MiscJewelryLib
    {
        return CoC.instance.miscjewelries;
    }
    private function get_headjewelries() : HeadJewelryLib
    {
        return CoC.instance.headjewelries;
    }
    private function get_necklaces() : NecklaceLib
    {
        return CoC.instance.necklaces;
    }
    private function get_jewelries() : JewelryLib
    {
        return CoC.instance.jewelries;
    }
    private function get_shields() : ShieldLib
    {
        return CoC.instance.shields;
    }
    private function get_undergarments() : UndergarmentLib
    {
        return CoC.instance.undergarments;
    }
    private function get_vehicles() : VehiclesLib
    {
        return CoC.instance.vehicles;
    }
    
    private static function get_questLib() : QuestLib
    {
        return CoC.instance.questLib;
    }
    private function get_inventory() : Inventory
    {
        return SceneLib.inventory;
    }
    
    private function get_time() : TimeModel
    {
        return CoC.instance.time;
    }
    
    private function set_time(val : TimeModel) : TimeModel
    {
        CoC.instance.time = val;
        return val;
    }
    
    private static function get_mainView() : MainView
    {
        return CoC.instance.mainView;
    }
    
    private function get_mainViewManager() : MainViewManager
    {
        return CoC.instance.mainViewManager;
    }
    
    private static function get_notificationView() : NotificationView
    {
        return CoC.instance.mainView.notificationView;
    }
    
    private static function get_model() : GameModel
    {
        return CoC.instance.model;
    }
    
    private function set_model(val : GameModel) : GameModel
    {
        CoC.instance.model = val;
        return val;
    }
    
    private static function get_flags() : DefaultDict
    {
        return CoC.instance.flags;
    }
    
    private function get_achievements() : DefaultDict
    {
        return CoC.instance.achievements;
    }
    
    private function set_achievements(val : DefaultDict) : DefaultDict
    {
        CoC.instance.achievements = val;
        return val;
    }
    
    //==========================
    //SceneHunter shortcuts
    private function get_sceneHunter() : SceneHunter
    {
        return CoC.instance.gameSettings.sceneHunter_inst;
    }
    private function get_recalling() : Bool
    {
        return CoC.instance.gameSettings.sceneHunter_inst._recalling;
    }
    private function set_recalling(val : Bool) : Bool
    {
        CoC.instance.gameSettings.sceneHunter_inst._recalling = val;
        return val;
    }
    private function recallWakeUp() : Void
    {
        CoC.instance.gameSettings.sceneHunter_inst.recallWakeUpImpl();
    }
    private function get_mocking() : Bool
    {
        return CoC.instance.gameSettings.sceneHunter_inst._mocking;
    }
    private function set_mocking(val : Bool) : Bool
    {
        CoC.instance.gameSettings.sceneHunter_inst._mocking = val;
        return val;
    }
    //============================
    
    private function showStatDown(arg : String) : Void
    {
        CoC.instance.mainView.statsView.showStatDown(arg);
    }
    
    private function showStatUp(arg : String) : Void
    {
        CoC.instance.mainView.statsView.showStatUp(arg);
    }
    
    private function buttonTextIsOneOf(index : Int, possibleLabels : Array<Dynamic>) : Bool
    {
        return EngineCore.buttonTextIsOneOf(index, possibleLabels);
    }
    
    private function getButtonText(index : Int) : String
    {
        return EngineCore.getButtonText(index);
    }
    
    private function buttonIsVisible(index : Int) : Bool
    {
        return EngineCore.buttonIsVisible(index);
    }
    
    private static function get_shiftKeyDown() : Bool
    {
        return flags[kFLAGS.SHIFT_KEY_DOWN];
    }
    private static function set_shiftKeyDown(value : Bool) : Bool
    {
        flags[kFLAGS.SHIFT_KEY_DOWN] = value;
        return value;
    }
    
    private function darkTheme() : Bool
    {
        return CoC.instance.mainViewManager.darkThemeImpl();
    }
    private static function onGameInit(f : Function) : Void
    {
        CoC.onGameInit(f);
    }
    private function get_context() : StoryContext
    {
        return CoC.instance.context;
    }
    private static function get_explorer() : ExplorationEngine
    {
        return SceneLib.explorationEngine;
    }
    /**
		 * [Next] to camp or exploration map
		 * @param timePassedMinutes Advance time, -1 for default value
		 * */
    private function endEncounter(timePassedMinutes : Int = -1) : Void
    {
        doNext(curry(explorer.done, timePassedMinutes));
    }
    
    private function adjustedPlayerLevel() : Int
    {
        return as3hx.Compat.parseInt(player.level + combat.playerLevelAdjustment());
    }
    
    public static var submenuPage : Int = 0;
    /**
		 * Print a submenu from the provided buttons
		 * @param buttons List of buttons for the menu
		 * @param back Function for the "Back" button (14)
		 * @param page Currently displayed page
		 * @param IsSorted If true, the buttons will be sorted by their names
		 * @param constButtons Adds constant buttons, aside from Prev/Next page. Arrays ["Name", Function]
		 */
    public static function submenu(buttons : ButtonDataList, back : Function = null, page : Int = 0, IsSorted : Bool = true, constButtons : Array<Dynamic> = null) : Void
    {
        if (constButtons == null)
        {
            constButtons = [];
        }
        var list : Array<Dynamic> = buttons.list.filter(function(e : ButtonData, i : Int, a : Array<Dynamic>) : Bool
                {
                    return e.visible;
                });
        if (IsSorted)
        {
            list.sortOn("text");
        }
        // find out how much buttons we can place on each page
        var total : Int = list.length;  // total number of menu buttons  
        var totalConst : Int = as3hx.Compat.parseInt(constButtons.length + ((back != null) ? 1 : 0));  // const buttons on each page  
        if (total + totalConst > 15)
        
        //can't fit on 1 page!{
            
            totalConst += 2;
        }  // prev/nex  
        var buttonsPerPage : Int = as3hx.Compat.parseInt(15 - totalConst);  // including back, prev/next, other shit  
        var pageCount : Int = Math.ceil(total / buttonsPerPage);
        page = boundInt(0, page, pageCount);
        submenuPage = page;
        menu();
        // menu buttons
        var n : Int = Math.min(total, (page + 1) * buttonsPerPage);  // max index for this page  
        var bi : Int = 0;  // button index  
        var li : Int = as3hx.Compat.parseInt(page * buttonsPerPage);
        while (li < n)
        {
            list[li].applyTo(button(bi % buttonsPerPage));
            li++;
            bi++;
        }
        // const buttons
        bi = as3hx.Compat.parseInt(15 - totalConst);
        var cbi : Int = 0;
        while (cbi < constButtons.length)
        {
            if (constButtons[cbi][0] != null && constButtons[cbi][1] != null)
            {
                button(bi).show(constButtons[cbi][0], constButtons[cbi][1]).hint((constButtons[cbi].length > 2) ? constButtons[cbi][2] : "");
            }
            ++cbi;
            ++bi;
        }
        if (page != 0 || total > buttonsPerPage)
        {
            button(bi++).show("Prev Page", curry(submenu, buttons, back, page - 1, IsSorted, constButtons)).disableIf(page == 0).icon("Left");
            button(bi++).show("Next Page", curry(submenu, buttons, back, page + 1, IsSorted, constButtons)).disableIf(n >= total).icon("Right");
        }
        if (back != null)
        {
            button(bi++).show("Back", back);
        }
    }
    
    /**
		 * Display a 5xN button grid after the current text.
		 * @param bd Button data, row-by-row.
		 * If label is an empty string, it's an empty cell.
		 * If bd.extraData is "text", a text field is added instead of button (to add text between button rows)
		 * @example
		 * var bd:ButtonDataList = new ButtonDataList();
		 * // Row 1
		 * bd.add("");
		 * bd.add("North", goNorth);
		 * bd.add("");
		 * bd.add("");
		 * bd.add("Climb Up", climbUp).disableIf(!canClimbUp);
		 * // Row 2
		 * bd.add("West", goWest);
		 * bd.add("South", goSouth);
		 * bd.add("East", goEast);
		 * bd.add("");
		 * bd.add("Climb Down", climbDown);
		 *
		 * bigButtonGrid(bd);
		 */
    private static function bigButtonGrid(bd : ButtonDataList) : Void
    {
        DragButton.cleanUp();
        flushOutputTextToGUI();
        var grid : Block = new Block({
            layoutConfig : {
                type : "grid",
                cols : 5
            }
        });
        for (i in 0...bd.list.length)
        {
            var b : ButtonData = bd.list[i];
            if (b.extraData == "text")
            {
                grid.addTextField({
                            width : MainView.BTN_W,
                            height : MainView.BTN_H,
                            htmlText : Parser.recursiveParser(b.text),
                            defaultTextFormat : mainView.mainText.defaultTextFormat
                        });
            }
            else if (b.text == "")
            
            // add spacer{
                
                grid.addElement(new Block({
                            width : MainView.BTN_W,
                            height : MainView.BTN_H
                        }));
            }
            // add button
            else
            {
                
                var btn : CoCButton = new CoCButton();
                b.applyTo(btn);
                grid.addElement(btn);
                if (b.draggable)
                {
                    new DragButton(b.slot, btn, b.slotType);
                }
            }
        }
        mainView.setCustomElement(grid, true, true);
        grid.doLayout();
    }
    
    /**
		 * Displays a selection to call the function with a number
		 * @param fun Function to call
		 * @param from Minimum number (inclusive)
		 * @param to Maximum number (inclusive)
		 * @param back "Back" button function (optional)
		 */
    public static function pickANumber(fun : Function, from : Int, to : Int, back : Function = null) : Void
    {
        var bd : ButtonDataList = new ButtonDataList();
        for (i in from...to + 1)
        {
            bd.add(Std.string(i), curry(fun, i));
        }
        BaseContent.submenu(bd, back, 0, false);
    }

    public function new()
    {
        super();
    }
}



package classes;

import haxe.Constraints.Function;
import classes.globalFlags.KFLAGS;
import classes.iMutations.IMutationsLib;
import classes.parser.Parser;
import classes.scenes.SceneLib;
import classes.internals.Utils;
import coc.view.CoCButton;
import coc.view.MainView;
import coc.view.charview.DragButton;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

class EngineCore
{
    private static var funcLookups : Dictionary = null;
    private static var allStats : Array<Dynamic> = ["str", "tou", "spe", "inte", "wis", "lib", "sens", "cor", "HP", "lust", "wrath", "fatigue", "mana", "soulforce", "hunger"];
    private static var allStatsOld : Array<Dynamic> = [];
    public function new()
    {
        GenerateCodeBits();
    }
    private static function _oldStatNameFor(statName : String) : String
    {
        return "old" + statName.charAt(0).toUpperCase() + statName.substr(1);
    }
    private static function GenerateCodeBits() : Void
    {
        for (statstr in allStats)
        {
            allStatsOld.push(_oldStatNameFor(statstr));
        }
    }
    
    public static function maxHP() : Float
    {
        return CoC.instance.player.maxHP();
    }
    
    public static function maxOverHP() : Float
    {
        return CoC.instance.player.maxOverHP();
    }
    
    public static function maxOverHPCW() : Float
    {
        var mOHPCW : Float = maxOverHP();
        if (CoC.instance.player.hasStatusEffect(StatusEffects.CombatWounds))
        {
            mOHPCW *= (1 - CoC.instance.player.statusEffectv1(StatusEffects.CombatWounds));
            mOHPCW = Math.round(mOHPCW);
        }
        return mOHPCW;
    }
    
    public static function minHP() : Float
    {
        return CoC.instance.player.minHP();
    }
    
    public static function maxSoulforce() : Float
    {
        return CoC.instance.player.maxSoulforce();
    }
    
    public static function maxOverSoulforce() : Float
    {
        return CoC.instance.player.maxOverSoulforce();
    }
    
    public static function maxWrath() : Float
    {
        return CoC.instance.player.maxWrath();
    }
    
    public static function maxOverWrath() : Float
    {
        return CoC.instance.player.maxOverWrath();
    }
    
    public static function maxMana() : Float
    {
        return CoC.instance.player.maxMana();
    }
    
    public static function maxOverMana() : Float
    {
        return CoC.instance.player.maxOverMana();
    }
    
    public static function maxVenom() : Float
    {
        return CoC.instance.player.maxVenom();
    }
    
    public static function silly() : Bool
    {
        return CoC.instance.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] == 1;
    }
    
    /**
     * Alters player's HP.
     * @param    changeNum The amount to damage (negative) or heal (positive).
     * @param    display Show the damage or heal taken.
     * @return  effective delta
     */
    public static function HPChange(changeNum : Float, display : Bool) : Float
    {
        var before : Float = CoC.instance.player.HP;
        var healingFromHealer : Float = 1;
        if (changeNum == 0)
        {
            return 0;
        }
        if (changeNum > 0)
        
        //Increase by 20%!{
            
            if (CoC.instance.player.hasPerk(PerkLib.HistoryHealer) || CoC.instance.player.hasPerk(PerkLib.PastLifeHealer))
            {
                healingFromHealer += 0.2;
                if (CoC.instance.player.hasPerk(PerkLib.Nurse))
                {
                    healingFromHealer += 0.2;
                }
                if (CoC.instance.player.hasPerk(PerkLib.Doctor))
                {
                    healingFromHealer += 0.2;
                }
                if (CoC.instance.player.hasPerk(PerkLib.FirstResponse))
                {
                    healingFromHealer += 0.2;
                }
                if (CoC.instance.player.hasPerk(PerkLib.Paramedic))
                {
                    healingFromHealer += 0.2;
                }
                if (CoC.instance.player.hasPerk(PerkLib.SurgeonsAide))
                {
                    healingFromHealer += 0.2;
                }
                if (CoC.instance.player.hasPerk(PerkLib.Surgeon))
                {
                    healingFromHealer += 0.2;
                }
                if (CoC.instance.player.hasPerk(PerkLib.Medic))
                {
                    healingFromHealer += 0.2;
                }
                changeNum *= healingFromHealer;
                changeNum = Math.min(changeNum, as3hx.Compat.INT_MAX);
            }
            if (Math.min(CoC.instance.player.HP + changeNum, as3hx.Compat.INT_MAX) > maxOverHPCW())
            {
                if (CoC.instance.player.HP >= maxOverHPCW())
                {
                    if (display)
                    {
                        cast((changeNum), HPChangeNotify);
                    }
                    return CoC.instance.player.HP - before;
                }
                if (display)
                {
                    cast((changeNum), HPChangeNotify);
                }
                CoC.instance.player.HP = maxOverHPCW();
            }
            else
            {
                if (display)
                {
                    cast((changeNum), HPChangeNotify);
                }
                CoC.instance.player.HP += as3hx.Compat.parseInt(changeNum);
                CoC.instance.mainView.statsView.showStatUp("hp");
            }
        }
        //Negative HP
        else
        {
            if (CoC.instance.player.HP + changeNum <= minHP())
            {
                if (display)
                {
                    cast((changeNum), HPChangeNotify);
                }
                CoC.instance.player.HP = minHP();
                CoC.instance.mainView.statsView.showStatDown("hp");
            }
            else
            {
                if (display)
                {
                    cast((changeNum), HPChangeNotify);
                }
                CoC.instance.player.HP += changeNum;
                CoC.instance.mainView.statsView.showStatDown("hp");
            }
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false);  //Workaround to showing the arrow.  
        statScreenRefresh();
        return CoC.instance.player.HP - before;
    }
    
    public static function HPChangeNotify(changeNum : Float) : Void
    {
        if (changeNum == 0)
        {
            if (CoC.instance.player.HP >= maxOverHP())
            {
                outputText("You're as healthy as you can be.\n");
            }
        }
        else if (changeNum > 0)
        {
            if (CoC.instance.player.HP >= maxOverHP())
            {
                outputText("Your HP maxes out at " + maxOverHP() + ".\n");
            }
            else
            {
                outputText("You gain <b>[font-heal]" + Utils.formatNumber(as3hx.Compat.parseInt(changeNum)) + "[/font]</b> HP.\n");
            }
        }
        else if (CoC.instance.player.HP <= minHP())
        {
            outputText("You take <b>[font-damage]" + Utils.formatNumber(as3hx.Compat.parseInt(changeNum * -1)) + "[/font]</b>" +
                    " damage, dropping your HP to " + minHP() + ".\n");
        }
        else
        {
            outputText("You take <b>[font-damage]" + Utils.formatNumber(as3hx.Compat.parseInt(changeNum * -1)) + "[/font]</b> damage.\n");
        }
    }
    
    public static function SoulforceChange(changeNum : Float) : Float
    {
        var before : Float = CoC.instance.player.soulforce;
        if (changeNum == 0)
        {
            return 0;
        }
        if (changeNum > 0)
        {
            if (CoC.instance.player.soulforce + as3hx.Compat.parseInt(changeNum) > maxOverSoulforce())
            {
                CoC.instance.player.soulforce = maxOverSoulforce();
            }
            else
            {
                CoC.instance.player.soulforce += changeNum;
            }
        }
        else if (CoC.instance.player.soulforce + changeNum <= 0)
        {
            CoC.instance.player.soulforce = 0;
        }
        else
        {
            CoC.instance.player.soulforce += changeNum;
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false);
        statScreenRefresh();
        return CoC.instance.player.soulforce - before;
    }
    
    public static function ManaChange(changeNum : Float) : Float
    {
        var before : Float = CoC.instance.player.mana;
        if (changeNum == 0)
        {
            return 0;
        }
        if (changeNum > 0)
        {
            if (CoC.instance.player.mana + as3hx.Compat.parseInt(changeNum) > maxOverMana())
            {
                CoC.instance.player.mana = maxOverMana();
            }
            else
            {
                CoC.instance.player.mana += changeNum;
            }
        }
        else
        {
            if (CoC.instance.player.mana + changeNum <= 0)
            {
                CoC.instance.player.mana = 0;
            }
            else
            {
                CoC.instance.player.mana += changeNum;
            }
            if (CoC.instance.player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 3)
            {
                HPChange(-changeNum, false);
            }
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false)  //Workaround to showing the arrow.  ;
        statScreenRefresh();
        return CoC.instance.player.mana - before;
    }
    
    public static function WrathChange(changeNum : Float) : Float
    {
        var before : Float = CoC.instance.player.wrath;
        if (changeNum == 0)
        {
            return 0;
        }
        if (changeNum > 0)
        {
            if (CoC.instance.player.wrath + as3hx.Compat.parseInt(changeNum) > maxOverWrath())
            {
                CoC.instance.player.wrath = maxOverWrath();
            }
            else
            {
                CoC.instance.player.wrath += changeNum;
            }
        }
        else if (CoC.instance.player.wrath + changeNum <= 0)
        {
            CoC.instance.player.wrath = 0;
        }
        else
        {
            CoC.instance.player.wrath += changeNum;
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false)  //Workaround to showing the arrow.  ;
        statScreenRefresh();
        return CoC.instance.player.wrath - before;
    }
    
    public static function VenomWebChange(changeNum : Float) : Float
    {
        var before : Float = CoC.instance.player.tailVenom;
        if (changeNum == 0)
        {
            return 0;
        }
        if (changeNum > 0)
        {
            if (CoC.instance.player.tailVenom + as3hx.Compat.parseInt(changeNum) > maxVenom())
            {
                CoC.instance.player.tailVenom = maxVenom();
            }
            else
            {
                CoC.instance.player.tailVenom += changeNum;
            }
        }
        else if (CoC.instance.player.tailVenom + changeNum <= 0)
        {
            CoC.instance.player.tailVenom = 0;
        }
        else
        {
            CoC.instance.player.tailVenom += changeNum;
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false)  //Workaround to showing the arrow.  ;
        statScreenRefresh();
        return CoC.instance.player.tailVenom - before;
    }
    
    public static function clone(source : Dynamic) : Dynamic
    {
        var copier : ByteArray = new ByteArray();
        copier.writeObject(source);
        copier.position = 0;
        return (copier.readObject());
    }
    
    public static function clearOutputTextOnly(forget : Bool = false) : Void
    {
        DragButton.cleanUp();
        if (!forget && CoC.instance.currentText.length > 0)
        {
            CoC.instance.textHistory.push(CoC.instance.currentText);
            while (CoC.instance.textHistory.length > 20)
            {
                CoC.instance.textHistory.shift();
            }
        }
        CoC.instance.currentText = "";
        CoC.instance.mainView.clearOutputText();
    }
    
    /**
     * Clear the text on screen.
     */
    public static function clearOutput() : Void
    {
        CoC.instance.forceUpdate();
        clearOutputTextOnly();
        if (CoC.instance.gameState != 3)
        {
            CoC.instance.mainView.hideMenuButton(MainView.MENU_DATA);
        }
        CoC.instance.mainView.hideMenuButton(MainView.MENU_APPEARANCE);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_LEVEL);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_PERKS);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_STATS);
    }
    
    /**
     * Basically the same as outputText() but without the parser tags. Great for displaying square brackets on text.
     * @param    output The text to show. It can be formatted such as bold, italics, and underline tags.
     * @param    purgeText Clear the old text.
     */
    public static function rawOutputText(output : String, purgeText : Bool = false) : Void
    //OUTPUT!
    {
        
        if (purgeText)
        
        //if(!debug) mainText.htmlText = output;{
            
            //trace("Purging and writing Text", output);
            clearOutput();
            CoC.instance.currentText = output;
            CoC.instance.mainView.setOutputText(output);
        }
        //trace("Adding Text");
        else
        {
            
            CoC.instance.currentText += output;
            CoC.instance.mainView.appendOutputText(output);
        }
    }
    
    /**
     * Output the text on main text interface.
     * @param    output The text to show. It can be formatted such as bold, italics, and underline tags.
     */
    public static function outputText(output : String) : Void
    // This is cleaup in case someone hits the Data or new-game button when the event-test window is shown.
    {
        
        // It's needed since those buttons are available even when in the event-tester
        CoC.instance.mainView.hideTestInputPanel();
        
        
        output = Parser.recursiveParser(output);
        
        //OUTPUT!
        CoC.instance.currentText += output;
    }
    
    public static function displayHeader(string : String) : Void
    {
        outputText("<font size=\"36\" face=\"Georgia\"><u>" + string + "</u></font>\n");
    }
    
    public static function buttonIsVisible(index : Int) : Bool
    {
        if (index < 0 || index > 14)
        {
            return null;
        }
        else
        {
            return button(index).visible;
        }
    }
    
    public static function buttonTextIsOneOf(index : Int, possibleLabels : Array<Dynamic>) : Bool
    {
        var buttonText : String = getButtonText(index);
        return (Lambda.indexOf(possibleLabels, buttonText) != -1);
    }
    
    public static function getButtonText(index : Int) : String
    {
        if (index < 0 || index > 14)
        {
            return "";
        }
        else
        {
            return button(index).labelText;
        }
    }
    
    public static function getButtonToolTipHeader(buttonText : String) : String
    {
        var toolTipHeader : String;
        
        if (buttonText.indexOf(" x") != -1)
        {
            buttonText = buttonText.split(" x")[0];
        }
        
        //Get items
        var itype : ItemType = ItemType.lookupItem(buttonText);
        var temp : String = "";
        if (itype != null)
        {
            temp = itype.longName;
        }
        itype = ItemType.lookupItemByShort(buttonText);
        if (itype != null)
        {
            temp = itype.longName;
        }
        if (temp != "")
        {
            temp = Utils.capitalizeFirstLetter(temp);
            toolTipHeader = temp;
        }
        
        //Set tooltip header to button.
        if (toolTipHeader == null)
        {
            toolTipHeader = buttonText;
        }
        
        return toolTipHeader;
    }
    
    public static function getButtonToolTipText(buttonText : String) : String
    {
        var toolTipText : String;
        
        buttonText = buttonText || "";
        
        //Items
        //if (/^....... x\d+$/.test(buttonText)){
        //	buttonText = buttonText.substring(0,7);
        //}
        
        // Fuck your regex
        if (buttonText.indexOf(" x") != -1)
        {
            buttonText = buttonText.split(" x")[0];
        }
        
        var itype : ItemType = ItemType.lookupItem(buttonText);
        if (itype != null)
        {
            toolTipText = itype.description;
        }
        itype = ItemType.lookupItemByShort(buttonText);
        if (itype != null)
        {
            toolTipText = itype.description;
        }
        
        //------------
        // COMBAT
        //------------
        if (buttonText.indexOf("Defend") != -1)
        
        //Not used at the moment.{
            
            toolTipText = "Selecting defend will reduce the damage you take by 66 percent, but will not affect any lust incurred by your enemy's actions.";
        }
        //Urta's specials - MOVED
        //P. Special attacks - MOVED
        //M. Special attacks - MOVED
        
        //------------
        // MASTURBATION
        //------------
        //Masturbation Toys
        if (buttonText.indexOf("AN Stim-Belt") != -1)
        {
            toolTipText = "This is an all-natural self-stimulation belt.  The methods used to create such a pleasure device are unknown.  It seems to be organic in nature.";
        }
        if (buttonText.indexOf("Stim-Belt") != -1)
        {
            toolTipText = "This is a self-stimulation belt.  Commonly referred to as stim-belts, these are clockwork devices designed to pleasure the female anatomy.";
        }
        if (buttonText.indexOf("AN Onahole") != -1)
        {
            toolTipText = "An all-natural onahole, this device looks more like a bulbous creature than a sex-toy.  Nevertheless, the slick orifice it presents looks very inviting.";
        }
        if (buttonText.indexOf("D Onahole") != -1)
        {
            toolTipText = "This is a deluxe onahole, made of exceptional materials and with the finest craftsmanship in order to bring its user to the height of pleasure.";
        }
        if (buttonText.indexOf("Onahole") != -1)
        {
            toolTipText = "This is what is called an 'onahole'.  This device is a simple textured sleeve designed to fit around the male anatomy in a pleasurable way.";
        }
        if (buttonText.indexOf("Dual Belt") != -1)
        {
            toolTipText = "This is a strange masturbation device, meant to work every available avenue of stimulation.";
        }
        if (buttonText.indexOf("C. Pole") != -1)
        {
            toolTipText = "This 'centaur pole' as it's called appears to be a sex-toy designed for females of the equine persuasion.  Oddly, it's been sculpted to look like a giant imp, with an even bigger horse-cock.";
        }
        if (buttonText.indexOf("Fake Mare") != -1)
        {
            toolTipText = "This fake mare is made of metal and wood, but the anatomically correct vagina looks as soft and wet as any female centaur's.";
        }
        //Books
        if (buttonText.indexOf("Dangerous Plants") != -1)
        {
            toolTipText = "This is a book titled 'Dangerous Plants'.  As explained by the title, this tome is filled with information on all manner of dangerous plants from this realm.";
        }
        if (buttonText.indexOf("Traveler's Guide") != -1)
        {
            toolTipText = "This traveler's guide is more of a pamphlet than an actual book, but it still contains some useful information on avoiding local pitfalls.";
        }
        if (buttonText.indexOf("Yoga Guide") != -1)
        {
            toolTipText = "This leather-bound book is titled 'Yoga for Non-Humanoids.' It contains numerous illustrations of centaurs, nagas and various other oddly-shaped beings in a variety of poses.";
        }
        if (buttonText.indexOf("Hentai Comic") != -1)
        {
            toolTipText = "This oddly drawn comic book is filled with images of fornication, sex, and overly large eyeballs.";
        }
        //------------
        // TITLE SCREEN
        //------------
        if (buttonText.indexOf("ASPLODE") != -1)
        {
            toolTipText = "MAKE SHIT ASPLODE";
        }
        return toolTipText;
    }
    
    public static function getFunctionName(f : Function) : String
    // trace("Getting function name")
    {
        
        // get the object that contains the function (this of f)
        //var t:Object = flash.sampler.getSavedThis(f);
        if (funcLookups == null)
        {
            trace("Rebuilding lookup object");
            funcLookups = new Dictionary();
            buildFuncLookupDict();
        }
        
        
        if (Lambda.has(funcLookups, f))
        {
            return (Reflect.field(funcLookups, Std.string(f)));
        }
        
        // if we arrive here, we haven't found anything...
        // maybe the function is declared in the private namespace?
        return null;
    }
    
    public static function createCallBackFunction(func : Function, arg : Dynamic, arg2 : Dynamic = null, arg3 : Dynamic = null) : Function
    {
        if (func == null)
        {
            CoC_Settings.error("createCallBackFunction(null," + arg + ")");
        }
        var somagicnumber : Float = -9000;
        
        if (arg == somagicnumber || arg == null)
        {
            return function() : Dynamic
            {
                if (CoC_Settings.haltOnErrors)
                {
                    logFunctionInfo(func, arg);
                }
                return func();
            };
        }
        else if (arg2 == somagicnumber || arg2 == null)
        {
            return function() : Dynamic
            {
                if (CoC_Settings.haltOnErrors)
                {
                    logFunctionInfo(func, arg);
                }
                return func(arg);
            };
        }
        else if (arg3 == somagicnumber || arg3 == null)
        {
            return function() : Dynamic
            {
                if (CoC_Settings.haltOnErrors)
                {
                    logFunctionInfo(func, arg, arg2);
                }
                return func(arg, arg2);
            };
        }
        else
        {
            return function() : Dynamic
            {
                if (CoC_Settings.haltOnErrors)
                {
                    logFunctionInfo(func, arg, arg2, arg3);
                }
                return func(arg, arg2, arg3);
            };
        }
    }
    
    public static function createCallBackFunction2(func : Function, args : Array<Dynamic> = null) : Function
    {
        if (func == null)
        {
            CoC_Settings.error("createCallBackFunction(null," + args + ")");
        }
        return function() : Dynamic
        {
            if (CoC_Settings.haltOnErrors)
            {
                logFunctionInfo(func, args);
            }
            return Reflect.callMethod(null, func, args);
        };
    }
    
    /**
     * Adds a button.
     * @param    pos Determines the position. Starts at 0. (First row is 0-4, second row is 5-9, third row is 10-14.)
     * @param    text Determines the text that will appear on button.
     * @param    func1 Determines what function to trigger.
     * @param    arg1 Pass argument #1 to func1 parameter.
     * @param    arg2 Pass argument #2 to func1 parameter.
     * @param    arg3 Pass argument #3 to func1 parameter.
     * @param    toolTipText The text that will appear on tooltip when the mouse goes over the button.
     * @param    toolTipHeader The text that will appear on the tooltip header. If not specified, it defaults to button text.
     */
    public static function addButton(pos : Int, text : String = "", func1 : Function = null, arg1 : Dynamic = -9000, arg2 : Dynamic = -9000, arg3 : Dynamic = -9000, toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        var btn : CoCButton = button(pos);
        if (func1 == null)
        {
            return btn.hide();
        }
        var callback : Function;
        //Removes sex-related button in SFW mode.
        callback = createCallBackFunction(func1, arg1, arg2, arg3);
        
        if (toolTipText == "")
        {
            toolTipText = getButtonToolTipText(text);
        }
        if (toolTipHeader == "")
        {
            toolTipHeader = getButtonToolTipHeader(text);
        }
        btn.show(text, callback, toolTipText, toolTipHeader);
        //CoC.instance.mainView.setOutputText( CoC.instance.currentText );
        CoC.instance.flushOutputTextToGUI();
        return btn;
    }
    
    public static function fiveArgButton(pos : Int, text : String = "", func1 : Function = null, arg1 : Dynamic = -9000, arg2 : Dynamic = -9000, arg3 : Dynamic = -9000, arg4 : Dynamic = -9000, arg5 : Dynamic = -9000, toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        var btn : CoCButton = button(pos);
        if (func1 == null)
        {
            return btn.hide();
        }
        var callback : Function;
        
        callback = createCallBackFunction2(func1, arg1, arg2, arg3, arg4, arg5);
        
        if (toolTipText == "")
        {
            toolTipText = getButtonToolTipText(text);
        }
        if (toolTipHeader == "")
        {
            toolTipHeader = getButtonToolTipHeader(text);
        }
        btn.show(text, callback, toolTipText, toolTipHeader);
        //CoC.instance.mainView.setOutputText( CoC.instance.currentText );
        CoC.instance.flushOutputTextToGUI();
        return btn;
    }
    
    public static function addButtonDisabled(pos : Int, text : String = "", toolTipText : String = "", toolTipHeader : String = "") : CoCButton
    {
        var btn : CoCButton = button(pos);
        if (toolTipText == "")
        {
            toolTipText = getButtonToolTipText(text);
        }
        if (toolTipHeader == "")
        {
            toolTipHeader = getButtonToolTipHeader(text);
        }
        btn.showDisabled(text, toolTipText, toolTipHeader);
        CoC.instance.flushOutputTextToGUI();
        return btn;
    }
    
    public static function button(pos : Int) : CoCButton
    {
        return CoC.instance.mainView.bottomButtons[pos];
    }
    
    public static function setButtonTooltip(index : Int, toolTipHeader : String = "", toolTipText : String = "") : Void
    {
        button(index).hint(toolTipText, toolTipHeader);
    }
    
    public static function hasButton(arg : Dynamic) : Bool
    {
        if (Std.is(arg, String))
        {
            return CoC.instance.mainView.hasButton(Std.string(arg));
        }
        else
        {
            return false;
        }
    }
    
    /**
     * Removes a button.
     * @param    arg The position to remove a button. (First row is 0-4, second row is 5-9, third row is 10-14.)
     */
    public static function removeButton(arg : Dynamic) : Void
    {
        var buttonToRemove : Int = 0;
        if (Std.is(arg, String))
        {
            buttonToRemove = CoC.instance.mainView.indexOfButtonWithLabel(Std.string(arg));
        }
        if (Std.is(arg, Float))
        {
            if (arg < 0 || arg > 14)
            {
                return;
            }
            buttonToRemove = as3hx.Compat.parseInt(arg);
        }
        CoC.instance.mainView.hideBottomButton(buttonToRemove);
    }
    
    /**
     * Hides all bottom buttons.
     */
    public static function menu() : Void
    //The newer, simpler menu - blanks all buttons so addButton can be used
    {
        
        for (i in 0...14)
        {
            CoC.instance.mainView.hideBottomButton(i);
        }
        CoC.instance.flushOutputTextToGUI();
        statScreenRefresh();
    }
    
    /**
     * Adds buttons that can be chosen.
     *
     * I highly recommend you <b>DO NOT</b> use this for new content. Use addButton() instead.
     */
    public static function choices(text1 : String, butt1 : Function,
            text2 : String, butt2 : Function,
            text3 : String, butt3 : Function,
            text4 : String, butt4 : Function,
            text5 : String, butt5 : Function,
            text6 : String, butt6 : Function,
            text7 : String, butt7 : Function,
            text8 : String, butt8 : Function,
            text9 : String, butt9 : Function,
            text0 : String, butt0 : Function) : Void
    //New typesafe version
    {
        
        
        menu();
        addButton(0, text1, butt1);
        addButton(1, text2, butt2);
        addButton(2, text3, butt3);
        addButton(3, text4, butt4);
        addButton(4, text5, butt5);
        addButton(5, text6, butt6);
        addButton(6, text7, butt7);
        addButton(7, text8, butt8);
        addButton(8, text9, butt9);
        addButton(9, text0, butt0);
    }
    
    
    /**
     * Adds five button that can be chosen.
     *
     * I highly recommend you <b>DO NOT</b> use this for new content. Use addButton() instead.
     */
    public static function simpleChoices(text1 : String, butt1 : Function,
            text2 : String, butt2 : Function,
            text3 : String, butt3 : Function,
            text4 : String, butt4 : Function,
            text5 : String, butt5 : Function) : Void
    {
        menu();
        addButton(0, text1, butt1);
        addButton(1, text2, butt2);
        addButton(2, text3, butt3);
        addButton(3, text4, butt4);
        addButton(4, text5, butt5);
    }
    
    /**
     * Clears all button and adds a 'Yes' and a 'No' button.
     * @param    eventYes The event parser or function to call if 'Yes' button is pressed.
     * @param    eventNo The event parser or function to call if 'No' button is pressed.
     */
    public static function doYesNo(eventYes : Function, eventNo : Function) : Void
    {
        menu();
        addButton(0, "Yes", eventYes);
        addButton(1, "No", eventNo);
    }
    
    /**
     * Clears all button and adds a 'Next' button.
     * @param    func The event function to call if the button is pressed.
     */
    public static function doNext(func : Function, args : Array<Dynamic> = null) : Void
    //Now typesafe
    {
        
        //Prevent new events in combat from automatically overwriting a game over.
        if (CoC.instance.mainView.getButtonText(0).indexOf("Game Over") != -1)
        {
            trace("Do next setup cancelled by game over");
            return;
        }
        menu();
        addButton.apply(null, [0, "Next", func].concat(args));
    }
    
    /**
     * Used to update the display of statistics
     */
    private static var statScreenRefreshScheduled : Bool = false;
    public static function doStatScreenRefresh() : Void
    {
        statScreenRefreshScheduled = false;
        if (!CoC.instance || !CoC.instance.player)
        {
            return;
        }
        Utils.Begin("engineCore", "statScreenRefresh");
        CoC.instance.mainViewManager.refreshStats();
        CoC.instance.mainView.statsView.show();
        if (CoC.instance.inCombat)
        {
            CoC.instance.mainView.monsterStatsView.refreshStats(CoC.instance);
            CoC.instance.mainView.monsterStatsView.show();
        }
        else
        {
            CoC.instance.mainView.monsterStatsView.hide();
        }
        Utils.End("engineCore", "statScreenRefresh");
    }
    public static function statScreenRefresh() : Void
    {
        if (statScreenRefreshScheduled)
        {
            return;
        }
        statScreenRefreshScheduled = true;
        // call doStatScreenRefresh ASAP after all other code is executed
        as3hx.Compat.setTimeout(doStatScreenRefresh, 0);
    }
    
    /**
     * Show the stats pane. (Name, stats and attributes)
     */
    public static function showStats() : Void
    {
        CoC.instance.mainView.statsView.show();
        CoC.instance.mainViewManager.refreshStats();
        CoC.instance.mainViewManager.tweenInStats();
    }
    
    /**
     * Hide the stats pane. (Name, stats and attributes)
     */
    public static function hideStats() : Void
    {
        if (!CoC.instance.mainViewManager.buttonsTweened)
        {
            CoC.instance.mainView.statsView.hide();
        }
        CoC.instance.mainViewManager.tweenOutStats();
        CoC.instance.mainView.monsterStatsView.hide();
        CoC.instance.mainView.notificationView.clearNotifications();
    }
    
    /**
     * Hide the top buttons.
     */
    public static function hideMenus() : Void
    {
        CoC.instance.mainView.hideAllMenuButtons();
    }
    
    /**
     * Hides the up/down arrow on stats pane.
     */
    public static function hideUpDown() : Void
    {
        CoC.instance.mainView.statsView.hideUpDown();
        //Clear storage values so up/down arrows can be properly displayed
        
        for (stat in allStatsOld)
        {
            CoC.instance.oldStats[stat] = 0;
        }
    }
    
    public static function fatigue(mod : Float, type : Float = 0) : Void
    {
        SceneLib.combat.fatigueImpl(mod, type);
    }
    
    public static function changeFatigue(changeF : Float) : Void
    {
        fatigue(changeF);
    }
    
    public static function minLust() : Float
    {
        return CoC.instance.player.minLust();
    }
    
    public static function openURL(url : String) : Void
    {
        flash.Lib.getURL(new URLRequest(url), "_blank");
    }
    
    /**
     * Awards the achievement. Will display a light blue text if achievement hasn't been earned.
     * @param    title The name of the achievement.
     * @param    achievement The achievement to be awarded.
     * @param    display Determines if achievement earned should be displayed.
     * @param    nl Inserts a new line before the achievement text.
     * @param    nl2 Inserts a new line after the achievement text.
     */
    public static function awardAchievement(title : String, achievement : Dynamic, display : Bool = true, nl : Bool = false, nl2 : Bool = true) : Void
    {
        if (CoC.instance.achievements[achievement] != null)
        {
            if (CoC.instance.achievements[achievement] <= 0)
            {
                CoC.instance.achievements[achievement] = 1;
                if (nl && display)
                {
                    outputText("\n");
                }
                if (display)
                {
                    outputText("<b>[font-lblue]Achievement unlocked: " + title + "[/font]</b>");
                }
                if (nl2 && display)
                {
                    outputText("\n");
                }
                CoC.instance.saves.savePermObject(false);
            }
        }
        else
        {
            outputText("\n<b>ERROR: Invalid achievement!</b>");
        }
    }
    
    public static function lustPercent() : Float
    {
        return CoC.instance.player.lustPercent();
    }
    
    public static function applyOperator(old : Float, op : String, val : Float) : Float
    {
        switch (op)
        {
            case "=":
                return val;
            case "+":
                return old + val;
            case "-":
                return old - val;
            case "*":
                return old * val;
            case "/":
                return old / val;
            default:
                trace("applyOperator(" + old + ",'" + op + "'," + val + ") unknown op");
                return old;
        }
    }
    
    public static function showUpDown() : Void
    //Moved from StatsView.
    {
        
        Utils.Begin("engineCore", "showUpDown");
        
        for (i in 0...allStats.length)
        {
            if (CoC.instance.player[allStats[i]] > CoC.instance.oldStats[allStatsOld[i]])
            {
                CoC.instance.mainView.statsView.showStatUp(allStats[i]);
            }
            if (CoC.instance.player[allStats[i]] < CoC.instance.oldStats[allStatsOld[i]])
            {
                CoC.instance.mainView.statsView.showStatDown(allStats[i]);
            }
        }
        Utils.End("engineCore", "showUpDown");
    }
    
    public static function range(min : Float, max : Float, round : Bool = false) : Float
    {
        var num : Float = (min + Math.random() * (max - min));
        
        if (round)
        {
            return Math.round(num);
        }
        return num;
    }
    
    public static function doNothing() : Void
    {  //This literally does nothing.  
        
    }
    
    private static function buildFuncLookupDict(object : Dynamic = null, prefix : String = "") : Void
    {
        trace("Building function <-> function name mapping table for " + (((object == null)) ? "CoC." : prefix));
        // get all methods contained
        if (object == null)
        {
            object = new EngineCore();
        }
        var typeDesc : FastXML = describeType(object);
        //trace("TypeDesc - ", typeDesc)
        
        for (node/* AS3HX WARNING could not determine type for var: node exp: EE4XDescend(EIdent(typeDesc),EIdent(method)) type: null */ in typeDesc.descendants("method"))
        
        // return the method name if the thisObject of f (t){
            
            // has a property by that name
            // that is not null (null = doesn't exist) and
            // is strictly equal to the function we search the name of
            //trace("this[node.@name] = ", this[node.@name], " node.@name = ", node.@name)
            if (Reflect.field(object, Std.string(node.att.name)) != null)
            {
                Reflect.setField(funcLookups, Std.string(Reflect.field(object, Std.string(node.att.name))), prefix + node.att.name);
            }
        }
        for (node/* AS3HX WARNING could not determine type for var: node exp: EE4XDescend(EIdent(typeDesc),EIdent(variable)) type: null */ in typeDesc.descendants("variable"))
        {
            if (Std.string(node.att.type).indexOf("classes.Scenes.") == 0 ||
                node.metadata.att.name.contains("Scene"))
            {
                if (Reflect.field(object, Std.string(node.att.name)) != null)
                {
                    buildFuncLookupDict(Reflect.field(object, Std.string(node.att.name)), node.att.name + ".");
                }
            }
        }
    }
    
    private static function logFunctionInfo(func : Function, arg : Dynamic = null, arg2 : Dynamic = null, arg3 : Dynamic = null) : Void
    {
        var logStr : String = "";
        if (Std.is(arg, Function))
        {
            logStr += "Calling = " + getFunctionName(func) + " Param = " + getFunctionName(arg);
        }
        else
        {
            logStr += "Calling = " + getFunctionName(func) + " Param = " + arg;
        }
        CoC_Settings.appendButtonEvent(logStr);
        trace(logStr);
    }
}


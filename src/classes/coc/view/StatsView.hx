package coc.view;

import classes.CoC;
import classes.globalFlags.KFLAGS;
import classes.PerkLib;
import classes.Player;
import classes.stats.BuffableStat;
import classes.stats.IStat;
import classes.stats.PrimaryStat;
import classes.stats.StatUtils;
import classes.internals.Utils;
import coc.model.TimeModel;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class StatsView extends Block
{
    public static inline var ValueFontOld : String = "Lucida Sans Typewriter";
    public static inline var ValueFont : String = "Georgia";
    
    public static var LABEL_FORMAT : Dynamic = {
            font : "Times New Roman",
            bold : true,
            size : 22
        };
    public static var TEXT_FORMAT : Dynamic = {
            font : ValueFont,
            size : 16
        };
    public static var TIME_FORMAT : Dynamic = {
            font : "Lucida Sans Typewriter",
            size : 18
        };
    
    private var sideBarBG : BitmapDataSprite;
    private var nameText : TextField;
    private var coreStatsText : TextField;
    private var combatStatsText : TextField;
    private var strBar : StatBar;
    private var touBar : StatBar;
    private var speBar : StatBar;
    private var intBar : StatBar;
    private var wisBar : StatBar;
    private var libBar : StatBar;
    private var senBar : StatBar;
    private var corBar : StatBar;
    private var hpBar : StatBar;
    private var wrathBar : StatBar;
    private var lustBar : StatBar;
    private var fatigueBar : StatBar;
    private var manaBar : StatBar;
    private var soulforceBar : StatBar;
    private var hungerBar : StatBar;
    
    private var allStats : Array<Dynamic>;
    
    private var col1 : Block;
    private var col2 : Block;
    private var corner : CornerStatsView;
    
    public function new(mainView : MainView, cornerStatsView : CornerStatsView)
    {
        super({
                    x : MainView.STATBAR_X,
                    y : MainView.STATBAR_Y,
                    width : MainView.STATBAR_W,
                    height : MainView.STATBAR_H
                });
        this.corner = cornerStatsView;
        sideBarBG = addBitmapDataSprite({
                            x : 0,
                            y : 0,
                            width : MainView.STATBAR_W,
                            height : MainView.STATBAR_H,
                            crop : true,
                            borderColor : "#A37C17",
                            borderWidth : 1,
                            borderRadius : 2
                        });
        nameText = addTextField({
                            x : 0,
                            y : 0,
                            width : MainView.STATBAR_W,
                            defaultTextFormat : Utils.extend({ }, LABEL_FORMAT, {
                                        align : TextFormatAlign.CENTER
                                    })
                        });
        addElement(col1 = new Block({
                            x : 0,
                            y : 20,
                            width : MainView.STATBAR_COL_W,
                            height : MainView.STATBAR_H,
                            layoutConfig : {
                                padding : MainView.HALFGAP,
                                type : "flow",
                                direction : "column",
                                ignoreHidden : true,
                                gap : 1
                            }
                        }));
        addElement(col2 = new Block({
                            x : MainView.STATBAR_COL_W,
                            y : 20,
                            width : MainView.STATBAR_COL_W,
                            height : MainView.STATBAR_H,
                            layoutConfig : {
                                padding : MainView.HALFGAP,
                                type : "flow",
                                direction : "column",
                                ignoreHidden : true,
                                gap : 1
                            }
                        }));
        coreStatsText = col1.addTextField({
                            text : "Core stats:",
                            defaultTextFormat : LABEL_FORMAT
                        }, {
                            before : 1
                        });
        col1.addElement(strBar = new StatBar({
                            statName : "Strength:"
                        }));
        strBar.addEventListener("rollOver", Utils.curry(hoverStat, "str"));
        strBar.addEventListener("rollOut", Utils.curry(hoverStat, "str"));
        col1.addElement(touBar = new StatBar({
                            statName : "Toughness:"
                        }));
        touBar.addEventListener("rollOver", Utils.curry(hoverStat, "tou"));
        touBar.addEventListener("rollOut", Utils.curry(hoverStat, "tou"));
        col1.addElement(speBar = new StatBar({
                            statName : "Speed:"
                        }));
        speBar.addEventListener("rollOver", Utils.curry(hoverStat, "spe"));
        speBar.addEventListener("rollOut", Utils.curry(hoverStat, "spe"));
        col1.addElement(intBar = new StatBar({
                            statName : "Intelligence:"
                        }));
        intBar.addEventListener("rollOver", Utils.curry(hoverStat, "int"));
        intBar.addEventListener("rollOut", Utils.curry(hoverStat, "int"));
        col1.addElement(wisBar = new StatBar({
                            statName : "Wisdom:"
                        }));
        wisBar.addEventListener("rollOver", Utils.curry(hoverStat, "wis"));
        wisBar.addEventListener("rollOut", Utils.curry(hoverStat, "wis"));
        col1.addElement(libBar = new StatBar({
                            statName : "Libido:"
                        }));
        libBar.addEventListener("rollOver", Utils.curry(hoverStat, "lib"));
        libBar.addEventListener("rollOut", Utils.curry(hoverStat, "lib"));
        col1.addElement(senBar = new StatBar({
                            statName : "Sensitivity:"
                        }));
        senBar.addEventListener("rollOver", Utils.curry(hoverStat, "sens"));
        senBar.addEventListener("rollOut", Utils.curry(hoverStat, "sens"));
        col1.addElement(corBar = new StatBar({
                            statName : "Corruption:"
                        }));
        corBar.addEventListener("rollOver", Utils.curry(hoverStat, "cor"));
        corBar.addEventListener("rollOut", Utils.curry(hoverStat, "cor"));
        
        combatStatsText = col2.addTextField({
                            text : "Combat stats",
                            defaultTextFormat : LABEL_FORMAT
                        }, {
                            before : 1
                        });
        col2.addElement(hpBar = new StatBar({
                            statName : "HP:",
                            barColor : "#008000",
                            bgColor : "#ff0000",
                            showMax : true
                        }));
        hpBar.addEventListener("rollOver", Utils.curry(hoverStat, "hp"));
        hpBar.addEventListener("rollOut", Utils.curry(hoverStat, "hp"));
        col2.addElement(lustBar = new StatBar({
                            statName : "Lust:",
                            minBarColor : "#ff0000",
                            hasMinBar : true,
                            showMax : true
                        }));
        lustBar.addEventListener("rollOver", Utils.curry(hoverStat, "minlust"));
        lustBar.addEventListener("rollOut", Utils.curry(hoverStat, "minlust"));
        col2.addElement(wrathBar = new StatBar({
                            statName : "Wrath:",
                            showMax : true
                        }));
        wrathBar.addEventListener("rollOver", Utils.curry(hoverStat, "wrath"));
        wrathBar.addEventListener("rollOut", Utils.curry(hoverStat, "wrath"));
        col2.addElement(fatigueBar = new StatBar({
                            statName : "Fatigue:",
                            showMax : true
                        }));
        col2.addElement(manaBar = new StatBar({
                            statName : "Mana:",
                            showMax : true
                        }));
        col2.addElement(soulforceBar = new StatBar({
                            statName : "SF:",
                            showMax : true
                        }));
        col2.addElement(hungerBar = new StatBar({
                            statName : "Satiety:",
                            showMax : true
                        }));
        ///////////////////////////
        allStats = [];
        var ci : Int = 0;
        var cn : Int = col1.numElements;
        while (ci < cn)
        {
            var e : StatBar = try cast(col1.getElementAt(ci), StatBar) catch(e:Dynamic) null;
            if (e != null)
            {
                allStats.push(e);
            }
            ci++;
        }
        for (ci in 0...cn)
        {
            e = try cast(col2.getElementAt(ci), StatBar) catch(e:Dynamic) null;
            if (e != null)
            {
                allStats.push(e);
            }
        }
        for (ci in 0...cn)
        {
            e = try cast(cornerStatsView.getElementAt(ci), StatBar) catch(e:Dynamic) null;
            if (e != null)
            {
                allStats.push(e);
            }
        }
    }
    override public function invalidateLayout() : Void
    {
        super.invalidateLayout();
        if (col1 != null)
        {
            col1.invalidateLayout();
        }
        if (col2 != null)
        {
            col2.invalidateLayout();
        }
        if (corner != null)
        {
            corner.invalidateLayout();
        }
    }
    public function show() : Void
    {
        this.visible = true;
    }
    
    public function hide() : Void
    {
        this.visible = false;
    }
    
    
    override private function set_visible(value : Bool) : Bool
    {
        if (visible != value)
        {
            for (sb in allStats)
            {
                sb.animate = value && (CoC.instance.flags[kFLAGS.STATBAR_ANIMATIONS] == 0);
            }
        }
        super.visible = value;
        if (corner != null)
        {
            corner.visible = visible;
        }
        return value;
    }
    // <- hideUpDown
    public function hideUpDown() : Void
    {
        var ci : Int;
        var cc : Int = this.allStats.length;
        for (ci in 0...cc)
        {
            var c : StatBar = this.allStats[ci];
            c.isUp = false;
            c.isDown = false;
        }
    }
    
    public function showLevelUp() : Void
    {
        this.corner.levelBar.isUp = true;
    }
    
    public function hideLevelUp() : Void
    {
        this.corner.levelBar.isUp = false;
    }
    
    public function statByName(statName : String) : StatBar
    {
        switch (statName.toLowerCase())
        {
            case "str":
                return strBar;
            case "tou":
                return touBar;
            case "spe":
                return speBar;
            case "inte", "int":
                return intBar;
            case "wis":
                return wisBar;
            case "lib":
                return libBar;
            case "sens", "sen":
                return senBar;
            case "cor":
                return corBar;
            case "hp":
                return hpBar;
            case "wrath":
                return wrathBar;
            case "lust":
                return lustBar;
            case "fatigue":
                return fatigueBar;
            case "mana":
                return manaBar;
            case "soulforce":
                return soulforceBar;
            case "hunger":
                return hungerBar;
            case "level":
                return corner.levelBar;
            case "xp":
                return corner.xpBar;
            case "gems":
                return corner.gemsBar;
            case "spiritstones":
                return corner.spiritstonesBar;
        }
        return null;
    }
    public function showStatUp(statName : String) : Void
    {
        var stat : StatBar = statByName(statName);
        if (stat != null)
        {
            stat.isUp = true;
        }
        else
        {
            trace("[ERROR] Cannot showStatUp " + statName);
        }
    }
    
    public function showStatDown(statName : String) : Void
    {
        var stat : StatBar = statByName(statName);
        if (stat != null)
        {
            stat.isDown = true;
        }
        else
        {
            trace("[ERROR] Cannot showStatDown " + statName);
        }
    }
    public function hungerBarIsVisible() : Bool
    {
        return hungerBar.visible;
    }
    public function toggleHungerBar(show : Bool) : Void
    {
        hungerBar.visible = show;
        invalidateLayout();
    }
    public function refreshStats(game : CoC) : Void
    {
        var player : Player = game.player;
        nameText.htmlText = "<b>" + player.short + "</b>";
        strBar.maxValue = player.strStat.max;
        strBar.value = player.str;
        touBar.maxValue = player.touStat.max;
        touBar.value = player.tou;
        speBar.maxValue = player.speStat.max;
        speBar.value = player.spe;
        intBar.maxValue = player.intStat.max;
        intBar.value = player.inte;
        wisBar.maxValue = player.wisStat.max;
        wisBar.value = player.wis;
        libBar.maxValue = player.libStat.max;
        libBar.value = player.lib;
        senBar.maxValue = player.sens;
        senBar.value = player.effectiveSensitivity();
        corBar.value = player.cor;
        var hpPercent : Bool = game.flags[kFLAGS.HP_STATBAR_PERCENTAGE] == 1;
        hpBar.maxValue = player.maxHP();
        hpBar.value = player.HP;
        hpBar.percentage = hpPercent;
        var wrathPercent : Bool = game.flags[kFLAGS.WRATH_STATBAR_PERCENTAGE] == 1;
        wrathBar.maxValue = player.maxWrath();
        wrathBar.value = player.wrath;
        wrathBar.percentage = wrathPercent;
        var lustPercent : Bool = game.flags[kFLAGS.LUST_STATBAR_PERCENTAGE] == 1;
        lustBar.maxValue = player.maxLust();
        lustBar.minValue = player.minLust();
        lustBar.percentage = lustPercent;
        lustBar.value = player.lust;
        fatigueBar.maxValue = player.maxFatigue();
        fatigueBar.value = player.fatigue;
        manaBar.maxValue = player.maxMana();
        manaBar.value = player.mana;
        soulforceBar.maxValue = player.maxSoulforce();
        soulforceBar.value = player.soulforce;
        //	soulforceBar.valueText= (player.soulforce/player.maxSoulforce()).toFixed(2)+'%';
        hungerBar.maxValue = player.maxHunger();
        hungerBar.value = player.hunger;
        if (player.hunger < 25)
        {
            hungerBar.statName = "/!\\ Satiety:";
        }
        else
        {
            hungerBar.statName = "Satiety:";
        }
        
        corner.advancementText.htmlText = "<b>Advancement</b>";
        corner.levelBar.value = player.level;
        if (player.negativeLevel)
        {
            corner.levelBar.valueText = "(-" + player.negativeLevel + ") " + player.level;
        }
        if (player.level < CoC.instance.levelCap || player.negativeLevel > 0)
        {
            corner.xpBar.maxValue = player.requiredXP();
            corner.xpBar.value = player.XP;
        }
        else
        {
            corner.xpBar.maxValue = player.XP;
            corner.xpBar.value = player.XP;
            corner.xpBar.valueText = "MAX";
        }
        corner.gemsBar.valueText = Utils.addComma(Math.floor(player.gems));
        corner.spiritstonesBar.valueText = game.flags[kFLAGS.SPIRIT_STONES];
        
        var minutesDisplay : String = "" + game.model.time.minutes;
        if (minutesDisplay.length == 1)
        {
            minutesDisplay = "0" + minutesDisplay;
        }
        
        var hours : Float = game.model.time.hours;
        var hrs : String;
        var ampm : String;
        if (game.flags[kFLAGS.USE_12_HOURS] == 0)
        {
            hrs = "" + hours;
            ampm = "";
        }
        else
        {
            hrs = ((hours % 12 == 0)) ? "12" : "" + (hours % 12);
            ampm = (hours < 12) ? "am" : "pm";
        }
        corner.timeText.htmlText = "<u>Days Passed: " + game.model.time.days + "</u>\n" + ((CoC.instance.model.time.useRealDate()) ? "" : "<u>Date: " + TimeModel.formatDate(CoC.instance.model.time.date) + "</u>\n") + "Time: " + hrs + ":" + minutesDisplay + ampm;
        corner.debugBuildVersion.htmlText = "CoCX: " + CoC.instance.debugGameVer +
                ", NG: " + CoC.instance.flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
        
        invalidateLayout();
    }
    
    public function setTheme(type : Int, font : String) : Void
    {
        var style : Dynamic = MainView.Themes[type];
        if (style == null)
        {
            return;
        }
        sideBarBG.borderColor = style.statBorderColor;
        sideBarBG.fillColor = style.statGlass;
        sideBarBG.fillAlpha = style.statGlassAlpha;
        corner.bg.borderColor = style.statBorderColor;
        corner.bg.fillColor = style.statGlass;
        corner.bg.fillAlpha = style.statGlassAlpha;
        
        var dtf : TextFormat;
        for (e in allStats)
        {
            dtf = e.valueLabel.defaultTextFormat;
            dtf.color = style.statTextColor;
            dtf.font = font;
            e.valueLabel.defaultTextFormat = dtf;
            e.valueLabel.setTextFormat(dtf);
            e.nameColor = style.statTextColor;
            if (e.bar)
            {
                e.bar.alpha = style.barAlpha;
            }
            if (e.minBar)
            {
                e.minBar.alpha = (1 - (1 - style.barAlpha) / 2);
            }
        }
        for (tf in [nameText, coreStatsText, combatStatsText, corner.advancementText, corner.timeText, corner.debugBuildVersion])
        {
            dtf = tf.defaultTextFormat;
            dtf.color = style.statTextColor;
            tf.defaultTextFormat = dtf;
            tf.setTextFormat(dtf);
        }
    }
    
    private function hoverStat(statname : String, event : MouseEvent) : Void
    {
        var player : Player = CoC.instance.player;
        var _sw1_ = (event.type);        

        switch (_sw1_)
        {
            case MouseEvent.ROLL_OVER:
                var astat : IStat = player.statStore.findStat(statname);
                var isPositiveStat : Bool = true;
                var bar : StatBar = try cast(event.target, StatBar) catch(e:Dynamic) null;
                if (Std.is(astat, BuffableStat))
                {
                    var stat : BuffableStat = try cast(astat, BuffableStat) catch(e:Dynamic) null;
                    if (stat == null)
                    {
                        return;
                    }
                    if (bar == null)
                    {
                        return;
                    }
                    if (statname == "sens" || statname == "cor" || statname == "minlust")
                    {
                        isPositiveStat = false;
                    }
                    if (statname == "minlust")
                    {
                        var lustValue : String = ((CoC.instance.flags[kFLAGS.LUST_STATBAR_PERCENTAGE] != null)) ? "Lust: " +
                        Utils.formatNumber(Math.floor(player.lust)) + ((bar.showMax) ? "/" + Utils.formatNumber(player.maxLust()) : "") + "\n" : "";
                        var text : String = lustValue + StatUtils.describeBuffs(stat, false, isPositiveStat);
                        player.listMinLustMultiBuffs();
                        text += StatUtils.describeBuffs(player.minLustXStat, true, isPositiveStat);
                        CoC.instance.mainView.toolTipView.showForElement(
                                bar, 
                                bar.statName, 
                                text
                );
                    }
                    else
                    {
                        CoC.instance.mainView.toolTipView.showForElement(
                                bar, 
                                bar.statName, 
                                StatUtils.describeBuffs(stat, false, isPositiveStat)
                );
                    }
                }
                else if (Std.is(astat, PrimaryStat))
                {
                    var primStat : PrimaryStat = try cast(astat, PrimaryStat) catch(e:Dynamic) null;
                    if (primStat == null)
                    {
                        return;
                    }
                    if (statname == "sens" || statname == "cor")
                    {
                        isPositiveStat = false;
                    }
                    var s : String = "Core: " + primStat.core.value + "/" + primStat.core.max + ". ";
                    s += "Training: " + primStat.train.value + "/" + primStat.train.max + ". ";
                    if (statname == "tou" && (player.hasPerk(PerkLib.IcyFlesh) || player.hasPerk(PerkLib.HaltedVitals)))
                    {
                        s += "\nYou are currently in a state of undeath and cannot benefit from bonus to toughness.";
                    }
                    else
                    {
                        s += "\n" +
                        "" + StatUtils.describeBuffs(primStat.bonus, false, isPositiveStat) + "" +
                        "" + StatUtils.describeBuffs(primStat.mult, true, isPositiveStat) + "";
                    }
                    CoC.instance.mainView.toolTipView.showForElement(bar, bar.statName, s);
                }
                else if (statname == "hp")
                {
                    if (bar == null)
                    {
                        return;
                    }
                    if (CoC.instance.flags[kFLAGS.HP_STATBAR_PERCENTAGE] == null)
                    {
                        return;
                    }
                    var hpText : String = "HP: " + Utils.formatNumber(Math.floor(player.HP)) + ((bar.showMax) ? "/" + Utils.formatNumber(player.maxHP()) : "");
                    CoC.instance.mainView.toolTipView.showForElement(bar, bar.statName, hpText);
                }
                else if (statname == "wrath")
                {
                    if (bar == null)
                    {
                        return;
                    }
                    if (CoC.instance.flags[kFLAGS.WRATH_STATBAR_PERCENTAGE] == null)
                    {
                        return;
                    }
                    var wrathText : String = "Wrath: " + Utils.formatNumber(Math.floor(player.wrath)) + ((bar.showMax) ? "/" + Utils.formatNumber(player.maxWrath()) : "");
                    CoC.instance.mainView.toolTipView.showForElement(bar, bar.statName, wrathText);
                }
            case MouseEvent.ROLL_OUT:
                CoC.instance.mainView.toolTipView.hide();
                if (statname == "minlust")
                {
                    player.minLustStat.removeCombatRoundTrackingBuffs();
                    player.minLustXStat.removeCombatRoundTrackingBuffs();
                }
        }
    }
}


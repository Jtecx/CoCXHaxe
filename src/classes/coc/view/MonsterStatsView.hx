/**
 * Coded by aimozg on 24.11.2017.
 */
package coc.view;

import classes.CoC;
import classes.globalFlags.KFLAGS;
import classes.Monster;
import classes.PerkLib;
import classes.Player;
import classes.internals.Utils;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

class MonsterStatsView extends Block
{
    
    private var sideBarBG : BitmapDataSprite;
    private var nameText : TextField;
    private var levelBar : StatBar;
    private var hpBar : StatBar;
    private var lustBar : StatBar;
    private var fatigueBar : StatBar;
    private var manaBar : StatBar;
    private var soulforceBar : StatBar;
    private var wrathBar : StatBar;
    private var corBar : StatBar;
    private var generalTypeLabel : TextField;
    private var generalTypeValue : TextField;
    private var elementalTypeLabel : TextField;
    private var elementalTypeValue : TextField;
    
    public function new(mainView : MainView)
    {
        super({
                    x : MainView.MONSTER_X,
                    y : MainView.MONSTER_Y,
                    width : MainView.MONSTER_W,
                    height : MainView.MONSTER_H,
                    layoutConfig : {
                        padding : MainView.GAP,
                        type : "flow",
                        direction : "column",
                        ignoreHidden : true,
                        gap : 1
                    }
                });
        StatBar.setDefaultOptions({
                    barColor : "#600000",
                    width : innerWidth
                });
        sideBarBG = addBitmapDataSprite({
                            width : MainView.MONSTER_W,
                            height : MainView.MONSTER_H,
                            crop : true,
                            borderColor : "#A37C17",
                            borderWidth : 1,
                            borderRadius : 2
                        }, {
                            ignore : true
                        });
        nameText = addTextField({
                            defaultTextFormat : StatsView.LABEL_FORMAT,
                            width : MainView.MONSTER_W,
                            multiline : true,
                            wordWrap : true
                        });
        addElement(levelBar = new StatBar({
                            statName : "Level:",
                            hasBar : false
                        }));
        addElement(hpBar = new StatBar({
                            statName : "HP:",
                            barColor : "#008000",
                            bgColor : "#ff0000",
                            showMax : true
                        }));
        hpBar.addEventListener("rollOver", Utils.curry(hoverStat, "hp"));
        hpBar.addEventListener("rollOut", Utils.curry(hoverStat, "hp"));
        addElement(lustBar = new StatBar({
                            statName : "Lust:",
                            minBarColor : "#ff0000",
                            hasMinBar : true,
                            showMax : true
                        }));
        lustBar.addEventListener("rollOver", Utils.curry(hoverStat, "lust"));
        lustBar.addEventListener("rollOut", Utils.curry(hoverStat, "lust"));
        addElement(fatigueBar = new StatBar({
                            statName : "Fatigue:",
                            showMax : true
                        }));
        addElement(soulforceBar = new StatBar({
                            statName : "SF:",
                            showMax : true
                        }));
        addElement(manaBar = new StatBar({
                            statName : "Mana:",
                            showMax : true
                        }));
        addElement(wrathBar = new StatBar({
                            statName : "Wrath:",
                            showMax : true
                        }));
        wrathBar.addEventListener("rollOver", Utils.curry(hoverStat, "wrath"));
        wrathBar.addEventListener("rollOut", Utils.curry(hoverStat, "wrath"));
        addElement(corBar = new StatBar({
                            statName : "Corruption:",
                            showMax : false,
                            maxValue : 100
                        }));
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
            for (i in 0...numElements)
            {
                var sb : StatBar = try cast(getElementAt(i), StatBar) catch(e:Dynamic) null;
                if (sb != null)
                {
                    sb.animate = value && (CoC.instance.flags[kFLAGS.STATBAR_ANIMATIONS] == 0);
                }
            }
        }
        super.visible = value;
        return value;
    }
    public function refreshStats(game : CoC) : Void
    {
        var player : Player = game.player;
        var monster : Monster = game.monster;
        nameText.text = Utils.capitalizeFirstLetter(monster.short);
        nameText.height = nameText.textHeight + 5;
        levelBar.value = monster.level;
        var hpPercent : Bool = game.flags[kFLAGS.HP_STATBAR_PERCENTAGE] == 1;
        hpBar.maxValue = monster.maxHP();
        hpBar.value = monster.HP;
        hpBar.percentage = hpPercent;
        var lustPercent : Bool = game.flags[kFLAGS.LUST_STATBAR_PERCENTAGE] == 1;
        lustBar.maxValue = monster.maxLust();
        lustBar.minValue = monster.minLust();
        lustBar.value = monster.lust;
        lustBar.percentage = lustPercent;
        fatigueBar.value = monster.fatigue;
        fatigueBar.maxValue = monster.maxFatigue();
        soulforceBar.value = monster.soulforce;
        soulforceBar.maxValue = monster.maxSoulforce();
        soulforceBar.visible = player.hasPerk(PerkLib.SoulSense);
        manaBar.value = monster.mana;
        manaBar.maxValue = monster.maxMana();
        manaBar.visible = player.hasPerk(PerkLib.JobSorcerer);
        var wrathPercent : Bool = game.flags[kFLAGS.WRATH_STATBAR_PERCENTAGE] == 1;
        wrathBar.value = monster.wrath;
        wrathBar.maxValue = monster.maxWrath();
        wrathBar.percentage = wrathPercent;
        wrathBar.visible = player.hasPerk(PerkLib.SenseWrath);
        corBar.value = monster.cor;
        corBar.visible = player.hasPerk(PerkLib.SenseCorruption);
        
        invalidateLayout();
    }
    public function setMonsterTypes(generalTypes : Array<Dynamic>, elementalTypes : Array<Dynamic>) : Void
    {
        generalTypeLabel.visible = generalTypes.length > 0;
        generalTypeValue.visible = generalTypes.length > 0;
        generalTypeValue.text = generalTypes.join("\n");
        elementalTypeLabel.visible = elementalTypes.length > 0;
        elementalTypeValue.visible = elementalTypes.length > 0;
        elementalTypeValue.text = elementalTypes.join("\n");
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
        
        var dtf : TextFormat;
        var ci : Int = 0;
        var cn : Int = this.numElements;
        while (ci < cn)
        {
            var e : StatBar = try cast(this.getElementAt(ci), StatBar) catch(e:Dynamic) null;
            if (e == null)
            {
                {ci++;continue;
                }
            }
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
            ci++;
        }
        for (tf in [nameText])
        {
            dtf = tf.defaultTextFormat;
            dtf.color = style.statTextColor;
            tf.defaultTextFormat = dtf;
            tf.setTextFormat(dtf);
        }
    }
    private function hoverStat(statname : String, event : MouseEvent) : Void
    {
        var monster : Monster = CoC.instance.monster;
        var _sw0_ = (event.type);        

        switch (_sw0_)
        {
            case MouseEvent.ROLL_OVER:
                var bar : StatBar = try cast(event.target, StatBar) catch(e:Dynamic) null;
                if (bar == null)
                {
                    return;
                }
                if (statname == "hp")
                {
                    if (CoC.instance.flags[kFLAGS.HP_STATBAR_PERCENTAGE] == null)
                    {
                        return;
                    }
                    var hpText : String = "HP: " + Utils.formatNumber(Math.floor(monster.HP)) + ((bar.showMax) ? "/" + Utils.formatNumber(monster.maxHP()) : "");
                    CoC.instance.mainView.toolTipView.showForElement(bar, bar.statName, hpText);
                }
                else if (statname == "lust")
                {
                    if (CoC.instance.flags[kFLAGS.LUST_STATBAR_PERCENTAGE] == null)
                    {
                        return;
                    }
                    var lustValue : String = "Lust: " + Utils.formatNumber(Math.floor(monster.lust)) + ((bar.showMax) ? "/" + Utils.formatNumber(monster.maxLust()) : "");
                    CoC.instance.mainView.toolTipView.showForElement(bar, bar.statName, lustValue);
                }
                else if (statname == "wrath")
                {
                    if (CoC.instance.flags[kFLAGS.WRATH_STATBAR_PERCENTAGE] == null)
                    {
                        return;
                    }
                    var wrathText : String = "Wrath: " + Utils.formatNumber(Math.floor(monster.wrath)) + ((bar.showMax) ? "/" + Utils.formatNumber(monster.maxWrath()) : "");
                    CoC.instance.mainView.toolTipView.showForElement(bar, bar.statName, wrathText);
                }
            case MouseEvent.ROLL_OUT:
                CoC.instance.mainView.toolTipView.hide();
        }
    }
}


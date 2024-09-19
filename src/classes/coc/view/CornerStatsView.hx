/**
 * Coded by aimozg on 17.01.2020.
 */
package coc.view;

import classes.scenes.Holidays;
import flash.text.TextField;

class CornerStatsView extends Block
{
    @:allow(coc.view)
    private var advancementText : TextField;
    @:allow(coc.view)
    private var timeText : TextField;
    @:allow(coc.view)
    private var debugBuildVersion : TextField;
    @:allow(coc.view)
    private var levelBar : StatBar;
    @:allow(coc.view)
    private var xpBar : StatBar;
    @:allow(coc.view)
    private var gemsBar : StatBar;
    @:allow(coc.view)
    private var spiritstonesBar : StatBar;
    @:allow(coc.view)
    private var bg : BitmapDataSprite;
    public function new()
    {
        super({
                    x : MainView.CORNERSTATS_X,
                    width : MainView.CORNERSTATS_W,
                    layoutConfig : {
                        padding : MainView.HALFGAP,
                        type : "flow",
                        direction : "column",
                        ignoreHidden : true,
                        gap : 1
                    }
                });
        bg = addBitmapDataSprite({
                            x : 0,
                            y : 0,
                            width : this.width,
                            height : this.height,
                            crop : true,
                            borderColor : "#A37C17",
                            borderWidth : 1,
                            borderRadius : 2
                        }, {
                            ignore : true
                        });
        advancementText = addTextField({
                            text : "Advancement",
                            defaultTextFormat : StatsView.LABEL_FORMAT
                        }, {
                            before : 1
                        });
        addElement(levelBar = new StatBar({
                            statName : "Level:",
                            hasBar : false
                        }));
        addElement(xpBar = new StatBar({
                            statName : "XP:"
                        }));
        addElement(gemsBar = new StatBar({
                            statName : "Gems:",
                            hasBar : false
                        }));
        addElement(spiritstonesBar = new StatBar({
                            statName : "Spirit Stones:",
                            hasBar : false
                        }));
        timeText = addTextField({
                            htmlText : "<u>Day#: 0</u>"
                            + "\n<u>Date: D: 01 Jun 2010</u>"
                            + "\nTime: 00:00",
                            defaultTextFormat : StatsView.TIME_FORMAT
                        }, {
                            before : 1
                        });
        debugBuildVersion = addTextField({
                            text : "CoCX: UNKNOWN, NG: 0",
                            defaultTextFormat : StatsView.TEXT_FORMAT
                        }, {
                            before : 1
                        });
    }
    
    override public function doLayout() : Void
    {
        super.doLayout();
        this.y = MainView.CORNERSTATS_BOTTOM - this.height;
        bg.height = this.height;
    }
}


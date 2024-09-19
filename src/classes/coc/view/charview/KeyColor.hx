/**
 * Coded by aimozg on 28.07.2017.
 */
package coc.view.charview;

import classes.CoCSettings;
import classes.internals.Utils;
import coc.view.Color;

class KeyColor
{
    public var src(get, never) : Int;
    public var base(get, never) : String;

    private var _src : Int;
    private var _base : String;
    private var tfs : Array<Dynamic>;
    public function new(src : Int, base : String, tf : String)
    {
        this._src = src;
        this._base = base;
        if (tf != null)
        {
            this.tfs = tf.split(";");
        }
        else
        {
            this.tfs = [];
        }
    }
    public function transform(baseValue : Int) : Int
    {
        var hsl : Dynamic = Color.toHsl(baseValue);
        for (tf in tfs)
        {
            var fn : Array<Dynamic> = tf.match(new as3hx.Compat.Regex('^(\\w+)\\(([\\d.,-]+)\\)', ""));
            var fname : String = (fn != null) ? fn[1] : null;
            var values : Array<Dynamic> = (fn != null) ? fn[2].split(",") : [];
            for (i in 0...values.length)
            {
                values[i] = as3hx.Compat.parseFloat(values[i]);
            }
            switch (fname)
            {
                case "shift", "h":
                    hsl.h = hsl.h + values[0];
                case "shiftTo", "hto":
                    if (hsl.h > values[0])
                    {
                        hsl.h -= values[1];
                    }
                    else
                    {
                        hsl.h += values[2];
                    }
                case "saturate", "s":
                    hsl.s += values[0];
                case "desaturate":
                    hsl.s -= values[0];
                case "darken":
                    hsl.l -= values[0];
                case "lighten", "l":
                    hsl.l += values[0];
                default:
                    CoC_Settings.error("invalid color transform '" + tf + "'");
            }
            hsl.h = hsl.h % 360;
            while (hsl.h < 0)
            {
                hsl.h += 360;
            }
            hsl.s = Utils.boundFloat(0, hsl.s, 100);
            hsl.l = Utils.boundFloat(0, hsl.l, 100);
        }
        return Color.fromHsl(hsl);
    }
    private function get_src() : Int
    {
        return _src;
    }
    private function get_base() : String
    {
        return _base;
    }
}


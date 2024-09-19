/**
 * Coded by aimozg on 30.09.2017.
 */
package coc.view;

import haxe.Constraints.Function;

class ButtonDataList
{
    public var length(get, never) : Int;
    public var active(get, never) : Int;

    public var list : Array<Dynamic> = [];
    public function new()
    {
    }
    public function append(bd : ButtonData) : Void
    {
        list.push(bd);
    }
    public function add(text : String, callback : Function = null, toolTipText : String = "", toolTipHeader : String = "") : ButtonData
    {
        var bd : ButtonData = new ButtonData(text, callback, toolTipText, toolTipHeader);
        list.push(bd);
        return bd;
    }
    public function get(index : Int) : ButtonData
    {
        return list[index];
    }
    public function clear() : Void
    {
        list.splice(0, list.length);
    }
    private function get_length() : Int
    {
        return list.length;
    }
    private function get_active() : Int
    {
        var activeBtns : Int = 0;
        for (i in list)
        {
            if (Reflect.field(i, "enabled") != null)
            {
                activeBtns++;
            }
        }
        return activeBtns;
    }
}

